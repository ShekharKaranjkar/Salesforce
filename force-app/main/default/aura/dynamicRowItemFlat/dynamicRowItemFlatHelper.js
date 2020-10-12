({
    
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
    
    
    
    
})