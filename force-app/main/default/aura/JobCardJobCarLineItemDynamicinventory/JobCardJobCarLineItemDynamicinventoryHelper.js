({
	getInventory : function(component, event, helper) {
  var action = component.get("c.getInventory");
        
        action.setCallback(this, function(a) {
            var state = a.getState();
            if (state === "SUCCESS") {
                var returnval = a.getReturnValue();
                component.set("v.inventryList",returnval);
                console.log('returnval======='+JSON.stringify(returnval));
                
            }                else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Error',
                            message:  errors[0].message,
                            key: 'info_alt',
                            type: 'error',
                            mode: 'pester'
                        });
                        toastEvent.fire();
                    }
                }
            }
            
        });
        $A.enqueueAction(action);
    },
    checkErrorhelper : function(component, event, helper) {
         console.log('checkErrorhelper');
           var checkerror = component.find('checkerror');
    var val = checkerror.get('v.value');
      //  var val=component.find("checkerror").get('v.value');
       var testt= component.get("v.jobcardItemInstance");
                console.log('val33'+JSON.stringify(testt));
        var temp=testt.avaliableQuantity;
        console.log('temp'+temp);
        console.log('val'+val);

        if(parseInt(val)>parseInt(temp)){
              console.log('ifblock'+val); 
            
                        var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error Message',
                message:'Quantity:'+ val +' Value should be less then Product Available '+temp,
                messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                duration:' 2000',
                key: 'info_alt',
                type: 'error',
                mode: 'pester'
            });
            toastEvent.fire();
           // checkerror.set("v.errors", [{message:"Input not a number: " + value}]);
           // console.log('error');
             //    checkerror.set('v.validity', {valid:false, badInput :true});
        //checkerror.showHelpMessageIfInvalid();
        }
    },
})