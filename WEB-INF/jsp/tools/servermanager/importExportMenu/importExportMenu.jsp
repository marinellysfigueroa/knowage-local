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
<script type="text/javascript" src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/servermanager/menuImportExport/importExportMenuController.js")%>"></script>
<script type="text/javascript" src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/servermanager/menuImportExport/importStep0Controller.js")%>"></script>
<!-- 
<script type="text/javascript" src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/servermanager/menuImportExport/importStep1Controller.js")%>"></script>
<script type="text/javascript" src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/servermanager/menuImportExport/importStep2Controller.js")%>"></script>
<script type="text/javascript" src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/servermanager/menuImportExport/importStep3Controller.js")%>"></script>
<script type="text/javascript" src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/servermanager/menuImportExport/importStep4Controller.js")%>"></script>
-->


<%-- breadCrumb --%>
<script type="text/javascript" 
		src="<%=urlBuilder.getResourceLink(request, "js/src/angular_1.4/tools/commons/BreadCrumb.js")%>"></script>
<link rel="stylesheet" type="text/css" href="<%=urlBuilder.getResourceLink(request, "themes/commons/css/customStyle.css")%>">

</head>
<body class="bodyStyle kn-importExportDocument" ng-app="importExportMenuModule" >
<rest-loading></rest-loading>
	<div ng-controller="importExportMenuController " layout="column" layout-fill layout-wrap class="contentdemoBasicUsage">
	
	
		<md-toolbar class="miniheadimportexport" >
			<div class="md-toolbar-tools">
				<i class="fa fa-exchange fa-2x"></i>
				<h2 class="md-flex" >
					{{translate.load("SBISet.impexp.menu.title", "component_impexp_messages")}}
				</h2>
			</div>
		</md-toolbar>

		<md-content flex layout-wrap class="mainContainer">
			<md-tabs layout-fill class="absolute">
				<md-tab	>
					<md-tab-label>{{translate.load("SBISet.export", "component_impexp_messages")}}</md-tab-label>
					<md-tab-body>
					<md-card>
						<md-content	ng-controller="exportController">
							<div layout="column" layout-padding layout-wrap>
								<div layout="row" layout-align="center center">
									<md-input-container flex="90" class="md-block">
										<label>{{translate.load('SBISet.importexport.nameExp', 'component_impexp_messages')}}</label>
										<input type="text" ng-model="exportName" required> 
									</md-input-container>
										<md-button ng-if="!flags.waitExport" ng-click="exportFiles(selected)" aria-label="{{translate.load('SBISet.importexport.fileArchive', 'component_impexp_messages')}}"
											ng-disabled="exportName===undefined || exportName.length == 0" class="md-fab md-mini"  > <md-icon
										md-font-icon="fa fa-download"  >
										</md-icon> </md-button>
									
					
								</div>
								
							</div>
						</md-content>
						</md-card>
					</md-tab-body> 
				</md-tab> 
				
				<md-tab id="importTab" > 
					<md-tab-label>{{translate.load("SBISet.import", "component_impexp_messages")}}</md-tab-label>
					<md-tab-body> <md-card>
					<md-toolbar> 
						<div class="md-toolbar-tools">{{translate.load("sbi.importusers.import")}}</div>
					</md-toolbar>
						<md-card-content>
							<div layout="row" layout-wrap layout-align="center center">
								<file-upload flex id="AssociationFileUploadImport" ng-model="importFile" file-max-size="<%=importFileMaxSizeMB%>" ></file-upload>
								<md-button ng-click="upload($event)" aria-label="upload Menu"
								class="md-fab md-mini"  > <md-icon
								md-font-icon="fa fa-upload"  >
								</md-icon> </md-button>
							</div>
							<div layout="row" layout-wrap >
								<md-radio-group layout="row" ng-model="typeSaveMenu">
								      <md-radio-button value="Override" ng-click="reloadTree('Override')">{{translate.load("sbi.importusers.override");}}</md-radio-button>
								      <md-radio-button value="Missing" ng-click="reloadTree('Missing')">{{translate.load("sbi.importusers.addmissing");}} </md-radio-button>
								 </md-radio-group>
								
								<span flex></span>
								<md-button class="md-raised" ng-click="save($event)" aria-label="upload Menu" >{{translate.load("sbi.importusers.startimport");}}</md-button>
							</div>
						
							<div layout="row" layout-wrap>
								<span flex></span>
								<div flex=30  >
									<h4>{{translate.load("sbi.importusers.userimport");}}</h4>
									<component-tree ng-model="tree" subnode-key="children" text-to-show-key="name" > </component-tree>
								</div>
								<span flex=10>
							
								</span>
								<div flex=30>
									<h4>{{translate.load("sbi.importusers.userimporting");}}</h4>
									<component-tree ng-model="treeInTheDB" subnode-key="children" text-to-show-key="name" > </component-tree>
								</div>
								<span flex></span>
							</div>
							</md-card-content>
						</md-card>
					</md-tab-body>
				</md-tab>
			</md-tabs> 
		</md-content>
	</div>
</body>
</html>
