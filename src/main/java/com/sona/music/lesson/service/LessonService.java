package com.sona.music.lesson.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.sona.music.board.dto.QnADTO;
import com.sona.music.board.dto.ReviewDTO;
import com.sona.music.lesson.dao.LessonDAO;
import com.sona.music.lesson.dto.LessonDTO;
import com.sona.music.lesson.dto.PhotoDTO;

@Service
public class LessonService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired LessonDAO lessonDAO;
	
	public String file_root = "C:/upload/";

	public Map<String, Object> recommendListCall(int currPage, int pagePerCnt, String condition, String content, String inst, String loginId) {
		
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<LessonDTO> list = lessonDAO.recommendListCall(pagePerCnt, start, condition, content, inst, loginId);
		logger.info("list : {}", list);
		logger.info("list size : "+list.size());
		result.put("list", list);		
		result.put("currPage", currPage);
		result.put("totalPages", lessonDAO.recommendListCount(pagePerCnt, condition, content, inst, loginId));
		
		return result;
	}

	public Map<String, Object> allListCall(int currPage, int pagePerCnt, String condition, String content,
			String loca, String instCategory, String inst, String loginId) {
		
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<LessonDTO> list = lessonDAO.allListCall(pagePerCnt, start, condition, content, loca, instCategory, inst, loginId);
		logger.info("list : {}", list);
		logger.info("list size : "+list.size());
		result.put("list", list);		
		result.put("currPage", currPage);
		result.put("totalPages", lessonDAO.allListCount(pagePerCnt, condition, content, loca, instCategory, inst, loginId));
		
		return result;
	}

	public int lessonOpenDo(MultipartFile lessonLogo, MultipartFile[] photos, Map<String, String> param, String user_id) {
		logger.info("강의 개설 Service 접속 완료");

		int row = -1;
		
		// insert 후 생성된 idx 가져오는 방법
		// 조건1. 파라메터는 DTO로 넣을것
		LessonDTO dto = new LessonDTO();
		
		dto.setUser_id(user_id);
		dto.setClass_name(param.get("class_name"));
		dto.setInst_category_idx(Integer.parseInt(param.get("inst_category_idx")));
		dto.setClass_inst(param.get("class_inst"));
		dto.setClass_content(param.get("class_content"));
		dto.setClass_location(param.get("class_location"));
		dto.setCareer_years(param.get("career_years"));
		dto.setCareer_contents(param.get("career_content"));
		dto.setNeed_inst(Integer.parseInt(param.get("need_inst")));
		dto.setClass_days(param.get("class_days"));
		dto.setClass_hours(param.get("start_hour") + "~" + param.get("end_hour"));
		dto.setClass_style(param.get("class_style"));
		dto.setClass_times(Integer.parseInt(param.get("class_times")));
		dto.setClass_price(Integer.parseInt(param.get("class_price")));
		
		
		row = lessonDAO.lessonWrite(dto);
		
		// 조건3. 이후 dto 에서 저장된 키 값을 받아 온다.
		int idx = dto.getClass_idx();
		
		String ori_url = param.get("video_url");
		logger.info("ori_url : " + ori_url);
		
		
		
		logger.info("class_idx = " + idx);
		if (row > 0) {
			if (!(ori_url.equals(""))) {
				String new_url = "";
				
				if (!ori_url.contains("watch")) {
					new_url = ori_url.substring(ori_url.lastIndexOf("/")+1, ori_url.indexOf("?"));			
				}else {
					new_url = ori_url.substring(ori_url.indexOf("=")+1);
				}
				new_url = "https://www.youtube.com/embed/" + new_url;
				
				logger.info("new_url = " + new_url);
				
				lessonDAO.videoWrite(idx, new_url);
			}
			fileSave(idx, user_id, photos, lessonLogo);			
		}
		
		return row;
	}
	
	public void fileSave(int idx, String user_id, MultipartFile[] photos, MultipartFile lessonLogo) {
		logger.info("filesave 도착");
		if (lessonDAO.lessonPhotosLoad(idx) != null) {
			lessonDAO.lessonPhotosDel(idx);
		}
		if (lessonDAO.lessonLogoLoad(idx) != null) {
			lessonDAO.lessonLogoDel(idx);
		}
		String fileName = lessonLogo.getOriginalFilename();
		logger.info("fileName : " + fileName);
		if (!fileName.equals("")) { // 파일명이 있다 == 업로드 파일이 있다면
			
			
			// 1. 기존 파일명에서 확장자 추출 (high.gif)
			// 1-2. subString 활용 방법
			String ext = fileName.substring(fileName.lastIndexOf("."));
			
			// 2. 새파일명 생성
			String newFileName = System.currentTimeMillis() + ext;
			logger.info(fileName + " -> " + newFileName);
			
			// 3. 파일 저장
			try {
				byte[] bytes = lessonLogo.getBytes(); // MultipartFile 로부터 바이너리 추출
				Path path = Paths.get(file_root + newFileName); // 저장 경로 지정
				Files.write(path, bytes);
				
				String photo_category = "Lesson";
				
				lessonDAO.photoWrite(user_id, fileName, newFileName, idx, photo_category);
				
				Thread.sleep(1); // 파일명이 곂치지 않기 위해 강제 휴식 부여
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		
		for (MultipartFile photo : photos) {
			logger.info("filesave 쪼개기 시작");
			// 1. 업로드할 파일 명이 있는가?
			fileName = photo.getOriginalFilename();
			logger.info("fileName : " + fileName);
			if (!fileName.equals("")) { // 파일명이 있다 == 업로드 파일이 있다면
				
				// 1. 기존 파일명에서 확장자 추출 (high.gif)
				// 1-2. subString 활용 방법
				String ext = fileName.substring(fileName.lastIndexOf("."));
				
				// 2. 새파일명 생성
				String newFileName = System.currentTimeMillis() + ext;
				logger.info(fileName + " -> " + newFileName);
				
				// 3. 파일 저장
				try {
					byte[] bytes = photo.getBytes(); // MultipartFile 로부터 바이너리 추출
					Path path = Paths.get(file_root + newFileName); // 저장 경로 지정
					Files.write(path, bytes);
					
					String photo_category = "Career";
					
					lessonDAO.photoWrite(user_id, fileName, newFileName, idx, photo_category);
					
					Thread.sleep(1); // 파일명이 곂치지 않기 위해 강제 휴식 부여
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		
	}


	public void lessonDetail(int idx, Model model, String loginId) {
		logger.info("상세보기 Service 접속 완료");
		LessonDTO dto = lessonDAO.lessonDetail(idx);
		model.addAttribute("lesson", dto);
		
		logger.info("idx = " + idx);
		logger.info("loginId = " + loginId);
		
//		List<PhotoDTO> list = dao.photos(idx);
		String lessonLogo = lessonDAO.lessonLogoLoad(idx);
		logger.info("lessonLogo : {}", lessonLogo);
		model.addAttribute("lessonLogo", lessonLogo);
		
		List<PhotoDTO> photos = lessonDAO.lessonPhotosLoad(idx);
		model.addAttribute("photos", photos);
		
		List<ReviewDTO> reviewList = lessonDAO.lessonReviewList(idx);
		model.addAttribute("reviewList", reviewList);
		
		List<QnADTO> QnAList = lessonDAO.lessonQnAList(idx);
		model.addAttribute("QnAList", QnAList);
		
		LessonDTO applyCheck = lessonDAO.applyCheck(idx, loginId);
		model.addAttribute("applyCheck", applyCheck);
		
	}

	public void lessonApplyDo(int class_idx, String loginId) {
		
		lessonDAO.leesonApply(class_idx, loginId);
	}

	public void lessonBlind(int class_idx) {
		lessonDAO.lessonBlind(class_idx);
		
	}

	public void lessonUnBlind(int class_idx) {
		lessonDAO.lessonUnBlind(class_idx);
		
	}

	public void lessonDisable(int class_idx) {
		lessonDAO.lessonDisable(class_idx);
		
	}

	public void lessonUnDisable(int class_idx) {
		lessonDAO.lessonUnDisable(class_idx);
		
	}

	public void lessonEditGo(int idx, Model model, String loginId) {
		
		LessonDTO dto = lessonDAO.lessonDetail(idx);
		model.addAttribute("lesson", dto);
		
	}

	public int lessonEditDo(MultipartFile lessonLogo, MultipartFile[] photos, Map<String, String> param,
			String user_id, String class_idx) {
		logger.info("강의 수정 Service 접속 완료");
		
		int row = -1;
		
		// insert 후 생성된 idx 가져오는 방법
		// 조건1. 파라메터는 DTO로 넣을것
		LessonDTO dto = new LessonDTO();
		
		dto.setClass_idx(Integer.parseInt(class_idx));
		dto.setUser_id(user_id);
		dto.setClass_name(param.get("class_name"));
		dto.setInst_category_idx(Integer.parseInt(param.get("inst_category_idx")));
		dto.setClass_inst(param.get("class_inst"));
		dto.setClass_content(param.get("class_content"));
		dto.setClass_location(param.get("class_location"));
		dto.setCareer_years(param.get("career_years"));
		dto.setCareer_contents(param.get("career_content"));
		dto.setNeed_inst(Integer.parseInt(param.get("need_inst")));
		dto.setClass_days(param.get("class_days"));
		dto.setClass_hours(param.get("start_hour") + "~" + param.get("end_hour"));
		dto.setClass_style(param.get("class_style"));
		dto.setClass_times(Integer.parseInt(param.get("class_times")));
		dto.setClass_price(Integer.parseInt(param.get("class_price")));
		
		
		row = lessonDAO.lessonUpdate(dto);
		
		// 조건3. 이후 dto 에서 저장된 키 값을 받아 온다.
		int idx = Integer.parseInt(class_idx);
		String ori_url = param.get("video_url");
		logger.info("ori_url : " + ori_url);
		
		
		
		logger.info("class_idx = " + idx);
		if (row > 0) {
			if (!(ori_url.equals("")) && !ori_url.contains("embed")) {
				String new_url = "";
				
				if (!ori_url.contains("watch")) {
					new_url = ori_url.substring(ori_url.lastIndexOf("/")+1, ori_url.indexOf("?"));			
				}else {
					new_url = ori_url.substring(ori_url.indexOf("=")+1);
				}
				new_url = "https://www.youtube.com/embed/" + new_url;
				
				logger.info("new_url = " + new_url);
				
				lessonDAO.videoUpsert(idx, new_url);
			}
			fileSave(idx, user_id, photos, lessonLogo);			
		}
		
		return row;
	}

	
}
