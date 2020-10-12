({
    onLoad: function(component, event) {
        var action = component.get('c.fetchLeave');
        action.setCallback(this, function(response) {
            
            var state = response.getState();
            if (state === "SUCCESS") {
                 var leaveRecords = response.getReturnValue();
                    console.log(JSON.stringify(leaveRecords));
                    for(var i=0; i<leaveRecords.length; i++){
                        console.log('leaveRecords'+leaveRecords);
                        component.set("v.leaveList",leaveRecords);
                        
                    }
            }
            else
                console.log('error');
        });
        $A.enqueueAction(action);
    },
})