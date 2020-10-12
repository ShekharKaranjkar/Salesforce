({

    getPicklists: function(component, event, helper,objDetails) {
        var action = component.get('c.getShiftPicklist');
        
      //  var   temp=['--NONE--','12','24'];
        
     //   console.log('listControllingValues========'+JSON.stringify(temp));            
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let pickVal = response.getReturnValue();
                component.set("v.listControllingValues" , pickVal);  
                
         //       console.log('listControllingValues========'+JSON.stringify(pickVal));
                
                window.setTimeout(
                    $A.getCallback(function() {
                        component.set("v.weekendRostdataObject" , objDetails);  
                    }), 200
                );
                
            }
            
        });
        $A.enqueueAction(action);
    },
    
    
})