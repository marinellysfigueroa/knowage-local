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
 * Object name 
 * 
 * [description]
 * 
 * 
 * Public Properties
 * 
 * enableTreeDD: truue to enable dd
 * 
 * 
 * Public Methods
 * 
 *  [list]
 * 
 * 
 * Public Events
 * 
 *  [list]
 * 
 * Alberto Ghedin alberto.ghedin@eng.it
 * 
 * - name (mail)
 */

Ext.define('Sbi.widgets.tree.SimpleStore', {
	extend: 'Ext.tree.Panel'

		,config: {

		}
	
	/**
	 * Creates the store.
	 * @param {Object} config (optional) Config object
	 */
	, constructor: function(config) {
	
		var store = Ext.create('Ext.data.TreeStore', {
			proxy: {
				type: 'ajax',
				url: 'get-nodes.php'
			},
			root: {
				id: 'src',
				expanded: true
			}
		});
		
		
		
		var treeConf = {
				store: store,
				useArrows: true
		}
		
		
		if(config.enableTreeDD){
			this.viewConfig ={
				plugins: {
					ptype: 'treeviewdragdrop'
				}
			};
		}
		
		if(config.enableExpandCollapse){
			this.dockedItems =[{
				xtype: 'toolbar',
				items: [{
					text: 'Expand All',
					handler: function(){
						tree.expandAll();
					}
				}, {
					text: 'Collapse All',
					handler: function(){
						tree.collapseAll();
					}
				}]
			}];
		}
		
		
	}
});