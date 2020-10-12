({
        getTripList : function(component, event) {
        var tripList = event.getParam('arguments');
        if (tripList) {
            var trip = tripList.tripListfromParent;
            console.log('trip'+JSON.stringify(trip));
            "##### Hello "+param1+" From Child Component #####";
        }
        return "";
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
    /*
    checkboxSelect: function(component, event, helper) {
        console.log('productListAfterCancelBtn1dModel'+JSON.stringify(component.get('v.productListAfterCancelBtn1dModel')));
        console.log('productListAfterCancelBtnTripModel'+JSON.stringify(component.get('v.productListAfterCancelBtnTripModel')));
        var indexvar= component.get('v.rowIndex');
        
        
       var target = event.target;
       var indexvar = target.getAttribute("data-row-index");
       console.log("Row No : " + indexvar);
        console.log('checked'+event.target.checked);
         console.log('checkedid'+event.target.id);
        
        
     // var selectedRec = component.find("boxPack").get("v.checked");    
       // console.log('selectedRec'+selectedRec);
       // var indexvar = event.getSource().get("v.label");        
        var selectedRec = event.target.checked;    
      var id = event.target.id;    
    
     
        var getSelectedNumberof1D = component.get("v.selectedCountOf1D2d");
        var getSelectedNumberofTrip = component.get("v.selectedCountOfTrip");

        console.log('oneDlistL==========1=======11111'+JSON.stringify(component.get('v.productselected1DList')));
        console.log('oneDlist==========1=======11111'+JSON.stringify(component.get('v.productListAfterCancelBtn1dModel')));
        if(id == 'boxPack'){
            // var products = component.get('v.productListAfterCancelBtn1dModel');
            var temponeDlist = component.get('v.productselected1DList');
            
            var getboxPack =event.target.value;    
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
    },*/
})