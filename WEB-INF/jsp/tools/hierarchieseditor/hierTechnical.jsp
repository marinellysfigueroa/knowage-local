<div ng-controller = "hierTechnController" id="hierTechnicalController" style="min-height: 30rem;height:90%">
	<md-content layout="row" layout-wrap>
		<div class="div-container" flex style="margin-right: 20px;" >
			
			<md-toolbar class="miniheadhiersmall" style="border-bottom: 2px solid grey;">
				<div class="md-toolbar-tools">
					<i class="fa fa-list"></i>
					<h2 class="md-flex" style="padding-left: 14px">{{translate.load("sbi.hierarchies.hierSrc");}}</h2>
					<span flex=""></span>					
				</div>
			</md-toolbar>
			
			<md-content id='hierarchiesSrc' layout-padding layout='column' layout-align='space-around stretch'>
				<md-content layout='row' layout-xs='column' layout-padding layout-align='start start'>
					<md-datepicker ng-model="dateSrc" ng-change="getTree('src')"></md-datepicker>
				</md-content>
				<md-content id='hierarchiesSrcSelection' layout='row' layout-wrap layout-align='space-around center' layout-sm='column' layout-align-sm='space-around stretch' style='width:96%'>
					<md-input-container flex flex-sm='90'>
			        	<label>{{translate.load("sbi.hierarchies.dimensions");}}</label>
			        	<md-select type='text' ng-model='dimSrc' ng-disabled='!dateSrc' md-on-close='getHierarchies("src");getHierarchies("target")'>
			        		<md-option ng-value="dimSrc" ng-repeat="dimSrc in dimensionSrc">{{ dimSrc.DIMENSION_NM }}</md-option>
			        	</md-select>
					</md-input-container>
					<md-input-container flex flex-sm='90'>
			        	<label>{{translate.load("sbi.hierarchies.hierarchies");}} {{translate.load("sbi.generic.type");}}</label>
			        	<md-select type='text' ng-model='hierTypeSrc' ng-disabled='!dateSrc' md-on-close='getHierarchies("src")'>
			        		<md-option ng-value="hierTypeSrc" ng-repeat="hierTypeSrc in hierarchiesTypeSrc">{{ hierTypeSrc }}</md-option>
			        	</md-select>
					</md-input-container>
					<md-input-container flex flex-sm='90'>
			        	<label>{{translate.load("sbi.hierarchies.hierarchies");}}</label>
			        	<md-select type='text' ng-model='hierSrc'  md-on-close='getTree("src")' ng-disabled='!hierTypeSrc || !dimSrc || hierarchiesSrc.length==0'>
			        		<md-option ng-value="hierSrc" ng-repeat="hierSrc in hierarchiesSrc">{{ hierSrc.HIER_NM	}}</md-option>
			        	</md-select>
					</md-input-container>
				</md-content>
				<md-content layout-align='start start'>
					<md-icon ng-if="!seeFilterSrc" class="fa fa-filter" ng-click="toogleSeeFilter('src')"></md-icon>
					<md-icon ng-if="seeFilterSrc" class="fa fa-times" ng-click="toogleSeeFilter('src')"></md-icon>
				</md-content>
				<md-content id='srcFilters' ng-show='seeFilterSrc' class="force-100width">
					<fieldset class="standard" >
				        <legend>Filters</legend>
				        <div layout="column" layout-wrap flex layout-align="space-around stretch">
					        <md-content layout='row' class="force-100width" layout-align='start center'>
				        		<md-checkbox ng-model="seeHideLeafSrc" style='height: 33px;' ng-disabled="!hierSrc">{{translate.load("sbi.hierarchies.show.misselement");}}</md-checkbox>
					        </md-content>
				        	<md-content layout='row' class="force-100width" layout-align='start center'>
				        		After Date: <md-datepicker ng-model="dateFilterSrc" ng-disabled="!hierSrc"></md-datepicker>
				        	</md-content>
				        	<md-content layout='row' class="force-100width" layout-align='space-between center'>
						        <md-input-container flex='40'>
						        	<label>{{translate.load("sbi.ds.filterLabel");}}</label>
						        	<input type='text' ng-model='filterBySrc' ng-disabled="!hierSrc"></input>
					      		</md-input-container>
						        <md-input-container flex='40'>
						        	<label>{{translate.load("sbi.ds.orderComboLabel");}}</label>
						        	<md-select type='text' ng-model='orderBySrc' ng-disabled="!hierSrc">
						        		<md-option ng-value="orderBySrc" ng-repeat="orderBySrc in orderByFields">{{ orderBySrc }}</md-option>
						        	</md-select>
						        </md-input-container>
				        		 <div>
					        		 <md-icon class="fa fa-check" ng-click="applyFilter('src')"></md-icon>
							         <md-icon class="fa fa-trash" ng-click="removeFilter('src')"></md-icon>
						         </div>
			        		</md-content>
			        	</div>
			        </fieldset>
				</md-content>
				<md-content ng-hide="showLoadingSrc || hierTreeSrc.length == 0" layout='row' layout-fill flex='50'>
					<document-tree 
						id="left" 
						ng-model="hierTreeSrc" 
						create-tree="false"
						multi-select='false' 
						keys='keys' 
						text-search='filterBySrcTrigger' 
						fields-search='["name"]' 
						order-by='orderBySrcTrigger'
						menu-option='menuSrcOption' 
						enable-drag='true' 
						no-drop-enabled='true'
						enable-clone=true
						show-empty-placeholder="true" 
						translate="false"
						options-drag-drop="treeSrcOptions" >
					</document-tree>
				</md-content>
				<md-content class='force-100width' ng-show='showLoadingSrc' layout='row' layout-align ='space-around center'>
					<md-progress-circular md-mode="indeterminate"></md-progress-circular>
					<h4>{{translate.load("sbi.generic.wait");}}</h4>
				</md-content>
				<md-content class='' ng-show='hierTreeSrc.length==0 && !showLoadingSrc && hierTypeSrc && hierSrc' layout='row' layout-padding layout-align ='space-around center'>
					<h4>{{translate.load("sbi.hierarchies.nodata");}}</h4>
				</md-content>
			</md-content>
		</div> 
		<div  class="div-container" flex>	
			<md-toolbar class="miniheadhiersmall" style="border-bottom: 2px solid grey;" >
				<div class="md-toolbar-tools">
					<i class="fa fa-list"></i>
					<h2 class="md-flex" style="padding-left: 14px">{{translate.load("sbi.hierarchies.hierTarget");}}</h2>
					<span flex=""></span>					
				</div>
			</md-toolbar>
			<md-content id='hierarchiesTarget' layout-padding layout='column' layout-align='space-around stretch'>
				<md-content layout='row' layout-xs='column' layout-padding layout-align='space-around center'>
					<md-datepicker ng-model="dateTarget" ng-change="getTree('target')"></md-datepicker>
					<md-button ng-click='createTree()' ng-disabled='!dimSrc' class='md-raised md-ExtraMini'>{{translate.load("sbi.generic.create");}}</md-button>
					<md-button ng-click='saveTree()' ng-disabled='!treeTargetDirty' class='md-raised md-ExtraMini'>{{translate.load("sbi.generic.update");}}</md-button>
					<md-checkbox ng-model="doBackup" ng-disabled='!treeTargetDirty'>{{translate.load("sbi.hierarchies.backup");}}</md-checkbox>
				</md-content>
				<md-content id='hierarchiesTargetSelection' layout='row' layout-wrap layout-align='space-around center' layout-sm='column' layout-align-sm='space-around stretch' style='width:96%'>
					<md-input-container flex flex-sm='90'>
			        	<label>{{translate.load("sbi.hierarchies.hierarchies");}}</label>
			        	<label ng-if=''>{{translate.load("sbi.hierarchies.hierarchies");}}</label>
			        	<md-select type='text' ng-model='hierTarget'  md-on-close='getTree("target")' ng-disabled='!dimSrc || hierarchiesTarget.length==0'>
			        		<md-option ng-value="hierTarget" ng-repeat="hierTarget in hierarchiesTarget">{{ hierTarget.HIER_NM	}}</md-option>
			        	</md-select>
					</md-input-container>
				</md-content>
				<md-content  layout-align='start start'>
					<md-icon ng-if="!seeFilterTarget" class="fa fa-filter" ng-click="toogleSeeFilter('target')"></md-icon>
					<md-icon ng-if="seeFilterTarget" class="fa fa-times" ng-click="toogleSeeFilter('target')"></md-icon>
				</md-content>
				<md-content id='targetFilters' ng-show='seeFilterTarget' class="force-100width">
					<fieldset class="standard" >
				        <legend>Filters</legend>
				        <div layout="column" layout-wrap flex layout-align="space-around stretch">
					        <md-content layout='row' class="force-100width" layout-align='start center'>
				        		<md-checkbox ng-model="seeHideLeafTarget" style='height: 33px;' ng-disabled="!hierTarget">{{translate.load("sbi.hierarchies.show.misselement");}}</md-checkbox>
					        </md-content>
					        <md-content layout='row' class="force-100width" layout-align='start center'>
				        		After Date: <md-datepicker ng-model="dateFilterTarget"  ng-disabled="!hierTarget"></md-datepicker>
				        	</md-content>
				        	<md-content layout='row' class="force-100width" layout-align='space-between center'>
						        <md-input-container flex='40'>
						        	<label>{{translate.load("sbi.ds.filterLabel");}}</label>
						        	<input type='text' ng-model='filterByTarget' ng-disabled="!hierTarget"></input>
					      		</md-input-container>
						        <md-input-container flex='40'>
						        	<label>{{translate.load("sbi.ds.orderComboLabel");}}</label>
						        	<md-select type='text' ng-model='orderByTarget' ng-disabled="!hierTarget">
						        		<md-option ng-value="orderByTarget" ng-repeat="orderByTarget in orderByFields">{{ orderByTarget }}</md-option>
						        	</md-select>
						        </md-input-container>
				        		 <div>
					        		 <md-icon class="fa fa-check" ng-click="applyFilter('target')"></md-icon>
							         <md-icon class="fa fa-trash" ng-click="removeFilter('target')"></md-icon>
						         </div>
			        		</md-content>
			        	</div>
			        </fieldset>
				</md-content>
				<md-content ng-hide="showLoadingTarget || hierTreeTarget.length == 0" class="force-100width">
					<document-tree  
						id="right" 
						ng-model="hierTreeTarget" 
						create-tree="false" 
						multi-select='false' 
						keys='keys' 
						text-search='filterByTargetTrigger' 
						fields-search='["name"]' 
						order-by='orderByTargetTrigger' 
						menu-option='menuTargetOption' 
						enable-drag='true' 
						no-drop-enabled='false' 
						enable-clone='true'
						show-empty-placeholder="true" 
						translate="false"	
						options-drag-drop="treeTargetOptions" 
					></document-tree>
				</md-content>
				<md-content class='force-100width' ng-show='showLoadingTarget' layout='row' layout-align ='space-around center'>
					<md-progress-circular md-mode="indeterminate"></md-progress-circular>
					<h4>{{translate.load("sbi.generic.wait");}}</h4>
				</md-content>
				<md-content class='' ng-show='hierTreeTarget.length==0 && !showLoadingTarget && dateTarget && hierTypeSrc && hierTarget' layout='row' layout-padding layout-align ='space-around center'>
					<h4>{{translate.load("sbi.hierarchies.nodata");}}</h4>
				</md-content>
			</md-content>	
		</div>
	</md-content>
</div>