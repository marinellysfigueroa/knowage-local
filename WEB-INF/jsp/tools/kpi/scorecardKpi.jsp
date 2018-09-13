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


<%@ page language="java" pageEncoding="utf-8" session="true"%>


<%-- ---------------------------------------------------------------------- --%>
<%-- JAVA IMPORTS															--%>
<%-- ---------------------------------------------------------------------- --%>


<%@include file="/WEB-INF/jsp/commons/angular/angularResource.jspf"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="scorecardManager">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<%@include file="/WEB-INF/jsp/commons/angular/angularImport.jsp"%>
<link rel="stylesheet" type="text/css"	href="<%=urlBuilder.getResourceLink(request, "themes/commons/css/customStyle.css")%>"> 
<script type="text/javascript" src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/kpi/scorecardKpiController.js")%>"></script>
<script type="text/javascript" src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/kpi/scorecardSubController/scorecardDefinitionController.js")%>"></script>
<script type="text/javascript" src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/kpi/scorecardSubController/scorecardPerspectiveDefinitionController.js")%>"></script>
<script type="text/javascript" src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/kpi/scorecardSubController/scorecardTargetDefinitionController.js")%>"></script>

<!-- 	breadCrumb -->
<script type="text/javascript" src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/commons/BreadCrumb.js")%>"></script>
<link rel="stylesheet" type="text/css" href="<%=urlBuilder.getResourceLink(request, "themes/glossary/css/bread-crumb.css")%>">

<script type="text/javascript" src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/kpi/directive/kpiSemaphoreIndicator/kpiSemaphoreIndicator.js")%>"></script>
<script type="text/javascript" src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/kpi/directive/kpiColorIndicator/kpiColorIndicator.js")%>"></script>
</head>
<body class="kn-scorecardKpiDefinition" ng-cloak>

	<angular-list-detail ng-controller="scorecardMasterController"  full-screen="true">
		<list label="translate.load('sbi.kpi.scorecard.scorecard.list')" ng-controller="scorecardListController" new-function="newScorecardFunction" layout-column>
		 	<angular-table flex id='scorecardListTable' ng-model=scorecardList
				columns='scorecardColumnsList'
				columns-search='["name","author"]'
			 	 show-search-bar=true
			 	 speed-menu-option = scorecardListAction
				 click-function="scorecardClickEditFunction(item, index);" > </angular-table>
		</list>
		
		<extra-button>
		 <md-button ng-click="broadcastCall('saveTarget')" ng-if="selectedStep.value==2" >{{translate.load('sbi.kbi.scorecard.goal.save')}}</md-button>
		 <md-button  ng-click="broadcastCall('cancelTarget')" ng-if="selectedStep.value==2" >{{translate.load('sbi.browser.defaultRole.cancel')}}</md-button>
		 
		 <md-button  ng-click="broadcastCall('savePerspective')" ng-if="selectedStep.value==1" >{{translate.load('sbi.kbi.scorecard.perspective.save')}}</md-button>
		 <md-button  ng-click="broadcastCall('cancelPerspective')" ng-if="selectedStep.value==1" >{{translate.load('sbi.browser.defaultRole.cancel')}}</md-button>
		</extra-button>
		
				
		<detail label="getNameForBar()" ng-controller="scorecardDetailController"
		 save-function="saveScorecardFunction"
		 cancel-function="cancelScorecardFunction"
		 show-save-button="selectedStep.value==0"
		 show-cancel-button="selectedStep.value==0"
		 ng-switch="selectedStep.value"
		 layout="column" >
		 <!--  md-whiteframe class="md-whiteframe-1dp" >
			<bread-crumb ng-model=steps.stepItem item-name='name' selected-index='selectedStep.value' control='steps.stepControl' disable-go-back="true"> </bread-crumb>
		 </md-whiteframe-->
			<div ng-switch-when="0" layout="column" flex ng-controller="scorecardDefinitionController">
				<%@include	file="./scorecardTemplate/scorecardDefinitionTemplate.jsp"%>
			</div>
		
			<div ng-switch-when="1" layout="column" flex ng-controller="scorecardPerspectiveDefinitionController">
		<!-- 		<md-button class="md-raised" ng-click="addTarget();">Aggiungi obiettivo</md-button>   -->	
				<%@include	file="./scorecardTemplate/scorecardPerspectiveDefinitionTemplate.jsp"%>
			</div>
			
			<div ng-switch-when="2" layout="column" flex ng-controller="scorecardTargetDefinitionController">	
				<%@include	file="./scorecardTemplate/scorecardTargetDefinitionTemplate.jsp"%>
			</div>
		</detail>
		
	</angular-list-detail>
</body>
</html>
