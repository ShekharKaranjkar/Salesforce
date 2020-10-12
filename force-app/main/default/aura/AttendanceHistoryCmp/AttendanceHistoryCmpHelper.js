({
    getLeaveList : function(component, event, helper) {
        debugger;
        var action = component.get('c.attendanceHistoryMethod');
        action.setParams({
            "attenId" : component.get('v.recordId')
        });
        
        action.setCallback(this, function(a) {
            var state = a.getState();
            if (state === "SUCCESS") {
                var response = a.getReturnValue();
                console.log(JSON.stringify(response.leave30List));
                if(response.leave30List !== undefined && response.leave30List.length > 0){
                    var leaveRecords = response.leave30List;
                    console.log(JSON.stringify(leaveRecords));
                     var today = new Date;
                      console.log(JSON.stringify(today));
                    for(var i=0; i<leaveRecords.length; i++){
                        component.set("v.leave30Days",leaveRecords);
                       
        component.set('v.currentDate', today.Login__c);
                        
                    }
                    console.log(JSON.stringify(component.get('v.leave30Days')));
                } 
            }
        
                          });
        $A.enqueueAction(action);
        
    }
})