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

<%@page import="it.eng.spago.security.IEngUserProfile"%>
<%@page import="it.eng.spagobi.commons.constants.SpagoBIConstants"%>
<%
	IEngUserProfile profile = (IEngUserProfile) session.getAttribute(IEngUserProfile.ENG_USER_PROFILE);
	;
%>

<md-content ng-controller="documentBrowserController" layout="column" ng-cloak layout-fill>
	<div layout-fill ng-hide="hideProgressCircular" style="z-index: 10000; position: absolute; background-color: rgba(0, 0, 0, 0.21);">
		<md-progress-circular md-mode="indeterminate" md-diameter="60"
			style="left: 50%;top: 50%;margin-left: -30px;margin-top: -30px;">
		</md-progress-circular>
	</div>

<!-- Toolbar --> 
	<md-toolbar class="documentBrowserToolbar ">
		<div class="md-toolbar-tools" layout="row" layout-align="center center">
			<!-- Folders button -->
			<md-button class="md-icon-button" title="Folders" aria-label="Folders"
				hide-gt-sm ng-hide="showSearchView" ng-click="toggleFolders()">
			<md-icon md-font-icon="fa fa-ellipsis-v"></md-icon> </md-button>
		
			<!-- Title -->
			<h1 ng-hide="showSearchView">{{translate.load("sbi.browser.title")}}</h1>
			<h1 ng-show="showSearchView">{{translate.load("sbi.browser.document.searchDocuments")}}</h1>
		
			<!-- Search view back button -->
			<md-button class="md-icon-button" title="Back" aria-label="back"
				ng-show="showSearchView" ng-click="toggleSearchView()"> <md-icon
				md-font-icon="fa fa-arrow-left"></md-icon> </md-button>
		
			<!-- Search input -->
			<md-input-container ng-show="showSearchView" class="searchInput flex">
			<label>{{translate.load("sbi.generic.search.msg")}}</label> <input
				type="text" id="searchInput" ng-model="searchInput"
				focus-on="searchInput" key-enter="setSearchInput(searchInput)">
			</md-input-container>
		
			<!-- Search clear -->
			<md-button class="md-icon-button" title="Clear" aria-label="Clear"
				ng-show="showSearchView" ng-click="setSearchInput('')"> <md-icon
				md-font-icon="fa fa-times"></md-icon> </md-button>
		
			<!--  Search button -->
			<md-button tabindex="1" class="md-icon-button" title="Search" aria-label="Search"
				ng-show="showSearchView" ng-click="setSearchInput(searchInput)">
			<md-icon md-font-icon="fa fa-search"></md-icon> </md-button>
		
			<span flex=""></span>
		
			<!--  Search view button -->
			<md-button tabindex="1" class="md-icon-button" title="Search" aria-label="Search"
				ng-hide="showSearchView" ng-click="toggleSearchView()"> <md-icon
				md-font-icon="fa fa-search"></md-icon> </md-button>
		
			<!-- Document view button -->
			<md-button tabindex="1" class="md-icon-button" ng-click="toggleDocumentView()"
				title="{{showDocumentGridView?'List view':'Grid view'}}"
				aria-label="{{showDocumentGridView?'List view':'Grid view'}}">
			<md-icon md-font-icon="fa"
				ng-class="showDocumentGridView ? 'fa-th-list' : 'fa-th'"></md-icon> </md-button>
		
			<!-- 					 Document Detail button -->
			<!-- 					<md-button class="md-icon-button"  ng-class="{'selectedButton':showDocumentDetail}" ng-click="setDetailOpen(!showDocumentDetail)" ng-disabled="!isSelectedDocumentValid()" title="Details" aria-label="Details"> -->
			<!-- 						 <md-icon md-font-icon="fa fa-info-circle"></md-icon> -->
			<!-- 					 </md-button> -->
		
		
		
			<!-- New Document -->
			<%
				if (UserUtilities.haveRoleAndAuthorization(profile, SpagoBIConstants.ADMIN_ROLE_TYPE, new String[0])
						|| UserUtilities.haveRoleAndAuthorization(profile, SpagoBIConstants.ROLE_TYPE_DEV, new String[0])) {
			%>
			<md-menu  style="padding: 0;"> <md-button
				aria-label="Create new document" class="md-fab md-mini"
				style="top: 0;" ng-click="$mdOpenMenu($event)"> <md-icon
				md-menu-origin md-font-icon="fa fa-plus" class="md-primary"></md-icon>
			</md-button> <md-menu-content width="4"> <md-menu-item>
			<md-button ng-click="newDocument();" tabindex="1"> <md-icon
				md-font-icon="fa fa-plus" md-menu-align-target></md-icon>
			{{translate.load("sbi.generic.document.add.traditional")}} </md-button> </md-menu-item> <%
		 	if (UserUtilities.haveRoleAndAuthorization(profile, SpagoBIConstants.ADMIN_ROLE_TYPE, new String[] {SpagoBIConstants.CREATE_COCKPIT_FUNCTIONALITY})
		 				|| UserUtilities.haveRoleAndAuthorization(profile, SpagoBIConstants.ROLE_TYPE_DEV, new String[] {SpagoBIConstants.CREATE_COCKPIT_FUNCTIONALITY})) {
		 %> <md-menu-item> <md-button
				ng-click="newDocument('cockpit');"> <md-icon
				md-font-icon="fa fa-plus" md-menu-align-target></md-icon>
			{{translate.load("sbi.generic.document.add.adhocCockpit")}} </md-button> </md-menu-item> <%
		 	}
		 %> </md-menu-content> </md-menu>
			<%
				}
			%>
		</div>
	</md-toolbar>
	<md-content layout="row" flex>
		<md-content layout="row" flex ng-show="!showSearchView">
			<md-sidenav class="md-sidenav-left md-whiteframe-4dp" md-component-id="left" md-is-locked-open="$mdMedia('gt-sm')" ng-class="{'full-screen-sidenav': smallScreen}">
				<md-content> 
					<document-tree ng-model="folders" highlights-selected-item="true" create-tree="true" selected-item="selectedFolder" click-function="setSelectedFolder(item)"></document-tree>
				</md-content>
			</md-sidenav> 
			<md-content flex layout="column" class="mainContent"> 
				<bread-crumb item-name='name' ng-model="breadModel" selected-item="selectedFolder" class="kn-documentBrowser-comp"
					control='breadCrumbControl' move-to-callback=moveBreadCrumbToFolder(item,index)>
				</bread-crumb>
		
				<md-content flex layout="column" class="md-whiteframe-5dp" layout-margin>
					<div layout="row" ng-show='showDocumentGridView' class="documentGridViewInput">
						<md-input-container class="md-block" flex> <label>{{translate.load("sbi.ds.orderComboLabel")}}</label>
							<md-select ng-model="selectedOrder"	ng-model-option="trackBy:'$value.id'"> 
								<md-option ng-repeat="orderElement in orderElements" value="{{orderElement.name}}">{{orderElement.label}}</md-option> 
							</md-select>
						</md-input-container>
					</div>
			
			
					<h3 class="md-title" layout-padding ng-show="folderDocuments.length==0">{{translate.load("sbi.browser.document.noDocument")}}</h3>
			
				<!-- From Andrea		I have deleted option style='overflow:auto'  because on IE the document-view break layout  when pass the mouse over the "play button" --> 
					<document-view
					flex ng-model="folderDocuments" ng-show="hideProgressCircular"
					class="hidden-overflow-vertical widthDivContent flex2"
					show-grid-view="showDocumentGridView"
					table-speed-menu-option="documentTableButton"
					selected-document=selectedDocument
					select-document-action="selectDocument(doc);"
					edit-document-action="editDocument(doc)"
					clone-document-action="cloneDocument(doc)"
					delete-document-action="deleteDocument(doc)"
					execute-document-action="executeDocument(doc)"
					ordering-document-cards=selectedOrder> </document-view> 
				</md-content>
			</md-content>
		</md-content> 
	
		<md-content flex ng-show="searchingDocuments"> 
			<md-progress-circular oading md-mode="indeterminate" md-diameter="75%"
			style="position:fixed; top:50%; left:50%; z-index:500; background:rgba(255, 255, 255, 0);">
			</md-progress-circular>
		</md-content> 
	
		<md-content layout="column" flex ng-show="showSearchView && !searchingDocuments">
			<h3 class="md-title" ng-show="searchDocuments.length == 0">{{translate.load("sbi.browser.document.noDocument")}}</h3>
			<h3 class="md-title" ng-show="searchDocuments.length > 0">{{searchDocuments.length || 0}} {{translate.load("sbi.browser.document.found")}}</h3>
	
			<document-view flex ng-model="searchDocuments"
				show-grid-view="showDocumentGridView"
				table-speed-menu-option="documentTableButton"
				selected-document=selectedDocument
				select-document-action="selectDocument(doc);"
				edit-document-action="editDocument(doc)"
				clone-document-action="cloneDocument(doc)"
				delete-document-action="deleteDocument(doc)"
				execute-document-action="executeDocument(doc)"> 
			</document-view> 
		</md-content> 
		
		<md-sidenav class="md-sidenav-right selectedDocumentSidenav md-whiteframe-4dp" md-component-id="right" md-is-locked-open="$mdMedia('gt-sm')"
			ng-class="{'full-screen-sidenav': smallScreen}" ng-show="showDocumentDetails()"> 
			<md-toolbar class="ternaryToolbar">
			 <!-- 					<h1 class="md-toolbar-tools" style="text-align:center; display:inline;">{{selectedDocument.name | limitEllipses:28}}</h1> -->
				<div layout="row" layout-align="space-around center">
					<md-button ng-if="smallScreen"
					title="{{translate.load('sbi.documentbrowser.execute')}}"
					aria-label="Close panel" class="md-icon-button"
					ng-click="selectDocument();toggleDocumentDetail();"> <md-icon
					md-font-icon="fa fa-times"></md-icon> </md-button>
			
				<md-button title="{{translate.load('sbi.documentbrowser.execute')}}"
					aria-label="Execute Document" class="md-icon-button"
					ng-click="executeDocument(selectedDocument)"> <md-icon
					md-font-icon="fa fa-play-circle"></md-icon> </md-button>
				<%
					if (UserUtilities.haveRoleAndAuthorization(profile, SpagoBIConstants.ADMIN_ROLE_TYPE, new String[0])
							|| UserUtilities.haveRoleAndAuthorization(profile, SpagoBIConstants.ROLE_TYPE_DEV, new String[0])) {
				%>
				<md-button title="{{translate.load('sbi.documentbrowser.edit')}}"
					aria-label="Edit Document" class="md-icon-button"
					ng-click="editDocument(selectedDocument)"> <md-icon
					md-font-icon="fa fa-pencil"></md-icon> </md-button>
			
				<md-button title="{{translate.load('sbi.documentbrowser.clone')}}"
					aria-label="Clone Document" class="md-icon-button"
					ng-click="cloneDocument(selectedDocument)"> <md-icon
					md-font-icon="fa fa-clone"></md-icon> </md-button>
			
				<md-button title="{{translate.load('sbi.documentbrowser.delete')}}"
					aria-label="Delete Document" class="md-icon-button"
					ng-click="deleteDocument(selectedDocument)"> <md-icon
					md-font-icon="fa fa-trash-o"></md-icon> </md-button>
				<%
					}
				%>
			</div>
		</md-toolbar> 
		<md-content layout-margin>
			<md-list> 
				<md-list-item layout="column" class="md-2-line">
					<div class="md-list-item-text " flex>
						<h3> <b>{{translate.load("sbi.generic.descr")}}</b> </h3>
						<p>{{selectedDocument.description}}</p>
					</div>
				</md-list-item>
				<md-list-item class="md-2-line">
					<div class="md-list-item-text">
						<h3>
							<b>{{translate.load("sbi.generic.state")}}</b>
						</h3>
						<p>{{selectedDocument.stateCodeStr | translateLoad}}</p>
					</div>
					</md-list-item>
				<md-list-item class="md-2-line">
					<div class="md-list-item-text">
						<h3>
							<b>{{translate.load("sbi.generic.type")}}</b>
						</h3>
						<p>{{selectedDocument.typeCode}}</p>
					</div>
					</md-list-item>
				<md-list-item class="md-2-line">
					<div class="md-list-item-text">
						<h3>
							<b>{{translate.load("sbi.generic.creationdate")}}</b>
						</h3>
						<p>{{selectedDocument.creationDate | asDate | date:'yyyy/MM/dd
							HH:mm:ss' }}</p>
					</div>
				</md-list-item> 
			</md-list>
		</md-content>
	</md-sidenav> 
	</md-content> 
</md-content>


