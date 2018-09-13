var app = angular.module('kpiTarget').controller('listController', ['$scope','sbiModule_translate' ,"$mdDialog","sbiModule_restServices","$q","$mdToast",'$angularListDetail','$timeout',KPIDefinitionListControllerFunction ]);

function KPIDefinitionListControllerFunction($scope,sbiModule_translate,$mdDialog, sbiModule_restServices,$q,$mdToast,$angularListDetail,$timeout){
	$scope.translate=sbiModule_translate;

	$scope.addTarget= function() {
		$angularListDetail.goToDetail();
	}

	$scope.loadTarget = function(item) {
		if (typeof item.id == 'undefined' || item.id == null) return; // TODO: remove after debug

		$scope.target.id = item.id;
		$scope.target.name = item.name;
		$scope.target.category = item.category;
		$scope.target.startValidityDate = item.startValidityDate; //new Date(item.startValidity);
		$scope.target.endValidityDate = item.endValidityDate; // new Date(item.endValidity);
		var scopeDbg = $scope;
		sbiModule_restServices.get("1.0/kpiee", $scope.target.id + "/listKpiWithTarget")
		.success(
			function(data, status, headers, config) {
				$scope.kpis.length = 0;
				for (var i = 0; i < data.length; i++) {
					$scope.kpis.push({
						id: data[i].kpiId,
						version: data[i].kpiVersion,
						name: data[i].kpi.name,
						category: null,
						date: this.formatDate(data[i].kpi.dateCreation),
						author: data[i].kpi.author,
						value: data[i].value
					});
				}
			}
		).error(
			function(data, status, headers, config) {
				showToast("Error while loading data", 3000); // sbiModule_translate.load("...")
			}
		);

		$angularListDetail.goToDetail();
	};

	$scope.indexInList = function(item, list) {
		for (var i = 0; i < list.length; i++) {
			var object = list[i];
			if(object.id==item.id){
				return i;
			}
		}
		return -1;
	};
}