<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import="gnete.etc.WorkflowConstants"%>
<%response.setHeader("Cache-Control", "no-cache");%>
<%@ include file="/common/taglibs.jsp" %>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@ include file="/common/meta.jsp" %>
		<%@ include file="/common/sys.jsp" %>
		<title>${ACT.name}</title>
		
		<f:css href="/css/page.css"/>
		<f:js src="/js/jquery.js"/>
		
		<f:js src="/js/sys.js"/>
		<f:js src="/js/common.js"/>

		<style type="text/css">
			html { overflow-y: scroll; }
		</style>
	</head>
    
	<body>
		<jsp:include flush="true" page="/layout/location.jsp"></jsp:include>
		
		<div class="userbox">
		<table class="detail_grid" width="98%" border="1" cellspacing="0" cellpadding="1">
			<caption>卡类型审核详细信息<span class="caption_title"> | <f:link href="/cardSubClass/checkList.do?goBack=goBack">返回列表</f:link></span></caption>
						<tr>
							<td width="80" height="30" align="right">卡类型号</td>
							<td>
								${cardSubClassDef.cardSubclass}
							</td>
							<td width="80" height="30" align="right">卡类型名称</td>
							<td>
								${cardSubClassDef.cardSubclassName}
							</td>
							<td width="80" height="30" align="right">卡种</td>
							<td>
								${cardSubClassDef.cardTypeName}
							</td>
						</tr>
						<tr>
							<td width="80" height="30" align="right">卡BIN号</td>
							<td>
								${cardSubClassDef.binNo}
							</td>
							<td width="80" height="30" align="right">参考面值</td>
							<td>
								${fn:amount(cardSubClassDef.faceValue)}
							</td>
							<td width="80" height="30" align="right">会员子类型</td>
							<td>
								${membClassDef.className}
							</td>
						</tr>
						<tr>
							<td width="80" height="30" align="right">初始会员级别</td>
							<td>
								${cardSubClassDef.membLevel}
							</td>
							<td width="80" height="30" align="right">开卡积分</td>
							<td>
								${cardSubClassDef.ptOpencard}
							</td>
							<td width="80" height="30" align="right">折扣子类型</td>
							<td>
								${discntClassDef.className}
							</td>
						</tr>
						<tr>
							<td width="80" height="30" align="right">次数卡子类型</td>
							<td>
								${accuClassDef.className}
							</td>
							<td width="80" height="30" align="right">积分子类型</td>
							<td>
								${pointClassDef.className}
							</td>
							<td width="80" height="30" align="right">赠券子类型</td>
							<td>
								${couponClassDef.className }
							</td>
						</tr>
						<tr>
							<td width="80" height="30" align="right">卡片抵用金</td>
							<td>
								${fn:amount(cardSubClassDef.cardPrice)}
							</td>
							<td width="80" height="30" align="right">密码标志</td>
							<td>
								<s:if test="cardSubClassDef.chkPwd == 1">是</s:if>
								<s:else>否</s:else>
							</td>
							<td width="80" height="30" align="right">密码类型</td>
							<td>
								${cardSubClassDef.pwdTypeName}
							</td>
						</tr>
						<tr>
							<td width="80" height="30" align="right">密码</td>
							<td>
								${cardSubClassDef.pwd}
							</td>
							<td width="80" height="30" align="right">预制卡检查</td>
							<td>
								<s:if test="cardSubClassDef.chkPfcard == 1">是</s:if>
								<s:else>否</s:else>
							</td>
							<td width="80" height="30" align="right">自动销卡标志</td>
							<td>
								<s:if test="cardSubClassDef.autoCancelFlag == 1">是</s:if>
								<s:else>否</s:else>
							</td>
						</tr>
						<tr>
							<td width="80" height="30" align="right">卡内额度上限</td>
							<td>
								${fn:amount(cardSubClassDef.creditUlimit)}
							</td>
							<td width="80" height="30" align="right">单笔充值上限</td>
							<td>
								${fn:amount(cardSubClassDef.chargeUlimit)}
							</td>
							<td width="80" height="30" align="right">单笔消费上限</td>
							<td>
								${fn:amount(cardSubClassDef.consmUlimit)}
							</td>
						</tr>
						<tr>
							<td width="80" height="30" align="right">失效方式</td>
							<td>
								${cardSubClassDef.expirMthdName}
							</td>
							<s:if test="cardSubClassDef.expirMthd == 1">
								<td width="80" height="30" align="right">失效日期</td>
								<td>
									${cardSubClassDef.expirDate}
								</td>
							</s:if>
							<s:else>
								<td width="80" height="30" align="right">有效期(月数)</td>
								<td>
									${cardSubClassDef.effPeriod}
								</td>
							</s:else>
							<td width="80" height="30" align="right">卡延期(月数)</td>
							<td>
								${cardSubClassDef.extenPeriod}
							</td>
						</tr>
						<tr>
							<td width="80" height="30" align="right">最大延期次数</td>
							<td>
								${cardSubClassDef.extenMaxcnt}
							</td>
							<td width="80" height="30" align="right">绝对失效日期</td>
							<td>
								${cardSubClassDef.mustExpirDate}
							</td>
							<td width="80" height="30" align="right">状态</td>
							<td>
								${cardSubClassDef.statusName}
							</td>
						</tr>
						<tr>
							<td width="80" height="30" align="right">售卡面值能否修改</td>
							<td>
								${cardSubClassDef.changeFaceValueName}
							</td>
							<td width="80" height="30" align="right">卡能否充值</td>
							<td>
								${cardSubClassDef.depositFlagName}
							</td>
							<td width="80" height="30" align="right">更新用户名</td>
							<td>
								${cardSubClassDef.updateBy}
							</td>
						</tr>
						<tr>
							<td width="80" height="30" align="right">更新时间</td>
							<td colspan="5">
								<s:date name="cardSubClassDef.updateTime" format="yyyy-MM-dd HH:mm:ss"/>
							</td>
						</tr>
		</table>
		</div>
		
		<!-- 流程相关信息 -->
		<jsp:include flush="true" page="/workflow/flow.jsp">
			<jsp:param name="workflowId" value="<%=WorkflowConstants.CARD_SUB_CLASS_DEF%>"/>
			<jsp:param name="refId" value="${cardSubClassDef.cardSubclass}"/>
		</jsp:include>

		<jsp:include flush="true" page="/layout/copyright.jsp"></jsp:include>
	</body>
</html>