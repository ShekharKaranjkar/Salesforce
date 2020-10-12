({
    getLead: function(component) {
       
        var action = component.get("c.getLeads");
        action.setParams({ 
            "leadid": component.get('v.recordId')
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                component.set("v.lead", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    
    save : function(component, newAccRec) {
        var accR = [];
        accR.push(newAccRec);
        component.set('v.leads', accR);
        var action = component.get("c.saveRecord");
        action.setParams({ 
            "leadRecord": component.get('v.accounts')
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                var rec = response.getReturnValue();
                console.log(rec);
            }
        });
        $A.enqueueAction(action);
    },
    /* refreshcomponent : function(component, events) {
         //alert('Refresh')
           
        $A.get('e.force:refreshView').fire();

    }, */

    showToast : function(component, event, message,type,title) {
    var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        "title": title,
        "message": message,
        "type":type
    });
    toastEvent.fire();
    }
})