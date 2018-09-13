/*
 * Knowage, Open Source Business Intelligence suite
 * Copyright (C) 2016 Engineering Ingegneria Informatica S.p.A.
 * 
 * Knowage is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Knowage is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 * 
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */ 

/**
 * 
 * This class is the container for the ad-hoc reporting interface 
 *    
 *  @author
 *  Alberto Ghedin (alberto.ghedin@eng.it)
 */
 
  
Ext.define('Sbi.adhocreporting.AdhocreportingContainer', {
	extend: 'Ext.panel.Panel',

	config:{
    	qbeFromBMBaseUrl : '',
    	qbeFromDataSetBaseUrl : '',
        user : '',
        myAnalysisServicePath: '',
        georeportEngineBaseUrl: '',
        cockpitEngineBaseUrl: '',
        //datasetsServicePath: ''
        contextName: ''
	},

	/**
	 * @property {Panel} adhocreportingTabsPanel
	 *  Tab panel that contains the my analysis documents
	 */
    adhocreportingTabsPanel: null,
	
	/**
	 * @property {Panel} documentexecution
	 *  Tab panel that contains the execution of the engine
	 */
    documentexecution: null
	
	, constructor : function(config) {

		this.initConfig(config);
		
		this.layout =  'card';
		
		this.documentexecution = Ext.create('Sbi.selfservice.SelfServiceExecutionIFrame',{hideToolbar:true}); 
		this.adhocreportingTabsPanel = Ext.create('Sbi.adhocreporting.AdhocreportingTabsPanel', {
			adhocreportingContainer : this
			, myAnalysisServicePath : config.myAnalysisServicePath
		}); 
					
		this.items = [ this.adhocreportingTabsPanel
		               , this.documentexecution
		               ]
		this.callParent(arguments);
		
		this.addEvents(
		        /**
		         * @event event1
		         * Execute the qbe clicking in the model/dataset
				 * @param {Object} docType engine to execute 'QBE'/'/'COCKPIT'
				 * @param {Object} inputType 'DOCUMENT'
				 * @param {Object} record the record that contains all the information of the document
		         */
		        'executeDocument'
				);
		this.adhocreportingTabsPanel.on('executeDocument', this.executeDocument ,this);
		
		this.addEvents('openMyDataForReport');
		
		this.adhocreportingTabsPanel.on('openMyDataForReport', this.createReport ,this);
		
		this.addEvents('openMyDataForGeo');

		this.adhocreportingTabsPanel.on('openMyDataForGeo', this.createGeo ,this);
		
		this.addEvents('openCockpitDesigner');

		this.adhocreportingTabsPanel.on('openCockpitDesigner', this.createCockpit ,this);

	}
	
	,createReport: function(){
		var myDataUrl = this.contextName + '/servlet/AdapterHTTP?ACTION_NAME=SELF_SERVICE_DATASET_START_ACTION&LIGHT_NAVIGATOR_RESET_INSERT=TRUE&MYDATA=true&TYPE_DOC=REPORT&MYANALYSIS=TRUE';
		Sbi.debug('myDataUrl: ' + myDataUrl);
		this.documentexecution.load(myDataUrl);
		this.getLayout().setActiveItem(1);	
	}
	
	,createGeo: function(){
		var myGeoUrl = this.contextName + '/servlet/AdapterHTTP?ACTION_NAME=SELF_SERVICE_DATASET_START_ACTION&LIGHT_NAVIGATOR_RESET_INSERT=TRUE&MYDATA=true&TYPE_DOC=GEO&MYANALYSIS=TRUE';
		Sbi.debug('myDataUrl: ' + myGeoUrl);
		this.documentexecution.load(myGeoUrl);
		this.getLayout().setActiveItem(1);	
	}
	
	,createCockpit: function(){
		var cockpitUrl = this.cockpitEngineBaseUrl + '&MYANALYSIS=TRUE&documentMode=EDIT';
		Sbi.debug('cockpitUrl: ' + cockpitUrl);
		this.documentexecution.load(cockpitUrl);
		this.getLayout().setActiveItem(1);	
	}
	
	,executeDocument: function(docType,inputType, record){		
		if(docType=='COCKPIT'){
			Sbi.debug("Cockpit document execution");
			this.executeCockpit(inputType, record);
		} else if (docType=='GEOREPORT'){
			Sbi.debug("Georeport document execution");
			this.executeGeoreport(inputType, record);
		} else {
			alert('Impossible to execute document of type [' + docType + ']');
		}
		this.getLayout().setActiveItem(1);	
	}
	
	
	, executeCockpit: function(inputType, record){
		if(inputType == "DOCUMENT"){
			this.executeDocumentAction(inputType, record);			
		}
	}

	, executeGeoreport: function(inputType, record){
		if(inputType == "DOCUMENT"){
			this.executeDocumentAction(inputType, record);
		}
	}
	
	, executeDocumentAction: function(inputType, record){
		var doc = record.data;
		var executionUrl = this.contextName + '/servlet/AdapterHTTP?ACTION_NAME=EXECUTE_DOCUMENT_ACTION&OBJECT_LABEL='+doc.label+'&OBJECT_ID='+doc.id+'&MYANALYSIS=TRUE';
		this.documentexecution.load(executionUrl);
	}
	
   
	
});