({
    doInit : function(component, event, helper) {
        console.log('component.get("v.oppLineItemInstance")==========='+JSON.stringify(component.get("v.oppLineItemInstance")));
        var controllingFieldAPI = component.get("v.controllingFieldAPI");
        var objDetails = component.get("v.objDetail");
      helper.getPicklists(component,component.get("v.oppLineItemInstance"));
    },
    
    AddNewRow : function(component, event, helper){
        var temp=component.get("v.oppLineItemInstance");
        console.log('tempppppppppp==========='+JSON.stringify(temp));
        var cmpEvent = component.getEvent("AddNewRowEvt1D");
        cmpEvent.setParams( { "productId" :temp.productid } );
        cmpEvent.fire();
    },
    
    removeRow : function(component, event, helper){
        console.log("in slab remove row"+component.get("v.oppLineItemInstance"));
        var temp1=component.get("v.oppLineItemInstance");
        console.log('component.get("v.rowIndex")'+component.get("v.rowIndex"));    
        component.getEvent("DeleteRowEvt1D").setParams({"indexVar" :component.get("v.rowIndex"), "productId" :temp1.productid }).fire();
    },
    
    onControllerFieldChange: function(component, event, helper) {     
        helper.onControllerFieldChangeValue(component, event, helper);
    },
    check : function(component, event, helper) {
        var temp=component.get("v.oppLineItemInstance");
        var value = event.getSource().get("v.value"); 
        console.log('value'+value);
        var allValid = component.find('boxPack').reduce(function (validSoFar, inputCmp) {
           // inputCmp.showHelpMessageIfInvalid();
            return validSoFar && !inputCmp.get('v.validity').valueMissing;
        }, true);
        if (allValid) {
            temp.getAllValues1D=true;
            component.set("v.oppLineItemInstance",temp);
   
        } else {
       temp.getAllValues1D=false;
   		component.set("v.oppLineItemInstance",temp);
     
        }
    },
        checkLastvalue : function(component, event, helper) {
        var temp=component.get("v.oppLineItemInstance");
        var value = event.getSource().get("v.value"); 
    	temp.getAllValues1D=true;
   		component.set("v.oppLineItemInstance",temp);
        console.log('value'+value);
           if(!Number(value) )
        {
       
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error Message',
                message:'Please enter integer values',
                messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                duration:'2000',
                key: 'info_alt',
                type: 'error',
                mode: 'pester'
            });
            toastEvent.fire();
        } 
    }
})