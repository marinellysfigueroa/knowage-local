<div ng-controller = "hierBackupController">
	<md-content layout="row" layout-wrap>
		<div class="div-container" flex style="margin-right: 20px;" >
			
			<md-toolbar class="miniheadhiersmall" style="border-bottom: 2px solid grey;">
				<div class="md-toolbar-tools">
					<i class="fa fa-list"></i>
					<h2 class="md-flex" style="padding-left: 14px">{{translate.load("sbi.hierarchies.backup");}}</h2>
					<span flex=""></span>					
				</div>
			</md-toolbar>
			
			<md-content id='hierarchiesBackup' layout-padding layout='column' layout-align='space-around stretch'>
				<md-content id='hierarchiesBackupSelection' layout='row' layout-wrap layout-align='space-around center' layout-sm='column' layout-align-sm='space-around stretch' style='width:96%'>
					<md-input-container flex flex-sm='90'>
			        	<label>{{translate.load("sbi.hierarchies.dimensions");}}</label>
			        	<md-select type='text' ng-model='dimBackup' md-on-close='getHierarchies("src")'>
			        		<md-option ng-value="dimBackup" ng-repeat="dimBackup in dimensionBackup">{{ dimBackup.DIMENSION_NM }}</md-option>
			        	</md-select>
					</md-input-container>
					<md-input-container flex flex-sm='90'>
			        	<label>{{translate.load("sbi.hierarchies.hierarchies");}} {{translate.load("sbi.generic.type");}}</label>
			        	<md-select type='text' ng-model='hierTypeBackup' ng-disabled='!dimBackup' md-on-close='getHierarchies("src")'>
			        		<md-option ng-value="hierTypeBackup" ng-repeat="hierTypeBackup in hierarchiesTypeBackup">{{ hierTypeBackup }}</md-option>
			        	</md-select>
					</md-input-container>
					<md-input-container flex flex-sm='90'>
			        	<label>{{translate.load("sbi.hierarchies.hierarchies");}}</label>
			        	<md-select type='text' ng-model='hierBackup'  md-on-close='getBackupTable()' ng-disabled='!hierTypeBackup || !dimBackup || hierarchiesBackup.length==0'>
			        		<md-option ng-value="hierBackup" ng-repeat="hierBackup in hierarchiesBackup">{{ hierBackup.HIER_NM	}}</md-option>
			        	</md-select>
					</md-input-container>
				</md-content>
				<md-content class='force-100width' ng-show='showLoadingBackup' layout='row' layout-align ='space-around center'>
					<md-progress-circular md-mode="indeterminate"></md-progress-circular>
					<h4>{{translate.load("sbi.generic.wait");}}</h4>
				</md-content>
				<md-content layout='row'  ng-hide="showLoadingBackup">
					<angular-table
						ng-model="backupTable"
						columns = "columnsTable"
						id='backupTable'
					    columns-search="columnSearchTable"
					    show-search-bar = "true"
					    speed-menu-option="backupSpeedMenu"
					    allow-edit="true"
					    edit-function = "storeOldValue(	item,itemOld,cell,listId,row,column)"
					></angular-table>
				</md-content>
			</md-content>
		</div> 
	</md-content>
</div>