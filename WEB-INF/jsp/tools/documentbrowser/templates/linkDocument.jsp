<%--
Knowage, Open Source Business Intelligence suite
Copyright (C) 2016 Engineering Ingegneria Informatica S.p.A.

Knowage is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

Knowage is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
--%>


<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="it.eng.spago.navigation.LightNavigationManager"%>

<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="/WEB-INF/jsp/commons/angular/angularResource.jspf"%>

 <%
		 	
			String documentID = "";
 			String documentLabel = "";
			if(request.getParameter("OBJECT_ID")!=null){
				documentID = request.getParameter("OBJECT_ID");
			}
 			if(request.getParameter("OBJECT_LABEL")!=null){
 				documentLabel = request.getParameter("OBJECT_LABEL");
			}
 			
 			Map backUrlPars = new HashMap();
 			backUrlPars.put("PAGE", "detailBIObjectPage");
 			backUrlPars.put(LightNavigationManager.LIGHT_NAVIGATOR_BACK_TO,"0");
 			backUrlPars.put("MESSAGEDET", "DETAIL_SELECT");
 			String backUrl = urlBuilder.getUrl(request, backUrlPars);
 			 			
		%>
		
		<script>
			var documentID = '<%= documentID %>';
			var documentLabel = '<%= documentLabel %>';
			var backUrl =  '<%= backUrl %>';
		</script> 



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
	
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>{{translate.load("Dataset Link");}}</title>
		<%@include file="/WEB-INF/jsp/commons/angular/angularImport.jsp"%>
<%-- 
		<script type="text/javascript" src="/knowage/js/src/angular_1.4/tools/documentbrowser/linkDocument.js"></script>
		<link rel="stylesheet" type="text/css"	href="/knowage/themes/commons/css/customStyle.css">
 --%>
		<script type="text/javascript" src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/documentbrowser/linkDocument.js")%>"></script>
		<link rel="stylesheet" type="text/css"	href="<%=urlBuilder.getResourceLink(request, "themes/commons/css/customStyle.css")%>">
	
		</head>

	<body class="federatedDataset linkDocument" ng-app="linkDocumentModule" id="ng-app">
		
		<div ng-controller="linkDocumentCTRL" layout-fill class="contentdemoBasicUsage">		
		  <div class ="md-container" >
			<md-toolbar class="miniheadfederation" >
				<div class="md-toolbar-tools">
				
				<h2 class="md-flex" >Table Link for  <%= documentLabel %> </h2>
				
				</div>
				
			</md-toolbar>
	
			
	
			<md-content layout-padding class="mainContainer" >
			
			<rest-loading></rest-loading>
			
			<md-select placeholder="Select Source" ng-model="source">
      		<md-option ng-value="source" ng-repeat="source in sourceList" ng-click="getTablesBySourceID(source.sourceId)">{{source.name}}</md-option>
    		</md-select>
			
				<div ng-show="showme == true" layout="row" style="height:680px">
					
					<!-- Avaliable tables -->
					<div flex class="datasetBox">
					  <md-card>	
						<md-toolbar class="miniheadfedsmall"  >
							<div class="md-toolbar-tools">
								<h2 class="md-flex" >Avaibile tables</h2>
								<span flex=""></span>					
							</div>
						</md-toolbar>
						

					
						<md-content  layout-padding>
							<angular-list
							layout-fill 
							id="availableTables_id" 
							ng-model="tablesList" 
							item-name="name"
							show-search-bar=true
							click-function="moveToSelected(item)"
							>					
							</angular-list>
						</md-content>
					 </md-card>	
					</div>
				
					<!-- Selected tables -->
					<div  flex class="datasetBox">
					 <md-card>
						<md-toolbar class="miniheadfedsmall"  >
							<div class="md-toolbar-tools">
								<h2 class="md-flex" >Selected Tables</h2>
								<span flex=""></span>					
							</div>
						</md-toolbar>
					
						<md-content layout-padding >
							<angular-list layout-fill 
							id="selectedTables_id" 
							ng-model="selectedTables" 
							item-name="name" 
							speed-menu-option=removeFromSelected
							>					
							</angular-list>
						</md-content>
					</md-card>
				</div>
				
				<div>
				
				<div>
				<md-button class="md-raised buttonLeft" aria-label="btn_cancel"
				href='<%=backUrl%>'>Cancel
				</md-button> 
				</div>
				<div>
				<md-button class="md-raised buttonRight" aria-label="btn_save"
						ng-click="saveRelation(<%= documentID %>)" ng-disabled="checkSave()">Save
				</md-button>
				</div>
				</div>
				
				
				
			</md-content>
			
		 </div>		 	
		</div>
	
	</body>

</html>
