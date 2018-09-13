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


<div layout="row" layout-wrap layout-align="center center">
	<file-upload flex id="fileUploadImport" ng-model="IEDConf.fileImport" file-max-size="<%=importFileMaxSizeMB%>" ></file-upload>
	<md-button class="md-fab md-mini"  ng-disabled="isInvalidImportStep0Form();" aria-label="{{translate.load('SBISet.import','component_impexp_messages');}} {{translate.load('sbi.ds.wizard.file');}}" ng-click="importFile()">
       			<md-icon class="fa fa-upload fa-2x"></md-icon>
   			 </md-button>	 
</div>
<div layout-padding class="associations-container">
	<md-radio-group ng-model="IEDConf.associations">
    	<md-radio-button value="noAssociations " class="md-primary" >{{translate.load("impexp.withoutAss","component_impexp_messages");}}</md-radio-button>
    	<!--  <md-radio-button value="mandatoryAssociations">{{translate.load("impexp.mandatoryAss","component_impexp_messages");}}</md-radio-button>-->
     	<md-radio-button value="defaultAssociations">{{translate.load("impexp.defaultAss","component_impexp_messages");}}</md-radio-button>
    </md-radio-group>
    <div layout-padding layout="column" layout-wrap ng-if = "IEDConf.associations != 'noAssociations' ">
    	<div layout-xs="column" layout-align-xs="center stretch" layout="row"  layout-align="start center">
	    	<md-input-container flex   class="md-block">
				<label>{{translate.load("impexp.savedAss","component_impexp_messages");}}</label>
				<input type="text" ng-model="IEDConf.fileAssociation.name" ng-disabled="true" aria-label="{{translate.load('impexp.savedAss','component_impexp_messages');}}">
			</md-input-container>
    	
			<md-button class="md-fab md-mini" ng-click="listAssociation()" aria-label="{{translate.load('impexp.listAssFile','component_impexp_messages')}}" >
         				<md-icon class="fa fa-search fa-2x"></md-icon>
     				</md-button>
		</div>

    </div>
    
    <div class="downloadDiv">
    	<h3 ng-if="IEDConf.associationsFileName!=''" class="md-body-2">
			<span>{{translate.load("Sbi.downloadAss","component_impexp_messages");}} {{IEDConf.associationsFileName}}.xml </span>
			
			<md-button class="md-fab md-mini"   aria-label="download" ng-click="downloadAssociationsFile()">
       			<md-icon class="fa fa-download fa-2x"></md-icon>
   			 </md-button>
   			
		 </h3>
		
		<h3 ng-if="IEDConf.associationsFileName!=''" class="md-body-2">
		<span>{{translate.load("impexp.saveAss","component_impexp_messages");}}</span>
		
		<md-button class="md-fab md-mini"   aria-label="download" ng-click="saveAssociationsFile()">
      			<md-icon class="fa fa-save fa-2x"></md-icon>
  			 </md-button> 
  			 
			</h3>
				
		<h3 ng-if="IEDConf.logFileName!=''" class="md-body-2">
			<span>{{translate.load("Sbi.downloadLog","component_impexp_messages");}} {{IEDConf.logFileName}}.log</span>
			
			<md-button class="md-fab md-mini"   aria-label="download" ng-click="downloadLogFile()">
       			<md-icon class="fa fa-download fa-2x"></md-icon>
   			 </md-button> 
			</h3>
		
	
    
    </div>
</div>
