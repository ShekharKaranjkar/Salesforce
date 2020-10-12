({
    onLoad: function(component, event) {
        //alert('sart');
        console.log('onLoad call');
        //call apex class method
        var action = component.get('c.fetchAttendance');
        
        action.setCallback(this, function(response) {
            
            var state = response.getState();
            if (state === "SUCCESS") {
           //     alert('test10');
                component.set('v.ListOfAttendance', response.getReturnValue());
                console.log(JSON.stringify(component.get("v.ListOfAttendance") ));
              //  component.set("v.selectedCount", 0);
              //  component.find("box3").set("v.value", false);
            }
        });
        $A.enqueueAction(action);
    },
})