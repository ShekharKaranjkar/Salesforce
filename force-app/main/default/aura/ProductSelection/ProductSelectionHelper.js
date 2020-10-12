({
    
    getProducts: function(component, event, helper,objDetails,controllerField, dependentField) {
        component.set("v.Spinner", true);
        var action = component.get('c.getAllProducts');
        var tempTabelSelectedProduct = component.get('v.tabelSelectedProduct');
        action.setParams({
            'recordId' :component.get("v.recordId"),
        });
        action.setCallback(this, function(response) {
            
            var state = response.getState();
            if (state === "SUCCESS") {
                var temp = response.getReturnValue();
                var temp1 = response.getReturnValue();
                var temp2 = JSON.parse(JSON.stringify(temp1));
                var tableValueoneD =component.get("v.tabelSelectedProduct1D");
                var tableValue =component.get("v.tabelSelectedProduct");  
                component.set('v.firstWrapper', JSON.parse(JSON.stringify(temp1)));
                component.set('v.productListAfterCancelBtn1dModel', JSON.parse(JSON.stringify(temp1)));
                component.set('v.productListAfterCancelBtnTripModel', JSON.parse(JSON.stringify(temp2)));
                component.set('v.productselected1DList', component.get('v.productListAfterCancelBtn1dModel'));
                component.set('v.productselectedTripList',component.get('v.productListAfterCancelBtnTripModel'));
                //  console.log('ond========'+JSON.stringify(component.get("v.productselected1DList")));
            //    console.log('ond22========'+JSON.stringify(temp1));
                var slabObjList=[];
                var flatObjList=[];
                var onedObjList=[];
                
                if(temp[0].oli){
                    //       console.log('oli========'+JSON.stringify(temp[0].oli));  
                    var tempOli=temp[0].oli;
                    
                    for( var i=0;i<tempOli.length;i++){
                        if(tempOli[i].Flat_slab__c=="Slab-Based" && tempOli[i].Driver_Model__c=="Trip Model" ){
                            //  console.log("tempOli[i].Product2.Name"+tempOli[i].Product2.Name);
                            // console.log("Slab333333333333"+tempOli[i].Name);
                            //                console.log("Slab333333333333"+tempOli[i].Name.indexOf(' '));
                            console.log("Slab333333333333"+tempOli[i].Name.substr(tempOli[i].Name.indexOf(' '),tempOli[i].Name.length));
                            var newobj={
                                "productName":tempOli[i].Product2.Name,
                                "productid": tempOli[i].Product2.Id,
                                "oppliid":tempOli[i].Id,
                                "rowIndex":i,
                                "Current_Pursuit__c": "",
                                "Other_Location_Present__c": tempOli[i].Other_Location_Present__c,
                                "Other_Location__c": tempOli[i].Other_Location__c ,
                                "electrictyInc":temp[0].electricityInclude,
                                "Price_Trip__c": tempOli[i].Price_Trip__c,
                                "Price_Car_Month__c": "",
                                "slab": "Slab-Based",
                                "afterCancelButton":true,
                                "showSlab":true,
                                "typeofModel": "Trip ",
                                "Cars_to_be_ordered_for_Current_Pursuit__c": tempOli[i].Cars_to_be_ordered_for_Current_Pursuit__c,
                                "Trips_per_Day__c": tempOli[i].Trips_per_Day__c,
                                "productname": "",
                                "getAllValuesSlab": true,
                                "atleastOneSlab":true,
                                "Slab__c": tempOli[i].Slab__c,
                                "index": "",
                                "subLocation":tempOli[i].SubLocation__c ,
                                "location":tempOli[i].Location__c,
                                "price": tempOli[i].UnitPrice,
                                "TripCustomMetadata":temp[0].ModelTrip
                                
                            };
                            slabObjList.push(newobj);
                        }
                    }
                    for( var i=0;i<tempOli.length;i++){
                        if(tempOli[i].Driver_Model__c=="1D" ){
                            //  console.log('tempOli[i]============'+JSON.stringify(tempOli[i]));
                            //   console.log('tempOli[i].Productivity__c[i]============'+tempOli[i].Productivity__c);
                            //    console.log("1D");
                            var newobj1={
                                "productName":tempOli[i].Product2.Name,
                                "productid": tempOli[i].Product2.Id,
                                "rowIndex":i,
                                "Current_Pursuit__c": tempOli[i].Current_Pursuit__c,
                                "electrictyInc":temp[0].electricityInclude,
                                "Price_Trip__c": tempOli[i].Price_Trip__c,
                                "PriceCarMonth": tempOli[i].SuggestedPriceCarMonth__c,
                                "suggestedPrice": tempOli[i].Price_Car_Month__c,
                                "oppliid":tempOli[i].Id,
                                "afterCancelButton":true,
                                "Productivity__c":tempOli[i].Productivity__c,
                                "typeofModel": "1D",
                                "showD":true,
                                "Cars_to_be_ordered_for_Current_Pursuit__c": tempOli[i].Cars_to_be_ordered_for_Current_Pursuit__c,
                                "Trips_per_Day__c": tempOli[i].Trips_per_Day__c,
                                "productname": "",
                                "getAllValues1D": true,
                                "index": "",
                                "subLocation":tempOli[i].SubLocation__c ,
                                "location":tempOli[i].Duration__c,
                                "price": tempOli[i].UnitPrice,
                                "OneDCustomMetadata":temp[0].Model1D
                            };
                            onedObjList.push(newobj1);
                        }
                    }
                    for( var i=0;i<tempOli.length;i++){
                        if(tempOli[i].Flat_slab__c=="Flat"  && tempOli[i].Driver_Model__c=="Trip Model" ){
                            //       console.log("Flat");
                            var newobj2={
                                "productName":tempOli[i].Product2.Name,
                                "productid": tempOli[i].Product2.Id,
                                "rowIndex":i,
                                "Current_Pursuit__c": "",
                                "oppliid":tempOli[i].Id,
                                "electrictyInc":temp[0].electricityInclude,
                                "Price_Trip__c": tempOli[i].Price_Trip__c,
                                "Other_Location_Present__c": tempOli[i].Other_Location_Present__c,
                                "Other_Location__c": tempOli[i].Other_Location__c ,
                                "Price_Car_Month__c": "",
                                "slab": "Flat",
                                "atleastOneFlat":true,
                                "getAllValuesFlat":true,
                                "afterCancelButton":true,
                                "showFlat":true,
                                "typeofModel": "Trip ",
                                "Cars_to_be_ordered_for_Current_Pursuit__c": tempOli[i].Cars_to_be_ordered_for_Current_Pursuit__c,
                                "Trips_per_Day__c": tempOli[i].Trips_per_Day__c,
                                "productname": "",
                                "Slab__c": tempOli[i].Slab__c,
                                "index": "",
                                "subLocation":tempOli[i].SubLocation__c ,
                                "location":tempOli[i].Location__c,
                                "price": tempOli[i].UnitPrice,
                                "TripCustomMetadata":temp[0].ModelTrip
                            };
                            flatObjList.push(newobj2);
                        } 
                    }    
                }
                //     console.log('flatObjList========1'+flatObjList.length);
                //console.log('flatObjList========'+JSON.stringify(flatObjList));
                //    console.log('onedObjList========'+JSON.stringify(onedObjList));
                //      console.log('slabObjList========'+JSON.stringify(slabObjList));
                component.set("v.flatObjList", flatObjList);
                component.set("v.onedObjList", onedObjList);
                component.set("v.slabObjList", slabObjList);
                
                let temptripObject =
                    {
                        "productName": "",
                        "tableToShow": "",
                        "checkboxSelected1d": false,
                        "checkboxSelectedTrip ": false,
                        "showFlat":true,
                        "showSlab":false,
                        "productFlat":false,
                        "productSlab":false,
                        "Id":"",
                        "slab": "",
                        "electrictyInc":"",
                        "Name": "",
                        "olislab": [
                            {
                                "productName": "",
                                "productid":"",
                                "rowIndex":0,
                                "afterCancelButton":false,
                                "Current_Pursuit__c":"",
                                "Price_Trip__c": "",
                                "Price_Car_Month__c":"",
                                "showSlab":false,
                                "slab": "Slab-Based",
                                "typeofModel": "Trip",                               
                                "Other_Location_Present__c": false,
                                "Other_Location__c": "",
                                "Cars_to_be_ordered_for_Current_Pursuit__c": "",
                                "Trips_per_Day__c": "",
                                "productname": "",
                                "productselectedOrnot":false,
                                "atleastOneSlab":false,
                                "getAllValuesSlab":false,
                                "Slab__c": "",
                                "index": "",
                                "subLocation": "",
                                "location": "",
                                "price": "",
                                "electrictyInc":"",
                                "TripCustomMetadata":""
                            }
                            
                        ],
                        "oliflat":[
                            {
                                "productName": "",
                                "productid": "",
                                "rowIndex": 0,
                                "Current_Pursuit__c": "",
                                "Price_Trip__c": "",
                                "afterCancelButton":false,
                                "Price_Car_Month__c": "",
                                "productselectedOrnot":false,
                                "slab": "Flat",
                                "Other_Location_Present__c": false,
                                "Other_Location__c": "",
                                "typeofModel": "Trip",
                                "Cars_to_be_ordered_for_Current_Pursuit__c": "",
                                "Trips_per_Day__c": "",
                                "productname": "",
                                "showFlat":false,
                                "getAllValuesFlat": false,
                                "atleastOneFlat":false,
                                "Slab__c": "",
                                "index": "",
                                "subLocation": "",
                                "location": "",
                                "price": "",
                                "electrictyInc":"",
                                "TripCustomMetadata":""
                            }
                        ],
                        "pbe": {
                            "PricebookEntryId":"",
                            "UnitPrice": "",
                            "Product2Id":"",
                            "Pricebook2Id":"",
                            "ProductCode": "",
                            "Product2": {
                                "ProductCode":  "",
                                "Family":  "",
                                "Id":  "",
                                "Name":  ""
                            }
                        }
                    }
                var newlistOfTrip = new Array();
                
                for(let i=0; i<temp2.length;i++ ){
                    let t=temp2[i].pbe;
                    let retriveTripObj = new Object();
                    retriveTripObj=temptripObject;
                    retriveTripObj.productName=t.Name;
                    retriveTripObj.Id=t.Product2Id;
                    retriveTripObj.Name=t.Name;
                    
                    let olislab= retriveTripObj.olislab[0];
                    retriveTripObj.olislab[0].productName=t.Name;
                    retriveTripObj.olislab[0].productid=t.Product2Id;
                    retriveTripObj.olislab[0].electrictyInc=temp2[i].electricityInclude;
                    retriveTripObj.olislab[0].typeofModel="Trip";
                    retriveTripObj.olislab[0].TripCustomMetadata=temp2[i].ModelTrip;
                    
                    retriveTripObj.oliflat[0].productName=t.Name;
                    retriveTripObj.oliflat[0].productid=t.Product2Id;
                    retriveTripObj.oliflat[0].electrictyInc=temp2[i].electricityInclude;
                    retriveTripObj.oliflat[0].typeofModel="Trip";
                    retriveTripObj.oliflat[0].TripCustomMetadata=temp2[i].ModelTrip;
                    
                    retriveTripObj.pbe.Pricebook2Id=t.Pricebook2Id;
                    retriveTripObj.pbe.PricebookEntryId=t.Id;
                    retriveTripObj.pbe.UnitPrice=t.UnitPrice;
                    retriveTripObj.pbe.Product2Id=t.Product2Id;
                    retriveTripObj.pbe.ProductCode=t.ProductCode;
                    retriveTripObj.pbe.Product2.ProductCode= t.Product2.ProductCode;
                    retriveTripObj.pbe.Product2.Family= t.Product2.Family;
                    retriveTripObj.pbe.Product2.Id= t.Product2.Id;
                    retriveTripObj.pbe.Product2.Name= t.Product2.Name;
                    retriveTripObj.pbe.Name= t.Product2.Name;
                    
                    newlistOfTrip.push(JSON.parse(JSON.stringify(retriveTripObj)));
                    
                    console.log('new List try ---------'+JSON.stringify(retriveTripObj));
                }
                console.log('new List try full ---------'+JSON.stringify(newlistOfTrip));
                console.log('new List length ---------'+newlistOfTrip.length);
                
                if(temp[0].oli){
                    for(var t=0;t<newlistOfTrip.length;t++){
                        var oliSlabNew=newlistOfTrip[t].olislab;
                        var oliFlatNew=newlistOfTrip[t].oliflat;
                        for(var i=0;i<slabObjList.length;i++){
                            if(oliSlabNew[0].productid==slabObjList[i].productid){
                                newlistOfTrip[t].olislab.push(slabObjList[i]);
                            }
                        }
                        for(var i=0;i<flatObjList.length;i++){
                            if(oliSlabNew[0].productid==flatObjList[i].productid){
                                newlistOfTrip[t].oliflat.push(flatObjList[i]);
                            }
                        }
                        
                    }
                    component.set('v.productListAfterCancelBtnTripModel', JSON.parse(JSON.stringify(newlistOfTrip)));
                    component.set('v.productselectedTripList', component.get('v.productListAfterCancelBtnTripModel'));
                    
                } 
                console.log('new List try full and final ---------'+JSON.stringify(component.get("v.productListAfterCancelBtnTripModel")));
                
                
                
                
                let temptableobj1Dnew =
                    {
                        "productName":"",
                        "tableToShow": "",
                        "checkboxSelected1d":false,
                        "checkboxSelectedTrip ":false ,
                        "Id": "",
                        "productD":false,
                        "slab": "",
                        "Name": "",
                        "oli1D": [
                            {
                                "productName": "",
                                "productid": "",
                                "rowIndex":0,
                                "Productivity__c":"",
                                "Current_Pursuit__c":"",
                                "electrictyInc":"",
                                "Price_Trip__c": "",
                                "PriceCarMonth":"",
                                "typeofModel": "1D",
                                "Cars_to_be_ordered_for_Current_Pursuit__c": "",
                                "Trips_per_Day__c": "",
                                "showD":false,
                                "productname": "",
                                "getAllValues1D": false,
                                "index": "",
                                "subLocation": "",
                                "location": "",
                                "price": "",
                                "suggestedPrice": "",
                                "OneDCustomMetadata":""
                            }
                        ],
                        "pbe": {
                            "Name":"",
                            "Pricebook2Id":"",
                            "PricebookEntryId":"",
                            "UnitPrice": "",
                            "Product2Id":"",
                            "ProductCode": "",
                            "Product2": {
                                "ProductCode":"",
                                "Family": "",
                                "Id":  "",
                                "Name":""
                            }
                        }
                    }
                var newlistOfOned = new Array();
                
                for(let i=0; i<temp1.length;i++ ){
                    let t=temp1[i].pbe;
                    let retrive1dObj = new Object();
                    retrive1dObj=temptableobj1Dnew;
                    retrive1dObj.Id=t.Product2Id;
                    retrive1dObj.Name=t.Name;
                    retrive1dObj.productName=t.Name;
                    let oli1D= retrive1dObj.oli1D[0];
                    retrive1dObj.oli1D[0].productName=t.Name;
                    retrive1dObj.oli1D[0].productid=t.Product2Id;
                    retrive1dObj.oli1D[0].OneDCustomMetadata=temp1[i].Model1D;
                    retrive1dObj.oli1D[0].electrictyInc=temp1[i].electricityInclude;
                    retrive1dObj.oli1D[0].typeofModel="1D";
                    
                    retrive1dObj.pbe.Pricebook2Id=t.Pricebook2Id;
                    retrive1dObj.pbe.PricebookEntryId=t.Id;
                    retrive1dObj.pbe.UnitPrice=t.UnitPrice;
                    retrive1dObj.pbe.Product2Id=t.Product2Id;
                    retrive1dObj.pbe.ProductCode=t.ProductCode;
                    retrive1dObj.pbe.Product2.ProductCode= t.Product2.ProductCode;
                    retrive1dObj.pbe.Product2.Family= t.Product2.Family;
                    retrive1dObj.pbe.Product2.Id= t.Product2.Id;
                    retrive1dObj.pbe.Product2.Name= t.Product2.Name;
                    retrive1dObj.pbe.Name= t.Product2.Name;
                    
                    newlistOfOned.push(JSON.parse(JSON.stringify(retrive1dObj)));
                    
              //      console.log('new List try ---------'+JSON.stringify(retrive1dObj));
                }
                //console.log('new List try full ---------'+JSON.stringify(newlistOfOned));
                //console.log('new List length ---------'+newlistOfOned.length);
                //console.log('new List try full ---------'+JSON.stringify(newlistOfOned));
                if(temp[0].oli){
                    for(var t=0;t<newlistOfOned.length;t++){
                        var olinew=newlistOfOned[t].oli1D;
                        for(var i=0;i<onedObjList.length;i++){
                            if(olinew[0].productid==onedObjList[i].productid){
                                newlistOfOned[t].oli1D.push(onedObjList[i]);
                            }
                        }
                    }
                    component.set('v.productListAfterCancelBtn1dModel', JSON.parse(JSON.stringify(newlistOfOned)));
                    component.set('v.productselected1DList', component.get('v.productListAfterCancelBtn1dModel'));
                } 
               // console.log('new List try full and final ---------'+JSON.stringify(newlistOfOned));
            }
            
            
            
        });
        $A.enqueueAction(action);
        component.set("v.Spinner", false);
    },
    
    selectedProductHelper:function(component, event, helper){
        var table= component.get('v.tabelSelectedProduct1D');
        var tableValue= component.get('v.tabelSelectedProduct');
        console.log('tabelSelectedProduct1D=='+ JSON.stringify(table));
        console.log('tabelSelectedProduct=='+ JSON.stringify(tableValue));
        var origOliList= component.get('v.firstWrapper');
        console.log('origOliList=='+ JSON.stringify(origOliList));
        var countOneD= component.get('v.selectedCountOf1D2d');
        var countTrip= component.get('v.selectedCountOfTrip');
        var countTripNum=Number(countTrip);
        var countOnedNum=Number(countOneD);
        console.log('countOneD=='+ typeof (countOneD) );
        console.log('countTrip=='+ typeof (countTrip) );
        
        
        if(origOliList[0].oli.length>0 && countOneD==0 && countTripNum==0 ){
            var navEvt = $A.get("e.force:navigateToSObject");
            navEvt.setParams({
                "recordId":component.get("v.recordId") ,
                "slideDevName": "related"
            });
            navEvt.fire();
            
        }
        else{
            var ond =[]; 
            var toatlOfOneD=0;
            var valtrip;
            var valOneD;
            var valslab;
            //       console.log('newo2============'+JSON.stringify(table));
            var flagFlat = true;
            var flagSlab = true;
            var flagOneD = true;
            var flagtemp = false;
            var showProduct= true;
            
            console.log('table.length============'+table.length);
            console.log('tableValue.length============'+tableValue.length);
            if(table.length==0 && tableValue.length==0 ){
                showProduct= false;
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error Message',
                    message:'Please Select Product',
                    messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                    duration:' 3000',
                    key: 'info_alt',
                    type: 'error',
                    mode: 'pester'
                });
                toastEvent.fire();
            }
            if(showProduct){
                for(var i=0; i<table.length;i++){
                    if(table[i].tableToShow){
                        var temp = table[i].oli1D;
                        console.log('totaltabletempolislab'+JSON.stringify(temp));
                        for(var j=0; j<temp.length;j++){
                            
                            console.log(' showD '+ temp[j].showD);
                            if(temp[j].showD){
                                table[i].productD=true;
                            }
                            
                        }
                    }
                    
                }
                
                
                
                //        console.log('table.length ' ,table.length);
                for(var i=0; i<table.length;i++){
                    console.log('totalSlabTrips_per_Day__c'+table[i].checkboxSelected1d);
                    if(table[i].tableToShow== true && table[i].productD== true){
                        var temp = table[i].oli1D;
                        console.log('temp1d'+JSON.stringify(temp));
                        for(var j=0; j<temp.length;j++){
                            console.log(' temp[j].getAllValues1D '+ temp[j].getAllValues1D );
                            
                            
                            
                            if(temp[j].PriceCarMonth !== '' || (temp[j].PriceCarMonth && temp[j].PriceCarMonth==0 )){
                                // console.log('221.PriceCarMonth'+temp[j].PriceCarMonth);
                                //     console.log('221.PriceCarMonth'+temp[j].Current_Pursuit__c);
                                if(!temp[j].Current_Pursuit__c){
                                    valOneD=2;
                                    flagOneD = false;
                                    
                                }
                                if(!temp[j].suggestedPrice){
                                    valOneD=1;
                                    flagOneD = false;
                                    
                                }
                                
                                
                                
                                
                                if(flagOneD || (temp[j].location && temp[j].getAllValues1D) ){
                                    toatlOfOneD  +=temp[j].suggestedPrice*temp[j].Current_Pursuit__c ;  
                                }
                            }
                            
                        } 
                    }
                    
                }
                var oliListFlat =[];
                var totalOfthetripmodel=0;
                for(var i=0; i<tableValue.length;i++){
                    if(tableValue[i].tableToShow){
                        var temp = tableValue[i].olislab;
                        //     console.log('totaltabletempolislab'+JSON.stringify(temp));
                        for(var j=0; j<temp.length;j++){
                            
                            //      console.log(' showFlat '+ temp[j].showSlab);
                            if(temp[j].showSlab){
                                tableValue[i].productSlab=true;
                            }
                            
                        }
                    }
                    
                }
                for(var i=0; i<tableValue.length;i++){
                    var flat= tableValue[i].oliflat;
                    //  console.log('totaltabletempoliflat'+JSON.stringify(flat));
                    if(tableValue[i].tableToShow){
                        //     console.log('showFlat2'+ tableValue[i].tableToShow );
                        for(var j=0; j<flat.length;j++){
                            //      console.log('showFlat23'+ flat[j].showFlat );
                            if(flat[j].showFlat){
                                tableValue[i].productFlat=true;                    
                            }
                        }
                    }
                }
                // console.log('tabelSelectedProductFinal'+ JSON.stringify(tableValue));
                for(var i=0; i<tableValue.length;i++){
                    var count=0;
                    // console.log(' tableToShow '+ tableValue[i].tableToShow);
                    //   console.log(' productSlab '+  tableValue[i].productSlab );
                    //    console.log('tableToShow=========='+ tableValue[i].tableToShow);
                    //    console.log('tableToShow==========11'+  tableValue[i].productSlab );
                    
                    if(tableValue[i].tableToShow && tableValue[i].productSlab){
                        var temp = tableValue[i].olislab;
                        
                        console.log('totaltabletempolislab'+JSON.stringify(temp));
                        for(var j=0; j<temp.length;j++){
                            //             console.log('showFlat1==='+ temp[j].Trips_per_Day__c );
                            //              console.log('showFlat1==='+ temp[j].Price_Trip__c );
                            
                            
                            //         console.log('tableToShow==========11'+  temp[j].price );
                            if(temp[j].price !== '' || (temp[j].price && temp[j].price==0  )  ){
                                if(temp[j].Price_Trip__c && temp[j].Trips_per_Day__c && temp[j].Slab__c && temp[j].Slab__c.includes("-")
                                   && Number(temp[j].Price_Trip__c)  && Number(temp[j].Trips_per_Day__c) && temp[j].getAllValuesSlab  && temp[j].atleastOneSlab){
                                    
                                    totalOfthetripmodel  +=temp[j].Trips_per_Day__c*temp[j].Price_Trip__c ;  
                                    
                                    
                                }
                                else{
                                    
                                    if(!temp[j].Price_Trip__c){
                                        count++;
                                        valslab=3;
                                    }
                                    if(!temp[j].Trips_per_Day__c){
                                        count++;
                                        valslab=2;
                                    }
                                    if(!temp[j].Slab__c.includes("-")){
                                        count++;
                                        valslab=1;
                                    }
                                    if(!temp[j].atleastOneSlab){
                                        valslab=4;
                                    }
                                    
                                    if(count==4 && j==0){
                                        flagtemp = false;
                                    }
                                    
                                    flagSlab = false;
                                }
                            }
                        }
                    }
                }
                for(var i=0; i<tableValue.length;i++){
                    var flat= tableValue[i].oliflat;
                    var counts=0;
                    //      console.log('totaltabletempoliflat2'+flat.length); 
                    //           console.log('totaltabletempoliflat2'+JSON.stringify(flat)); 
                    //       console.log(' tableToShow========== '+ tableValue[i].tableToShow);
                    //        console.log(' tableToShow========== '+  tableValue[i].productFlat );
                    if(tableValue[i].tableToShow && tableValue[i].productFlat){
                        //       console.log('totaltabletempoliflat'+JSON.stringify(flat));
                        for(var j=0; j<flat.length;j++){
                            //         console.log('showFlat1==='+ flat[j].Trips_per_Day__c );
                            //         console.log('showFlat1==='+ flat[j].Price_Trip__c );
                            
                            if(flat[j].price !== '' || (flat[j].price && flat[j].price ==0) ){
                                //         console.log('showFlat===2'+ flat[j].price );
                                if(flat[j].Price_Trip__c && flat[j].Trips_per_Day__c && flat[j].location
                                   &&
                                   Number(flat[j].Price_Trip__c)  && Number(flat[j].Trips_per_Day__c) && flat[j].getAllValuesFlat && flat[j].atleastOneFlat) 
                                {
                                    
                                    totalOfthetripmodel  +=flat[j].Trips_per_Day__c*flat[j].Price_Trip__c ;   
                                    
                                }
                                else{
                                    //              console.log('totalflIF2');
                                    if(!flat[j].Price_Trip__c){
                                        counts++;
                                        valtrip=2;
                                    }
                                    if(!flat[j].Trips_per_Day__c){
                                        
                                        counts++;
                                        valtrip=1;
                                    }
                                    
                                    if(!flat[j].atleastOneFlat){
                                        
                                        counts++;
                                        valtrip=3;
                                    }
                                    if( counts==4 && j==0 && !flagtemp){
                                        flagtemp = false;
                                    }
                                    
                                    console.log('in else'+flagFlat);
                                    flagFlat = false;
                                }
                                
                            }
                            
                        }
                    }
                }
                
                //    console.log('valtrip'+valtrip);
                //    console.log('flagtemp'+flagtemp);
                //      console.log('tabelSelectedProductFinal'+ JSON.stringify(tableValue));
                //       console.log('flagOneD'+flagOneD);
                //      console.log('flagFlat'+flagFlat);
                //        console.log('flagSlab'+flagSlab);
                if( flagOneD && flagFlat && flagSlab){
                    component.set("v.showHide", false);
                }
                else{
                    //        console.log('valOneD'+valOneD);
                    if(!flagOneD){
                        switch (valOneD) {
                            case 1:
                                var toastEvent = $A.get("e.force:showToast");
                                toastEvent.setParams({
                                    title : 'Error Message',
                                    message:'Please enter value  in Price/Vehicle/month 1D/2D model',
                                    messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                                    duration:' 2000',
                                    key: 'info_alt',
                                    type: 'error',
                                    mode: 'pester'
                                });
                                toastEvent.fire();
                                break;
                                
                                
                            case 2:
                                var toastEvent = $A.get("e.force:showToast");
                                toastEvent.setParams({
                                    title : 'Error Message',
                                    message:'Please enter value  in currentPursuit 1D/2D model',
                                    messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                                    duration:' 2000',
                                    key: 'info_alt',
                                    type: 'error',
                                    mode: 'pester'
                                });
                                toastEvent.fire();
                                break;
                                
                            case 3:
                                var toastEvent = $A.get("e.force:showToast");
                                toastEvent.setParams({
                                    title : 'Error Message',
                                    message:'Please enter values  in 1D/2D model',
                                    messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                                    duration:' 2000',
                                    key: 'info_alt',
                                    type: 'error',
                                    mode: 'pester'
                                });
                                toastEvent.fire();
                                break;
                                
                                
                        }
                    }
                    //      console.log('val'+valtrip);
                    if(!flagFlat){
                        //          console.log('flagFlat'+flagFlat);
                        switch (valtrip) {
                                
                            case 1:
                                var toastEvent = $A.get("e.force:showToast");
                                toastEvent.setParams({
                                    title : 'Error Message',
                                    message:'Please enter TotalTrips/Day value of FlatBased System',
                                    messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                                    duration:' 2000',
                                    key: 'info_alt',
                                    type: 'error',
                                    mode: 'pester'
                                });
                                toastEvent.fire();
                                break;
                            case 2:
                                var toastEvent = $A.get("e.force:showToast");
                                toastEvent.setParams({
                                    title : 'Error Message',
                                    message:'Please enter Price/Trip FlatBased System',
                                    messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                                    duration:' 2000',
                                    key: 'info_alt',
                                    type: 'error',
                                    mode: 'pester'
                                });
                                toastEvent.fire();
                                break;
                                
                                
                                
                        }
                    }
                    
                    if(!flagSlab){
                        switch (valslab) {
                            case 0:
                                var toastEvent = $A.get("e.force:showToast");
                                toastEvent.setParams({
                                    title : 'Error Message',
                                    message:'Please enter valid location to fill other fields values  of SlabBased System',
                                    messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                                    duration:' 2000',
                                    key: 'info_alt',
                                    type: 'error',
                                    mode: 'pester'
                                });
                                toastEvent.fire();
                                break;
                            case 1:
                                var toastEvent = $A.get("e.force:showToast");
                                toastEvent.setParams({
                                    title : 'Error Message',
                                    message:'Please Select slabformat(11-22) in Trip model of SlabBased System',
                                    messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                                    duration:' 2000',
                                    key: 'info_alt',
                                    type: 'error',
                                    mode: 'pester'
                                });
                                toastEvent.fire();
                                break;
                            case 2:
                                var toastEvent = $A.get("e.force:showToast");
                                toastEvent.setParams({
                                    title : 'Error Message',
                                    message:'Please enter TotalTrips/Day value of SlabBased System',
                                    messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                                    duration:' 2000',
                                    key: 'info_alt',
                                    type: 'error',
                                    mode: 'pester'
                                });
                                toastEvent.fire();
                                break;
                            case 3:
                                var toastEvent = $A.get("e.force:showToast");
                                toastEvent.setParams({
                                    title : 'Error Message',
                                    message:'Please enter Price/Trip SlabBased System',
                                    messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                                    duration:' 2000',
                                    key: 'info_alt',
                                    type: 'error',
                                    mode: 'pester'
                                });
                                toastEvent.fire();
                                break;
                            case 4:
                                var toastEvent = $A.get("e.force:showToast");
                                toastEvent.setParams({
                                    title : 'Error Message',
                                    message:'Please enter Price/Trip SlabBased System',
                                    messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                                    duration:' 2000',
                                    key: 'info_alt',
                                    type: 'error',
                                    mode: 'pester'
                                });
                                toastEvent.fire();
                                break;
                            case 5:
                                var toastEvent = $A.get("e.force:showToast");
                                toastEvent.setParams({
                                    title : 'Error Message',
                                    message:'Please enter valid location to fill other fields values of SlabBased System',
                                    messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                                    duration:' 2000',
                                    key: 'info_alt',
                                    type: 'error',
                                    mode: 'pester'
                                });
                                toastEvent.fire();
                                break;
                                
                        }
                    }
                    
                }
            }
            
            //    console.log('toatlOfOneD============'+toatlOfOneD);
            //     console.log('totalOfthetripmodel============'+totalOfthetripmodel);
            component.set("v.MRRValueTrip",totalOfthetripmodel);
            component.set("v.MRRValue1D",toatlOfOneD);    
        }
        
        
    },
    
    getproductNewList :function(component, event, helper){  
        var results=[];   
        var input;  
        let products=[];
        var id = event.getSource().getLocalId(); 
        //  console.log('id==getproductNewList='+id);
        if(id=='oneD'){
            input =   component.get("v.searchKeyword1D");
            //    console.log('input+'+input);
            products= component.get('v.productListAfterCancelBtn1dModel');
            //    console.log('products===oneD'+JSON.stringify(products));
        }
        if(id=='trip'){
            input =  component.get("v.searchKeywordTrip")
            //  console.log('input+'+input);
            products= component.get("v.productListAfterCancelBtnTripModel");
            // console.log('products===trip'+JSON.stringify(products));
        }
        
        if(input==0 || !Number(input)){
            if(input){
                
                if(products.length == 0 ){
                    if(id == 'oneD'){
                        products= component.get('v.productselected1DList');
                    }else{
                        products= component.get("v.productselectedTripList");
                    }
                }
                for(var i=0; i<products.length; i++) {
                    var t=products[i].pbe.Product2.Name; 
                  //  console.log('t=='+t);
                    
                    
                    if(t.toLowerCase().substring(0, input.toLowerCase().length)==input.toLowerCase()) {
                     //   console.log('t=='+t);
                        results.push(products[i]);
                    }
                    
                }
                if(id=='oneD'){
                    component.set('v.productListAfterCancelBtn1dModel', results);   
                }
                else{
                    component.set('v.productListAfterCancelBtnTripModel', results);
                }
            }
            else{
                if(id=='oneD'){
                    component.set('v.productListAfterCancelBtn1dModel', component.get('v.productselected1DList'));  
                }
                else
                {
                    console.log('products==productselectedTripList'+JSON.stringify(component.get('v.productselectedTripList')));
                    console.log('products==1234productListAfterCancelBtnTripModel'+JSON.stringify(component.get('v.productListAfterCancelBtnTripModel')));
                    component.set('v.productListAfterCancelBtnTripModel', component.get('v.productselectedTripList'));   
                   //   component.set("v.tabelSelectedProduct", component.get('v.tabelSelectedProduct'));
                }
                
            }
        }else{
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title : 'Error Message',
                message:'Please enter string value',
                messageTemplate: 'Mode is pester ,duration is 5sec and Message is overrriden',
                duration:' 2000',
                key: 'info_alt',
                type: 'error',
                mode: 'pester'
            });
            toastEvent.fire(); 
        }
    },
    
    getproductAfterCancel : function(component, event, helper){
        var onedList=component.get('v.tabelSelectedProduct1D');
        var tripList=component.get('v.tabelSelectedProduct');
        for(var i=0; i<tripList.length;i++){
            var flat= tripList[i].oliflat;
            for(var j=0; j<flat.length;j++){
                flat[j].afterCancelButton=true; 
            }
        }
        for(var i=0; i<tripList.length;i++){
            var flat= tripList[i].olislab;
            for(var j=0; j<flat.length;j++){
                flat[j].afterCancelButton=true; 
            }
        } 
        component.set('v.tabelSelectedProduct',  tripList);
        component.set('v.tabelSelectedProduct1D',  component.get('v.tabelSelectedProduct1D'));
    },
    
    checkboxSelectValues :function(component, event, helper){
        var indexvar = event.getSource().get("v.name");
        var selectedRec = event.getSource().get("v.checked");    
        var temp=component.find("boxPack1");
        var currentPursuit=component.find("boxPack2");       
        var id = event.getSource().getLocalId();    
        var getSelectedNumberof1D = component.get("v.selectedCountOf1D2d");
        var getSelectedNumberofTrip = component.get("v.selectedCountOfTrip");
        var newflatObjList =  component.get("v.flatObjList");
        var newonedObjList =  component.get("v.onedObjList");
        var newslabObjList =  component.get("v.slabObjList");
        if(id == 'boxPack'){
            var newproductList = component.get('v.productListAfterCancelBtn1dModel');
            var tempTabelSelectedProduc1D = component.get('v.tabelSelectedProduct1D');
            var temponeDlist = component.get('v.productselected1DList');
            var getboxPack = event.getSource().get("v.value");   
            var t=getboxPack.pbe;
            
            let n;
            if (selectedRec == true) {
                getSelectedNumberof1D++;
                getboxPack.tableToShow = selectedRec;
                getboxPack.checkboxSelected1d = selectedRec;
                getboxPack.checkboxSelectedTrip = false;
                
                tempTabelSelectedProduc1D.push(getboxPack);      
                console.log('new List try full tempTabelSelectedProduc1D ---------'+JSON.stringify(tempTabelSelectedProduc1D));
                component.set("v.tabelSelectedProduct1D", tempTabelSelectedProduc1D);
            }if(selectedRec==false){
                getSelectedNumberof1D--;
                let tempTabelSelectedProductDelete = component.get('v.tabelSelectedProduct1D');
                const found = tempTabelSelectedProductDelete.find(element => element.productName == t.Name);  
                if(found){
                    var test=tempTabelSelectedProductDelete.indexOf(found);
                    tempTabelSelectedProductDelete.splice(test, 1);
                }
                component.set("v.tabelSelectedProduct1D", tempTabelSelectedProductDelete); 
           
            }
            component.set("v.selectedCountOf1D2d", getSelectedNumberof1D);
        }
        
        /** trip Model Else part */
        if(id == 'tripModel'){

            let t;
            var tempTripList = component.get('v.productListAfterCancelBtnTripModel');              
            var tempTabelSelectedProduct = component.get('v.tabelSelectedProduct');
            var length=tempTabelSelectedProduct.length;
            var getTripModel = event.getSource().get("v.value");     
            console.log('new List try full getTripModel ---------'+JSON.stringify(getTripModel));
            console.log('new List try full tempTripList ---------'+JSON.stringify(tempTripList));
            console.log('new List try full tabelSelectedProduct1D ---------'+JSON.stringify(tempTabelSelectedProduct));
            /** trip Model checkbox true part */
            if (selectedRec == true) {  
                getTripModel.tableToShow=selectedRec;
                getTripModel.checkboxSelectedTrip=selectedRec;
                getTripModel.checkboxSelected1d=false;
              
                tempTabelSelectedProduct.push(getTripModel);              
                component.set("v.tabelSelectedProduct", tempTabelSelectedProduct);
                getSelectedNumberofTrip++;               
          /*      const found = tempTripList.find(element => element.pbe.Id == getTripModel.pbe.Id);            
                if(found){
                    t=tempTripList.indexOf(found);
                    console.log('t'+t);
                    tempTripList[t].checkboxSelectedTrip = true;
                    tempTripList[t].typeofModel = 'Trip Model';
                    tempTripList[t].tableToShow = true;
                }    
                */
            }
            /** trip Model checkbox false part */             
            if(selectedRec==false) {
                getSelectedNumberofTrip--;
                let tempTabelSelectedProductDelete = component.get('v.tabelSelectedProduct');
                const found = tempTabelSelectedProductDelete.find(element => element.productName == getTripModel.pbe.Name);  
                if(found){
                    var test=tempTabelSelectedProductDelete.indexOf(found);
                    tempTabelSelectedProductDelete.splice(test, 1);
                }
                component.set("v.tabelSelectedProduct", tempTabelSelectedProductDelete);  
          /*      const foundFalse = tempTripList.find(element => element.pbe.Id == getTripModel.pbe.Id);
                if(foundFalse){
                    t=tempTripList.indexOf(foundFalse);
                    tempTripList[t].checkboxSelectedTrip=false;
                    tempTripList[t].typeofModel='Trip Model';
                    tempTripList[t].tableToShow = false;
                }   
                 */
            }
          //  component.set("v.productselectedTripList", tempTripList);
           
            component.set("v.selectedCountOfTrip", getSelectedNumberofTrip);     
        }        
    },
    
    saveProducts  :function(component, event, helper){
        component.set("v.Spinner", true);
        var count = component.get("v.selectedCountOfSave");
        count= count+1;
        console.log('count'+count);
        component.set("v.selectedCountOfSave", count);
        if(count==1){
            
            var tableValueoneD =component.get("v.tabelSelectedProduct1D");
            var tableValue =component.get("v.tabelSelectedProduct");
            console.log('tableValue==========='+JSON.stringify(tableValue));
            console.log('tableValueoneD==========='+JSON.stringify(tableValueoneD));
            var table =component.get("v.productselected1DList");
            var ond =[]; 
            var ondupdate =[];
            var toatlOfOneD=0;
            
            var DeleteoneDList =component.get("v.DeleteoneDList");
            var DeleteflatList =component.get("v.DeleteflatList");
            var DeleteslabList =component.get("v.DeleteslabList");
            console.log('newo2============'+JSON.stringify(table));
            for(var i=0; i<tableValueoneD.length ;i++){
                var   temp1D = tableValueoneD[i].oli1D;
                console.log('temp1D==========='+JSON.stringify(temp1D));
                for(var j=0; j<temp1D.length;j++){
                    var temp = tableValueoneD[i].checkboxSelected1d;
                    if(temp==true){
                        
                        
                        toatlOfOneD += temp1D[j].Current_Pursuit__c*temp1D[j].PriceCarMonth;
                        if(temp1D[j].oppliid){
                            var newobj={
                                
                                "sobjectType":"opportunitylineitem",
                                "Id":temp1D[j].oppliid,
                                "Duration__c":temp1D[j].location,
                                "OpportunityId":component.get("v.recordId"),
                                "Current_Pursuit__c": temp1D[j].Current_Pursuit__c,
                                "Quantity":1,
                                "Cars_to_be_ordered_for_Current_Pursuit__c":temp1D[j].Cars_to_be_ordered_for_Current_Pursuit__c,
                                "SuggestedPriceCarMonth__c":temp1D[j].PriceCarMonth+'',
                                "Driver_Model__c":'1D',
                                "Productivity__c":temp1D[j].Productivity__c,
                                "Price_Car_Month__c":temp1D[j].suggestedPrice,
                                "UnitPrice":temp1D[j].suggestedPrice,
                                "Product2Id": tableValueoneD[i].pbe.Product2Id,
                                "PricebookEntryId":tableValueoneD[i].pbe.PricebookEntryId,
                                "Pricebook2Id": tableValueoneD[i].pbe.Pricebook2Id,
                                "ProductCode": tableValueoneD[i].pbe.ProductCode,
                                
                                "Family": tableValueoneD[i].pbe.Product2.Family
                            };
                            
                            ondupdate.push(newobj);
                        }else{
                            if( temp1D[j].suggestedPrice && temp1D[j].Current_Pursuit__c){
                                var newobj={
                                    "sobjectType":"opportunitylineitem",
                                    
                                    "OpportunityId":component.get("v.recordId"),
                                    "Current_Pursuit__c": temp1D[j].Current_Pursuit__c,
                                    "Quantity":1,
                                    "Cars_to_be_ordered_for_Current_Pursuit__c":temp1D[j].Cars_to_be_ordered_for_Current_Pursuit__c,
                                    "SuggestedPriceCarMonth__c":temp1D[j].PriceCarMonth+'',
                                    "Driver_Model__c":'1D',
                                    "Productivity__c":temp1D[j].Productivity__c,
                                    "Duration__c":temp1D[j].location,
                                    "Price_Car_Month__c":temp1D[j].suggestedPrice,
                                    "UnitPrice":temp1D[j].suggestedPrice,
                                    "Product2Id": tableValueoneD[i].pbe.Product2Id,
                                    "PricebookEntryId":tableValueoneD[i].pbe.PricebookEntryId,
                                    "Pricebook2Id": tableValueoneD[i].pbe.Pricebook2Id,
                                    "ProductCode": tableValueoneD[i].pbe.ProductCode,
                                    
                                    "Family": tableValueoneD[i].pbe.Product2.Family
                                };
                                ond.push(newobj);
                            }
                            
                        }
                        
                        
                    }
                    
                }
            }
            //    console.log('onelist'+JSON.stringify(ond));
            var oliListFlat =[];
            var oliListFlatUpdate =[];
            var totalOfthetripmodel=0;
            for(var i=0; i<tableValue.length;i++){
                var temp = tableValue[i].olislab;
                for(var j=0; j<temp.length;j++){
                    if(!(temp[j].Price_Trip__c== "") || !(temp[j].Trips_per_Day__c=="" ) || !(temp[j].Slab__c=="" )){
                        totalOfthetripmodel  +=temp[j].Trips_per_Day__c*temp[j].Price_Trip__c    
                        if(temp[j].oppliid){
                            var newobj={
                                "sobjectType":"opportunitylineitem",
                                "Id":temp[j].oppliid,
                                
                                "OpportunityId":component.get("v.recordId"),
                                "Current_Pursuit__c": temp[j].Current_Pursuit__c,
                                "Price_Trip__c": temp[j].Price_Trip__c,
                                "Price_Car_Month__c":temp[j].Price_Car_Month__c,
                                "Slab__c": temp[j].Slab__c,
                                "Quantity":1,
                                "Location__c":temp[j].location,
                                "SubLocation__c":temp[j].subLocation,
                                "Other_Location_Present__c": temp[j].Other_Location_Present__c,
                                "Other_Location__c":temp[j].Other_Location__c,
                                "Flat_slab__c":temp[j].slab,
                                "Cars_to_be_ordered_for_Current_Pursuit__c":temp[j].Cars_to_be_ordered_for_Current_Pursuit__c,
                                "Trips_per_Day__c": temp[j].Trips_per_Day__c,
                                "Driver_Model__c":'Trip Model',
                                "Pricebook2Id": tableValue[i].pbe.Pricebook2Id,
                                "UnitPrice":temp[j].Price_Trip__c ,
                                "Product2Id": tableValue[i].pbe.Product2Id,
                                "PricebookEntryId":tableValue[i].pbe.PricebookEntryId,
                                "ProductCode": tableValue[i].pbe.ProductCode,
                                "Family": tableValue[i].pbe.Product2.Family
                            };
                            oliListFlatUpdate.push(newobj);
                        }else{
                            if(temp[j].Price_Trip__c && temp[j].Trips_per_Day__c && temp[j].Slab__c ){
                                var newobj={
                                    "sobjectType":"opportunitylineitem",
                                    
                                    "OpportunityId":component.get("v.recordId"),
                                    "Current_Pursuit__c": temp[j].Current_Pursuit__c,
                                    "Price_Trip__c": temp[j].Price_Trip__c,
                                    "Price_Car_Month__c":temp[j].Price_Car_Month__c,
                                    "Slab__c": temp[j].Slab__c,
                                    "Quantity":1,
                                    
                                    "Location__c":temp[j].location,
                                    "SubLocation__c":temp[j].subLocation,
                                    "Other_Location_Present__c": temp[j].Other_Location_Present__c,
                                    "Other_Location__c":temp[j].Other_Location__c,
                                    "Flat_slab__c":temp[j].slab,
                                    "Other_Location_Present__c": temp[j].Other_Location_Present__c,
                                    "Other_Location__c":temp[j].Other_Location__c,
                                    "Cars_to_be_ordered_for_Current_Pursuit__c":temp[j].Cars_to_be_ordered_for_Current_Pursuit__c,
                                    "Trips_per_Day__c": temp[j].Trips_per_Day__c,
                                    "Driver_Model__c":'Trip Model',
                                    "Pricebook2Id": tableValue[i].pbe.Pricebook2Id,
                                    "UnitPrice":temp[j].Price_Trip__c,
                                    "Product2Id": tableValue[i].pbe.Product2Id,
                                    "PricebookEntryId":tableValue[i].pbe.PricebookEntryId,
                                    "ProductCode": tableValue[i].pbe.ProductCode,
                                    "Family": tableValue[i].pbe.Product2.Family
                                };
                                oliListFlat.push(newobj); 
                            }
                            
                        }
                        
                    }
                }
            }
            for(var i=0; i<tableValue.length;i++){
                var tempFlat=tableValue[i].oliflat;
                for(var j=0; j<tempFlat.length;j++){
                    if(!(tempFlat[j].Price_Trip__c== "") || !(tempFlat[j].Trips_per_Day__c=="" ) ){
                        totalOfthetripmodel  +=tempFlat[j].Trips_per_Day__c*tempFlat[j].Price_Trip__c      
                        if(tempFlat[j].oppliid){
                            var newobj={
                                "sobjectType":"opportunitylineitem",
                                "Id":tempFlat[j].oppliid,
                                
                                "OpportunityId":component.get("v.recordId"),
                                "Current_Pursuit__c": tempFlat[j].Current_Pursuit__c,
                                "Price_Trip__c": tempFlat[j].Price_Trip__c,
                                "Price_Car_Month__c":tempFlat[j].Price_Car_Month__c,
                                "Slab__c": tempFlat[j].Slab__c,
                                "Quantity":1,
                                "Flat_slab__c":tempFlat[j].slab,
                                "Location__c":tempFlat[j].location,
                                "SubLocation__c":tempFlat[j].subLocation,
                                "Other_Location_Present__c": tempFlat[j].Other_Location_Present__c,
                                "Other_Location__c":tempFlat[j].Other_Location__c,
                                "Cars_to_be_ordered_for_Current_Pursuit__c":tempFlat[j].Cars_to_be_ordered_for_Current_Pursuit__c,
                                "Trips_per_Day__c": tempFlat[j].Trips_per_Day__c,
                                "Driver_Model__c":'Trip Model',
                                "UnitPrice":tempFlat[j].Price_Trip__c ,
                                "Product2Id": tableValue[i].pbe.Product2Id,
                                "PricebookEntryId":tableValue[i].pbe.PricebookEntryId,
                                "ProductCode": tableValue[i].pbe.ProductCode,
                                "Pricebook2Id": tableValue[i].pbe.Pricebook2Id,
                                "Family": tableValue[i].pbe.Product2.Family
                            };
                            oliListFlatUpdate.push(newobj);
                        }else{
                            if(tempFlat[j].Price_Trip__c && tempFlat[j].Trips_per_Day__c){
                                var newobj={
                                    "sobjectType":"opportunitylineitem",
                                    
                                    "OpportunityId":component.get("v.recordId"),
                                    "Current_Pursuit__c": tempFlat[j].Current_Pursuit__c,
                                    "Price_Trip__c": tempFlat[j].Price_Trip__c,
                                    "Price_Car_Month__c":tempFlat[j].Price_Car_Month__c,
                                    "Slab__c": tempFlat[j].Slab__c,
                                    "Quantity":1,
                                    "Flat_slab__c":tempFlat[j].slab,
                                    "Location__c":tempFlat[j].location,
                                    "SubLocation__c":tempFlat[j].subLocation,
                                    "Other_Location_Present__c": tempFlat[j].Other_Location_Present__c,
                                    "Other_Location__c":tempFlat[j].Other_Location__c,
                                    "Cars_to_be_ordered_for_Current_Pursuit__c":tempFlat[j].Cars_to_be_ordered_for_Current_Pursuit__c,
                                    "Trips_per_Day__c": tempFlat[j].Trips_per_Day__c,
                                    "Driver_Model__c":'Trip Model',
                                    "UnitPrice":tempFlat[j].Price_Trip__c ,
                                    "Product2Id": tableValue[i].pbe.Product2Id,
                                    "PricebookEntryId":tableValue[i].pbe.PricebookEntryId,
                                    "ProductCode": tableValue[i].pbe.ProductCode,
                                    "Pricebook2Id": tableValue[i].pbe.Pricebook2Id,
                                    "Family": tableValue[i].pbe.Product2.Family
                                };
                                oliListFlat.push(newobj);
                            }
                            
                        }
                        
                    }
                }
            }
            var total=toatlOfOneD+  totalOfthetripmodel; 
            var action = component.get("c.saveProduct");
            console.log('onelist'+JSON.stringify(ond));
            console.log('ondupdate'+JSON.stringify(ondupdate));
            console.log('oliListFlat============'+JSON.stringify(oliListFlat));
            console.log('oliListFlatUpdate============'+JSON.stringify(oliListFlatUpdate));
            console.log('DeleteoneDList'+DeleteoneDList);
            console.log('DeleteflatList'+DeleteflatList);
            console.log('DeleteslabList'+DeleteslabList);
            action.setParams({
                'DeleteoneDList' :component.get("v.DeleteoneDList"),
                'DeleteflatList' :component.get("v.DeleteflatList"),
                'DeleteslabList' :component.get("v.DeleteslabList"),
                'oliListFlatUpdate':oliListFlatUpdate,
                'ondupdate':ondupdate,
                'onelist':ond,
                'listofTripProduct':oliListFlat,
                'total': total,
                'recordId' : component.get("v.recordId")
            });
            
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    let temp = response.getReturnValue();
                    console.log('temp'+temp);
                    if(temp){
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Success Message',
                            message:  "The record has been created successfully.",
                            messageTemplate: 'Record {0} created! See it {1}!',
                            
                            key: 'info_alt',
                            type: 'success',
                            mode: 'pester'
                        });
                        toastEvent.fire();
                        
                        var navEvt = $A.get("e.force:navigateToSObject");
                        navEvt.setParams({
                            "recordId":component.get("v.recordId") ,
                            "slideDevName": "related"
                        });
                        navEvt.fire();   
                    }
                }         
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            var toastEvent = $A.get("e.force:showToast");
                            toastEvent.setParams({
                                title : 'Error',
                                message:  errors[0].message,
                                key: 'info_alt',
                                type: 'error',
                                mode: 'pester'
                            });
                            toastEvent.fire();
                        }
                    }
                }
            });
            $A.enqueueAction(action);
            
            
            component.set("v.Spinner", false); 
        }
        
    },
    
    createObjectData: function(component,event,productId) {
        var tableValue = component.get("v.tabelSelectedProduct");
        //  console.log("tablevalue"+JSON.stringify(tableValue));
        var valueofresponse = component.get("v.productListAfterCancelBtn1dModel");
        //   console.log("valueofresponse"+JSON.stringify(valueofresponse));
        for(var i=0 ; i<tableValue.length ; i++){
            if(tableValue[i].Id == productId){
                var temp= tableValue[i].olislab;
                console.log('templength'+temp.length);
                console.log('temp'+JSON.stringify(temp));
                var newobj={
                    "productName": tableValue[i].productName,
                    "productid": productId,
                    "rowIndex": temp.length ,
                    "Current_Pursuit__c": "",
                    "electrictyInc":valueofresponse[0].electricityInclude,
                    "Price_Trip__c": "",
                    "Other_Location_Present__c": false,
                    "Other_Location__c":"" ,
                    "Price_Car_Month__c": "",
                    "slab": "Slab-Based",
                    "afterCancelButton":false,
                    "showSlab":false,
                    "typeofModel": "Trip ",
                    "Cars_to_be_ordered_for_Current_Pursuit__c": "",
                    "Trips_per_Day__c": "",
                    "productname": "",
                    "getAllValuesSlab": false,
                    "atleastOneSlab":false,
                    "Slab__c": "",
                    "index": "",
                    "subLocation": "",
                    "location": "",
                    "price": "",
                    "TripCustomMetadata":tableValue[i].oliflat[0].TripCustomMetadata
                   
                };
                temp.push(newobj);
            }
        }
        component.set("v.tabelSelectedProduct", tableValue);
        // console.log('in parent create data'+ component.get("v.tabelSelectedProduct"));
    },
    
    createObjectDataflat: function(component,event,productId) {
        var tableValue = component.get("v.tabelSelectedProduct");
        // console.log("tablevalue"+JSON.stringify(tableValue));
        var valueofresponse = component.get("v.productListAfterCancelBtn1dModel");
        // console.log("valueofresponse"+JSON.stringify(valueofresponse));
        for(var i=0 ; i<tableValue.length ; i++){
            if(tableValue[i].Id == productId){
                var temp= tableValue[i].oliflat;
                //    console.log('templength'+temp.length);
                //     console.log('temp'+JSON.stringify(temp));
                var newobj={
                    "productName": tableValue[i].productName,
                    "productid": productId,
                    "rowIndex": temp.length ,
                    "Current_Pursuit__c": "",
                    "electrictyInc":valueofresponse[0].electricityInclude,
                    "Price_Trip__c": "",
                    "Price_Car_Month__c": "",
                    "afterCancelButton":false,
                    "showFlat":false,
                    "slab": "Flat",
                    "typeofModel": "Trip ",
                    "Other_Location_Present__c": false,
                    "Other_Location__c": "",
                    "Cars_to_be_ordered_for_Current_Pursuit__c": "",
                    "Trips_per_Day__c": "",
                    "productname": "",
                    "getAllValuesFlat": false,
                    "Slab__c": "",
                    "atleastOneFlat":false,
                    "index": "",
                    "subLocation": "",
                    "location": "",
                    "price": "",
                    "TripCustomMetadata":tableValue[i].olislab[0].TripCustomMetadata
          
                };
                temp.push(newobj);
            }
        }
        component.set("v.tabelSelectedProduct", tableValue);
        // console.log('in parent create data'+ component.get("v.tabelSelectedProduct"));
    },
    
    createObjectData1D : function(component,event,productId) {
        var tableValue = component.get("v.tabelSelectedProduct1D");
          console.log("tablevalue"+JSON.stringify(tableValue));
        var valueofresponse = component.get("v.productListAfterCancelBtn1dModel");
            console.log("valueofresponse"+JSON.stringify(valueofresponse));
        for(var i=0 ; i<tableValue.length ; i++){
            if(tableValue[i].Id == productId){
                var temp= tableValue[i].oli1D;
                console.log('templength'+temp.length);
                console.log('temp'+JSON.stringify(temp));
                var newobj={
                    "productName": tableValue[i].productName,
                    "productid": productId,
                    "rowIndex": temp.length ,
                    "Current_Pursuit__c": "",
                    "suggestedPrice": "",
                    "Price_Trip__c": "",
                    "PriceCarMonth": "",
                    "Productivity__c":"",
                    "typeofModel": "1D",
                    "Cars_to_be_ordered_for_Current_Pursuit__c": "",
                    "Trips_per_Day__c": "",
                    "productname": "",
                    "getAllValues1D": false,
                    "electrictyInc":valueofresponse.electricityInclude,
                    "index": "",
                    "subLocation": "",
                    "location": "",
                    "price": "",
                    "OneDCustomMetadata":tableValue[i].oli1D[0].OneDCustomMetadata
                };
                tableValue[i].oli1D.push(newobj);
            }
        }
  
        component.set("v.tabelSelectedProduct1D", tableValue);
           console.log('in parent create data'+ JSON.stringify(component.get("v.tabelSelectedProduct1D")));
    },
    
})