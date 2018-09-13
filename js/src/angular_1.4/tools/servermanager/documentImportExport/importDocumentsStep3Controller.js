angular.module('importExportDocumentModule').controller('importControllerStep3', ["$scope","importExportDocumentModule_importConf","sbiModule_restServices",importStep3FuncController]);

function importStep3FuncController($scope,importExportDocumentModule_importConf,sbiModule_restServices) {
	$scope.showCircular = false;

	function datasourcesInList(datasource,list){
		for(var i in list){
			if(list[i].label==datasource.label){
				return i;
			}
		}
		return -1;
	}


	$scope.currentDatasourcesIsSelectable=function(datasource,expDatasource){
		var datasourceinl=datasourcesInList(datasource,importExportDocumentModule_importConf.datasources.associatedDatasources);
		if(datasourceinl!=-1 && datasourceinl!=expDatasource.dsId){
			return false
		}
		return true;	
	}

	function getExportedDatasources(){
		var expr=[];
		for(var key in importExportDocumentModule_importConf.datasources.associatedDatasources){
			expr.push({datasourceAssociateId:importExportDocumentModule_importConf.datasources.associatedDatasources[key].dsId,expDatasourceId:key});
		}
		return expr;
	}
	$scope.checkDatasourceAssociated = function() {
			
			var associatedDS = $scope.IEDConf.datasources.associatedDatasources;
			var exportedDS = $scope.IEDConf.datasources.exportedDatasources;
			var countAssociatedDS = Object.keys(associatedDS).length;
			
			if(exportedDS.length == countAssociatedDS){
				return false;
			}else{
				return true;
			}
			
		}
	$scope.saveDatasourceAssociation=function(){
		$scope.showCircular = true;

		sbiModule_restServices.post("1.0/serverManager/importExport/document", 'associateDatasources',getExportedDatasources())
		.success(function(data, status, headers, config) {
			console.log("data--->",data)
			if(data.hasOwnProperty("errors")){
				$scope.stopImport(data.errors[0].message);	
			}else if(data.STATUS=="NON OK"){
				$scope.stopImport(data.ERROR);		
			}
			else if(data.STATUS=="OK"){
				$scope.showCircular = false;

				importExportDocumentModule_importConf.summary=data;

				$scope.stepControl.insertBread({name: $scope.translate.load('sbi.execution.executionpage.toolbar.metadata')})
			}
		})
		.error(function(data, status, headers, config) {
			$scope.stopImport(data);		
		});
	}



}
