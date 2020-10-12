({
    doInit: function(component, event, helper) {
        component.set("v.pass",'');
        helper.getFields(component, event, helper);
    },
    
    handleOnload: function(cmp, event, helper) {
        
    },
    
    handleOnSubmit : function(component, event, helper) {
        event.preventDefault();
        var fields = event.getParam("fields");
        console.log('fields'+JSON.stringify(fields));
        fields["VIN_Number__c"] = component.get("v.pass");
        fields["Re_enter_VIN_Number__c"] = component.get("v.repass");
        var registrationNumber= fields["Vehicle_Registration_Number__c"];
        var vin=component.get("v.pass");
        var revin=   component.get("v.repass");
        var tempvehicleRecords=   component.get("v.vehicleRecords");
        var flag=true;
        const found = tempvehicleRecords.find(element => element.VIN_Number__c==vin || element.Re_enter_VIN_Number__c==revin);
        console.log("found"+JSON.stringify(found));
        if(found){
            flag=false; 
            name= found.Vehicle_Registration_Number__c;
        }

        if(vin==revin && registrationNumber.length == 10 && flag && vin.length == 17 && revin.length == 17 ){
          //  console.log('reEnterVinNO11111'+revin);
              console.log('fields============'+JSON.stringify(fields));
            component.find('form').submit(fields);
         //   console.log('reEnterVinNO11111test'+revin);
        }else{
            if(vin != revin){
             //   console.log('vin not equal');
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error Message',
                    message:'please enter the same VIN number',
                    messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'error',
                    mode: 'pester'
                });
                toastEvent.fire();  
            }
            if(registrationNumber.length != 10 ){
             //   console.log('registrationNumber not equal');
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error Message',
                    message:'Please Enter Valid Registration Number ',
                    messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'error',
                    mode: 'pester'
                });
                toastEvent.fire();  
            }
            if(!flag){
             //   console.log('registrationNumber not unique');
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error Message',
                    message:'Please Enter unique Registration Number & VIN-Number',
                    messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'error',
                    mode: 'pester'
                });
                toastEvent.fire();  
            }
            if(vin.length != 17 && revin.length != 17 ){
              //  console.log('VIN number and Re-enter VIN Number should be 17 characters.');
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error Message',
                    message: 'VIN number and Re-enter VIN Number should be 17 characters.',
                    messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                    duration:' 5000',
                    key: 'info_alt',
                    type: 'error',
                    mode: 'pester'
                });
                toastEvent.fire();
            }
        }
    },
    
    handleOnError: function(cmp, event, helper) {
        var errors = event.getParams();
     console.log("response======================="+ JSON.stringify(errors));
        
    },
    
    handleOnSuccess: function(component, event, helper) {
     //   console.log('testttttttttttt');
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success Message',
            message: 'Record save successfully and Please fill in the PDI form',
            messageTemplate: 'Record {0} created! See it {1}!',
            duration:' 5000',
            key: 'info_alt',
            type: 'success',
            mode: 'pester'
        });
        toastEvent.fire();
        
        
        var responseJSON = event.getParams();
       // console.log('test============='+JSON.stringify(responseJSON));
        var recordId = responseJSON.response.id;  
        console.log('recordId'+recordId);
        
        var action = component.get('c.getId');
        action.setParams({ recordId : recordId});//RecordTypeId
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let temp = response.getReturnValue();
                if(temp){
                    
                    var navEvt = $A.get("e.force:navigateToSObject");
                    navEvt.setParams({
                        "recordId": recordId,
                        "slideDevName": "detail"
                    });
                    navEvt.fire(); 
                }
            }
        });
        $A.enqueueAction(action);
        
        
        
        
    },
    openModel: function(component, event, helper) {
        // for Display Model,set the "isOpen" attribute to "true"
        
    },
    
    closeModel: function(component, event, helper) {
        
        
        
        
    },
    
    Submit: function(component, event, helper) {
      //  console.log('hiiiiiiiiiiiiiii223333333333'+   component.get("v.vinNumber" ) );
        event.preventDefault();
        
        var vinNO = component.get("v.vinNumber");
        var reEnterVinNO = component.find("vinNO").get("v.value");
        
        if(vinNO==reEnterVinNO){
            
        }else{
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error Message',
                message:'please enter the same VIN number',
                messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                duration:' 5000',
                key: 'info_alt',
                type: 'error',
                mode: 'pester'
            });
            toastEvent.fire();
        }
        
        
        component.set("v.isOpen", false);
    },
    cancel : function(component, event, helper) {
        //Find the text value of the component with aura:id set to "address"
        
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": 'https://lithium--dev.lightning.force.com/lightning/o/Vehicle__c/list?filterName=Recent' 
        });
        urlEvent.fire();
    },
    
    
})