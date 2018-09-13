var app = angular.module('kpiDefinitionManager', [ 'ngMaterial', 'angular_table' ,'sbiModule', 'angular-list-detail','ui.codemirror','color.picker','angular_list']);
app.config(['$mdThemingProvider', function($mdThemingProvider) {
	$mdThemingProvider.theme('knowage')
	$mdThemingProvider.setDefaultTheme('knowage');
}]);


app.controller('kpiDefinitionMasterController', ['$scope','sbiModule_translate', 'sbiModule_restServices','$mdDialog','$q','$mdToast','$timeout','sbiModule_messaging',kpiDefinitionMasterControllerFunction ]);

function kpiDefinitionMasterControllerFunction($scope,sbiModule_translate,sbiModule_restServices,$mdDialog,$q,$mdToast,$timeout,sbiModule_messaging){
	$scope.translate=sbiModule_translate;
	//variables formula
	$scope.checkFormula = false;
	$scope.emptyKpi = {"name":"","definition":"",'id':undefined,cardinality:"{\"measureList\":[],\"checkedAttribute\":{}}",threshold:{description:"",thresholdValues:[]},placeholder:""};
	$scope.kpi = {"name":"","definition":"",'id':undefined};
	$scope.activeSave = "";
	$scope.AttributeCategoryList=[];
	$scope.showGUI=false;
	$scope.formulaModified={"value":false};
	$scope.columns = [{"label":"Name","name":"name"},{"label":"DateCreation","name":"datacreation"},{"label":"Category","name":"valueCd"},{"label":"Author","name":"author"}];
	$scope.kpiList=[];
	$scope.listOrder = '';
	$scope.listDirection = false;
	$scope.kpiListOriginal=[];
	$scope.selectedTab={'tab':0};
	$scope.thresholdTypeList=[];
	$scope.isUsedByAnotherKpi={value:false};
	$scope.measures=[];
	//variables placeholder
	$scope.flagLoaded = false;
	$scope.placeHolderObjectList = {};
	$scope.placeHolderList=[];
	$scope.placeholder={};
	//variables cardinality
	$scope.countAccessCardinality = 0;
	
	//methods formula
	sbiModule_restServices.promiseGet("2.0/domains","listByCode/KPI_KPI_CATEGORY")
	.then(function(response){ 
		angular.copy(response.data,$scope.AttributeCategoryList);
	},function(response){

	});
	sbiModule_restServices.promiseGet("1.0/kpi", 'listMeasure')
	.then(function(response){ 

		$scope.measures=response.data;
	},function(response){
		$scope.errorHandler(response.data,"");
	});

	$scope.getKpiName = function(){
		if($scope.kpi.name!=""){
			return $scope.kpi.name;
		} else{
			return 'New Kpi';
		}
	}
	
	$scope.parseFormula = function(){
		$scope.$broadcast ('parseEvent');
		if($scope.showGUI){
			$scope.showSaveGUI().then(function(response){
				$scope.saveKPI();
			});
		}
	}

	$scope.flagActivateBrother= function(event){
		$scope.$broadcast (event);
	}
	
	$scope.toggleOrder = function(col){
		if($scope.listOrder == col.name){
			$scope.listDirection = !$scope.listDirection ? true : false;
		}else {
			$scope.listOrder = col.name;
			$scope.listDirection = false;
		}
		
	}

	$scope.cancelMeasureFunction=function(){
		if(!angular.equals($scope.originalRule,$scope.currentRule)){
			var confirm = $mdDialog.confirm()
			.title($scope.translate.load("sbi.layer.modify.progress"))
			.content($scope.translate.load("sbi.layer.modify.progress.message.modify"))
			.ariaLabel('cancel metadata') 
			.ok($scope.translate.load("sbi.general.ok"))
			.cancel($scope.translate.load("sbi.general.cancel"));
			$mdDialog.show(confirm).then(function() {

				$angularListDetail.goToList();
			}, function() {
				return;
			});
		}else{

			$angularListDetail.goToList();
		} 
	};
	
	$scope.cancel = function(){
		if($scope.formulaModified.value && $scope.kpi.id!=undefined){
			var confirm = $mdDialog.confirm()
			.title($scope.translate.load("sbi.layer.modify.progress"))
			.content($scope.translate.load("sbi.layer.modify.progress.message.modify"))
			.ariaLabel('cancel metadata') 
			.ok($scope.translate.load("sbi.general.ok"))
			.cancel($scope.translate.load("sbi.general.cancel"));
			$mdDialog.show(confirm).then(function() {
				$scope.formulaModified.value=false;
				$scope.kpi.cardinality.measureList=[];
				$scope.kpi.cardinality.checkedAttribute={"attributeUnion":{},"attributeIntersection":{}};
				$scope.$broadcast ('cancelEvent');
			}, function() {
				return;
			});
		}else{
			$scope.formulaModified.value=false;
			if(angular.isObject($scope.kpi.cardinality)){
				angular.copy({"measureList":[],"checkedAttribute":{}},$scope.kpi.cardinality);
			}else{
				$scope.kpi.cardinality = JSON.parse($scope.kpi.cardinality);
				angular.copy({"measureList":[],"checkedAttribute":{}},$scope.kpi.cardinality);
			}

			$scope.$broadcast('clearAllEvent');
			$scope.$broadcast ('cancelEvent');
		}
	}
	
	$scope.showSaveGUI= function(){
		var deferred = $q.defer();
		$mdDialog.show({
			controller: DialogControllerKPI,
			templateUrl: 'templatesaveKPI.html',
			clickOutsideToClose:true,
			preserveScope:true,
			locals: {items: deferred,AttributeCategoryList: $scope.AttributeCategoryList,kpi:$scope.kpi, translate:sbiModule_translate}
		})
		.then(function(answer) {
			$scope.status = 'You said the information was "' + answer + '".';
			return deferred.resolve($scope.selectedFunctionalities);
		}, function() {
			$scope.status = 'You cancelled the dialog.';
		});
		return deferred.promise;
	}

	$scope.showAction = function(text) {		
		sbiModule_messaging.showInfoMessage(text,"");
	}

	$scope.errorHandler=function(text,title){
		var titleFin=title || "";
		var textFin=text;
		if(angular.isObject(text)){
			if(text.hasOwnProperty("errors")){
				textFin="";
				for(var i=0;i<text.errors.length;i++){
					textFin+=text.errors[i].message+" <br> ";
				}
			}else{
				textFin=JSON.stringify(text)
			}
		}

		var confirm = $mdDialog.confirm()
		.title(titleFin)
		.content(textFin)
		.ariaLabel('error') 
		.ok('OK') 
		return $mdDialog.show(confirm);
	}
	
	$scope.parsePlaceholder = function(placeholder){
		for(var key in Object.keys( placeholder)){
			if( placeholder[Object.keys( placeholder)[key]]==""){
				delete  placeholder[Object.keys( placeholder)[key]];
			}
		}
	}

	$scope.saveKPI = function(){
		var tmpKpiToSave={};
		angular.copy($scope.kpi,tmpKpiToSave);
		//save formula
		if(angular.isObject($scope.kpi.definition)){
			tmpKpiToSave.definition = JSON.stringify($scope.kpi.definition);
		}
		//update cardinality
		if(angular.isObject($scope.kpi.cardinality)){
			if(Object.keys($scope.kpi.cardinality).length>0 ){
				if($scope.kpi.cardinality.length!=$scope.kpi.cardinality.measureList.length && $scope.formulaModified.value){
					$scope.setCardinality();
					tmpKpiToSave.cardinality=JSON.stringify($scope.kpi.cardinality);
				}else{
					tmpKpiToSave.cardinality=JSON.stringify($scope.kpi.cardinality);
				}
			}else{
				var obj;
				if(angular.isObject($scope.kpi.cardinality)){
					obj = $scope.kpi.cardinality;
				}else{
					obj=JSON.parse($scope.kpi.cardinality);
				}
				var obj2;
				if(angular.isObject($scope.kpi.definition)){
					obj2= $scope.kpi.definition.measures;
				}else{
					obj2=JSON.parse($scope.kpi.definition).measures;
				}

				For1:for(var i=0;i<obj.length;i++){
					if(obj.measureList[i].measureName!=obj2[i]){
						break For1;
					}
				}
				if(obj2.length!=obj.measureList.length){
					$scope.kpi.cardinality={"measureList":[],"checkedAttribute":{}};
					tmpKpiToSave.cardinality=JSON.stringify($scope.kpi.cardinality);
				}
			}
		}else{
			$scope.kpi.cardinality = JSON.parse($scope.kpi.cardinality);
			if($scope.kpi.cardinality.length!=$scope.kpi.cardinality.measureList.length && $scope.formulaModified.value){
				$scope.setCardinality();
				tmpKpiToSave.cardinality=JSON.stringify($scope.kpi.cardinality);
			}else{
				tmpKpiToSave.cardinality=JSON.stringify($scope.kpi.cardinality);
			}
		}
		
		//update placeholder
		if(tmpKpiToSave.placeholder==null || tmpKpiToSave.placeholder==undefined || (angular.isObject(tmpKpiToSave.placeholder) && Object.keys(tmpKpiToSave.placeholder).length==0)){
			tmpKpiToSave.placeholder='';
		}
		else if(angular.isObject(tmpKpiToSave.placeholder) && !$scope.formulaModified.value){
			$scope.parsePlaceholder(tmpKpiToSave.placeholder);
			tmpKpiToSave.placeholder=JSON.stringify(tmpKpiToSave.placeholder);
		}else if($scope.formulaModified.value && tmpKpiToSave.placeholder!=""){
			tmpKpiToSave.placeholder=JSON.stringify(tmpKpiToSave.placeholder);
		}
		$scope.convertThresholdToCorrectObject(tmpKpiToSave);

		sbiModule_restServices.promisePost("1.0/kpi", 'saveKpi',tmpKpiToSave).then(
				function(response) {
					if (response.data.hasOwnProperty("errors")) {
						$scope.showAction(response.data);
					} else {
						$scope.$broadcast ('savedEvent');
						$scope.formulaModified.value=false;
					}

				},function(response) {
					$scope.errorHandler(response.data,"");
				})
	}

	$scope.convertThresholdToCorrectObject=function(kpi){
		for(var i=0;i<kpi.threshold.thresholdValues.length;i++){
			if(kpi.threshold.thresholdValues[i].position != i+1){
				kpi.threshold.thresholdValues[i].position = i+1;
			}
		}
	}

	$scope.measureMenuOption= [{
		label : sbiModule_translate.load('sbi.generic.delete'),
		icon:'fa fa-trash' ,
		backgroundColor:'transparent',	
		action : function(item,event) {
			$scope.deleteMeasure(item,event);
		}

	},{
		label : sbiModule_translate.load('sbi.generic.clone'),
		icon:'fa fa-copy' ,	 
		backgroundColor:'transparent',	 
		action : function(item,event) {
			$scope.cloneKpi(item,event);
		}

	}];

	$scope.deleteMeasure=function(item,event){
		event.preventDefault();
		event.stopImmediatePropagation();
		var confirm = $mdDialog.confirm()
		.title($scope.translate.load("sbi.kpi.measure.delete.title"))
		.content($scope.translate.load("sbi.kpi.measure.delete.content"))
		.ariaLabel('delete kpi') 
		.ok($scope.translate.load("sbi.general.yes"))
		.cancel($scope.translate.load("sbi.general.No"));
		$mdDialog.show(confirm).then(function() {

			sbiModule_restServices.promiseDelete("1.0/kpi",item.id+"/"+item.version+"/deleteKpi").then(
					function(response){
						$scope.$broadcast("deleteKpiEvent");
					},
					function(response){
						$scope.errorHandler(response.data,""); 
					});

		}, function() {
		});
	}

	$scope.cloneKpi = function(item,event){
		event.preventDefault();
		event.stopImmediatePropagation();
		var confirm = $mdDialog.confirm()
		.title($scope.translate.load("sbi.generic.confirmClone"))
		.ariaLabel('clone measure') 
		.ok($scope.translate.load("sbi.general.yes"))
		.cancel($scope.translate.load("sbi.general.No"));
		$mdDialog.show(confirm).then(function() {
			sbiModule_restServices.promiseGet("1.0/kpi",item.id+"/"+item.version+"/loadKpi")
			.then(function(response){ 
				$timeout(function(){
					$scope.selectedTab.tab=0;
				},0)

				angular.copy(response.data,$scope.kpi); 
				$scope.kpi.id = undefined;
				$scope.flagActivateBrother('loadedEvent');

			},function(response){
			});
		}, function() {
			console.log("annulla")
		});

	}
	$scope.setTab = function(Tab){
		$scope.selectedTab = Tab;
	}
	$scope.isSelectedTab = function(Tab){
		return (Tab == $scope.selectedTab) ;
	}
	//methods cardinality
	$scope.setCardinality = function(){


		$scope.$broadcast ('parseEvent');

		if($scope.countAccessCardinality==0 && $scope.formulaModified.value ){
			var emptyobj={measureList:[],checkedAttribute:{"attributeUnion":{},"attributeIntersection":{}}}
			if(!angular.isObject($scope.kpi.cardinality)){ 
				$scope.kpi.cardinality = JSON.parse($scope.kpi.cardinality);
			}
			angular.copy(emptyobj,$scope.kpi.cardinality);
		}
		$scope.countAccessCardinality++;
		
		
		if(!angular.isObject($scope.kpi.cardinality))
			$scope.kpi.cardinality = JSON.parse($scope.kpi.cardinality);
		
		
		if($scope.kpi.cardinality!=undefined && Object.keys($scope.kpi.cardinality).length!=0){
			var obj=$scope.kpi.cardinality
			if(!angular.isObject($scope.kpi.cardinality)){ 
				obj = JSON.parse($scope.kpi.cardinality);
			}
			if(obj.measureList.length!=0 && !$scope.formulaModified.value){
				$scope.kpi.cardinality={};
				angular.copy(obj,$scope.kpi.cardinality); 
				$scope.$broadcast ('activateCardinalityEvent');
			}else if($scope.formulaModified.value){
				var flag = true;
				var obj2=$scope.kpi.definition.measures;
				For1:for(var i=0;i<obj.measureList.length;i++){
					if(obj.measureList[i].measureName!=obj2[i]){
						$scope.resetMatrix();
						flag=false;
						break For1;
					}
				}
				if(obj2.length!=obj.measureList.length){
					$scope.resetMatrix();
					flag=false;
				}else if(flag){
					$scope.kpi.cardinality = {};
					angular.copy(obj,$scope.kpi.cardinality); 
					$scope.$broadcast ('activateCardinalityEvent');
				}
			}else {
				$scope.resetMatrix();
			}
		}else{

			$scope.$broadcast ('nullCardinalityEvent');
			$scope.resetMatrix();
		}

	}

	$scope.resetMatrix = function(){
		$scope.kpi.cardinality.measureList=[];
		if(Object.keys($scope.kpi.definition).length!=0){
			var definition = {};
			for(var i=0;i<$scope.kpi.definition.measures.length;i++ ){
				
				var meas = $scope.kpi.definition.measures[i];
				definition[i] = meas;
			}
			sbiModule_restServices.promisePost("1.0/kpi", 'buildCardinalityMatrix',definition).then(
					function(response) {
						if (response.data.hasOwnProperty("errors")) {
							$scope.showAction(response.data);
						} else {
							if(!angular.isObject($scope.kpi.cardinality)){
								$scope.kpi.cardinality = JSON.parse($scope.kpi.cardinality);
							}
							angular.copy(response.data,$scope.kpi.cardinality.measureList);
							$scope.kpi.cardinality.checkedAttribute={"attributeUnion":{},"attributeIntersection":{}};
							$scope.$broadcast ('activateCardinalityEvent');
						}

					},function(response) {
						$scope.errorHandler(response.data,"");
					})
		}
	}
//	methods Filters
	$scope.setFilters = function(){
		$scope.$broadcast ('parseEvent');
		$scope.placeHolderList=[];
		if($scope.formulaModified.value){
			$scope.placeholder;
			if(!angular.isObject($scope.kpi.placeholder)){
				if($scope.kpi.placeholder==""){
					$scope.placeholder = {};
				}else
					$scope.placeholder =  JSON.parse($scope.kpi.placeholder);
			}else{
				$scope.placeholder = $scope.kpi.placeholder;
			}
			$scope.kpi.placeholder = "";
		}
		if($scope.kpi.placeholder=="" || $scope.kpi.placeholder==null || Object.keys($scope.kpi.placeholder).length==0){
			$scope.kpi.placeholder={};
			if($scope.kpi.definition!=undefined && Object.keys($scope.kpi.definition).length!=0){
				$scope.$broadcast('activateFiltersEvent');
			}
		}else{
			//placeholder presents
			if($scope.kpi.placeholder!=""){
				$scope.kpi.placeholder = JSON.parse($scope.kpi.placeholder);

			}else{
				$scope.kpi.placeholder={};
			}
			$scope.$broadcast('activateFiltersEvent');
		}


	}

	$scope.indexInList=function(item, list) {
		for (var i = 0; i < list.length; i++) {
			var object = list[i];
			if(object.measureName==item){
				return i;
			}
		}
		return -1;
	};
	//methods Threshold
	$scope.loadThreshold=function(){
		$scope.checkIfIsUsedByAnotherKpi();
	};

	$scope.errorHandler=function(text,title){
		var titleFin=title || "";
		var textFin=text;
		if(angular.isObject(text)){
			if(text.hasOwnProperty("errors")){
				textFin="";
				for(var i=0;i<text.errors.length;i++){
					textFin+=text.errors[i].message+" <br> ";
				}
			}else{
				textFin=JSON.stringify(text)
			}
		}

		var confirm = $mdDialog.confirm()
		.title(titleFin)
		.content(textFin)
		.ariaLabel('error') 
		.ok($scope.translate.load("sbi.general.ok")) 
		return $mdDialog.show(confirm);
	}

	$scope.checkIfIsUsedByAnotherKpi=function(){
		if($scope.kpi.id!=undefined && $scope.kpi.threshold.usedByKpi==true){
			$scope.isUsedByAnotherKpi.value=true;
		}else{
			$scope.isUsedByAnotherKpi.value=false;
		}
	}

};
function DialogControllerKPI($scope,$mdDialog,items,AttributeCategoryList,kpi, translate,$timeout){
	$scope.translate = translate;
	$scope.AttributeCategoryList=AttributeCategoryList;
	$scope.kpi=kpi;
	$scope.tmpcategory;
	$scope.close = function(){
		$mdDialog.cancel();

	}
	
	$scope.searchTextChange=function(kpi,searchTerm){
		if((kpi.category==undefined || kpi.category=="") && searchTerm!=""){
			$scope.tmpSearchterm=searchTerm; 
			$timeout(function(){
				if($scope.tmpSearchterm==searchTerm){
					kpi.category={valueCd:angular.uppercase(searchTerm)}; 
				}
			},500)
		}
	}
	
	$scope.apply = function(){
		$mdDialog.cancel();
		items.resolve($scope.kpi);
	}

	$scope.querySearchCategory=function(query){
		var results = query ? $scope.AttributeCategoryList.filter( createFilterFor(query) ) : [];
		results.push({valueCd:angular.uppercase(query)})
		return results;
	}
	function createFilterFor(query) {
		var lowercaseQuery = angular.lowercase(query);
		return function filterFn(state) {
			return (angular.lowercase(state.valueCd).indexOf(lowercaseQuery) === 0);
		};
	}

}