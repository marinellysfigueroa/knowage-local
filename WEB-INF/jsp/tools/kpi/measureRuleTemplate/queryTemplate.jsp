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


	<md-card  ng-controller="measureRuleQueryController">
		<md-card-content layout="column" layout-fill>
	    <md-input-container>
	        <label>{{translate.load("sbi.ds.dataSource")}}</label>
	        <md-select ng-model="currentRule.dataSourceId">
	          <md-option ng-repeat="ds in datasourcesList" value={{ds.DATASOURCE_ID}} ng-click="alterDatasource(ds.DATASOURCE_ID)">
	            {{ds.DATASOURCE_LABEL}}
	          </md-option>
	        </md-select>
	     </md-input-container> 
	    <md-whiteframe ng-if="detailProperty.dataSourcesIsSelected" class="md-whiteframe-2dp relative" layout-margin flex  >
			<div ui-codemirror="{ onLoad : codemirrorLoaded }" class="absolute" layout-fill ui-codemirror-opts="codemirrorOptions" ng-model=currentRule.definition></div> 
	     </md-whiteframe>
	     </md-card-content>
	</md-card>

