<div layout-fill class="overflow" layout="column">
	<md-card>
	<md-toolbar class="miniheadimportexport">
	<div class="md-toolbar-tools">
		<h2 class="md-flex">{{translate.load("sbi.kpiScheduler.executionType")}}</h2>
	</div>
	</md-toolbar> 
	<md-card-content><md-radio-group ng-model="selectedScheduler.delta">
	<md-radio-button ng-value="true">{{translate.load("sbi.kpiScheduler.insertAndUpdate")}}</md-radio-button>
	<md-radio-button ng-value="false">{{translate.load("sbi.kpiScheduler.deleteAndInsert")}}</md-radio-button>
	</md-radio-group> </md-card-content></md-card>
	<md-card 
		ng-controller="executionLogController"> <md-toolbar
		class="miniheadimportexport">
	<div class="md-toolbar-tools">
		<h2 class="md-flex">Log Execution</h2>
	</div>
	</md-toolbar>
	<md-card-content>
	<div layout="row">
		<md-input-container class="md-block" flex> 
		<label>Number of Exception</label> <input class="input_class" ng-model="numberLogs"
			required type="number" min="0"> </md-input-container>
		<md-button id="loadKpiExecution" class="md-primary" ng-click="loadLog()">{{translate.load("sbi.generic.load")}} </md-button>
	</div>
	<angular-table ng-show="kpiValueExecLogList.length>0" layout-fill id='logTable' ng-model=kpiValueExecLogList
		columns='[{"label":"TimeRun","name":"timeRun"},{"label":"Error Count","name":"errorCount"},{"label":"Success Count","name":"successCount"},{"label":"Total Count","name":"totalCount"},{"label":" ","name":"icon","size":"30px"}]'
		scope-functions=tableFunction> </angular-table> </md-card-content></md-card>
</div>