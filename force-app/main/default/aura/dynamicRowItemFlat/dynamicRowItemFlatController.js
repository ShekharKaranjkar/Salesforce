({
    doInit : function(component, event, helper) {
      //  console.log('tryyyyyyyyyyyyyyyyyyyyyyyye=='+JSON.stringify(component.get("v.oppLineItemInstance")));
        var controllingFieldAPI = component.get("v.controllingFieldAPI");
        var dependingFieldAPI = component.get("v.dependingFieldAPI");
        var objDetails = component.get("v.objDetail");
        helper.getPicklists(component,objDetails,controllingFieldAPI, dependingFieldAPI,component.get("v.oppLineItemInstance"));
    },
    
    AddNewRow : function(component, event, helper){
        var temp=component.get("v.oppLineItemInstance");
        console.log('tempppppppppp==========='+JSON.stringify(temp));
        console.log('temp.productid'+temp.productid);
        var cmpEvent = component.getEvent("AddNewRowEvtflat");
        cmpEvent.setParams( { "productId" :temp.productid } );
        cmpEvent.fire();
        console.log('rrrrrrrrrrrrrrrrrrrrrrrrrrr');        
    },
    
    removeRow : function(component, event, helper){
        console.log("in slab remove row"+component.get("v.oppLineItemInstance"));
        var temp1=component.get("v.oppLineItemInstance");
        console.log('delete'+temp1.rowIndex);
        component.getEvent("DeleteRowEvtflat").setParams({"indexVar" :component.get("v.rowIndex") , "productId" :temp1.productid }).fire();
    },
    onControllerFieldChange: function(component, event, helper) {     
        console.log('tempppppppppp=oppLineItemInstance==========1'+JSON.stringify(component.get("v.oppLineItemInstance")));
        var controllerValueKey = event.getSource().get("v.value"); // get selected controller field value
        console.log('controllerValueKey=='+controllerValueKey);
        var depnedentFieldMap = component.get("v.depnedentFieldMap");
        var priceOfcar;
        var temp=component.get("v.oppLineItemInstance");
        var productname=temp.productName;
        console.log('211temp'+JSON.stringify(temp));
        var customvalues=temp.TripCustomMetadata;
            console.log('customvalues'+JSON.stringify(customvalues));
        var ListOfDependentFields = depnedentFieldMap[controllerValueKey];
        
        if (controllerValueKey != '--- None ---') {
            
            if(ListOfDependentFields.length > 0){
                const foundTrue = customvalues.find(element => element.Location__c== controllerValueKey && element.Name__c==productname && element.ElectricityInclude__c==temp.electrictyInc  );
                console.log('foundTruesflat=='+JSON.stringify(foundTrue));
                priceOfcar=0;
                if(foundTrue){
                    var  n=customvalues.indexOf(foundTrue);
                    console.log('n'+n);
                    priceOfcar=  customvalues[n].Price__c;
                    console.log('priceOfcar'+priceOfcar);                    
                }  
                //  component.set("v.bDisabledDependentFld" , true); 
               // component.set("v.listDependingValues", ['--- None ---']);
                component.set("v.bDisabledDependentFld" , false);  
                component.set("v.PicklistOne" , controllerValueKey);  
                helper.fetchDepValues(component, ListOfDependentFields);    
            }else{
              /*  const foundTrue = customvalues.find(element => element.Location__c== controllerValueKey && element.Name__c==productname && element.ElectricityInclude__c==temp.electrictyInc  );
                console.log('foundTruesflat=='+JSON.stringify(foundTrue));
                priceOfcar=0;
                if(foundTrue){
                    var  n=customvalues.indexOf(foundTrue);
                    console.log('n'+n);
                    priceOfcar=  customvalues[n].Price__c;
                    console.log('priceOfcar'+priceOfcar);                    
                }  
              //  component.set("v.bDisabledDependentFld" , true); 
                component.set("v.listDependingValues", ['--- None ---']);
                */
            }  
            
        } else {
            console.log('hiii');
            temp.price='';
            component.set("v.oppLineItemInstance", temp);
          //  component.set("v.listDependingValues", ['--- None ---']);
            component.set("v.bDisabledDependentFld" , true);
        }
   /*     if(ListOfDependentFields.length > 0){
        }else{            
            if(controllerValueKey){                
                const foundTrue = customvalues.find(element => element.Location__c== controllerValueKey && element.Name__c==productname && element.ElectricityInclude__c==temp.electrictyInc  );
                console.log('foundTruesflat=='+JSON.stringify(foundTrue));
                priceOfcar=0;
                if(foundTrue){
                    var  n=customvalues.indexOf(foundTrue);
                    console.log('n'+n);
                    priceOfcar=  customvalues[n].Price__c;
                    console.log('priceOfcar'+priceOfcar);                    
                }           
            } 
        }    */
        console.log('hiii22');
        temp.price=priceOfcar;
        temp.atleastOneFlat=true;
        temp.location=controllerValueKey;
        temp.showFlat=true;
        component.set("v.priceOfModel", priceOfcar);
        component.set("v.oppLineItemInstance", temp);
        console.log('tempppppppppp=oppLineItemInstance=========='+JSON.stringify(component.get("v.oppLineItemInstance")));
        
        
    },
    onDependantFieldChange : function(component, event, helper){
        var picklist2 = event.getSource().get("v.value"); 
        

        var temp1=component.get("v.oppLineItemInstance");
        var productname=temp1.productName;
                var picklist1=temp1.location;
        console.log('picklist1=='+picklist1);
        console.log('picklist2=='+picklist2);
        console.log('temp1'+JSON.stringify(temp1));
        var customvalues=temp1.TripCustomMetadata;
       // console.log('customvalues'+JSON.stringify(customvalues));
        var priceOfcar;
        if(picklist1 && picklist2){            
            
            const found = customvalues.find(element => element.Location__c== picklist1 && element.SubLocation__c==picklist2 && element.Name__c==productname && element.ElectricityInclude__c==temp1.electrictyInc  );
            console.log('found=='+JSON.stringify(found));   

            if(found!='undefined' && found){
                var n=customvalues.indexOf(found);
                console.log('n'+n);
                priceOfcar=  customvalues[n].Price__c;
                console.log('priceOfcar'+priceOfcar);
                
            }
            if(picklist2=='Others'){
                console.log('if'+picklist2);
                temp1.Other_Location_Present__c=true;
                 priceOfcar=0;
                
            }else{
                console.log('else'+picklist2);
                 priceOfcar=0;
                temp1.Other_Location__c='';
                temp1.Other_Location_Present__c=false;
            }
            if(picklist2=='--- None ---'){
                temp1.Other_Location__c='';
                temp1.Other_Location_Present__c=false;
                console.log('picklist2None==='+picklist2);
                    console.log('picklist2None==='+picklist1);
                console.log('picklist2None==='+productname);
            
                  console.log('picklist2None==='+temp1.electrictyInc);
                const foundTrue = customvalues.find(element => element.Location__c== picklist1 && 
                                                    element.Name__c==productname && element.ElectricityInclude__c==temp1.electrictyInc  );
                console.log('foundTruesflat=='+JSON.stringify(foundTrue));
                priceOfcar=0;
                 console.log('foundTruesflat1=='+foundTrue!='undefined');
               // console.log('foundTruesflat1==length'+ foundTrue.length);
                // console.log('foundTruesflat1==length'+ foundTrue.length>0);
               //  console.log('foundTruesflat1=='+JSON.stringify(foundTrue));
                if(foundTrue!='undefined' && foundTrue ){
                    var  nt=customvalues.indexOf(foundTrue);
                    console.log('n'+nt);
                    priceOfcar=  customvalues[nt].Price__c;
                    console.log('priceOfcar'+priceOfcar);                    
                }  
            }
            
        }
        
        temp1.price=priceOfcar;
        temp1.subLocation=picklist2;
        component.set("v.priceOfModel", priceOfcar);
        component.set("v.oppLineItemInstance", temp1);
        
    },
    
    changeBoolean : function(component, event, helper){
        window.setTimeout(
            $A.getCallback(function() {
                helper.checktheSlab(component, event, helper);  
            }), 3000
        );
        
        
    },
    
    check : function(component, event, helper) {
        
        var temp=component.get("v.oppLineItemInstance");
        
        temp.atleastOneFlat=true;
        
        temp.showflat=true;
        // console.log('  temp.showflat'+value);
        // console.log('value'+value);
        var value = event.getSource().get("v.value"); 
        console.log('value'+value);
        var allValid = component.find('checkValues').reduce(function (validSoFar, inputCmp) {
            temp.atleastOneFlat=true;
            console.log('validSoFar'+validSoFar);
            console.log('inputCmp'+inputCmp.get('v.validity'));
            return validSoFar && !inputCmp.get('v.validity').valueMissing;
        }, true);
        if (allValid) {
            temp.getAllValuesFlat=true;
            component.set("v.oppLineItemInstance",temp);
        } else {
            temp.getAllValuesFlat=false;
            component.set("v.oppLineItemInstance",temp);
        }
        
        component.set("v.oppLineItemInstance", temp);
        
    }
})