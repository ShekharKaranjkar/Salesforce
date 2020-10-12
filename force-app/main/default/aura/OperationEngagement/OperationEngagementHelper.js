({
    getData : function(component) {
        var action = component.get('c.getSetting');
        action.setCallback(this, $A.getCallback(function (response) {
            var state = response.getState();
         //   alert('state'+state);
            console.log('response',JSON.stringify(response.getReturnValue()));
            
            if (state === "SUCCESS") {
                component.set('v.mycolumns', response.getReturnValue());
               console.log('get values ',JSON.stringify(component.get('v.mycolumns')));
            } else if (state === "ERROR") {
                var errors = response.getError();
                console.error('errors');
            }
        }));
        $A.enqueueAction(action);
    }
})