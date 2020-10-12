({
	doInit : function(component, event, helper) {
        helper.getLeaveList(component, event, helper);
	},
     backmethod : function(component, event, helper){
       //  alert('from lc');
       // var callbackmethod = component.get("v.redirecttovf");
        //if(callbackmethod != null && callbackmethod != undefined)
         //   callbackmethod(null,'Back',null,null,function(){});
    
      var domain = $A.get("$Label.c.Driver_Menu_Domain");
         if(!window.location.href.includes(domain))
                    domain = '/apex';
        
            var userAgent = navigator.userAgent; 
            var theme = component.get("v.uitheme");
            //alert(theme);
            if (theme === 'Theme4d' || theme === 'Theme4u'){
                 sforce.one.navigateToURL(domain+'/Driver_Attendence');
            }
             else if(theme ==='Theme4t'){
            if(userAgent.includes("SalesforceMoblieSDK") || userAgent.includes("Salesforce1"))
               sforce.one.navigateToURL(domain+'/Driver_Attendence');
                 else
                       window.location=domain+'/Driver_Attendence';
             //  window.location=domain+'/Driver_Repair_Form?issuewith='+issue.IssueWithEng+'&priority='+priority+'&category='+component.get("v.IssueCategoryval")+'&recid='+issue.recid;
                     } 
                 else
                       window.location=domain+'/Driver_Attendence';
     // window.location=domain+'/Driver_Repair_Form?issuewith='+issue.IssueWithEng+'&priority='+priority+'&category='+component.get("v.IssueCategoryval")+'&recid='+issue.recid;
        
        
     }
})