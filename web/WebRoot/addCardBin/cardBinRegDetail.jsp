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
			<caption>卡BIN申请记录详细信息<span class="caption_title"> | <f:link href="/addCardBin/regList.do?goBack=goBack">返回列表</f:link></span></caption>
			<tr>
				<td>卡BIN号码</td>
				<td>${cardBinReg.binNo}</td>
				<td>卡BIN名称</td>
				<td>${cardBinReg.binName}</td>
		  	</tr>
		  	<tr>
				<td>发卡机构</td>
				<td>${cardBinReg.cardIssuer}-${fn:branch(cardBinReg.cardIssuer)}</td>
				<td>卡种</td>
				<td>${cardBinReg.cardTypeName}</td>
		  	</tr>
		  	<tr>
				<td>币种代码</td>
				<td>${cardBinReg.currCode}</td>
				<td>状态</td>
				<td>${cardBinReg.statusName}</td>
		  	</tr>
		  	<tr>
				<td>申请发起方</td>
				<td>${cardBinReg.initiator}-${fn:branch(cardBinReg.initiator)}</td>
				<td>更新用户代码</td>
				<td>${cardBinReg.updateBy}</td>
		  	</tr>
		  	<tr>
				<td>更新时间</td>
				<td><s:date name="cardBinReg.updateTime" format="yyyy-MM-dd HH:mm:ss" /></td>
				<td></td>
				<td></td>
		  	</tr>
		</table>
		</div>
		
		<jsp:include flush="true" page="/workflow/flow.jsp">
			<jsp:param name="workflowId" value="<%=WorkflowConstants.CARD_BIN_REG%>"/>
			<jsp:param name="refId" value="${cardBinReg.id}"/>
		</jsp:include>

		<jsp:include flush="true" page="/layout/copyright.jsp"></jsp:include>
	</body>
</html>