<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	<style type="text/css">
		.goodsImgContainer {width: 600px; height: 600px; padding-right : 50px; float: left; position : relative;}
		.goodsImgBig{width: 450px; height: 450px; margin-left : 50px; margin-top: 30px;}
		.goodsDetail{width: 500px; display : inline-block; margin-top : 15px; float : right; position: relative;}
		.goodsDetail h4{margin-top: 30px;}
		#goodsInfo{border-collapse : separate; border-spacing : 10px 10px; border-bottom : 1px solid gray;}
		#goodsInfo tr{height : 30px;}
		#buttonArea input[type=button]{border-radius: 15px; width: 180px; height: 50px; margin : 10px 20px;}
		#goodsInfo input[type=button] {border-radius: 15px; }
		input[type=date]{height : 20px; width : 120px; }
		#size{height : 20px; width : 120px; }
		input[type=number] { height : 20px; width : 120px; text-align : right;}
		.goodsImgInfo{margin-bottom : 300px;}
		.DetailInfo{margin-top : 200px;}
		.contentContainer a{text-decoration : none; color : black;}
		.goods_tab{ text-align: center; padding-top: 40px; padding: 80px 0 0 0;
    border-bottom: 1px solid #bbbbbb;}
		.goods_tab ul{display: inline-block; width: auto; height: 57px; padding: 40px;}
		.goods_tab li {float: left; width: 220px; margin-left: -1px; }
		.DetailInfo p, h3{text-align : center; margin : 30px;}
		.goodsImgSmall{width : 50px; height : 50px;}
	</style>
		<title>상품 상세페이지</title>
		<script type="text/javascript">
			$(function(){
				
				
				$("#addCartBtn").click(function(){
					if(${member != null}) {
						addFrmInfo();
						
						let g_type = parseInt($("#frmCart").find("input[name=g_type]").val());
						
						if(!chkData("#date", "날짜를")) return;
						else if(g_type != 3){
							if(!chkData("#size", "사이즈를")) return;
						}
						
						$("#frmCart").attr({"method" : "post", "action" : "/member/cart/goCart"});
	 					$("#frmCart").submit();
	 					
					} else{
						alert("로그인 하신 후 이용할 수 있습니다.");
					}
 				});
				
				$("#buyBtn").click(function(){
					if(${member != null}) {
						addFrmInfo();
						
						let g_type = parseInt($("#frmCart").find("input[name=g_type]").val());
						
						if(!chkData("#date", "날짜를")) return;
						else if(g_type != 3){
							if(!chkData("#size", "사이즈를")) return;
						}
						
						$("#frmCart").attr({"method" : "post", "action" : "/member/cart/goPayment"});
	 					$("#frmCart").submit();
	 					
					} else{
						alert("로그인 하신 후 이용할 수 있습니다.");
					}
				});
				
				$("#size").change(function(){
					let g_price = parseInt($("#frmCart").find("input[name=g_price]").val());
					if($("#size").val() == 2){
						g_price += 10000;
						$("#frmCart").find("input[name=g_price]").val(g_price);
						console.log($("#frmCart").find("input[name=g_price]").val());
					}
				});
				
				$("#amount").change(function(){
					if($("#size").val() != ""){
						let totalPrice = 0;
						let goodsPrice = 0;
						let goodsAmount = 0;
						
						goodsPrice = parseInt($("#frmCart").find("input[name=g_price]").val());
						console.log(goodsPrice);
						goodsAmount = parseInt($("#amount").val());
						console.log(goodsAmount);
						totalPrice = goodsPrice * goodsAmount;
						
						$("#totalGoodsCnt").html(goodsAmount);
						$("#totalGoodsPrice").html(totalPrice);
					} else{
						alert("사이즈를 먼저 입력해주세요.");
						$("#size").focus();
					}
				});
			});
			
			function addFrmInfo(){
				let g_type = parseInt($("#frmCart").find("input[name=g_type]").val());
				
				let gc_amount = $("#amount").val();
				$("input[name='gc_amount']").val(gc_amount);
				m_id = "${member.m_id}";
				$("input[name='m_id']").val(m_id);
				if(g_type != 3){
					let g_size = $("#size").val();
					$("input[name='g_size']").val(g_size);
				} else{
					$("input[name='g_size']").val(1);
				}
			}
			
		</script>
	</head>
	<body>
		<div class="contentContainer container">
		<div class="goodsImgInfo">
			<div class="goodsImgContainer">
				<img class="goodsImgBig" src="/dorothyUpload/goods/${detail.g_file }" />
			</div>
			<div class="goodsDetail">
				<div id="goodsFormData">
					<form id="frmCart" name="frmCart">
						<input type="hidden" name="g_code" value="${detail.g_code }" />
						<input type="hidden" name="gc_amount" value="" />
						<input type="hidden" name="g_price" value="${detail.g_price }" />
						<input type="hidden" name="m_id" value="" />
						<input type="hidden" name="g_name" value="${detail.g_name }" />
						<input type="hidden" name="g_file" value="${detail.g_file }" />
						<input type="hidden" name="g_size" value="" />
						<input type="hidden" name="g_type" value="${detail.g_type }" />
					</form>
				</div>
				<h4 class="text-left">${detail.g_name }</h4>
				<p class="text-left">${detail.g_price }원</p>
				<form id="order">
					<table id="goodsInfo">
<!-- 						<tr>
							<th class="text-center">배송받는 곳</th>
							<td>
								<input type="text" id="address" placeholder="주소를 입력하세요" />
							</td>
						</tr> -->
						<tr>
							<th class="text-center">수령일</th>
							<td>
								<input type="date" id="date" min="${today }" max="2022-12-31"/>
							</td>
						</tr>
<!-- 						<tr>
							<th class="text-center">수령시간대</th>
							<td>
								<button type="button" class="time">14시-19시</button>
								<button type="button" class="time">19시-22시</button><br />
							</td>
						</tr>
						<tr>
							<th>
							</th>
							<td>
								<span>*토요일은 선택하신 시간대와 관계없이 14시-20시에만 배송됩니다.</span>
							</td>
						</tr> -->
						<c:if test="${detail.g_type ne 3 }">
							<tr>
								<th class="text-center">호수</th>
								<td>
									<select id="size">
										<option value="" selected="selected">= 옵션 : 가격 =</option>
										<option value="1">미니</option>
										<option value="2">1호</option>
									</select>
									<span>*1호를 선택하시면 금액이 1만원 추가됩니다*</span>
								</td>
							</tr>
						</c:if>
						
						<tr>
							<th class="text-center">수량</th>
							<td>
								<input type="number" id="amount" value="1" min="1"/>
							</td>
						</tr>
					</table>
				</form>
				<div id="goodsCheck" hidden="hidden">		
				</div>
				<div id="buttonArea">
					<div>	
						<input id="addCartBtn" type="button" value="ADD TO CART" />
						<input id="buyBtn" type="button" value="BUY NOW" />
					</div>
				</div>
	                 <div class="price_sum">
	                 	<br />
	                     <dl>
	                         <dt>총 <strong id="totalGoodsCnt">0</strong> 개의 상품금액 </dt>
	                         <dd><strong id="totalGoodsPrice">0</strong>원</dd>
	                     </dl>
	                 </div>
	                 <br />
	                 <br />
				<div id="imgs-s">
					<img class="goodsImgSmall" src="/dorothyUpload/goods/${detail.g_file }" />
					<img class="goodsImgSmall" src="/dorothyUpload/goodsDetail/1-${detail.g_file }" />
				</div>
			</div>
		</div>
		<br />
		<div class="DetailInfo">
			<div id="detail">
				<div class="goods_tab">
					<ul>
						<li class="on">
							<a href="#detail">상품상세정보</a>
						</li>
						<li>
							<a href="#delivery">배송안내</a>
						</li>
						<li>
							<a href="#exchange">교환 및 반품안내</a>
						</li>
					</ul>
				</div>
				<div class="detail_img_container">
					<div class="detail_img">
						<img src="/dorothyUpload/goodsDetail/1-${detail.g_file }" />
					</div>
					<div class="detail_img">
						<img src="/dorothyUpload/goodsDetail/2-${detail.g_file }" />
					</div>
				</div>
			</div>
			<div id="delivery">
				<div class="goods_tab">
					<ul>
						<li>
							<a href="#detail">상품상세정보</a>
						</li>
						<li class="on">
							<a href="#delivery">배송안내</a>
						</li>
						<li>
							<a href="#exchange">교환 및 반품안내</a>
						</li>
					</ul>
				</div>
				<div class="delivery_cont">
					<h3>배송안내</h3>
					<div class="admin_msg">
						<p>- 배송비 : 기본 배송료는 3,500원입니다. (도서,산간,오지 일부지역은 배송이 불가합니다.) 40,000원 이상 구매시 무료배송입니다.</p>
						<p>- 택배배송은 주문시점, 배송지에 따라 상이합니다. (서울지역만 당일택배배송이 가능합니다.)</p>
						<p>&nbsp;</p>
						<p>[서울 당일택배배송]</p>
						<p>월요일~금요일 배송 (토요일, 일요일 휴무)</p>
						<p>서울 당일택배배송의 경우 정확한 시간 지정은 어려우며, 우천시 다소 늦어질 수 있습니다.</p>
						<p>&nbsp;</p>
						<p>[전국 우체국택배배송]</p>
						<p>화요일~금요일 배송 (일요일, 월요일 휴무)</p>
						<p>택배배송의 특성상 받는 시간대는 미리 알 수 없는 점 미리 말씀드립니다.</p>
					</div>
				</div>
			</div>
			<div id="exchange">
				<div class="goods_tab">
					<ul>
						<li>
							<a href="#detail">상품상세정보</a>
						</li>
						<li class="on">
							<a href="#delivery">배송안내</a>
						</li>
						<li>
							<a href="#exchange">교환 및 반품안내</a>
						</li>
					</ul>
				</div>
			<div class="exchange_cont">
                <h3>교환 및 반품안내</h3>
                <div class="admin_msg">
                    <p>- 상품 청약철회 가능기간은 상품제작 이전에 가능합니다.&nbsp;</p>
                    <p>- 상품의 제작이 시작된 이후에는 단숨 변심으로 인한 환불 또는 교환은 불가합니다.&nbsp;</p>
                    <p>- 상품 수령 후 상품의 파손 또는 불량으로 인한 부분은 전액 환불 또는 교환이 가능합니다.&nbsp;</p>
                </div>
                <h3>환불안내</h3>
                <div class="admin_msg">
                    <p>- 케이크는 식품 특성상 주문 요청에 의해 제작되기 때문에 단순 변심, 임의 반품에 의한 교환(재배송) 환불이 불가한 점 양해 부탁드립니다.</p><p>- 고객님의 사정으로 인한 주소지 불충분 및 수취지연 시 발생되는 제품의 파손이나 변질에 대해 책임지지 않습니다.</p>
                    <p>- 파손/ 변질된 제품 사진을 접수하지 않는 경우 교환(재배송) 환불이 불가합니다.</p>
                    <p>- 배송된 상품의 신선도나 구성품 누락 시 라니케이크의 책임인 경우 새로운 구성으로 교환해드립니다. (문의 02-123-1234)</p>
                </div>
                <h3>AS안내</h3>
                <div class="admin_msg">
                    <p>- 소비자분쟁해결 기준(공정거래위원회 고시)에 따라 피해를 보상받을 수 있습니다.</p>
                    <p>- A/S는 판매자에게 문의하시기 바랍니다. 전화 : 02-123-1234 우측하단 상담톡을 활용해주시기 바랍니다.&nbsp;</p>
                </div>
            </div>
			</div>
		</div>
		</div>
	</body>
</html>