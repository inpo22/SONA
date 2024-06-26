package com.sona.music.admin.service;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.sona.music.admin.dao.AdminDAO;
import com.sona.music.admin.dto.AdminDTO;
import com.sona.music.admin.dto.PhotoDTO;

import com.sona.music.board.dto.FAQDTO;

import com.sona.music.board.dto.NoticeDTO;
import com.sona.music.board.dto.ReviewDTO;
import com.sona.music.board.dto.SuggestionDTO;

	

@Service
public class AdminService {

	
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired AdminDAO adminDAO;

	public String file_root = "C:/upload/";
	
	public int noticeDel(int noticeIdx) {
		
		int row = adminDAO.noticeDel(noticeIdx);
		logger.info("공지사항 삭제에 대한 값 : 1이면 삭제 완료" + row);
		return row;
	}

	public int adminCheck(Object attribute) {
		String id = (String) attribute;
		
		return adminDAO.adminCheck(id);
	}
	
	public Map<String, Object> adminNoticeShowListSearch(int currPage, int searchType, String serachText ,int delType) {
		int pagePerCnt = 10;
		int start = (currPage-1)*pagePerCnt;
		int deleteStatus = delType;
		Map<String, Object> result = new HashMap<String, Object>();
		List<AdminDTO> resultList = null;
		
		
		resultList = adminDAO.adminNoticeShowListSearch(start,pagePerCnt,deleteStatus,serachText,searchType);
		logger.info(serachText);


	
		result.put("list", resultList);
		result.put("currPage", currPage);
		result.put("totalPages", adminDAO.adminNoticeAllCount(pagePerCnt,deleteStatus,serachText,searchType));
		logger.info("공지사항관리에서 받아온 allCount"+adminDAO.adminNoticeAllCount(pagePerCnt,deleteStatus,serachText,searchType));
	return result;
}
	
	
	public int noticeWrite(MultipartFile[] photos, Map<String, String> param) {
		
		logger.info("공지사항 작성성 페이지에서 받은 공지사항 작성자 : "+param.get("writer"));
		
		AdminDTO noticeWriteDto = new AdminDTO();
		
		noticeWriteDto.setAdmin_id(param.get("writer"));
		noticeWriteDto.setNotice_content(param.get("content"));
		noticeWriteDto.setNotice_title(param.get("title"));
		String noticeWriteId = noticeWriteDto.getAdmin_id();
		
		int row = adminDAO.noticeWrite(noticeWriteDto);
		logger.info("공지사항 작성 성공시 나오는 row : 1" + row);
		int noticeIdx = noticeWriteDto.getNotice_idx();
		logger.info("공지사항 작성후 가져온 idx : " + noticeIdx);
		String photoCategory = "Notice";
		PhotoDTO noticePhotoDto = new PhotoDTO();
		if(row == 1) {
			fileSave(noticeIdx,noticeWriteId,photos,photoCategory);
		}
		
		return row;
	}
	
	public int noticeUpdate(MultipartFile[] photos, Map<String, String> param) {
		
		logger.info("공지사항 작성자 : "+param.get("writer"));
		
		AdminDTO noticeWriteDto = new AdminDTO();
		noticeWriteDto.setAdmin_id(param.get("writer"));
		noticeWriteDto.setNotice_content(param.get("content"));
		noticeWriteDto.setNotice_title(param.get("title"));
		noticeWriteDto.setNotice_idx(Integer.parseInt(param.get("noticeIdx")));
		String noticeWriteId = noticeWriteDto.getAdmin_id();
		
		int row = adminDAO.noticeUpdate(noticeWriteDto);
		logger.info("공지사항 작성 성공시 나오는 row : 1" + row);
		int noticeIdx = noticeWriteDto.getNotice_idx();
		logger.info("공지사항 작성후 가져온 idx : " + noticeIdx);
		String photoCategory = "Notice";
		PhotoDTO noticePhotoDto = new PhotoDTO();
		if(row == 1) {
			fileSave(noticeIdx,noticeWriteId,photos,photoCategory);
		}
		
		return row;
	}
	

	public void fileSave(int noticeIdx, String noticeWriteId, MultipartFile[] photos, String photoCategory) {
		 for (MultipartFile photo : photos) {
				
			   String fileName = photo.getOriginalFilename();
			   logger.info("upload file name : "+fileName);
			   
			   if(!(fileName.equals(""))) { // 파일명이 있다면 == 업로드 파일이 있다면
				   // 1.기존 파일명에서 확장자 추출(high.gif)
				   logger.info("파일명 확인" + fileName);
				   int a= fileName.lastIndexOf(".");
				   String filename2 =fileName.substring(a,fileName.length());
				   logger.info(filename2 + " : 확장자 뺀 파일명");
				   String ext = "";
				   // 2.새파일명 생성
				   String newFileName = System.currentTimeMillis()+filename2;
				   logger.info(fileName + " ->" + newFileName);
				   // 3.파일 저장
				   try {
					   byte[] bytes = photo.getBytes(); // MultipartFile 로 부터 바이너리 추출
					   Path path = Paths.get(file_root + newFileName);
					   Files.write(path, bytes); // 저장
					   adminDAO.noticePhotoWrite(fileName,newFileName,noticeIdx,noticeWriteId,photoCategory);
					   Thread.sleep(1); // 파일명을 위해 강제 휴식 부여
				   } catch (Exception e) {
					   e.printStackTrace();
				   }
			   }
		 }
		
	}

	public int photoDel(int photoidx, String photoname, String photocategory) {
		int row = adminDAO.photoDel(photoidx,photocategory,photoname);
		
		if(row == 1) {
			logger.info("DB 사진 삭제됨");
			delFile(photoname);
		}
		return row;
	}
	
	private void delFile(String photoname) {

			File file = new File(file_root+photoname);			
			boolean aa = file.delete();
		if(aa) {
			logger.info("경로에 있는 파일 삭제됨");
		}
	}
	
	public Map<String, Object> adminFaqList(int currPage, int searchType, String serachText, int categoryNum , int delType) {
		int pagePerCnt = 10;
		int start = (currPage-1)*pagePerCnt;
		int deleteStatus = delType;
		Map<String, Object> result = new HashMap<String, Object>();
		List<AdminDTO> resultList = null;
//		if(categoryNum == )
		
		resultList = adminDAO.adminFaqList(start,pagePerCnt,deleteStatus,serachText,searchType,categoryNum);
		logger.info(serachText + "텍스트");

		for (AdminDTO admindto : resultList) {
			logger.info(admindto.getFaq_title());
		}
	
		result.put("list", resultList);
		result.put("currPage", currPage);
		result.put("totalPages", adminDAO.adminFaqAllCount(pagePerCnt,deleteStatus,serachText,searchType,categoryNum));
		logger.info("공지사항관리에서 받아온 allCount"+adminDAO.adminFaqAllCount(pagePerCnt,deleteStatus,serachText,searchType,categoryNum));
		return result;
	}

	public int adminFaqWriteDo(String faqTitle, String faqAnswer, String faqType, String faqAdminId) {
		String adminId = faqAdminId;
		int row = adminDAO.adminFaqWriteDo(adminId,faqTitle,faqAnswer,faqType);
		return row;
	}

	public int adminFaqEditDo(Map<String, String> param) {
		
		logger.info("공지사항 작성자 : "+param.get("writer"));
		
		AdminDTO faqEditDto = new AdminDTO();
		faqEditDto.setAdmin_id(param.get("writer"));
		faqEditDto.setFaq_answer(param.get("answer"));
		faqEditDto.setFaq_title(param.get("title"));
		faqEditDto.setFaq_idx(Integer.parseInt(param.get("faqIdx")));
		faqEditDto.setFaq_target(param.get("faqType"));
		logger.info("faq수정에서 받은 faq 타겟"+faqEditDto.getFaq_target());
		logger.info("faq수정에서 받은 faq 타이틀"+faqEditDto.getFaq_title());
		logger.info("faq수정에서 받은 faq 대답"+faqEditDto.getFaq_answer());
		logger.info("faq수정에서 받은 faq idx"+faqEditDto.getFaq_idx());
		
		int row = adminDAO.faqEdit(faqEditDto);
		logger.info("faq 수정 성공시 나오는 row : 1 == " + row);
		int faqIdx = faqEditDto.getFaq_idx();
		logger.info("faq 수정 가져온 idx : " + faqIdx);
		
		return row;
	}
	public int faqDel(int faqIdx) {
		
		int row = adminDAO.faqDel(faqIdx);
		logger.info("faq 삭제에 대한 값 : 1이면 삭제 완료" + row);
		return row;
	}
	
	public int faqRestore(int faqIdx) {
		
		int row = adminDAO.faqRestore(faqIdx);
		logger.info("faq 복원 대한 값 : 1이면 삭제 완료" + row);
		return row;
	}
	
	public Map<String, Object> showListSearchSuggestion(int currPage, int searchType, String serachText, int categoryNum,int delType) {
		int pagePerCnt = 10;
		int start = (currPage-1)*pagePerCnt;
		int deleteStatus = delType;
		Map<String, Object> result = new HashMap<String, Object>();
		List<AdminDTO> resultList = null;
//		if(categoryNum == )
		
		resultList = adminDAO.showListSearchSuggestion(start,pagePerCnt,deleteStatus,serachText,searchType,categoryNum);
		for (AdminDTO list : resultList) {
			logger.info(list.getUser_id());
			logger.info("sug 답변 개수 : "+list.getSug_answerCount());
			logger.info("sug idx : "+list.getSug_idx());
			logger.info(list.getUser_id());
			
		}
		logger.info(serachText + "텍스트");

		for (AdminDTO faqdto : resultList) {
			logger.info("sug 에서 가져온 title : "+faqdto.getSug_title());
		}
	
		result.put("list", resultList);
		result.put("currPage", currPage);
		result.put("totalPages", adminDAO.allCountSuggestion(pagePerCnt,deleteStatus,serachText,searchType,categoryNum));
		logger.info("건의사항 받아온 allCount"+adminDAO.allCountSuggestion(pagePerCnt,deleteStatus,serachText,searchType,categoryNum));
		
		return result;
	}




	

	public Map<String, Object> showListSearchReview(int currPage, int searchType, String serachText, int categoryNum, int delType) {
		int pagePerCnt = 10;
		int start = (currPage-1)*pagePerCnt;
		int deleteStatus = delType;
		Map<String, Object> result = new HashMap<String, Object>();
		List<AdminDTO> resultList = null;

		
		resultList = adminDAO.showListSearchReview(start,pagePerCnt,deleteStatus,serachText,searchType,categoryNum);
		logger.info(serachText + "텍스트");

		for (AdminDTO reivew : resultList) {
			logger.info(reivew.getReview_idx() + " : 리뷰 idx admin");
			logger.info(reivew.getUser_type());
		}
	
		result.put("list", resultList);
		result.put("currPage", currPage);
		result.put("totalPages", adminDAO.allCountReview(pagePerCnt,deleteStatus,serachText,searchType,categoryNum));
		logger.info("리뷰 받아온 allCount"+adminDAO.allCountReview(pagePerCnt,deleteStatus,serachText,searchType,categoryNum));
		return result;
		}
	
	public void adminLessonHeader(Integer review_idx, Model model) {
		logger.info("lessonheader - 서비스");
		ReviewDTO dto = adminDAO.adminReviewLessonHeader(review_idx);
		model.addAttribute("lesson",dto);
		
		String lessonLogo = adminDAO.adminReviewlessonLogoLoad(review_idx);
		logger.info("lessonLogo : " +lessonLogo);
		model.addAttribute("lessonLogo",lessonLogo);
		
		
		
	}
	
	public void adminReviewDetail(int review_idx,int post_idx, String photo_category, Model model) {
		ReviewDTO dto = adminDAO.adminReviewDetail(review_idx);
		model.addAttribute("review", dto);

		List<com.sona.music.board.dto.PhotoDTO> list = adminDAO.adminReviewphotos(post_idx, photo_category);
		model.addAttribute("photos", list);
	}
	
	public int reviewBlind(int reviewIdx) {
		
		int row = adminDAO.reviewBlind(reviewIdx);
		logger.info("리뮤 블라인드에 대한 값 : 1이면 삭제 완료" + row);
		return row;
	}
	
	public int restoreReview(int reviewIdx) {
		
		int row = adminDAO.restoreReview(reviewIdx);
		logger.info("리뮤 블라인드에 대한 값 : 1이면 삭제 완료" + row);
		return row;
	}

		
	public Map<String, Object> showReportSearch(int currPage, int searchType, String searchText) {
		int pagePerCnt = 10;
		int start = (currPage-1)*pagePerCnt;
		Map<String, Object> result = new HashMap<String, Object>();
		List<AdminDTO> resultList = null;
		
		resultList = adminDAO.showReportSearch(start,pagePerCnt,searchText,searchType);
		logger.info(searchText);
		
		result.put("list", resultList);
		result.put("currPage", currPage);
		result.put("totalPages", adminDAO.reportAllCount(pagePerCnt,searchText,searchType));
		logger.info("공지사항관리에서 받아온 allCount"+adminDAO.reportAllCount(pagePerCnt,searchText,searchType));
		
		return result;
	}


	public void adminMainGO(Model model) {
		LocalDate currentDate = LocalDate.now();
		int currentMonth = currentDate.getMonthValue();
		int oneMonthAgo = currentMonth - 1;
		int twoMonthAgo = currentMonth - 2;
		
		if (oneMonthAgo < 1) {
			oneMonthAgo = 12 - oneMonthAgo;
		}
		if (twoMonthAgo < 1) {
			twoMonthAgo = 12 - twoMonthAgo;
		}
		
		model.addAttribute("currentMonth", currentMonth);
		model.addAttribute("oneMonthAgo", oneMonthAgo);
		model.addAttribute("twoMonthAgo", twoMonthAgo);
		
		
		AdminDTO maindto = adminDAO.adminData();
		
		model.addAttribute("maindto", maindto);
		
		
	}
	
	

	public Map<String, Object> adminMainAjax() {
		LocalDate currentDate = LocalDate.now();
		int currentMonth = currentDate.getMonthValue();
		int oneMonthAgo = currentMonth - 1;
		int twoMonthAgo = currentMonth - 2;
		
		if (oneMonthAgo < 1) {
			oneMonthAgo = 12 - oneMonthAgo;
		}
		if (twoMonthAgo < 1) {
			twoMonthAgo = 12 - twoMonthAgo;
		}
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<AdminDTO> userdto = adminDAO.userData(currentMonth, oneMonthAgo, twoMonthAgo);
		
		result.put("list", userdto);
		
		return result;
	}

	public Map<String, Object> adminUserListCall(int currPage, int pagePerCnt, String condition, String searchContent) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<AdminDTO> list = adminDAO.adminUserListCall(pagePerCnt, start, condition, searchContent);
		logger.info("list : {}", list);
		logger.info("list size : "+list.size());
		logger.info("condition = " + condition);
		logger.info("content = " + searchContent);
		result.put("list", list);		
		result.put("currPage", currPage);
		result.put("totalPages", adminDAO.adminUserListCount(pagePerCnt, condition, searchContent));
		result.put("userCount", adminDAO.userCount(condition, searchContent));
		
		return result;
	}

	public void adminUserDetailGo(String user_id, Model model) {
		
		AdminDTO dto = adminDAO.adminUserDetail(user_id);
		model.addAttribute("dto", dto);
		
		List<AdminDTO> list = adminDAO.adminUserDetailActionList(user_id);
		model.addAttribute("list", list);
		
	}

	

	


	public void reportDetailAdmin(int report_idx, Model model) {
		AdminDTO dto = adminDAO.reportDetailAdmin(report_idx);

		String title = dto.getReport_content();
		logger.info("신고에서 들어간 신고사항 상세보기 : " + title);		
		model.addAttribute("reportDetail", dto);
		
	}

	public void updateReportState(int report_idx, String new_state) {
		logger.info(report_idx+new_state);
        adminDAO.updateReportState(report_idx, new_state);
    }



	public int adminActionWriteDo(int reportIdx, String admin, String content, String action_result) {
		return adminDAO.adminActionWriteDo(reportIdx,admin,content,action_result);
	}

	public Map<String, Object> showSuspensionSearch(int currPage, int searchType, String searchText) {
		int pagePerCnt = 10;
		int start = (currPage-1)*pagePerCnt;
		Map<String, Object> result = new HashMap<String, Object>();
		List<AdminDTO> resultList = null;
		
		
		resultList = adminDAO.showSuspensionSearch(start,pagePerCnt,searchText,searchType);
		logger.info(searchText);


	
		result.put("list", resultList);
		result.put("currPage", currPage);
		result.put("totalPages", adminDAO.suspensionAllCount(pagePerCnt,searchText,searchType));
		logger.info("정지 이력 에서 받아온 allCount"+adminDAO.suspensionAllCount(pagePerCnt,searchText,searchType));
		return result;
	}

	public int reportDel(int reportIdx) {
		int row = adminDAO.reportDel(reportIdx);
		logger.info("공지사항 삭제에 대한 값 : 1이면 삭제 완료" + row);
		return row;
	}

	public void unbanUser(int banned_idx) {
        // 해당 사용자의 end_date를 오늘 날짜로 업데이트합니다.
	    adminDAO.updateEndDate(banned_idx); // LocalDate를 java.sql.Date로 변환하여 DAO에 전달합니다.
    }

	public void userSuspensionDetail(int banned_idx, Model model) {
		AdminDTO dto = adminDAO.userSuspensionDetail(banned_idx);

		String title = dto.getAction_category();
		logger.info("정지이력에서 들어간 신고사항 상세보기 : " + title);		
		model.addAttribute("suspension", dto);
		
	}

    public void addBan(int banned_idx, String end_date) {
        adminDAO.addBan(banned_idx, end_date);
    }
	
	public Map<String, Object> adminLessonListCall(int currPage, int pagePerCnt, String condition,
			String searchContent) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<AdminDTO> list = adminDAO.adminLessonListCall(pagePerCnt, start, condition, searchContent);
		logger.info("list : {}", list);
		logger.info("list size : "+list.size());
		logger.info("condition = " + condition);
		logger.info("content = " + searchContent);
		result.put("list", list);		
		result.put("currPage", currPage);
		result.put("totalPages", adminDAO.adminLessonListCount(pagePerCnt, condition, searchContent));
		
		return result;
	}

	public int noticeRestore(int noticeIdx) {
		
		int row = adminDAO.noticeRestore(noticeIdx);
		logger.info("공지사항 삭제에 대한 값 : 1이면 삭제 완료" + row);
		return row;
	}
	
}


