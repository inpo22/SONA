package com.sona.music.mypage.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sona.music.board.dto.QnADTO;
import com.sona.music.member.dto.MemberDTO;
import com.sona.music.lesson.dto.LessonDTO;
import com.sona.music.mypage.dao.MyPageDAO;
import com.sona.music.mypage.dto.MyPageDTO;

@Service
public class MyPageService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MyPageDAO myPageDAO;
	
	public String file_root = "C:/upload/";

	public MyPageDTO getUserInfo(String loginId) {
		MyPageDTO list = myPageDAO.getUserInfo(loginId);
		logger.info("userInfo list: {} ", list);
		return myPageDAO.getUserInfo(loginId);
	}

	public boolean confirmPw(String newPassword, String confirmPassword) {
		return newPassword.equals(confirmPassword);	
		
	}
	
	public int updateUserInfo(Map<String, String> map) {
		    // 전달된 데이터를 맵에 추가합니다.
        	logger.info("회원 수정하기~ ", map);
		    logger.info("전달된 데이터: {}", map);

		    // DAO를 통해 업데이트 수행
		    int row = myPageDAO.updateUserInfo(map);
		    
		    // 업데이트된 행 수 반환
		    return row;
		}




	public Map<String, Object> qnaList(int currPage, int pagePerCnt, String loginId) {
		int start = (currPage-1)*pagePerCnt;
		logger.info(loginId);
		Map<String, Object> result = new HashMap<String, Object>();
		logger.info("list 갯수 : " + loginId + "currPage 갯수 : " + currPage + "totalPages 갯수 : " + pagePerCnt);
		List<MyPageDTO> list = myPageDAO.qnaList(pagePerCnt,start,loginId);
		logger.info("list size: "+list.size());
		result.put("list", list);
		result.put("currPage",currPage);
		result.put("totalPages", myPageDAO.allCount(pagePerCnt));
		
		
		
		return result;
	}


	public List<String> getClassNames(String loginId) {
	        return myPageDAO.getClassNames(loginId);
	}

	public String getPointAmount(String loginId) {
		return myPageDAO.getPointAmount(loginId);
	}

	public Map<String, Object> pointList(int currPage, int pagePerCnt, String loginId) {
		int start = (currPage-1)*pagePerCnt;
		logger.info(loginId);
		Map<String, Object> result = new HashMap<String, Object>();
		
		logger.info("list 갯수 : " + loginId + "currPage 갯수 : " + currPage + "totalPages 갯수 : " + pagePerCnt);
		List<MyPageDTO> list = myPageDAO.pointList(pagePerCnt,start,loginId);
		logger.info("list size: "+list.size());
		
		result.put("list", list);
		result.put("currPage",currPage);
		result.put("totalPages", myPageDAO.allCount(pagePerCnt));				
		
		return result;
	}

	public Map<String, Object> receiveList(int currPage, int pagePerCnt, String loginId) {
		
		int start = (currPage-1)*pagePerCnt;
		logger.info(loginId);
		Map<String, Object> result = new HashMap<String, Object>();
		logger.info("list 갯수 : " + loginId + "currPage 갯수 : " + currPage + "totalPages 갯수 : " + pagePerCnt);
		List<MyPageDTO> list = myPageDAO.receiveList(pagePerCnt,start,loginId);
		
		logger.info("list size: "+list.size());
		
		result.put("list", list);
		result.put("currPage",currPage);
		result.put("totalPages", myPageDAO.allCount(pagePerCnt));				
		
		return result;
	}

	public Map<String, Object> sendList(int currPage, int pagePerCnt, String loginId) {
		
		int start = (currPage-1)*pagePerCnt;
		logger.info(loginId);
		Map<String, Object> result = new HashMap<String, Object>();
		logger.info("list 갯수 : " + loginId + "currPage 갯수 : " + currPage + "totalPages 갯수 : " + pagePerCnt);
		List<MyPageDTO> list = myPageDAO.sendList(pagePerCnt,start,loginId);
		
		logger.info("list size: "+list.size());
		
		result.put("list", list);
		result.put("currPage",currPage);
		result.put("totalPages", myPageDAO.allCount(pagePerCnt));				
		
		return result;
	}

	public Map<String, Object> courseList(int currPage, int pagePerCnt, String loginId) {
		
		int start = (currPage-1)*pagePerCnt;
		logger.info(loginId);
		Map<String, Object> result = new HashMap<String, Object>();
		logger.info("list 갯수 : " + loginId + "currPage 갯수 : " + currPage + "totalPages 갯수 : " + pagePerCnt);
		List<MyPageDTO> list = myPageDAO.courseList(pagePerCnt,start,loginId);
		
		logger.info("list size: "+list.size());
		
		result.put("list", list);
		result.put("currPage",currPage);
		result.put("totalPages", myPageDAO.allCount(pagePerCnt));				
		
		return result;
	}

	public Map<String, Object> lessonlist(int currPage, int pagePerCnt, String user_id) {

		int start = (currPage-1)*pagePerCnt;
		Map<String, Object> result = new HashMap<String, Object>();
		List<MemberDTO> list = myPageDAO.lessonlist(user_id,pagePerCnt,start);
		logger.info("list size: "+list.size());
		result.put("list", list);
		result.put("currPage",currPage);
		result.put("totalPages", myPageDAO.allCount(pagePerCnt));
		
		for (MemberDTO r : list) {
			logger.info(r.getClass_name()+"");
			logger.info(r.getClass_reg_date() + "");
			logger.info(r.getCount()+"");
			logger.info(r.getScore()+"");
			logger.info(r.getIndex_order()+"");
		}
		
	 return result;
	}

	public Map<String, Object> favoriteListCall(int currPage, int pagePerCnt, String loginId) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<LessonDTO> list = myPageDAO.favoriteListCall(pagePerCnt, start, loginId);
		logger.info("list : {}", list);
		logger.info("list size : "+list.size());
		result.put("list", list);		
		result.put("currPage", currPage);
		result.put("totalPages", myPageDAO.favoriteListCount(pagePerCnt, loginId));
		
		return result;
	}

	public int teacherListDel(List<String> delList, String loginId) {
		int cnt = 0;		
		for (String teacher_id : delList) {
			cnt += myPageDAO.teacherListDel(teacher_id, loginId);
		}				
		return cnt;
	}

	public Map<String, Object> blockListCall(int currPage, int pagePerCnt, String loginId) {
		int start = (currPage-1) * pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<LessonDTO> list = myPageDAO.blockListCall(pagePerCnt, start, loginId);
		logger.info("list : {}", list);
		logger.info("list size : "+list.size());
		result.put("list", list);		
		result.put("currPage", currPage);
		result.put("totalPages", myPageDAO.blockListCount(pagePerCnt, loginId));
		
		return result;
	}











	
}
