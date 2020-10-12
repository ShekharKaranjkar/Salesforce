({
    doInit : function(component, event, helper) {
        
        helper.getProducts(component, event, helper);
    },
    
    change : function(component, event, helper) {
          console.log('change');
        component.set("v.searchKeyword",'');
        console.log("productselectedTripList"+JSON.stringify(component.get("v.productselectedTripList")));
     helper.getproductNewList(component, event, helper);
    },
    
    checkboxSelect: function(component, event, helper) {
        console.log('productListAfterCancelBtn1dModel'+JSON.stringify(component.get('v.productListAfterCancelBtn1dModel')));
        console.log('productListAfterCancelBtnTripModel'+JSON.stringify(component.get('v.productListAfterCancelBtnTripModel')));
        var indexvar = event.getSource().get("v.label");        
        var selectedRec = event.getSource().get("v.checked");    
        var id = event.getSource().getLocalId();    
        
        var getSelectedNumberof1D = component.get("v.selectedCountOf1D2d");
        var getSelectedNumberofTrip = component.get("v.selectedCountOfTrip");

        console.log('oneDlistL==========1=======11111'+JSON.stringify(component.get('v.productselected1DList')));
        console.log('oneDlist==========1=======11111'+JSON.stringify(component.get('v.productListAfterCancelBtn1dModel')));
        if(id == 'boxPack'){
            // var products = component.get('v.productListAfterCancelBtn1dModel');
            var temponeDlist = component.get('v.productselected1DList');
            
            var getboxPack = component.find("boxPack")[indexvar].get("v.value");     
                    console.log('getboxPack==========1=======11111'+JSON.stringify(getboxPack));
            let n;
            if (selectedRec == true) {
                
                getSelectedNumberof1D++;
                const foundTrue = temponeDlist.find(element => element.pbe.Id == getboxPack.pbe.Id);
                if(foundTrue){
                    
                    n=temponeDlist.indexOf(foundTrue);
                    console.log('n'+n);
                    temponeDlist[n].checkboxSelected1d=true;
                    temponeDlist[n].typeofModel='1D2D';
                }
                console.log('found=boxPack==='+JSON.stringify(foundTrue));
                
            } else {
                getSelectedNumberof1D--;
                const foundFalse = temponeDlist.find(element => element.pbe.Id == getboxPack.pbe.Id);
                if(foundFalse){
                    n=temponeDlist.indexOf(foundFalse);
                    temponeDlist[n].checkboxSelected1d=false;
                    temponeDlist[n].typeofModel='1D2D';
                }
            }
            
            component.set("v.selectedCountOf1D2d", getSelectedNumberof1D);
           component.set("v.productselected1DList", temponeDlist);
            // component.set("v.productselected1DList", products);
           console.log('productselected1DList=================11111'+JSON.stringify(component.get("v.productselected1DList"))); 
        }
        
        else{
                    console.log('tripL==========1=======11111'+JSON.stringify(component.get('v.productselectedTripList')));
        console.log('tripL==========1=======11111'+JSON.stringify(component.get('v.productListAfterCancelBtnTripModel')));
            var tempTripList=component.get('v.productselectedTripList');
            console.log('tempTripList',JSON.stringify(tempTripList));
            let t;
            var getTripModel = component.find("tripModel")[indexvar].get("v.value");
            if (selectedRec == true) {
                getSelectedNumberofTrip++;
                
                const found = tempTripList.find(element => element.pbe.Id == getTripModel.pbe.Id);
               
                if(found){
                                  //      console.log('n'+n);
                    t=tempTripList.indexOf(found);
                    tempTripList[t].checkboxSelectedTrip=true;
                    tempTripList[t].typeofModel='Trip';
                }
                
                console.log('found=TripModel==='+JSON.stringify(found));
                
            } else {
                getSelectedNumberofTrip--;
                const foundFalse = tempTripList.find(element => element.pbe.Id == getTripModel.pbe.Id);
                if(foundFalse){
                    t=tempTripList.indexOf(foundFalse);
                    tempTripList[t].checkboxSelectedTrip=false;
                    tempTripList[t].typeofModel='Trip';
                }
                
        console.log('productselected1DList=================11111'+JSON.stringify(component.get("v.productselected1DList")));                 
            }
            component.set("v.productselectedTripList", tempTripList);
            component.set("v.selectedCountOfTrip", getSelectedNumberofTrip); 
           // component.set("v.productselectedTripList", productstrip);
             console.log('productselectedTripList=================11111'+JSON.stringify(component.get("v.productselectedTripList"))); 
             
        }        
    },

    
 /*   showNextPage: function(component, event, helper) {
        var myBool = component.get("v.showHide");
        component.set("v.showHide", false);
        component.set("v.showHide", false);
        helper.getSelectedProduct(component, event, helper);
    },
    */
    
    selectedProductsCheckbox: function(component, event, helper) {
        component.set("v.showHide", false);    
        helper.selectedProductHelper(component, event, helper);
    },
    
    goesBack: function(component,event,helper){       
        console.log('goback');
        component.set("v.showHide", true);      
        helper.getproductAfterCancel(component, event, helper);   
    },
    
    
    filterProducts:function(component, event, helper){
        window.setTimeout(
            $A.getCallback(function() {
                helper.getproductNewList(component, event, helper);  
            }), 3000
        );
        
    },
    
    Save: function(component, event, helper) {
        var action = component.get("c.saveProduct");
        action.setParams({
            'listOfSelectedProduct' : component.get("v.selectedProductList"),
            'recordId' : component.get("v.recordId")
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                window.open('/lightning/r/Opportunity/'+component.get("v.recordId")+'/view');            
            }
        });
        $A.enqueueAction(action); 
    },
    
    
    
    // this function automatic call by aura:waiting event  
    showSpinner: function(component, event, helper) {
        // make Spinner attribute true for display loading spinner 
        component.set("v.Spinner", true); 
    },
    
    // this function automatic call by aura:doneWaiting event 
    hideSpinner : function(component,event,helper){
        // make Spinner attribute to false for hide loading spinner    
        component.set("v.Spinner", false);
    },
    
})