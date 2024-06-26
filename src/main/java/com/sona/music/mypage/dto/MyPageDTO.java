package com.sona.music.mypage.dto;

import java.sql.Date;
import java.util.List;

public class MyPageDTO {
	private String user_id;
	private String user_pass;
	private String user_name;
	private String user_email;
	private String user_phone;
	private String user_accountnumber;
	private String user_bank;
	private String user_type;
	private boolean user_delete;
	private Date user_reg_date;
	private String applyform_inst;
	private int inst_category_idx;
	private String applyform_location;
	private String applyform_days;
	private String applyform_style;
	private boolean have_inst;
	private String manner;
	private String new_filename;
	private int class_idx;
	private String class_name;
	private String q_title;
	private String q_reg_date;
	private String question_idx;
	private String answer_idx;
	private boolean anonymous_status;
	private String answer_status;
	private String profile;
	private int point_idx;
	private String point_type;
	private int point;
	private Date point_date;
	private long balance;
	private String note;
	private Date review_reg_date;
	private String review_title;
	private String rater_id;
	private String score;
	private String ratee_id;
	private String teacher_name;
	private int class_price;
	private String apply_state;
	private String ch_result;
	private int ch_idx;
	private String student_id;
	private String student_name;
	private String lesson_progress;
	private String end_check;
	private Date apply_date;
	private int review_idx;
	private String apply_detail;
	private int apply_idx;
	private Date start_date;
	private Date end_date;
	private int accumulate_lesson;
	private String manner_variance;
	private String etc;
	private String attendance_rate;
	
	
	
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pass() {
		return user_pass;
	}
	public void setUser_pass(String user_pass) {
		this.user_pass = user_pass;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public void setUser_accountnumber(String user_accountnumber) {
		this.user_accountnumber = user_accountnumber;
	}
	public String getUser_accountnumber() {
		return user_accountnumber;
	}
	public String getUser_bank() {
		return user_bank;
	}
	public void setUser_bank(String user_bank) {
		this.user_bank = user_bank;
	}
	public String getUser_type() {
		return user_type;
	}
	public void setUser_type(String user_type) {
		this.user_type = user_type;
	}
	public boolean isUser_delete() {
		return user_delete;
	}
	public void setUser_delete(boolean user_delete) {
		this.user_delete = user_delete;
	}
	public Date getUser_reg_date() {
		return user_reg_date;
	}
	public void setUser_reg_date(Date user_reg_date) {
		this.user_reg_date = user_reg_date;
	}
	public String getApplyform_inst() {
		return applyform_inst;
	}
	public void setApplyform_inst(String applyform_inst) {
		this.applyform_inst = applyform_inst;
	}
	public int getInst_category_idx() {
		return inst_category_idx;
	}
	public void setInst_category_idx(int inst_category_idx) {
		this.inst_category_idx = inst_category_idx;
	}
	public String getApplyform_location() {
		return applyform_location;
	}
	public void setApplyform_location(String applyform_location) {
		this.applyform_location = applyform_location;
	}
	
	public boolean isHave_inst() {
		return have_inst;
	}
	public void setHave_inst(boolean have_inst) {
		this.have_inst = have_inst;
	}
	public String getManner() {
		return manner;
	}
	public void setManner(String manner) {
		this.manner = manner;
	}
	public String getNew_filename() {
		return new_filename;
	}
	public void setNew_filename(String new_filename) {
		this.new_filename = new_filename;
	}
	public int getClass_idx() {
		return class_idx;
	}
	public void setClass_idx(int class_idx) {
		this.class_idx = class_idx;
	}
	public String getClass_name() {
		return class_name;
	}
	public void setClass_name(String class_name) {
		this.class_name = class_name;
	}

	public String getQ_title() {
		return q_title;
	}
	public void setQ_title(String q_title) {
		this.q_title = q_title;
	}
	public String getQ_reg_date() {
		return q_reg_date;
	}
	public void setQ_reg_date(String q_reg_date) {
		this.q_reg_date = q_reg_date;
	}
	public String getQuestion_idx() {
		return question_idx;
	}
	public void setQuestion_idx(String question_idx) {
		this.question_idx = question_idx;
	}
	public String getAnswer_idx() {
		return answer_idx;
	}
	public void setAnswer_idx(String answer_idx) {
		this.answer_idx = answer_idx;
	}
	public boolean isAnonymous_status() {
		return anonymous_status;
	}
	public void setAnonymous_status(boolean anonymous_status) {
		this.anonymous_status = anonymous_status;
	}
	public String getAnswer_status() {
		return answer_status;
	}
	public void setAnswer_status(String answer_status) {
		this.answer_status = answer_status;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getApplyform_days() {
		return applyform_days;
	}
	public void setApplyform_days(String applyform_days) {
		this.applyform_days = applyform_days;
	}
	public String getApplyform_style() {
		return applyform_style;
	}
	public void setApplyform_style(String applyform_style) {
		this.applyform_style = applyform_style;
	}
	public int getPoint_idx() {
		return point_idx;
	}
	public void setPoint_idx(int point_idx) {
		this.point_idx = point_idx;
	}
	public String getPoint_type() {
		return point_type;
	}
	public void setPoint_type(String point_type) {
		this.point_type = point_type;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public Date getPoint_date() {
		return point_date;
	}
	public void setPoint_date(Date point_date) {
		this.point_date = point_date;
	}
	public long getBalance() {
		return balance;
	}
	public void setBalance(long balance) {
		this.balance = balance;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public Date getReview_reg_date() {
		return review_reg_date;
	}
	public void setReview_reg_date(Date review_reg_date) {
		this.review_reg_date = review_reg_date;
	}
	public String getReview_title() {
		return review_title;
	}
	public void setReview_title(String review_title) {
		this.review_title = review_title;
	}
	public String getRater_id() {
		return rater_id;
	}
	public void setRater_id(String rater_id) {
		this.rater_id = rater_id;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getRatee_id() {
		return ratee_id;
	}
	public void setRatee_id(String ratee_id) {
		this.ratee_id = ratee_id;
	}
	public String getTeacher_name() {
		return teacher_name;
	}
	public void setTeacher_name(String teacher_name) {
		this.teacher_name = teacher_name;
	}
	public int getClass_price() {
		return class_price;
	}
	public void setClass_price(int class_price) {
		this.class_price = class_price;
	}
	public String getApply_state() {
		return apply_state;
	}
	public void setApply_state(String apply_state) {
		this.apply_state = apply_state;
	}
	public String getCh_result() {
		return ch_result;
	}
	public void setCh_result(String ch_result) {
		this.ch_result = ch_result;
	}
	public int getCh_idx() {
		return ch_idx;
	}
	public void setCh_idx(int ch_idx) {
		this.ch_idx = ch_idx;
	}
	public String getStudent_id() {
		return student_id;
	}
	public void setStudent_id(String student_id) {
		this.student_id = student_id;
	}
	public String getLesson_progress() {
		return lesson_progress;
	}
	public void setLesson_progress(String lesson_progress) {
		this.lesson_progress = lesson_progress;
	}
	public String getEnd_check() {
		return end_check;
	}
	public void setEnd_check(String end_check) {
		this.end_check = end_check;
	}
	public Date getApply_date() {
		return apply_date;
	}
	public void setApply_date(Date apply_date) {
		this.apply_date = apply_date;
	}
	public int getAccumulate_lesson() {
		return accumulate_lesson;
	}
	public void setAccumulate_lesson(int accumulate_lesson) {
		this.accumulate_lesson = accumulate_lesson;
	}
	public int getReview_idx() {
		return review_idx;
	}
	public void setReview_idx(int review_idx) {
		this.review_idx = review_idx;
	}
	public String getApply_detail() {
		return apply_detail;
	}
	public void setApply_detail(String apply_detail) {
		this.apply_detail = apply_detail;
	}
	public int getApply_idx() {
		return apply_idx;
	}
	public void setApply_idx(int apply_idx) {
		this.apply_idx = apply_idx;
	}
	public String getStudent_name() {
		return student_name;
	}
	public void setStudent_name(String student_name) {
		this.student_name = student_name;
	}
	public Date getStart_date() {
		return start_date;
	}
	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public String getManner_variance() {
		return manner_variance;
	}
	public void setManner_variance(String manner_variance) {
		this.manner_variance = manner_variance;
	}
	public String getEtc() {
		return etc;
	}
	public void setEtc(String etc) {
		this.etc = etc;
	}
	public String getAttendance_rate() {
		return attendance_rate;
	}
	public void setAttendance_rate(String attendance_rate) {
		this.attendance_rate = attendance_rate;
	}





	
	

}
