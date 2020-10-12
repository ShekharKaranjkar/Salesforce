({
    
    handlesave : function(component,event,helper) {
        console.log('componentn.get("v.certificateApexString")'+component.get("v.certificateApexString"));
    
        console.log('covid'+  component.get("v.duty"));    
        console.log('covid'+  component.get("v.app"));
        
           console.log('------------>'+  component.get("v.recordid"));
        console.log('vehicleid'+  component.get("v.vehicleid"));
        var action = component.get("c.createRecord");
        action.setParams({ 
            'certificateApexString' :component.get("v.certificateApexString"),
       
            'app' :component.get("v.app"),
            'duty' :component.get("v.duty"),
           // 'vehicleid':component.get("v.vehicleid")
            
        }); 
        action.setCallback(this, function(a) {
            var state = a.getState();
            if (state === "SUCCESS") {
                
                var returnval = a.getReturnValue();
                console.log('jobCardLineItemUpdate==========returnval='+JSON.stringify(returnval));
              window.location.reload();
                       var urlEvent = $A.get("e.force:navigateToURL");
            urlEvent.setParams({
              "url": "/apex/DriverMenu",
              "isredirect": "true"
            });
            urlEvent.fire();
                
            }                else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Error',
                            message:  errors[0].message,
                            key: 'info_alt',
                            type: 'error',
                            mode: 'pester'
                        });
                        toastEvent.fire();
                    }
                }
            }
            
        });
        $A.enqueueAction(action);
        
    },
})