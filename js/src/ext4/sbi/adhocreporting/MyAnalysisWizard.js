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

Ext.define('Sbi.adhocreporting.MyAnalysisWizard', {
	extend: 'Sbi.widgets.wizard.WizardWindow'

		,config: {	
			fieldsStep1: null,
			height: 280, //440,
			record: {},
			user:'',
			isTabbedPanel:false, //if false rendering as 'card layout (without tabs)
			documentType: null,
			useCockpitEngine: null,
		    useWSEngine: null,
		    useQbeEngine: null,
		    useGeoEngine: null
		}

		, constructor: function(config) {
			
			Ext.QuickTips.init();
			
			thisPanel = this;
			this.initConfig(config);

		
			this.configureSteps();
		
			config.title =  LN('sbi.myanalysis.wizard.wizardname') + ' - ' + LN('sbi.myanalysis.wizard.myanalysisselection') + '...'; 	
//			config.bodyPadding = 10;   
			config.tabs = this.initSteps();
		
			this.callParent(arguments);
			
			this.addListener('cancel', this.closeWin, this);
			this.addListener('navigate', this.navigate, this);
			this.addListener('confirm', this.save, this);		
		
			this.addEvents('openMyDataForReport');
			this.addEvents('openMyDataForGeo');
			this.addEvents('openCockpitDesigner');
		}
		
		, configureSteps : function(){
			   
			this.fieldsStep1 =  this.getFieldsTab1(); 

		}
		
		, getFieldsTab1: function(){
			
			this.geoSelectionButton = new Ext.Button({
				  text: ''
		          ,flex:1
		          ,margin: 10
		          ,height: '100px'
		          ,cls:'geobutton'
		          ,handler: function() {
		        	  thisPanel.documentType = 'Geo';
		        	  thisPanel.fireEvent('openMyDataForGeo');
		        	  thisPanel.close();
		          }
			  	  ,tooltip:'Create a new Geographical Analysis'

			});
			
			this.cockpitSelectionButton = new Ext.Button({
				  text: ''
		          ,flex:1
		          ,margin: 10
		          ,height: '100px'
			      ,cls:'cockpitbutton'
			      ,handler: function() {
			    	  thisPanel.documentType = 'Cockpit';
			    	  thisPanel.fireEvent('openCockpitDesigner');
			    	  thisPanel.close();
		          }
		  	      ,tooltip:'Create a new Cockpit Analysis'

			});
			
			var buttons = [];
			
			if (this.useGeoEngine)
				buttons.push(this.geoSelectionButton);
			
			if (this.useCockpitEngine)
				buttons.push(this.cockpitSelectionButton);
			
			this.selectionPanel = new Ext.Panel({
			    layout: 'hbox',
			    align: 'stretch',
			    border: 0,
			    padding: 10,
			    style: 'background-color: white;padding: 40px',				
				items: buttons
			});
			
			this.parentPanel = new Ext.Panel({
				layout:'fit',
//				height: 200, //400,
//				style: 'margin:0 auto;margin-top:100px;',
				style: 'margin:0 auto;margin-top:40px;',
				border: 0,
				items: [this.selectionPanel]
			});
			
			return this.parentPanel;
			
			
		}
		
		, getFieldsTab2: function(){
			//General tab
			var toReturn = [];
			
			toReturn = [
				        {label: LN('sbi.ds.label'), name:"label", type:"text", mandatory:true, /*readOnly:(this.isNew || this.isOwner)?false:true,*/}, 
				        {label: LN('sbi.ds.name'), name:"name", type:"text", mandatory:true, readOnly:false /*,value:this.record.name*/},
				        {label: LN('sbi.ds.description'), name:"description", type:"textarea", readOnly:false /*,value:this.record.description*/}
			         ];
			
			return toReturn;
		}
		
		, getFieldsTab3: function() {
			var toReturn = [];
			
			
//			toReturn = [
//				        {label: LN('sbi.ds.label'), name:"label", type:"text", mandatory:true, /*readOnly:(this.isNew || this.isOwner)?false:true,*/}, 
//
//			         ];
			
			return toReturn;
		}		
		
		, initSteps: function(){
			
			var steps = [];

			steps.push({itemId:'0', items: this.fieldsStep1});

			return steps;
		}
		
		, initWizardBar: function() {
			var bar = this.callParent();
			for (var i=0; i<bar.length; i++){
				var btn = bar[i];
				if (btn.id === 'confirm'){
					if (!this.isOwner) {					
						btn.disabled = true;
					}
				}				
			}
			return bar;
		}
		
		, closeWin: function(){				
			this.destroy();
		}
		
		, navigate: function(panel, direction){		
	        // This routine could contain business logic required to manage the navigation steps.
	        // It would call setActiveItem as needed, manage navigation button state, handle any
	         // branching logic that might be required, handle alternate actions like cancellation
	         // or finalization, etc.  A complete wizard implementation could get pretty
	         // sophisticated depending on the complexity required, and should probably be
	         // done as a subclass of CardLayout in a real-world implementation.
			 var layout = panel.getLayout();
			 var newTabId;
			 if (this.isTabbedPanel){
				 newTabId  = parseInt(this.wizardPanel.getActiveTab().itemId);
			 }else{
				newTabId  = parseInt(this.wizardPanel.layout.getActiveItem().itemId);
			 }
			 
			 var oldTabId = newTabId;
			 var numTabs  = (this.wizardPanel.items.length-1);
			 var isTabValid = true;
			 if (direction == 'next'){
				 newTabId += (newTabId < numTabs)?1:0;	
				 if (newTabId == 0){
					 isTabValid = this.validateTab0();					
				 }
				 if (newTabId == 1){
					 isTabValid = this.validateTab1();
					if (isTabValid){						

					}
				 }
				 if (newTabId == 2){				 

				 }
			 }else{			
				newTabId -= (newTabId <= numTabs)?1:0;					
			 }
			 if (isTabValid){
				 if (this.isTabbedPanel){
					 this.wizardPanel.setActiveTab(newTabId);
				 }else{
					 this.wizardPanel.layout.setActiveItem(newTabId);
				 }
				 Ext.getCmp('move-prev').setDisabled(newTabId==0);
				 Ext.getCmp('move-next').setDisabled(newTabId==numTabs || newTabId==0);
			 	 Ext.getCmp('confirm').setVisible(!(parseInt(newTabId)<parseInt(numTabs)));
//				 	Ext.getCmp('confirm').setDisabled(parseInt(newTabId)<parseInt(numTabs));
			 }			 
		}
		
		, validateTab0: function(){		
			//TODO: to implement
			return true;
		}
		
		, validateTab1: function(){		
			//TODO: to implement
			return true;
		}
		
		, save : function(){
			if (this.validateTab0() && this.validateTab1()){
				//TODO: to implement
				this.fireEvent('save', values);
			}
		}
		
		, goNext: function(n){
			var newTabId;
			if (this.isTabbedPanel){
				newTabId  = parseInt(this.wizardPanel.getActiveTab().itemId)+n;
			}else{
				newTabId  = parseInt(this.wizardPanel.layout.getActiveItem().itemId)+n;
			}
			var numTabs  = (this.wizardPanel.items.length-1);	
			if (this.isTabbedPanel){
				this.wizardPanel.setActiveTab(newTabId);
			} else {
				this.wizardPanel.layout.setActiveItem(newTabId);
			}
			Ext.getCmp('move-prev').setDisabled(newTabId==0);
			Ext.getCmp('move-next').setDisabled(newTabId==numTabs );
			Ext.getCmp('confirm').setDisabled(newTabId<numTabs);
		}
});		