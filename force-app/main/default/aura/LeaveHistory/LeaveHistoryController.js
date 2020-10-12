({
	doInit : function(component, event, helper) {
        helper.getLeaveList(component, event, helper);
		
	},
     cancel : function(component, event, helper) {
       
      var domain = $A.get("$Label.c.Driver_Menu_Domain");
         if(!window.location.href.includes(domain))
                    domain = '/apex';
        
            var userAgent = navigator.userAgent; 
            var theme = component.get("v.uitheme");
            //alert(theme);
            if (theme === 'Theme4d' || theme === 'Theme4u'){
                 sforce.one.navigateToURL(domain+'/ApplyLeavePage');
            }
             else if(theme ==='Theme4t'){
            if(userAgent.includes("SalesforceMoblieSDK") || userAgent.includes("Salesforce1"))
               sforce.one.navigateToURL(domain+'/ApplyLeavePage');
                 else
                       window.location=domain+'/ApplyLeavePage';
             //  window.location=domain+'/Driver_Repair_Form?issuewith='+issue.IssueWithEng+'&priority='+priority+'&category='+component.get("v.IssueCategoryval")+'&recid='+issue.recid;
                     } 
                 else
                       window.location=domain+'/ApplyLeavePage';
     // window.location=domain+'/Driver_Repair_Form?issuewith='+issue.IssueWithEng+'&priority='+priority+'&category='+component.get("v.IssueCategoryval")+'&recid='+issue.recid;
        

    }
})