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
<html ng-app="profileAttributesManagementModule">
<head>
<%@include file="/WEB-INF/jsp/commons/angular/angularImport.jsp"%>

<!-- Styles -->
<!--  link rel="stylesheet" type="text/css"	href="/knowage/themes/glossary/css/generalStyle.css"-->
<!--  link rel="stylesheet" type="text/css"	href="/knowage/themes/catalogue/css/catalogue.css"-->

<link rel="stylesheet" type="text/css"    href="<%=urlBuilder.getResourceLink(request, "themes/commons/css/customStyle.css")%>">
<%-- 
<script type="text/javascript" src="/knowage/js/src/angular_1.4/tools/commons/angular-table/AngularTable.js"></script>

<script type="text/javascript" src="/knowage/js/src/angular_1.4/tools/catalogues/profileAttributesManagement.js"></script> 
--%>
<script type="text/javascript" src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/commons/angular-table/AngularTable.js")%>"></script>

<script type="text/javascript" src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/catalogues/profileAttributesManagement.js")%>"></script>


</head>
<body class="bodyStyle" ng-controller="profileAttributesManagementController as ctrl" >
	<angular-list-detail  show-detail="showMe">
		 	<list label='translate.load("sbi.attributes.title")' new-function="createProfileAttribute"> 
			
				<angular-table  
				        flex
 						id="profileAttributesList"
 						ng-model="attributeList" 
 						columns='[ 
 						         {"label":"Name","name":"attributeName"}, 
 						         {"label":"Description","name":"attributeDescription"}, 
 						         ]' 
 						columns-search='["attributeName","attributeDescription"]'
 						show-search-bar=true 
 						highlights-selected-item=true 
 						speed-menu-option="paSpeedMenu" 
						click-function="loadAttribute(item)">						
 				 </angular-table>
              
	</list> 
	<detail label='(selectedAttribute.attributeName==undefined)? "" : selectedAttribute.attributeName'  save-function="saveProfileAttribute"
		cancel-function="cancel"
		disable-save-button="!attributeForm.$valid"
		show-save-button="showMe" show-cancel-button="showMe">
		<div layout-fill class="containerDiv">
			<form name="attributeForm" ng-submit="attributeForm.$valid && saveProfileAttribute()" class="detailBody mozSize">
				<md-card layout-padding>
      						<div flex=100>
       							<md-input-container class="md-block">
       								<label>{{translate.load("sbi.attributes.headerName")}}</label>
       								<input 	ng-model="selectedAttribute.attributeName" 
       										required
       										name="name"
        									ng-change="setDirty()"  
        									ng-maxlength="255"
        									ng-pattern="regex.alphanumeric">		
        							<div ng-messages="attributeForm.name.$error" role="alert" ng-messages-multiple>
										<div ng-message="pattern">{{translate.load("sbi.config.manage.fields.validation.alphanumericRegex")}}</div>
										<div ng-message="maxlength">{{translate.load("sbi.config.manage.fields.validation.maximumCharacters")}} 255</div>
	  								</div>
        						</md-input-container>
    						</div>
      						<div flex=100>
       							<md-input-container class="md-block">
       								<label>{{translate.load("sbi.attributes.headerDescr")}}</label>
       								<input 	ng-model="selectedAttribute.attributeDescription"       									
       										name="description"
        									ng-change="setDirty()"
        									ng-maxlength="500"
        									ng-pattern="regex.extendedAlphanumeric">
        							<div ng-messages="attributeForm.description.$error" role="alert" ng-messages-multiple>
										<div ng-message="pattern">{{translate.load("sbi.config.manage.fields.validation.extendedAlphanumericRegex")}}</div>
										<div ng-message="maxlength">{{translate.load("sbi.config.manage.fields.validation.maximumCharacters")}} 500</div>
	  								</div>
        						</md-input-container>
      						</div>
				</md-card>
			</form>
		</div>	
	</detail>
	</angular-list-detail>
</body>
</html>
