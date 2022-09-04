<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
    <style type="text/css">
		.order_tit > ol li{float: left; }
		.pick_add_info a{text-decoration : none; color: black;}
		.cart_table thead, tr{border-bottom : 1px solid gray;}
		.no_line tr{border-bottom : 0;}
		.no_line td{padding : 15px;}
		.cart_table{margin-left : 130px;}
		.imgsize-s{border: 0; max-width: 100%; vertical-align: top; margin : 20px 10px 10px 10px;}
		.amountChange{text-decoration : none; color: black;}
		input[type=number]{width : 50px;}
	</style>
	
	<script type="text/javascript">
		$(function(){
			$(".amountChange").click(function(){
				let gc_amount = $(this).parents(".order_goods_num").find(".otherAmount").val();
				let gc_num = $(this).parents(".cart_info_tr").find(".cartCheck").attr("data-num");


				$("#changeGc_num").val(gc_num);
				$("#changeGc_amount").val(gc_amount);
				
				$("#amountUpdate").attr({
					"method":"post",
					"action":"/member/cart/cartUpdate"
				});
				$("#amountUpdate").submit();
			});
			$("#checkItemOrder").on("click", function(){
				let codeArr = [];
				
				$(".cart_info_tr").each(function(index, element){
					
					if($(element).find(".cartCheck").is(":checked") === true){	//체크여부
						
						let gc_num = $(element).find(".cartCheck").attr("data-num");
						codeArr.push(gc_num);
					}
				});
				$("#codeList").val(codeArr);
				console.log($("#codeList").val());
				$("#paymentForm").attr({
					"method":"post",
					"action":"/payment/paymentPage"
				});
				$("#paymentForm").submit();
			});
				
			$("#allItemOrder").on("click", function(){
				let codeArr = [];
				
				$(".cart_info_tr").each(function(index, element){
					
					let gc_num = $(element).find(".cartCheck").attr("data-num");
					codeArr.push(gc_num);
				});	
				
				$("#codeList").val(codeArr);
				console.log($("#codeList").val());
				$("#paymentForm").attr({
					"method":"post",
					"action":"/payment/paymentPage"
				});
				$("#paymentForm").submit();
			});
			
			$("#allCheck").click(function(){
				if($("#allCheck").is(":checked")){
					$("input[name='cartCheck']").prop("checked", true);
				}else{
					$("input[name='cartCheck']").prop("checked", false);
				}
			});
			
			$("#goCakeList").click(function(){
				location.href = "/member/goods/goodsList";
			});
			
			$("#deleteCart").click(function(){
				if(confirm("정말 삭제하시겠습니까?")){
					let numArr = [];
					
					$("input:checkbox[name=cartCheck]:checked").each(function(){
						numArr.push($(this).attr("data-num"));
					});
					
					
					$.ajax({
						url: "/member/cart/deleteAll",
						type: "post",
						traditional : true,
						data: { "numArr" : numArr },
						error: function(request,status,error){
							alert("문제가 발생했습니다. 잠시 후에 다시 시도해 주세요.");
						},
						success: function(resultData){
							alert("선택한 상품이 삭제되었습니다.");
							location.reload();
						}
					});
				}
			});
			
			$("#allCheck").change(function(){
				totalInfo();
			});
			
			$("input[name='cartCheck']").change(function(){
				totalInfo();
			});

		});
		
		function totalInfo(){
			let totalPrice = 0;
			let totalCount = 0;
			let cartPrice = 0;
			let cartAmount = 0;
			
			$(".cart_info_tr").each(function(index, element){
				
				if($(element).find(".cartCheck").is(":checked") === true){	//체크여부
					cartPrice = parseInt($(element).find(".cartCheck").attr("data-price"));
					cartAmount = parseInt($(element).find(".cartCheck").attr("data-amount"));
					totalCount += cartAmount;
					totalPrice += cartPrice * cartAmount;
				}
			}); 
			
			$("#totalGoodsCnt").html(totalCount);
			$("#totalGoodsPrice").html(totalPrice);
		}
		
	</script>
	
<div class="content_box">
    <div class="order_wrap">
        <div class="order_tit">
        <form id="paymentForm">
        	<input type="hidden" name="codeList" id="codeList" />
        </form>
        </div>
        <!-- //order_tit -->

        <div class="cart_cont">
			<div >
				<c:choose>
					<c:when test="${not empty cartList }">
						<div class="cart_table">
							<table>
       							<colgroup>
	                                <col style="width:100px">  <!-- 체크박스 -->
	                                <col style="width:700px">					<!-- 상품명/옵션 -->
	                                <col style="width:200px">  <!-- 수량 -->
	                                <col style="width:300px"> <!-- 상품금액 -->
	                                <col style="width:300px"> <!-- 합계금액 -->
                           	 	</colgroup>
								<thead>
                            		<tr>
		                                <th>
		                                    <div class="form_element">
		                                        <input type="checkbox" id="allCheck" class="gd_select_all_goods" data-target-id="cartSno1_" data-target-form="#frmCart">
		                                        <label for="allCheck1" class="check_s on"></label>
		                                    </div>
		                                </th>
		                                <th>상품/옵션 정보</th>
		                                <th>수량</th>
		                                <th>상품금액</th>
		                                <th>합계금액</th>
                            		</tr>
                         	    </thead>
                         	    <tbody>
						<c:forEach var="cart" items="${cartList}">
                            <tr class="cart_info_tr">
                                <td class="td_chk">
                                    <div class="form_element">
                                        <input type="checkbox" class="cartCheck" name="cartCheck" data-num="${cart.gc_num }" data-code="${cart.g_code }" data-file="${cart.g_file }" data-size="${cart.g_size }" data-name="${cart.g_name}" data-amount="${cart.gc_amount}" data-price="${cart.g_price }" data-m-id="${cart.m_id }"/>
                                    </div>
                                </td>
                                <td class="aqtd_left">
                                    <div class="pick_add_cont">
                                    	<table class="no_line">
                                    		<tr>
                                    			<td>
                                    			<span class="pick_add_img">
                                           		 <a href="/member/cart/cartList"><img src="/dorothyUpload/goods/${cart.g_file }" width="80" class="imgsize-s" /></a>
                                        		</span>
                                       			 </td>
                                       			 <td>
                                       			 <div class="pick_add_info">
                                            <em><a href="/member/goods/goodsDetail?g_code=${cart.g_code }">${cart.g_name}</a></em>

                                            <div class="pick_option_box">
                                                <span class="text_type_cont">호수 : </span>
                                                <c:if test="${cart.g_size eq 1 }">
                                                	미니
                                                </c:if>
                                                <c:if test="${cart.g_size eq 2 }">
                                                	1호
                                                </c:if>
                                            </div>

                                            <!-- tuning -->
<!--                                             <div class="pick_option_box">
                                                서울특별시 강서구 공항대로8길 18-8<br/>
                                                당일배송
                                                (2022-08-13 /  14시-19시)

                                            </div> -->
                                            <!-- tuning -->

                                        </div>
                                       			 </td>
                                    		</tr>
                                    	</table>
                                        
                                        
                                    </div>
                                    <!-- //pick_add_cont -->

                                    <!-- //pick_add_list -->

                                </td>
                                <td class="td_cart_amount">
                                    <div class="order_goods_num">
                                        <strong><input class="otherAmount" type="number" min="1" value="${cart.gc_amount }" />개</strong>
                                        <div class="btn_gray_list">
                                            <a href="#" class="amountChange"><span>수량변경</span></a>
                                        </div>
                                    </div>
                                </td>
                                <td class="td_cart_price">
                                    <strong>${cart.g_price }원</strong>
                                </td>
                                <td>
                                    <strong>${cart.g_price * cart.gc_amount }원</strong>
                                </td>
                            </tr>
						</c:forEach>
								</tbody>
							</table>
						</div>
					</c:when>
					<c:otherwise>
						<p class="no_data">장바구니에 담겨있는 상품이 없습니다.</p>
					</c:otherwise>
				</c:choose>
			</div>
            <form id="frmCart" name="frmCart" >
            </form>
            
            <form id="amountUpdate" name="amountUpdate" >
            	<input type="hidden" id="changeGc_num" name="changeGc_num" />
            	<input type="hidden" id="changeGc_amount" name="changeGc_amount" />
            </form>
			<br />
			<br />
			<div class="contentBtn text-right">
                <input type="button" value="쇼핑 계속하기" id="goCakeList" class="btn btn-success">
            </div>

            <div class="price_sum text-right">
                <div class="price_sum_cont">
                    <div class="price_sum_list">
                        <dl>
                            <dt>총 <strong id="totalGoodsCnt">0</strong> 개의 상품금액 </dt>
                            <dd><strong id="totalGoodsPrice">0</strong>원</dd>
                        </dl>
                    </div>
                </div>
            </div>      
        </div>
        <div class="contentBtn text-right">
                        <input type="button" value="선택 상품 삭제" id="deleteCart" class="btn btn-success">
                <input type="button" value="선택 상품 주문" id="checkItemOrder" class="btn btn-success">
                <input type="button" value="전체 상품 주문" id="allItemOrder" class="btn btn-success">
        </div> 
    </div>
</div>