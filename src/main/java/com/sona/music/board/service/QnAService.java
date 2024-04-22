package com.sona.music.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.sona.music.board.dao.QnADAO;
import com.sona.music.board.dto.QnADTO;
import com.sona.music.board.dto.ReviewDTO;

@Service
public class QnAService {

	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired QnADAO qnaDAO;

	public Map<String, Object> list(int currPage, int pagePerCnt, Integer classIdx) {
		int start = (currPage-1)*pagePerCnt;
		
		Map<String, Object> result = new HashMap<String, Object>();
		List<QnADTO> list = qnaDAO.list(pagePerCnt,start,classIdx);
		logger.info("list size: "+list.size());
		result.put("list", list);
		result.put("currPage",currPage);
		result.put("totalPages", qnaDAO.allCount(pagePerCnt));
		
		logger.info("QnA 리스트 페이지 이동");
		
		return result;
	}

	public int qwrite(Map<String, String> param) {
		int row = -1;
		
		QnADTO dto = new QnADTO();
		dto.setCLASS_IDX(Integer.parseInt(param.get("CLASS_IDX")));
		dto.setUSER_ID(param.get("USER_ID"));
		dto.setQ_TITLE(param.get("Q_TITLE"));
		dto.setQ_CONTENT("Q_CONTENT");
		
		//변수에 param 값 스트링으로 저장
		String anonymousStatusStr = param.get("ANONYMOUS_STATUS");
		//"true"와 equals 면 true, 아니면 false
		boolean anonymousStatus = "true".equals(anonymousStatusStr);
		dto.setANONYMOUS_STATUS(anonymousStatus);
		
		row = qnaDAO.qwrite(dto);
		
		return row;
	}

	public void detail(Integer qUESTION_IDX, Model model) {
		QnADTO dto = qnaDAO.detail(qUESTION_IDX);
		model.addAttribute("qna",dto);
		
	}
	
}
