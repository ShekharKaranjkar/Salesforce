({
    doInit:function(component, event, helper) {
      // alert('id'+component.get('v.recordId'));
        var action = component.get('c.checkCandidate');
        action.setParams({
            "candId" : component.get('v.recordId')
        });
       
        action.setCallback(this, function(a) {
            var state = a.getState();
            if (state === "SUCCESS") {
                var recId = a.getReturnValue();
                 
                console.log('recId'+recId);
               if(recId == false){
                    
                     component.set('v.show', false);
                }else
                    component.set('v.show', true);
            }
         });
        $A.enqueueAction(action);
    },
	 convert:function(component, event, helper) {
          var count = component.get("v.selectedCountOfSave");
        count= count+1;
        console.log('count'+count);
        component.set("v.selectedCountOfSave", count);
        if(count==1){
        var action = component.get('c.CreateSp');
        action.setParams({
            "candidateId": component.get('v.recordId')
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                
                 var recId = response.getReturnValue();
                console.log('recId'+recId);
                 if(recId == false){
                     var toastsuccessEvent = $A.get("e.force:showToast");
                toastsuccessEvent.setParams({
                    "title": "Something went wrong.",
                    "message": "Not eligible to become a Service Provider",
                    "type" : "error"
                });
                $A.get("e.force:closeQuickAction").fire();
                toastsuccessEvent.fire(); 
                     
                     
                   
                }else
                    var toastsuccessEvent = $A.get("e.force:showToast");
                toastsuccessEvent.setParams({
                    "title": "Success!",
                    "message": "Converted sucessfully!",
                    "type" : "success"
                });
                toastsuccessEvent.fire();
               
            }else if(state === "ERROR") {
                var toastsuccessEvent = $A.get("e.force:showToast");
                toastsuccessEvent.setParams({
                    "title": "Something went wrong.",
                    "message": "Service Provider is already exist with the given phone number",
                    "type" : "error"
                });
                $A.get("e.force:closeQuickAction").fire();
                toastsuccessEvent.fire(); 
            }
        });
        $A.enqueueAction(action);
        }  
    }
})