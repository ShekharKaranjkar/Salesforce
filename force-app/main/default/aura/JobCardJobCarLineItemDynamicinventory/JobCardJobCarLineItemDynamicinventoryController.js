({
    doInit : function(component, event, helper) {
        helper.getInventory(component, event, helper);
    },
    AddNewRow : function(component, event, helper){
        var temp=component.get("v.jobcardItemInstance");
       // console.log('tempppppppppp==========='+JSON.stringify(temp));
        var cmpEvent = component.getEvent("AddNewRowEvt1D");
        cmpEvent.setParams( { "productId" :'10' } );
        
        cmpEvent.fire();
        
    },
        doAction : function(component) {
        var inputCmp = component.find("inputCmp");
        var value = inputCmp.get("v.value");
console.log('value2222222'+value);
        // Is input numeric?
        if (isNaN(value)) {
            // Set error
            inputCmp.set("v.errors", [{message:"Input not a number: " + value}]);
        } else {
            // Clear error
            inputCmp.set("v.errors", null);
        }
    },
        checkValidityOfphone : function(component, event, helper) {
        console.log('checkValidityOfphone called');
        //var inp = event.getSource();
        var val=component.find("tel").get('v.value');
        val=val.replace(/ /g,'');
                 console('value'+value);
        console.log(val);
        console.log(val.length);
        if(val.length!=11){
            component.set("v.errors", ["Input not a number: " + val]);
            console.log('Error Set called');   
        }
    },
    valueChangeValidation : function(component, event, helper) {
    var inputField = component.find('inputField');
    var value = inputField.get('v.value');
        console('value'+value);
    if(value != 'foo') {
        inputField.set('v.validity', {valid:false, badInput :true});
        inputField.showHelpMessageIfInvalid();

    }
},
    
    removeRow : function(component, event, helper){
        
        console.log('rowIndex==========='+component.get("v.rowIndex")); 
        component.getEvent("DeleteRowEvt1D").setParams({"indexVar" :component.get("v.rowIndex"), "productId" :"10" }).fire();
        
    },
    
    handlemultipleComponentEvent : function(component, event, helper) {
        var jobcardItemInstanceVal=component.get("v.jobcardItemInstance");
         console.log('tempppppppppp==========='+JSON.stringify(jobcardItemInstanceVal));
        var cityname=jobcardItemInstanceVal.cityName;
        //     console.log('tempppppppppp==========='+cityname);
        var selecteduserGetFromEvent = event.getParam("vehicleByEvent");
        //console.log('eventlookup'+JSON.stringify(selecteduserGetFromEvent));
        var idOfLookup=selecteduserGetFromEvent.Id;
        var inventryList=component.get("v.inventryList");
        
        const foundTrue = inventryList.find(element => element.Id== idOfLookup && element.City__r.Name==cityname);
        //   console.log('foundTrueslab=='+JSON.stringify(foundTrue));
        
        if(foundTrue){
            
            jobcardItemInstanceVal.avaliableQuantity=  foundTrue.Stock__c; 
            jobcardItemInstanceVal.inventory=idOfLookup;
            component.set("v.availableQuantiy",foundTrue.Stock__c );
            console.log('tempppppppppp==========='+component.get("v.availableQuantiy"));
           // console.log('tempppppppppp==========='+JSON.stringify(component.get("v.jobcardItemInstance")));
          
             component.set("v.jobcardItemInstance",jobcardItemInstanceVal);
        }  else{
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error Message',
                message:'Not Available for this Location:'+cityname,
                messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                duration:' 2000',
                key: 'info_alt',
                type: 'error',
                mode: 'pester'
            });
            toastEvent.fire();
        }
        
        var IsServiceProvider = event.getParam("IsServiceProvider");
        var IsServiceProvider1 = event.getParam("IsServiceProvider1");
        var IsServiceProvider2 = event.getParam("IsServiceProvider2");
        console.log('IsServiceProvider'+JSON.stringify(IsServiceProvider));
        console.log('IsServiceProvider1'+IsServiceProvider1);
        console.log('IsServiceProvider2'+IsServiceProvider2);
        
    },
      checkError : function(component, event, helper) {
          console.log('erorr');
                  window.setTimeout(
                    $A.getCallback(function() {
                         helper.checkErrorhelper(component, event, helper);
                    }), 5000
                );

    },
})