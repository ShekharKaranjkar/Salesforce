({
    getLeaveList : function(component, event, helper) {	
        var action = component.get('c.LeaveHistoryMethod');
      
        action.setCallback(this, function(a) {
            var state = a.getState();
            if (state === "SUCCESS") {
                var response = a.getReturnValue();
                console.log(JSON.stringify(response.leave60List));
                if(response.leave30List !== undefined && response.leave30List.length > 0){
                    var leaveRecords = response.leave30List;
                    console.log(JSON.stringify(leaveRecords));
                    for(var i=0; i<leaveRecords.length; i++){
                        component.set("v.leave30Days",leaveRecords);
                        
                    }
                    
                } 
            	 if(response.leave60List !== undefined && response.leave60List.length > 0){
                    var leave60Records = response.leave60List;
                    console.log(JSON.stringify(leave60Records));
                    for(var i=0; i<leave60Records.length; i++){
                        component.set("v.leave60Days",leave60Records);
                        
                    }
                    
                }
                if(response.leave90List !== undefined && response.leave90List.length > 0){
                    var leave90Records = response.leave90List;
                    console.log(JSON.stringify(leave90Records));
                    for(var i=0; i<leave90Records.length; i++){
                        component.set("v.leave90Days",leave90Records);
                        
                    }
                    
                }
            
            
            
            }
        });
        $A.enqueueAction(action);
        
    }
})