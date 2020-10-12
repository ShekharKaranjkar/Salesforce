({
    approvalReq : function(component,event,helper) {
        
        var buttonType = event.getSource().get("v.variant");
        var action = component.get("c.saveRecord");
        var lList = component.get("v.leavRec");
        action.setParams({
            'leaveApprv' : lList,
            'reuestType' : buttonType
        });
        // set a callBack    
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                //alert('yes');
                var resVal =  response.getReturnValue();
                if(resVal == 'approveMessage'){
                      helper.toastMsg(component, event, helper, "success", "Success!", "Approved Sucessfully..!");

                } else if(resVal == 'RejectMessage'){
                    
                    helper.toastMsg(component, event, helper, "success", "Success!", "Rejected Sucessfully..!");
                }
            }
        });
        // enqueue the Action  
        $A.enqueueAction(action);
        
    },
    toastMsg : function (component, event, helper, type, title, msg) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": title,
            "type": type,
            "message": msg
        });
        toastEvent.fire();
    },
    
})