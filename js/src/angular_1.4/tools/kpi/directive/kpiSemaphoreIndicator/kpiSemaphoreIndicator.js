angular.module('kpi_semaphore_indicator', ['ngMaterial'])
.directive('kpiSemaphoreIndicator', function() {
	return {
		template:'<span layout="row"  layout-align="center center">'+
				'<span class="fa-stack">'+
					'<i class="fa  fa-stack-1x scorecardSemaphoreBackIcon" ng-class="getClass(indicatorColor,true)" ng-style="{color : black}"></i>'+
					'<i class="fa  fa-stack-1x scorecardSemaphoreFrontIcon" ng-class="getClass(indicatorColor,false)" ng-style="{color : indicatorColor || \'GRAY\'}"></i>'+
				'</span>'+
				'<span>{{indicatorValue}}</span>'+
			'</span>',
			replace:true,
		scope: {
			indicatorColor:"=",
			indicatorValue:"="
		},
		link: function(scope, element, attrs, ctrl, transclude) {
			scope.getClass=function(type,isBack){
				
				switch(type) {
				    case "RED":
				        return isBack ? 'fa-square-o' : 'fa-square'
				        break;
				    case "YELLOW":
				    	  return isBack ? ['fa-square-o', 'fa-rotate-45'] : ['fa-square', 'fa-rotate-45']
				        break;
				    case "GREEN":
				    	  return isBack ? 'fa-circle-o' : 'fa-circle'
				    	break;
				    default:
				    	  return isBack ? 'fa-circle-o' : 'fa-circle'
				    	break;
				   
				}
			}
			 
		}
	} 
});