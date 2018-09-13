<%@page import="it.eng.knowage.tools.servermanager.utils.LicenseManager"%>
<%@page import="it.eng.spagobi.commons.bo.UserProfile"%>
<%@page import="it.eng.spago.security.IEngUserProfile"%>
<%@page import="it.eng.spagobi.commons.utilities.ChannelUtilities"%>

 <%
    String userName="";
    String tenantName="";
    IEngUserProfile userProfile = (IEngUserProfile)session.getAttribute(IEngUserProfile.ENG_USER_PROFILE);
    
    if (userProfile!=null){
        userName=(String)((UserProfile)userProfile).getUserName();
        tenantName=(String)((UserProfile)userProfile).getOrganization();
    }

    String contextName = ChannelUtilities.getSpagoBIContextName(request);
%>
    

<md-dialog aria-label={{title}} ng-cloak flex=40 id="licenseDialog">
	<md-toolbar>
	  <div class="md-toolbar-tools">
	    <h2>{{title}}</h2>
	    <span flex></span>
	  </div>
	</md-toolbar>
    <md-dialog-content>
 	<md-tabs md-selected="selectedIndex" md-autoselect md-dynamic-height ng-if="hosts.length>0"> 
      <md-tab ng-repeat="host in hosts" label="{{host.hostName}}">
      
        <div layout="row" layout-align="center">
        	<div class="kn-info">
        		<strong>Hardware Id: </strong>{{host.hardwareId}}
        	</div>
        </div>
        
        <div class="licenseTopButtons">
            <label ng-disabled='ngDisabled' id="upload_license" class="md-knowage-theme md-button md-fab md-mini md-primary" md-ink-ripple for="upload_license_input">
                 <md-icon md-font-set="fa" md-font-icon="fa fa-plus"></md-icon>
            </label>
            <input  ng-disabled='ngDisabled' id="upload_license_input" type="file" class="ng-hide" onchange='angular.element(this).scope().setFile(this)'>
            <md-button ng-if="file" ng-click="uploadFile(host.hostName)" aria-label="menu" class="md-fab md-mini md-primary">
                <md-icon md-font-set="fa" md-font-icon="fa fa-upload"></md-icon>
             </md-button>
        </div>
        
        <md-list class="md-dense">
	        <md-list-item class="md-2-line" ng-repeat="license in licenseData[host.hostName]">
	        	<img ng-src="/knowage/themes/commons/img/licenseImages/{{license.product}}.png" class="md-avatar" alt="{{license.product}}" />
	        	<div class="md-list-item-text">
	          		<h3>{{license.product}}</h3>
	          		<p ng-class="{'kn-danger':license.status.contains('INVALID'),'kn-success':!license.status.contains('INVALID')}">
		          		{{license.status_ext}}
		          		<span ng-if="license.expiration_date">- {{license.expiration_date}}</span>
	          		</p>
	         	</div>
	         	<md-button class="md-secondary md-icon-button" ng-click="dowloadFile(license, host.hostName)" >
		        	<md-icon md-font-set="fa" md-font-icon="fa fa-download"></md-icon>
		        </md-button>
		        <!--  uncomment this to add the license delete md-button class="md-secondary md-icon-button" ng-click="deleteFile(license, host.hostName)" >
		        	<md-icon md-font-set="fa" md-font-icon="fa fa-trash"></md-icon>
		        </md-button -->
	         	<md-divider></md-divider>
	       </md-list-item>
        </md-list>
     
      </md-tab>
     </md-tabs> 
        
    </md-dialog-content>
    <md-dialog-actions layout="row">
      <md-button class="md-raised md-primary" ng-click="closeDialog()" >
          {{okMessage}}
      </md-button>
    </md-dialog-actions>
</md-dialog>