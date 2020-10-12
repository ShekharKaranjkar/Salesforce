({
    onSuccess : function(component, event, helper) {
        debugger;
        component.set("v.Spinner", true);
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "The record has been Saved successfully."
        });
        toastEvent.fire();
        component.set("v.Spinner", false);
    },
    onSubmit : function(component, event, helper) {
    },
    onLoad : function(component, event, helper) {
        //  component.set('v.sObjectName.MPM4_BASE__Program__c','a0H5D000002WrsnUAC');
        //   event.preventDefault();
        // var eventFields = event.getParam("fields");
        // eventFields["Name"] = "testtesttest";
        //  var recUi = event.getParam("recordUi");
        //recUi.record.fields["MPM4_BASE__Program__c"].value = 'a0H5D000002WrsnUAC';
        //  var objectInfo = event.getParams().objectInfos;
        // objectInfo["MPM4_BASE__Milestone1_Project__c"].fields['Name'] = 'testeteet';
        var record = event.getParam('record');
        record.fields.Name.displayValue = 'testasdfghjk';
        event.setParam('record', record); 
        /*var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Loaded!",
            "message": "The record has been Loaded successfully ."
        });
        toastEvent.fire(); */
  }, 
    
    
    handleOnload : function(component, event, helper) {
        var parentId = component.get("v.parentId");
        
        // requires inputFields to have aura:id
        component.find("programlookup").set("v.value", 'a0H5D000002WrsnUAC');
        
    },
    showSpinner: function(component, event, helper) {
        
        // make Spinner attribute true for display loading spinner 
        component.set("v.Spinner", true); 
    },
    
    // this function automatic call by aura:doneWaiting event 
    hideSpinner : function(component,event,helper){
        
        // make Spinner attribute to false for hide loading spinner    
        component.set("v.Spinner", false);
    },
    
    
    
    doInit : function(component, event, helper){
        // component.set('v.sObjectName.MPM4_BASE__Milestone1_Program__c','a0H5D000002WrsnUAC');
        // helper.getFields(component, event, helper);
        
    },
    
    onError : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Error!",
            "message": "Error."
        });
        toastEvent.fire();
    },
    cancel : function(component, event, helper) {
        //Find the text value of the component with aura:id set to "address"
        
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            "url": 'https://lithium--dev.lightning.force.com/lightning/o/MPM4_BASE__Milestone1_Project__c/list?filterName=Recent' 
        });
        urlEvent.fire();
    },
    handleOnSubmit : function(component, event, helper) {
        debugger;
        var responseJSON = event.getParams();
        console.log(responseJSON);
    var recordresponse = responseJSON.response; 
        var recordId = recordresponse.id;
        component.set("v.Spinner", true);
        event.preventDefault();
        var fields = event.getParam("fields");
        console.log('fields'+JSON.stringify(fields));
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title : 'Success Message',
            message: ' "The record has been Saved successfully."',
            messageTemplate: 'Record {0} created! See it {1}!',
            duration:' 5000',
            key: 'info_alt',
            type: 'success',
            mode: 'pester'
        });
        toastEvent.fire();
        component.set("v.Spinner", false);
        window.setTimeout(
            $A.getCallback(function() {
                helper.getvehicle(component, event,recordId);  
            }), 2000
        );
        
        //$A.enqueueAction(action);
        //$A.get('e.force:refreshView').fire();
    } 
    
})