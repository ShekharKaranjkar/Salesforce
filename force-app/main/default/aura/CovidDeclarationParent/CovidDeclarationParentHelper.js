({
    
    handlesave : function(component,event,helper) {
                  console.log('componentn.get("v.certificateApexString")'+component.get("v.certificateApexString"));
console.log('componentn.get("v.signedApexString")'+component.get("v.signedApexString")); 
            console.log('covid'+  component.get("v.duty"));    
   console.log('covid'+  component.get("v.app"));
        
            var action = component.get("c.createRecord");
            action.setParams({ 
                'certificateApexString' :component.get("v.certificateApexString"),
                  'signedApexString' :component.get("v.signedApexString"),
                   'app' :component.get("v.app"),
                   'duty' :component.get("v.duty")

            }); 
            action.setCallback(this, function(a) {
                var state = a.getState();
                if (state === "SUCCESS") {
                    alert('Record is saved successfully');
                    /*
                          var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success',
            message: 'Record is saved successfully',
            
            key: 'info_alt',
            type: 'success',
           
        });
        toastEvent.fire();
        */
                    var returnval = a.getReturnValue();
                 console.log('jobCardLineItemUpdate==========returnval='+JSON.stringify(returnval));
   
                    
                }      
                
            });
            $A.enqueueAction(action);
        
    },
})