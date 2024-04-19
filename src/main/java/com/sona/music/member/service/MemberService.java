package com.sona.music.member.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sona.music.member.dao.MemberDAO;
import com.sona.music.member.dto.MemberDTO;

@Service
public class MemberService {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired MemberDAO memberDAO;

	public String findIdEmail(String email) {
		
		return  memberDAO.findIdEmail(email);
	}

	public MemberDTO login(String id, String pw) {
		logger.info("여긴 서비스 ");
		logger.info("id : {} | pw : {}", id, pw);
		return memberDAO.login(id,pw);
	}
	
}
