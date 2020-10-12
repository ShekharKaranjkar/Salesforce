({
    /*doInit : function(component, event, helper) {
        //       console.log('component.get("v.oppLineItemInstance")==========='+JSON.stringify(component.get("v.oppLineItemInstance")));
        //     var controllingFieldAPI = component.get("v.controllingFieldAPI");
        var objDetails = component.get("v.weekendRostdataObject");
        helper.getPicklists(component, event, helper,objDetails);
        
    },
    updateFlag : function(component, event, helper) {
        console.log('weekendRostdataObject-child'+JSON.stringify(component.get("v.weekendRostdataObject")));
        var objDetails = component.get("v.weekendRostdataObject");
        objDetails.Update=true;
        component.set("v.weekendRostdataObject" , objDetails);          
        console.log('weekendRostdataObject-child updated=='+JSON.stringify(component.get("v.weekendRostdataObject")));
        
    },
    /*
    checkDate: function(component, event, helper) {
        //       console.log('component.get("v.oppLineItemInstance")==========='+JSON.stringify(component.get("v.oppLineItemInstance")));
        //     var controllingFieldAPI = component.get("v.controllingFieldAPI");
        var objDetails = component.get("v.weekendRostdataObject");
        objDetails.Update=true;
        var controllerValueKey = event.getSource().get("v.value"); 
        console.log('controllerValueKey'+controllerValueKey);
        var dateObj = new Date(controllerValueKey);
        var id = event.getSource().getLocalId();
        console.log('id'+id);
        var day = dateObj.getDay();
        
        if(day==0 || day==6){
            
        }else{
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error Message',
                message:'Select only Weekends',
                messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                duration:'2000',
                key: 'info_alt',
                type: 'error',
                mode: 'pester'
            });
            toastEvent.fire();
            
            if(id=='start'){
                objDetails.Start_Time__c=''; 
            }
            if(id=='end'){
                objDetails.End_Time__c='';
            }
            console.log('id'+id);
            
            
            component.set("v.weekendRostdataObject" , objDetails); 
            console.log('weekendRostdataObject-child updated=='+JSON.stringify(objDetails));
        }
        
    },
   
    
    checkDate: function(component, event, helper) {
        //       console.log('component.get("v.oppLineItemInstance")==========='+JSON.stringify(component.get("v.oppLineItemInstance")));
        //     var controllingFieldAPI = component.get("v.controllingFieldAPI");
        var objDetails = component.get("v.weekendRostdataObject");
        objDetails.Update=true;
        var controllerValueKey = event.getSource().get("v.value"); 
        console.log('controllerValueKey'+controllerValueKey);
        var dateObj = new Date(controllerValueKey);
        var id = event.getSource().getLocalId();
       console.log('id'+id);
        var day = dateObj.getDay();
        // console.log('day'+day);
        if(day==0 || day==6){
            
        }else{
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error Message',
                message:'Select only Weekends',
                messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                duration:'2000',
                key: 'info_alt',
                type: 'error',
                mode: 'pester'
            });
            toastEvent.fire();

              // console.log('id'+id);
            
    
        }
          if(id=='start'){
                objDetails.Start_Time__c=''; 
            }
            if(id=='end'){
                objDetails.End_Time__c='';
            }
                component.set("v.weekendRostdataObject" , objDetails);  
            console.log('weeklyRostdataObject-child updated=='+JSON.stringify(component.get("v.weekendRostdataObject")));
    },
    */
    
    doInit : function(component, event, helper) {
        //       console.log('component.get("v.oppLineItemInstance")==========='+JSON.stringify(component.get("v.oppLineItemInstance")));
        //     var controllingFieldAPI = component.get("v.controllingFieldAPI");
        var objDetails = component.get("v.weekendRostdataObject");
        helper.getPicklists(component, event, helper,objDetails);
        
    },
    updateFlag : function(component, event, helper) {
        //   console.log('weeklyRostdataObject-child'+JSON.stringify(component.get("v.weeklyRostdataObject")));
        var objDetails = component.get("v.weekendRostdataObject");
        objDetails.Update=true;
         objDetails.new=true;
        component.set("v.weekendRostdataObject" , objDetails);          
        //  console.log('weeklyRostdataObject-child updated=='+JSON.stringify(component.get("v.weekendRostdataObject")));
        
    },
    checkDate: function(component, event, helper) {
        //       console.log('component.get("v.oppLineItemInstance")==========='+JSON.stringify(component.get("v.oppLineItemInstance")));
        //     var controllingFieldAPI = component.get("v.controllingFieldAPI");
        
        var objDetails = component.get("v.weekendRostdataObject");
        objDetails.Update=true;
         objDetails.new=true;
        var controllerValueKey = event.getSource().get("v.value"); 
    //    console.log('controllerValueKey'+controllerValueKey);
        var dateObj = new Date(controllerValueKey);
 
        var day = dateObj.getDay();
        
        if(day==0 || day==6){
        }else{
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error Message',
                message:'Select only Weekends ',
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
         component.set("v.weekendRostdataObject" , objDetails);  
         console.log('weeklyRostdataObject-child updated=='+JSON.stringify(component.get("v.weekendRostdataObject")));
     },
    checkDateEnd: function(component, event, helper) {
        //       console.log('component.get("v.oppLineItemInstance")==========='+JSON.stringify(component.get("v.oppLineItemInstance")));
        //     var controllingFieldAPI = component.get("v.controllingFieldAPI");
        
        var objDetails = component.get("v.weekendRostdataObject");
        objDetails.Update=true;
         objDetails.new=true;
        var controllerValueKey = event.getSource().get("v.value"); 
    //    console.log('controllerValueKey'+controllerValueKey);
        var dateObj = new Date(controllerValueKey);
 
        var day = dateObj.getDay();
        
        if(day==0 || day==6){
        }else{
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error Message',
                message:'Select only Weekends ',
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
         component.set("v.weekendRostdataObject" , objDetails);  
         console.log('weeklyRostdataObject-child updated=='+JSON.stringify(component.get("v.weekendRostdataObject")));
     },
})

        /*   var id = event.getSource().getLocalId();
             console.log('id'+id);
            if(id=='start'){
               objDetails.Start_Time__c=''; 
            }
            if(id=='end'){
                 objDetails.End_Time__c='';
            }
            
           console.log('id'+id);
            */