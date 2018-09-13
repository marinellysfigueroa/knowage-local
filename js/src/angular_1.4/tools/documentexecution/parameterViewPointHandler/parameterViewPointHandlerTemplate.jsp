<md-toolbar layout="row">
    <div class="md-toolbar-tools" flex layout-align="center center">
      	<h2 class="md-flex" >{{translate.load("sbi.execution.viewpoints.title")}}</h2>
     	<span flex></span>
      	<md-button title="Close" aria-label="Close" class="toolbar-button-custom" 
				ng-click="paramRolePanelService.returnToDocument()">
		{{translate.load("sbi.general.close")}} 
	 </md-button>
	</div>
</md-toolbar>
<angular-table    flex
	id="tableViewpoints" ng-model="urlViewPointService.gvpCtrlViewpoints" 
	columns='[{"label":"Name","name":"vpName"},{"label":"Description","name":"vpDesc"},{"label":"Visibility","name":"vpScope"}]'
	columns-search='["vpName","vpDesc", "vpScope"]'
	highlights-selected-item = "true"
	show-search-bar="true"
	speed-menu-option=gvpCtrlVpSpeedMenuOpt	>
</angular-table>