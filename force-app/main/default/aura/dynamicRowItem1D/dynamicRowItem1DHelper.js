({
    
        getPicklists: function(component, oppLineItemInstance) {
        var action = component.get('c.getdurationPicklist');
  
    var   temp=['--NONE--','12','24'];
       
 console.log('listControllingValues========'+JSON.stringify(temp));            
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let pickVal = response.getReturnValue();
 component.set("v.listControllingValues" , pickVal);  
          
                console.log('listControllingValues========'+JSON.stringify(pickVal));
              
                 window.setTimeout(
                    $A.getCallback(function() {
                       component.set("v.oppLineItemInstance" , oppLineItemInstance);  
                    }), 200
                );
                
            }
            
        });
        $A.enqueueAction(action);
    },
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    onControllerFieldChangeValue: function(component, event, helper) {   
        console.log('controllerValueKey22222222');
        var controllerValueKey = event.getSource().get("v.value"); // get selected controller field value
        var listControllingValues = component.get("v.listControllingValues");
        console.log('controllerValueKey============'+controllerValueKey);
        var priceOfcar;
        var temp=component.get("v.oppLineItemInstance");
          var productname= temp.productName;
        console.log('controllerValueKey============'+JSON.stringify(temp));
        var customvalues = temp.OneDCustomMetadata;
        if(controllerValueKey!='--NONE--'){
            let foundTrue = customvalues.find(element => element.Duration__c== controllerValueKey &&  element.Name__c== productname);
          priceOfcar =0;
            if(foundTrue){
                var n=customvalues.indexOf(foundTrue);
                priceOfcar=  customvalues[n].Price__c;
             
            }
        }
        temp.PriceCarMonth=priceOfcar;
        temp.showD=true;
        component.set("v.priceOfModel", priceOfcar);
        component.set("v.oppLineItemInstance", temp);
    },
    
})