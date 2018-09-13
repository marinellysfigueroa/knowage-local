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


<md-content ng-controller="measureRuleMetadataController"  layout-fill>

<div layout="row" layout-wrap> 
<md-card class="md-whiteframe-3dp metadataTabs" ng-repeat=" mtdValue in currentRule.ruleOutputs ">
  <md-toolbar>
      <div class="md-toolbar-tools"  class="alertIconMissingAlias" >  
         <span ng-if="::(!aliasExtist(mtdValue.alias) && !aliasUsedByMeasure(mtdValue.alias))">
	  		 <md-tooltip md-direction="top">
	  		 {{translate.load("sbi.kpi.rule.alias.missing")}}
		 	</md-tooltip>  
        	<md-icon  class="alertIconMissingAlias"  md-font-icon="fa fa-exclamation-triangle" > 
       		</md-icon> 
         </span>
         
         <span ng-if="::aliasUsedByMeasure(mtdValue.alias)">
	  		 <md-tooltip md-direction="top">
	  		 {{translate.load("sbi.kpi.rule.alias.used")}}
		 	</md-tooltip>  
        	<md-icon  class="alertIconUsedAlias"  md-font-icon="fa fa-exclamation-triangle" > 
       		</md-icon> 
         </span>
         
		<span flex>{{mtdValue.alias}}</span>
		</div>
      
		 
</md-toolbar> 
<!-- <div layout="row" layout-sm="column" id="preview" layout-align="space-around" ng-show="showCircularMetadata" layout-fill> -->
<!--      	<md-progress-circular md-mode="indeterminate" ></md-progress-circular> -->
<!-- </div> -->
<md-card-content layout="column">
 <md-input-container class="md-block">
        <label> {{translate.load("sbi.generic.tipology")}}</label>
        <md-select ng-model="mtdValue.type" ng-model-options="{trackBy: '$value.valueCd'}" ng-disabled="mtdValue.isBlockedType" >
          <md-option ng-repeat="tipolo in tipologiesType" ng-value={{tipolo}}>
            {{translate.load(tipolo.translatedValueName)}}
          </md-option>
        </md-select>
      </md-input-container> 
        <md-input-container class="md-block" ng-if="mtdValue.type.valueCd=='TEMPORAL_ATTRIBUTE'">
        <label>{{translate.load("sbi.ds.metadata.dataset.hierarchy.level")}}</label>
        <!--  DAVIDE VERNASSA temporary required removal, logic moved to controller for a angular material bug 
        <md-select ng-model="mtdValue.hierarchy" ng-model-options="{trackBy: '$value.valueId'}" required-->
        <md-select ng-model="mtdValue.hierarchy" ng-model-options="{trackBy: '$value.valueId'}" >
          <md-option ng-repeat="hlevel in hierarchicalLevelList" ng-value="{{hlevel}}" >
            {{hlevel.valueName}}
          </md-option>
        </md-select>
      </md-input-container>
      
	<md-autocomplete ng-if="mtdValue.type.valueCd!='TEMPORAL_ATTRIBUTE'"
          ng-disabled="false" 
          md-selected-item="mtdValue.category" 
          md-search-text="searchText" 
          md-items="item in querySearchCategory(searchText)"
          md-item-text="item.valueCd" 
          md-floating-label="{{translate.load('sbi.generic.category')}}"
          md-autoselect	=true
          md-select-on-match=true
          md-search-text-change="searchTextChange(mtdValue,searchText)"
         >
        <md-item-template>
          <span md-highlight-text="searchText">{{item.valueCd}}</span>
        </md-item-template> 
      </md-autocomplete>      
      
      
      </md-card-content>
</md-card>

 </div>  
  </md-content> 
