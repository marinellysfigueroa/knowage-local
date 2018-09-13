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


<%@include file="/WEB-INF/jsp/commons/angular/angularResource.jspf"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<%@include file="/WEB-INF/jsp/commons/angular/angularImport.jsp"%>
<link rel="stylesheet" type="text/css"	href="<%=urlBuilder.getResourceLink(request, "themes/commons/css/customStyle.css")%>"> 

<script type="text/javascript"
	src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/servermanager/documentImportExport/importExportDocumentsController.js")%>"></script>
<script type="text/javascript"
	src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/servermanager/documentImportExport/importDocumentsStep0Controller.js")%>"></script>
<script type="text/javascript"
	src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/servermanager/documentImportExport/importDocumentsStep1Controller.js")%>"></script>
<script type="text/javascript"
	src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/servermanager/documentImportExport/importDocumentsStep2Controller.js")%>"></script>
<script type="text/javascript"
	src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/servermanager/documentImportExport/importDocumentsStep3Controller.js")%>"></script>
<script type="text/javascript"
	src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/servermanager/documentImportExport/importDocumentsStep4Controller.js")%>"></script>


<!-- 	breadCrumb -->
<script type="text/javascript"
	src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/commons/BreadCrumb.js")%>"></script>

</head>
<body class="bodyStyle kn-importExportDocument" ng-app="importExportDocumentModule" id="ng-app">
<rest-loading></rest-loading>
	<!-- TODO using correct message -->
	<div ng-controller="importExportController " layout="column"
		layout-fill layout-wrap class="contentdemoBasicUsage">

		<md-toolbar class="miniheadimportexport">
		<div class="md-toolbar-tools">
			<i class="fa fa-exchange fa-2x"></i>
			<h2 class="md-flex">{{translate.load("sbi.impexpdocuments");}}</h2>
		</div>
		</md-toolbar>

		<md-content class="mainContainer" flex layout-wrap> <!-- 		md-center-tabs md-stretch-tabs="always" -->
		<md-tabs layout-fill class="absolute"> <!-- Export -->
			<md-tab id="exportTab"> 
		 		<md-tab-label>{{translate.load("SBISet.export","component_impexp_messages");}}</md-tab-label>
				<md-tab-body> 
				  <md-card>
					<md-content ng-controller="exportController">
				
						<div ng-if="flags.viewDownload" class="md-body-2 kn-info">
							
				
							<span><i class="fa fa-file-archive-o"></i>&nbsp; {{downloadedFileName}}.zip </span>
							<md-button class="md-raised" ng-click="downloadFile()">{{translate.load("Sbi.download","component_impexp_messages");}}
							</md-button>
							<md-button ng-click="toggleViewDownload()"
								class="md-icon-button md-primary kn-close-Info" aria-label="Settings">
							<md-icon md-font-icon="fa fa-times"></md-icon> </md-button>							
<!-- 							<p >{{translate.load("SBISet.importexport.exportCompleteResourcesWarning","component_impexp_messages");}}</p> -->

						</div>

						<div layout="column" layout-padding layout-wrap>
							<div layout="row" layout-wrap class="w100" >
				
								<md-input-container flex class="md-block"> <label>{{translate.load("SBISet.importexport.nameExp","component_impexp_messages");}}</label>
								<input type="text" ng-model="exportName" required> </md-input-container>
				
								<md-button class="md-fab md-mini"
									ng-click="exportFiles(selected)"
									ng-disabled="selected.length==0 || exportName===undefined || exportName.length == 0"
									aria-label="{{translate.load('SBISet.importexport.fileArchive','component_impexp_messages')}}">
								<md-icon class="fa fa-download fa-2x"></md-icon> 
								</md-button>
				
							</div>
							<div layout-padding layout-gt-sm="row"
								layout-align-gt-sm="start center" layout-sm="column">
								<md-checkbox class="little-check" ng-model="checkboxs.exportSubObj"
									aria-label="Export sub views">{{translate.load("SBISet.importexport.expSubView","component_impexp_messages");}}</md-checkbox>
								<md-checkbox class="little-check"
									ng-model="checkboxs.exportSnapshots" aria-label="Export snapshots">{{translate.load("SBISet.importexport.expSnapshots","component_impexp_messages");}}</md-checkbox>
								<md-checkbox class="little-check"
									ng-model="checkboxs.exportCrossNav" aria-label="Export cross">{{translate.load("SBISet.importexport.expCrossNav","component_impexp_messages");}}</md-checkbox>
								<md-checkbox class="little-check"
									ng-model="checkboxs.exportBirt" aria-label="Export BIRT">{{translate.load("SBISet.importexport.expBirtTranslation","component_impexp_messages");}}</md-checkbox>
							    <md-checkbox class="little-check"
									ng-model="checkboxs.exportScheduler" aria-label="Export sched">{{translate.load("SBISet.importexport.expScheduler","component_impexp_messages");}}</md-checkbox>
						 
							</div>
							<div layout-padding layout-gt-sm="row"
								layout-align-gt-sm="start center" layout-sm="column">
								<h4>{{translate.load("sbi.impexpdoc.filterdoc")}}:</h4>
								<md-datepicker ng-model="filterDate" md-placeholder="Enter date"></md-datepicker>
								<md-button class="md-icon-button" ng-click="filterDocuments()">
							 		<md-icon md-font-icon="fa fa-filter" aria-label="Filter"></md-icon>
								 </md-button>
								 <md-button class="md-icon-button" ng-click="removeFilter()">
							 		<md-icon md-font-icon="fa fa-times" aria-label="Remove Filter"></md-icon>
								 </md-button>
							</div>
							<div layout-padding>
								<!--
 								<document-tree ng-model="folders" id="impExpTree" create-tree="true"
									selected-item="selected" multi-select="true" show-files="true">
								</document-tree>
								-->
								<component-tree ng-model="folders" remove-empty-folder=true id="impExpTree" create-tree="true"
									selected-item="selected" multi-select="true" show-files="true">
								</component-tree>
							</div>
						</div>
				</md-content>
			   </md-card>	
			 </md-tab-body>
		 </md-tab> 
		 <!-- Import -->
		  <md-tab id="importTab">
		  	<md-tab-label>{{translate.load("SBISet.import","component_impexp_messages");}}</md-tab-label>
				<md-tab-body> 
				  <md-card>
					<md-content ng-controller="importController" ng-cloak ng-switch="selectedStep">
						<bread-crumb
							ng-model=stepItem item-name='name' selected-index='selectedStep'
							control='stepControl'>
						</bread-crumb>

						<div class="importSteps" flex ng-controller="importControllerStep0" ng-switch-when="0"><%@include	file="./importDocumentsSteps/importDocumentsStep0.jsp"%></div>
						<div class="importSteps" flex ng-controller="importControllerStep1" ng-switch-when="1"><%@include	file="./importDocumentsSteps/importDocumentsStep1.jsp"%></div>
						<div class="importSteps" flex ng-controller="importControllerStep2" ng-switch-when="2"><%@include	file="./importDocumentsSteps/importDocumentsStep2.jsp"%></div>
						<div class="importSteps" flex ng-controller="importControllerStep3" ng-switch-when="3"><%@include	file="./importDocumentsSteps/importDocumentsStep3.jsp"%></div>
						<div class="importSteps" flex ng-controller="importControllerStep4" ng-switch-when="4"><%@include	file="./importDocumentsSteps/importDocumentsStep4.jsp"%></div>


					</md-content>
				  </md-card>	
				</md-tab-body> 
			</md-tab> 
		</md-tabs>
	</md-content>
	</div>
</body>
</html>
