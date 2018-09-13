	<md-input-container> 
		<label>{{translate.load('sbi.kpi.scorecard.scorecard.name')}}</label> <input ng-model="currentScorecard.name"> 
	</md-input-container> 

	<md-content layout="column" class=" md-whiteframe-3dp" flex>
		<md-toolbar>
			<div class="md-toolbar-tools">
				<h2>
					<span>{{translate.load('sbi.kpi.scorecard.perspective.list')}}</span>
				</h2>
				<span flex></span>
				<md-button class="ng-scope" ng-click="addPerspective()" aria-label="Add perspective">
					{{translate.load('sbi.kpi.scorecard.perspective.add')}}
				</md-button>
			</div>
		</md-toolbar>
		<div layout="row" layout-wrap  ng-cloak >
		
			<kpi-color-indicator perspectives="currentScorecard.perspectives" definition="true" criterion="criterionTypeList"></kpi-color-indicator>
		
		
			
			<!--  md-card class="md-whiteframe-2dp scorecardPrespectiveCard" layout="column" ng-repeat="perspective in currentScorecard.perspectives">
				<md-toolbar>
					<div class="md-toolbar-tools" layout-fill layout="row">
						<kpi-semaphore-indicator indicator-color="perspective.status"></kpi-semaphore-indicator>
			       		<label>{{perspective.name}}</label>
			       		<span flex></span>
			       		
			       	<md-menu>
				      <md-button aria-label="Menu List" class="md-icon-button" ng-click="$mdOpenMenu($event)">
				        <md-icon md-menu-origin md-font-icon="fa fa-ellipsis-v"></md-icon>
				      </md-button>
				      <md-menu-content width="4">
				        <md-menu-item>
				          <md-button ng-click="addPerspective(perspective, $index)">
				            <md-icon md-font-icon="fa fa-pencil-square-o" md-menu-align-target></md-icon>
				            {{translate.load('sbi.generic.modify')}}
				          </md-button>
				        </md-menu-item>
				        <md-menu-item>
				          <md-button ng-click="deletePerspective(perspective, $index)">
				            <md-icon md-font-icon="fa fa-trash"></md-icon>
				            {{translate.load('sbi.generic.delete')}}
				          </md-button>
				        </md-menu-item>
				   </md-menu-content>
				    </md-menu>

			    	</div>	
		    	</md-toolbar>
		    	<md-card-content layout-padding layout="row" >
		    		
		    			<b layout-padding class="lh30">KPI</b>
		    			<kpi-semaphore-indicator flex ng-repeat="groupedKpi in perspective.groupedKpis" indicator-color="groupedKpi.status" indicator-value="groupedKpi.count"></kpi-semaphore-indicator>

		    	</md-card-content>
			</md-card--> 
			
		</div>
		</md-content>
