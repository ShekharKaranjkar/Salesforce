({
    doInit : function(component, event, helper) {
        //       console.log('component.get("v.oppLineItemInstance")==========='+JSON.stringify(component.get("v.oppLineItemInstance")));
        //     var controllingFieldAPI = component.get("v.controllingFieldAPI");
        var objDetails = component.get("v.weeklyRostdataObject");
        helper.getPicklists(component, event, helper,objDetails);
        
    },
    updateFlag : function(component, event, helper) {
        //   console.log('weeklyRostdataObject-child'+JSON.stringify(component.get("v.weeklyRostdataObject")));
        var objDetails = component.get("v.weeklyRostdataObject");
        objDetails.Update=true;
         objDetails.new=true;
        component.set("v.weeklyRostdataObject" , objDetails);          
     //   console.log('weeklyRostdataObject-child updated=='+JSON.stringify(component.get("v.weeklyRostdataObject")));
        
    },
    checkDate: function(component, event, helper) {
        //       console.log('component.get("v.oppLineItemInstance")==========='+JSON.stringify(component.get("v.oppLineItemInstance")));
        //     var controllingFieldAPI = component.get("v.controllingFieldAPI");
        var objDetails = component.get("v.weeklyRostdataObject");
        objDetails.Update=true;
         objDetails.new=true;
        var controllerValueKey = event.getSource().get("v.value"); 
       // console.log('controllerValueKey'+controllerValueKey);
        var dateObj = new Date(controllerValueKey);
 
        var day = dateObj.getDay();
        // console.log('day'+day);
        if(day==1 || day==2 ||day==3 || day==4 || day==5){
            //   console.log('day'+day);
        }else{
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error Message',
                message:'Select only Weekdays',
                messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                duration:'2000',
                key: 'info_alt',
                type: 'error',
                mode: 'pester'
            });
            toastEvent.fire();
            
            
        }
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
        component.set("v.weeklyRostdataObject" , objDetails);  
        console.log('weeklyRostdataObject-child updated=='+JSON.stringify(component.get("v.weeklyRostdataObject")));
        
    },
    
    
    checkDateEnd: function(component, event, helper) {
        //       console.log('component.get("v.oppLineItemInstance")==========='+JSON.stringify(component.get("v.oppLineItemInstance")));
        //     var controllingFieldAPI = component.get("v.controllingFieldAPI");
        var objDetails = component.get("v.weeklyRostdataObject");
        objDetails.Update=true;
         objDetails.new=true;
        var controllerValueKey = event.getSource().get("v.value"); 
       // console.log('controllerValueKey'+controllerValueKey);
        var dateObj = new Date(controllerValueKey);
 
        var day = dateObj.getDay();
        // console.log('day'+day);
        if(day==1 || day==2 ||day==3 || day==4 || day==5){
            //   console.log('day'+day);
        }else{
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error Message',
                message:'Select only Weekdays',
                messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                duration:'2000',
                key: 'info_alt',
                type: 'error',
                mode: 'pester'
            });
            toastEvent.fire();
            
            
        }
        var today = new Date();
        today.setDate( today.getDate() - 1);
        if(dateObj<today){
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error Message',
              message:'Shift End-Date should not be less than Today.',
                messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                duration:'2000',
                key: 'info_alt',
                type: 'error',
                mode: 'pester'
            });
            toastEvent.fire();
        }
        component.set("v.weeklyRostdataObject" , objDetails);  
        console.log('weeklyRostdataObject-child updated=='+JSON.stringify(component.get("v.weeklyRostdataObject")));
        
    },
})