<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%response.setHeader("Cache-Control", "no-cache");%>
<%@ include file="/common/taglibs.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="/common/meta.jsp" %>
		<%@ include file="/common/sys.jsp" %>
		<title>${ACT.name}</title>
		
		<f:css href="/css/page.css"/>
		<f:js src="/js/jquery.js"/>
		<f:js src="/js/plugin/jquery.metadata.js"/>
		<f:js src="/js/plugin/jquery.validate.js"/>
		
		<f:js src="/js/sys.js"/>
		<f:js src="/js/common.js"/>
		
		<f:css href="/css/multiselctor.css"/>
		<f:js src="/js/plugin/jquery.multiselector.js"/>
		
		<style type="text/css">
			html { overflow-y: scroll; }
		</style>
		<script>
			$(function(){
				var branchCode = $('#idBranchCode').val();
				
				$('#idMerchs_sel').focus(function(){
					var proxyId = $('#idProxyId').val();
					if (isEmpty(proxyId)){
						showMsg('请先选择代理机构再选择商户');
					}
				});
				
				$('#idFeeType').change(function(){
					var value = $(this).val();
					if (value == '0' || value == '1') {
						$('td[id^="idFeeRateTd_"]').show();
						$('#idFeeRate').removeAttr('disabled');
						//$('#idCostCycle').removeAttr('disabled');
						$('#idSectTbl').hide();
					} else if (value == '2' || value == '3') {
						//$('#idCostCycle').val('2').attr('disabled', 'true');
						$('td[id^="idFeeRateTd_"]').hide();
						$('#idFeeRate').attr('disabled', 'true');
						$('#idSectTbl').show();
					} else {
						$('td[id^="idFeeRateTd_"]').hide();
						$('#idFeeRate').attr('disabled', 'true');
						//$('#idCostCycle').removeAttr('disabled');
						$('#idSectTbl').hide();
					}
					if (value == '0') {
						$('#idFeeRateTip').html('元');
					} else if (value == '1') {
						$('#idFeeRateTip').html('%');
					} 
				});
				
				$('#idProxyId').change(function(){
					var value = $(this).val();
					if (isEmpty(value)){
						$('#idMerchs_sel').focus(function(){
							var proxyId = $('#idProxyId').val();
							if (isEmpty(proxyId)){
								showMsg('请先选择代理机构再选择商户');
							}
						});
					} else {
						$('#idMerchs_sel').unbind().removeMulitselector();
						$('#idMerchs_sel').val('');
						$('#idMerchs').val('');
						Selector.selectMerch('idMerchs_sel', 'idMerchs', false, branchCode, value);
					}
				});
			});
			function addItem() {
				var count = $('tr[id^="idDetail_"]').size();
					var content = '<tr id="idDetail_'+ (count+1) +'"><td align="center">'+ (count+1) +'</td><td align="center"><input type="text" name="ulimit" onblur="formatCurrency(this)" value="" id="inputForm_ulimit" /></td><td align="center" ><input type="text" name="feeRate" value="" id="inputForm_feeRate" />%</td></tr>';
				
				$('#idXh').html(count+2);
				$('#idDetailMax').before(content);
			
				// 设置样式
				SysStyle.setFormGridStyle();
			}
			function deleteItem() {
				var count = $('tr[id^="idDetail_"]').size();
				if (count == 0) {
					$('#idXh').html('1');
					showMsg('必须设置一项');
					return;
				}
				$('#idXh').html(count);
				$('tr[id^="idDetail_"]:last').remove();
			}
			
			function check(){
				if(!isDisplay('idSectTbl')){
					return true;
				}
				var count = $('tr[id^="idDetail"]').size();
				for(i=0; i<count; i++){
					var $objU = $('tr[id^="idDetail"]').eq(i).children().eq(1).children()
					var objUValue = $objU.val().toString().replace(/\$|\,/g, '');
					
					var $objR = $('tr[id^="idDetail"]').eq(i).children().eq(2).children()
					var objRValue = $objR.val().toString().replace(/\$|\,/g, '');
					
					if((isNaN(objUValue))||(isNaN(objRValue))){
						showMsg("“分段金额上限”、“手续费分润比率”请输入数字");
						return false;
					}
					if((objUValue=="")||(objUValue < 0 )){
						showMsg("分段金额上限不能小于 0 ，请重新输入！");
						return false;
					}
					if(!isDecimal(objUValue, '14,2')){
						showMsg("分段金额最大为12位整数，2位小数，必须为Num(14,2)");
						return false;
					}
					if((objRValue=="")||(objRValue < 0 )){
						showMsg("手续费分润比率不能小于 0 ，请重新输入！");
						return false;
					}
					if(!isDecimal(objRValue, '14,4')){
						showMsg("手续费分润比率最大10位整数，4位小数，为必须为Num(14,4)");
						return false;
					}
				}
				for(i=1; i<count; i++){
					var $preObj = $('tr[id^="idDetail"]').eq(i-1).children().eq(1).children()
					var $nextObj = $('tr[id^="idDetail"]').eq(i).children().eq(1).children()
					var preValue = $preObj.val();
					preValue = preValue.toString().replace(/\$|\,/g, '');
					
					var nextValue = $nextObj.val();
					nextValue = nextValue.toString().replace(/\$|\,/g, '');
					
					if(Number(preValue) > Number(nextValue)){
						showMsg("后段“分段金额上限”必须大于前段“分段金额上限” ，请重新输入！");
						return false;
					}				
				}
				return true;
			}
			
			function submitForm(){
				if(!check()){
					return false;
				}
				$('#idCostCycleHidden').val($('#idCostCycle').val());
				$("#inputForm").submit();
			}
		</script>
	</head>
    
	<body>
		<jsp:include flush="true" page="/layout/location.jsp"></jsp:include>
		
		<div class="userbox">
			<b class="b1"></b><b class="b2"></b><b class="b3"></b><b class="b4"></b>	
			<div class="contentb">
			<s:form action="add.do" id="inputForm" cssClass="validate">
				<table class="form_grid" width="100%" border="0" cellspacing="3" cellpadding="0">
					<caption>${ACT.name}</caption>
					<tr>
						<td width="80" height="30" align="right">发卡机构</td>
						<td>
							<s:hidden  id="idBranchCode" name="merchProxyShares.branchCode" ></s:hidden>
							<s:textfield  id="idBranchName" name="merchProxyShares.branchName" cssClass="readonly" readonly="true"></s:textfield>
						</td>
					</tr>
					<tr>
						<td width="80" height="30" align="right">商户代理</td>
						<td>
							<s:select id="idProxyId" name="merchProxyShares.proxyId" headerKey="" headerValue="--请选择--" cssClass="{required:true}" list="proxyList" listKey="branchCode" listValue="branchName"></s:select>
						</td>
						
						<td width="80" height="30" align="right">商户</td>
						<td>
							<s:hidden id="idMerchs" name="merchs"/>
							<s:textfield id="idMerchs_sel" name="merchName"></s:textfield>
							<span class="field_tipinfo">不选为通用</span>
						</td>
					</tr>
					<tr>
						<td width="80" height="30" align="right">分润方式</td>
						<td>
							<s:select id="idFeeType" name="merchProxyShares.feeType" list="feeTypeList" headerKey="" headerValue="--请选择--" listKey="value" listValue="name" cssClass="{required:true}"></s:select>
						</td>
						<td width="80" height="30" align="right">分润周期</td>
						<td>
							<s:select id="idCostCycle" name="costCycle" list="costCycleList" listKey="value" listValue="name" cssClass="{required:true}"></s:select>
							<s:hidden id="idCostCycleHidden" name="merchProxyShares.costCycle"></s:hidden>
						</td>
					</tr>
					<tr>
						<td width="80" height="30" align="right">商户交易币种</td>
						<td>
							<s:select name="merchProxyShares.curCode" list="currCodeList" headerKey="" headerValue="--请选择--" listKey="currCode" listValue="currName" cssClass="{required:true}"></s:select>
						</td>
						<td width="80" height="30" align="right" id="idFeeRateTd_1" style="display: none;">手续费分润比率</td>
						<td colspan="3" id="idFeeRateTd_2" style="display: none;">
							<s:textfield id="idFeeRate" name="feeRateComma" cssClass="{required:true, decimal:'14,4'}" disabled="disabeld"></s:textfield><span id="idFeeRateTip">%</span>
							<span class="field_tipinfo">最大10位整数，4位小数</span>
						</td>
					</tr>
				</table>
				<table class="form_grid" width="60%" border="0" cellspacing="3" cellpadding="0" id="idSectTbl" style="display:none;">
					<tr>
					   <td align="center" nowrap class="titlebg">序号</td>
					   <td align="center" nowrap class="titlebg">分段金额上限</td>
					   <td align="center" nowrap class="titlebg">手续费分润比率</td>
					</tr>
					<tr id="idDetailMax">
						<td align="center" id="idXh">1</td>
						<td align="center">
							<s:textfield name="ulimit" value="999999999999.99" readonly="true" cssClass="readonly"/>
						</td>
						<td align="center" >
							<s:textfield name="feeRate" value=""/>%
						</td>
					</tr>
					<tr id="idLink" style="line-height: 30px;">
						<td align="left" colspan="4" style="padding-left: 20px;">
							<span class="redlink"><a href="javascript:void(0);" onclick="javascript:addItem();">增加一项</a><a class="ml30" href="javascript:void(0);" onclick="javascript:deleteItem();">删除一项</a></span>
						</td>
					</tr>
				</table>
				<table class="form_grid" width="80%" border="0" cellspacing="3" cellpadding="0">
					<tr>
						<td width="80" height="30" align="right">&nbsp;</td>
						<td height="30" colspan="3"> 
							<input type="button" value="提交" id="input_btn2"  name="ok" onclick="return submitForm()"/>
							<input type="button" value="清除" name="escape" onclick="FormUtils.reset('inputForm')" class="ml30" />
							<input type="button" value="返回" name="escape" onclick="gotoUrl('/fee/merchProxyShares/list.do?goBack=goBack')" class="ml30" />
						</td>
					</tr>
				</table>
				<s:token name="_TOKEN_MERCHPROXYSHARES_ADD"/>
			</s:form>
		</div>
			<b class="b4"></b><b class="b3"></b><b class="b2"></b><b class="b1"></b>
		</div>
		<jsp:include flush="true" page="/layout/copyright.jsp"></jsp:include>
	</body>
</html>