({
    /*
    
    getPicklists: function(component,objDetails,controllerField, dependentField, oppLineItemInstance) { 
        var action = component.get("c.getDependentMap");
        action.setParams({
            'objDetail' : objDetails,
            'contrfieldApiName': controllerField,
            'depfieldApiName': dependentField 
        });
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {

                var StoreResponse = response.getReturnValue();
                console.log('StoreResponse============'+JSON.stringify(StoreResponse));

                component.set("v.depnedentFieldMap",StoreResponse);

                var listOfkeys = [];
                var ControllerField = [];

                for (var singlekey in StoreResponse) {
                    listOfkeys.push(singlekey);
                }

                if (listOfkeys != undefined && listOfkeys.length > 0) {
                    ControllerField.push('--- None ---');
                }

                for (var i = 0; i < listOfkeys.length; i++) {
                    ControllerField.push(listOfkeys[i]);
                }  
     
                component.set("v.listControllingValues", ControllerField);
                console.log('ControllerField============'+JSON.stringify(ControllerField));
                console.log('oppLineItemInstance============'+JSON.stringify(oppLineItemInstance));
                var temp = oppLineItemInstance.location;
                console.log('location==========='+temp);
                console.log('location==========='+StoreResponse[temp]);
                var dependentFields = [];
                dependentFields.push('--- None ---');
                for (var i = 0; i < StoreResponse.length; i++) {
                    dependentFields.push(StoreResponse[temp]);
                }
                component.set("v.listDependingValues", StoreResponse[temp]);
                console.log('dependentFields111111111============'+JSON.stringify(dependentFields));
                   console.log('listDependingValues2222============'+JSON.stringify(component.get("v.listDependingValues")));
                window.setTimeout(
                    $A.getCallback(function() {
                       component.set("v.oppLineItemInstance" , oppLineItemInstance);  
                    }), 500
                );
                
            }else{
                alert('Something went wrong..');
            }
        });
        $A.enqueueAction(action);
    },
    fetchDepValues: function(component, ListOfDependentFields) {
        // create a empty array var for store dependent picklist values for controller field  
        var dependentFields = [];
        dependentFields.push('--- None ---');
        for (var i = 0; i < ListOfDependentFields.length; i++) {
            dependentFields.push(ListOfDependentFields[i]);
        }
        // set the dependentFields variable values to store(dependent picklist field) on lightning:select
        component.set("v.listDependingValues", dependentFields);
        
    },
    
    
*/
        
    getPicklists: function(component,objDetails,controllerField, dependentField, oppLineItemInstance) { 
        var action = component.get("c.getDependentMap");
        action.setParams({
            'objDetail' : objDetails,
            'contrfieldApiName': controllerField,
            'depfieldApiName': dependentField 
        });
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {

                var StoreResponse = response.getReturnValue();
              //  console.log('StoreResponse============'+JSON.stringify(StoreResponse));

                component.set("v.depnedentFieldMap",StoreResponse);

                var listOfkeys = [];
                var ControllerField = [];

                for (var singlekey in StoreResponse) {
                    listOfkeys.push(singlekey);
                }

                if (listOfkeys != undefined && listOfkeys.length > 0) {
                    ControllerField.push('--- None ---');
                }

                for (var i = 0; i < listOfkeys.length; i++) {
                    ControllerField.push(listOfkeys[i]);
                }  
     
                component.set("v.listControllingValues", ControllerField);
                console.log('ControllerField============'+JSON.stringify(ControllerField));
               // console.log('oppLineItemInstance============'+JSON.stringify(oppLineItemInstance));
                var temp = oppLineItemInstance.location;
                console.log('location==========='+temp);
                console.log('location==========='+StoreResponse[temp]);
                var dependentFields = [];
             //   dependentFields.push('--- None ---');
                for (var i = 0; i < StoreResponse.length; i++) {
                    dependentFields.push(StoreResponse[temp]);
                }
component.set("v.listDependingValues", StoreResponse[temp]);
console.log('dependentFields=='+JSON.stringify(dependentFields));
console.log('listDependingValues='+JSON.stringify(component.get("v.listDependingValues")));
                window.setTimeout(
                    $A.getCallback(function() {
                       component.set("v.oppLineItemInstance" , oppLineItemInstance);  
                    }), 500
                );
                
            }else{
                alert('Something went wrong..');
            }
        });
        $A.enqueueAction(action);
    },
    fetchDepValues: function(component, ListOfDependentFields) {
        var dependentFields = [];
       // dependentFields.push('--- None ---');
        for (var i = 0; i < ListOfDependentFields.length; i++) {
            dependentFields.push(ListOfDependentFields[i]);
        }
        component.set("v.listDependingValues", dependentFields);
        
    },
    
    
    checktheSlab: function(component, ListOfDependentFields) {
        var temp1=component.get("v.oppLineItemInstance");
        console.log('temp1'+JSON.stringify(temp1));
        temp1.showSlab = true;
        console.log('temp12'+JSON.stringify(temp1));
        component.set("v.oppLineItemInstance", temp1);
        var value = event.getSource().get("v.value"); 
        console.log('value'+value);
        if(!value.includes("-"))
        {
       
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error Message',
                message:'Please enter slab informat(0-50) values',
                messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                duration:'2000',
                key: 'info_alt',
                type: 'error',
                mode: 'pester'
            });
            toastEvent.fire();
        }  
        
    },

})