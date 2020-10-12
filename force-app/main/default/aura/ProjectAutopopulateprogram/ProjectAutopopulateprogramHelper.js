({
  getvehicle : function(component, event,recid) {
    debugger;
       var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                    "recordId": recid,
                    "slideDevName": "detail"
                });
                navEvt.fire();
    /*    var action = component.get('c.getId');
        
        
        action.setCallback(this, function(response) {
            debugger;
            var state = response.getState();
            if (state === "SUCCESS") {
                let temp = response.getReturnValue();
                
                var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                    "recordId": temp,
                    "slideDevName": "detail"
                });
                navEvt.fire();
                
                
            }
            
        });
        $A.enqueueAction(action);*/
    }, 

                           })