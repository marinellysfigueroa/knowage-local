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
 
  

Ext.define('Sbi.tools.document.SmartFilterModel', {
    extend: 'Ext.data.Model',
    proxy: {
        type: 'rest',
        url : Sbi.config.serviceRegistry.getRestServiceUrl({
			serviceName: '1.0/documents'
		}),
		extraParams: {
            inputType: 'SMART_FILTER'
        },
        reader: {
            type: 'json',
            root: 'root'
        }
    },
    fields: ['creationDate',
             'creationUser',
    		'dataSetLabel',
    		'dataSourceLabel',
    		'description',
    		'docVersion',
    		'engine',
    		'functionalities',
    		'id',
    		'label',
    		'name',
    		'objMetaDataAndContents',
    		'parametersRegion',
    		'previewFile',
    		'stateCode',
    		'tenant',
    		'typeCode',
    		'visible']
});