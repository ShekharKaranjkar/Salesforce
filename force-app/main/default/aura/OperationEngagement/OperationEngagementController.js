({
   init: function (component, event, helper) {
       
        helper.getData(component);
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
                 sforce.one.navigateToURL(domain+'/DriverMenu');
            }
             else if(theme ==='Theme4t'){
            if(userAgent.includes("SalesforceMoblieSDK") || userAgent.includes("Salesforce1"))
               sforce.one.navigateToURL(domain+'/DriverMenu');
                 else
                       window.location=domain+'/DriverMenu';
             //  window.location=domain+'/Driver_Repair_Form?issuewith='+issue.IssueWithEng+'&priority='+priority+'&category='+component.get("v.IssueCategoryval")+'&recid='+issue.recid;
                     } 
                 else
                       window.location=domain+'/DriverMenu';
     // window.location=domain+'/Driver_Repair_Form?issuewith='+issue.IssueWithEng+'&priority='+priority+'&category='+component.get("v.IssueCategoryval")+'&recid='+issue.recid;
        
        
     }, 
    controllerFunction: function(component,event,helper) {
        debugger;
        var value = event.currentTarget.getAttribute("data-value");
        //alert(value);
         console.log('value:::',JSON.stringify(value));
       // console.log(JSON.stringify(value));
        //component.set("v.particularExpense",value);
        component.set("v.isOpen", true);
    },
    closeModel: function(component, event, helper) {
        // for Hide/Close Model,set the "isOpen" attribute to "Fasle"  
        component.set("v.isOpen", false);
          $A.get('e.force:refreshView').fire();
    },
    openmodule : function(component,event,helper) {
        debugger;
        var buttonName = event.getSource().get("v.variant");
        console.log('buttonName--------',buttonName); 
        component.set("v.detailslist",buttonName);
        component.set("v.isOpen", true);
    },
})