<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
	function lyOn(btn){
		var btnId = btn.id; //클릭한 요소의 id
		var lyId = "ly_"+(btnId.replace("btn_","")); //id값에서 필요한 문자열 추출 후 만든 문자열로 새로운 id값으로 사용
		var lyTop = ($("#"+btnId).offset().top) + ($("#"+btnId).outerHeight()) + 4;
		var lyLeft = $("#"+btnId).offset().left;

		$("#"+btnId).addClass("on");
		$('#'+lyId).css({
			"top":lyTop,
			"left":lyLeft
			});
		$('#'+lyId).show();
		
	}
	$(document).ready(function(){
		//header 메뉴 active
		$("#header .header_item").removeClass("active");
		$("#header .gongu").addClass("active");
		
		
		
	});
</script>

<!-- <div class="card bg-secondary">

</div> -->
<div id="content" class="container">
	<div class="row">
		<div class="col-xl-2 col-12">
			<!-- conts1 : 공구 처리 버튼 -->
			<c:if test="${sessionScope.loginId eq 'system' || sessionScope.loginAuthor eq 0 }">
			<div class="section sec1">
				<h5>공구일괄처리</h5>
				<div class="gongu_btns">
					<div class="btn_start">
						<a href="adminGonguStartAction.ad">
							<span>승인된 공구들을 <br>한번에 공개하려면?</span>
							<em>공구 일괄 게시</em>
						</a>
					</div>
					<div class="btn_close">
						<a href="adminGonguCloseAction.ad">
							<span>오늘 마감된 공구들을 <br>한번에 종료하세요</span>
							<em>공구 일괄 종료</em>
						</a>
					</div>
				</div>
			</div>
			</c:if>
			<!-- //conts1 : 공구 처리 버튼 -->
			
			<!-- conts2 : 상태별 공구 건수 -->
			<div class="section">
			<h5>숫자로 보는 공구</h5>
			<div>
				<div class="gongu_cnts">
					<span>승인대기</span>
					<em>99</em>
				</div>
				<div class="gongu_cnts">
					<span>진행중</span>
					<em>99</em>
				</div>
				<div class="gongu_cnts">
					<span>정산중</span>
					<em>99</em>
				</div>
			</div>
			</div>
			<!-- //conts2 : 상태별 공구 건수 -->
		</div>
		<div class="col-xl-10 col-12">
			<!-- conts3 : 공구필터 + 리스트 -->
			<div class="section">
			<h5>공구검색</h5>
			<div class="utils">
				<button type="button" id="btn_filter" class="btn_filter frm_control" onclick="lyOn(this)">필터</button>
				<div id="ly_filter" class="ly_filter ly">
					<form class="utils_filter">
						<fieldset>
							<legend>공구상태표시</legend>
							<div class="frm_group">
								<input type="checkbox" id="gongu_9" name="gongu_status" value="9" class="frm_chk">
								<label for="gongu_9">전체</label>
							</div>
							<div class="frm_group">
								<input type="checkbox" id="gongu_3" name="gongu_status" value="3" class="frm_chk">
								<label for="gongu_3">반려</label>
							</div>
							<div class="frm_group">
								<input type="checkbox" id="gongu_0" name="gongu_status" value="0" class="frm_chk">
								<label for="gongu_0">승인대기</label>
							</div>
							<div class="frm_group">
								<input type="checkbox" id="gongu_4" name="gongu_status" value="4" class="frm_chk">
								<label for="gongu_4">진행중</label>
							</div>
							<div class="frm_group">
								<input type="checkbox" id="gongu_1" name="gongu_status" value="1" class="frm_chk">
								<label for="gongu_1">심사중</label>
							</div>
							<div class="frm_group">
								<input type="checkbox" id="gongu_5" name="gongu_status" value="5" class="frm_chk">
								<label for="gongu_5">비활성화</label>
							</div>
							<div class="frm_group">
								<input type="checkbox" id="gongu_2" name="gongu_status" value="2" class="frm_chk">
								<label for="gongu_2">승인</label>
							</div>
							<div class="frm_group">
								<input type="checkbox" id="gongu_7" name="gongu_status" value="7" class="frm_chk">
								<label for="gongu_7">종료</label>
							</div>
						</fieldset>
					</form>	
				</div>
				<div class="right">
					<div class="input_group">
						<select name="sch_options" class="frm_control">
							<option>공구명</option>
							<option>판매자</option>
						</select>
						<div class="utils_search frm_control">
							<input type="text" name="sch_keyword">
							<button type="button" class="btn_search">검색</button>
						</div>
					</div>
					<c:if test="${sessionScope.loginAuthor eq 1 }">
						<a href="gonguRegistForm.go" class="btn btn-primary">공구등록</a>
					</c:if>
				</div>
			</div>
			<div class="list gongu_list">
				<div class="list_header">
					<span>상태<button id="btn_help_status" class="help_icon" onclick="lyOn(this)">도움말</button>
						<div id="ly_help_status" class="ly ly_help_status">
							공구상태 설명
							<ul style="font-size:12px;">
								<li>승인대기 : 판매자가 작성한 공구글이 관리자의 승인을 받기 전 상태</li>
								<li>심사중 : 관리자가 글을 확인한 상태</li>
								<li>승인 : 판매자가 작성한 공구글이 관리자의 승인을 받은 상태</li>
								<li>반려 : 판매자가 작성한 공구글이 관리자의 승인 거절을 받은 상태</li>
								<li>진행중 : 공구글이 게시되어 구매자를 모집하는 상태</li>
								<li>비활성화 대기 : 관리자가 공구글을 비활성화 시키고 공구글이 비활성화 되기 전 상태, 찜하기와 참여하기가 불가능함, 공구글이 숨겨지기 전에 구매자들이 공구페이지에서 공구 중지에 대한 내용을 확인 할 수 있도록 하기 위함</li>
								<li>비활성화 : 공구글이 비활성화 되어 판매자&관리자만 확인할 수 있는 상태</li>
								<li>종료 : 공구마감일이 되었거나 공구 목표 달성으로 인해 공구가 종료된 상태</li>
							</ul>
						</div>
					</span>
					<span>공구명</span>
					<span>공구기간</span>
					<span>판매자</span>
					<span>등록일</span>
				</div>
			<c:choose>
				<c:when test="${gonguList.size() > 0 }">
					<c:forEach var="gongu" items="${gonguList}" varStatus="">
							<div class="list_item ${gongu.gongu_status eq '3'? 'reject':'' } ${gongu.gongu_status eq '4'? 'on':'' }">	
								<a href="adminGonguDetailViewAction.ad?gongu_id=${gongu.gongu_id}">
								<span>
									<span class="status">
										<c:choose>
											<c:when test="${gongu.gongu_status == '0' }">승인대기</c:when>
											<c:when test="${gongu.gongu_status == '1' }">심사중</c:when>
											<c:when test="${gongu.gongu_status == '2' }">승인</c:when>
											<c:when test="${gongu.gongu_status == '3' }">반려</c:when>
											<c:when test="${gongu.gongu_status == '4' }">진행중</c:when>
											<c:when test="${gongu.gongu_status == '5' }">비활성화 대기</c:when>
											<c:when test="${gongu.gongu_status == '6' }">비활성화</c:when>
											<c:when test="${gongu.gongu_status == '7' }">종료(공구성공)</c:when>
											<c:when test="${gongu.gongu_status == '8' }">종료(공구실패)</c:when>
										</c:choose>
									</span>
								</span>
								<span>${gongu.gongu_name }</span>
								<span>${gongu.gongu_startdate }~${gongu.gongu_findate }</span>
								<span>${gongu.seller_id }</span>
								<span>${gongu.gongu_date }</span>
								
								</a>
							</div>
						
					</c:forEach>
				</c:when>
				<c:otherwise>
					<p>등록된 공구가 없습니다.</p>
				</c:otherwise>	
			</c:choose>
			</div>
			</div>
			<!-- //conts3 : 공구필터 + 리스트 -->
		</div>
	</div>
</div>




