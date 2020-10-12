({
    doInit : function(component, event, helper) {
        
        //     var controllingFieldAPI = component.get("v.controllingFieldAPI");
        var objDetails = component.get("v.monthRostdataObject");
       //   console.log('objDetails======monthRostdataObject=====444444444444444444444444444'+JSON.stringify(objDetails));
        helper.getPicklists(component, event, helper,objDetails);
        
    },
        updateFlag : function(component, event, helper) {
      //  console.log('monthRostdataObject-child'+JSON.stringify(component.get("v.monthRostdataObject")));
        var objDetails = component.get("v.monthRostdataObject");
        objDetails.Update=true;
                    objDetails.new=true;
        objDetails.weekOff=true;
        component.set("v.monthRostdataObject" , objDetails);          
        console.log('monthRostdataObject-child updated=='+JSON.stringify(component.get("v.monthRostdataObject")));
        
    },
 checkdate: function(component, event, helper) {
        //       console.log('component.get("v.oppLineItemInstance")==========='+JSON.stringify(component.get("v.oppLineItemInstance")));
        //     var controllingFieldAPI = component.get("v.controllingFieldAPI");
             var controllerValueKey = event.getSource().get("v.value"); 
       // console.log('controllerValueKey'+controllerValueKey);
     var objDetails = component.get("v.monthRostdataObject");
        objDetails.Update=true;
   objDetails.new=true;
        var dateObj = new Date(controllerValueKey);
        var today = new Date();
      today.setDate( today.getDate() - 1);
        if(dateObj<today){
        
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error Message',
                message:'Shift Start-Date should not be less than Today.',
                messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                duration:'2000',
                key: 'info_alt',
                type: 'error',
                mode: 'pester'
            });
            toastEvent.fire();
        }
        component.set("v.monthRostdataObject" , objDetails);  
        console.log('weeklyRostdataObject-child updated=='+JSON.stringify(component.get("v.monthRostdataObject")));
        
    },
})