({
    getvehicle : function(component, event, helper) {
        /*
        var action = component.get('c.getId');
        
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let temp = response.getReturnValue();
                var navEvt = $A.get("e.force:navigateToSObject");
                navEvt.setParams({
                    "recordId": temp,
                    "slideDevName": "detail"
                });
                navEvt.fire();
                
                
            }
            
        });
        $A.enqueueAction(action);
        */
    },
    
    /*getFields : function(component, event, helper) {
        
        var action = component.get('c.getFields');
        
        
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let temp = response.getReturnValue();
           //     console.log("json"+JSON.stringify(temp));
                for(var i=0;i<temp.length;i++){
                    var str =temp[i].header;
                    var res = str.split("_");
                    var arr=[];
                    for(var j=0;j<res.length;j++){
                        const nameCapitalized = res[j].charAt(0).toUpperCase() + res[j].slice(1)
                        arr.push(nameCapitalized);
                    }
              //      console.log('hiiiiiiiii'+arr.join());
                    var te=arr.join();
                    var newStr = te.replace(/,/g, ' ');
             //       console.log('newStr'+newStr);
                    temp[i].header=newStr;
                }
                component.set('v.listOfSecionToShow',temp);
             //   console.log("json22"+JSON.stringify( component.get('v.listOfSecionToShow')));
                
                for(var i=0;i<temp.length;i++){
                    var t=temp[i].fieldsString;
                //    console.log('t'+JSON.stringify(t));
                    
                    
                    const found = t.find(element => element == 'Re_enter_VIN_Number__c');
                    if(found){
                        temp[i].renter=true;
                        var  n=t.indexOf(found);
                        t.splice(n, 1);
                    }
                    const orignal = t.find(element => element == 'VIN_Number__c');
                    if(orignal){
                        temp[i].orignal=true;
                        var  n=t.indexOf(orignal);
                        t.splice(n, 1);
                    }
                    temp[i].others=true;
                    
                    
                    
                }
                component.set('v.listOfSecionToShow',temp);
             //   console.log("json22333333333"+JSON.stringify( component.get('v.listOfSecionToShow'))); 
            }
            
        });
        $A.enqueueAction(action);
    }  */
       getFields : function(component, event, helper) {
           
        var action = component.get('c.getFields');
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let temp = response.getReturnValue();
              //   console.log("jsontemp"+JSON.stringify(temp));
                component.set('v.vehicleRecords',temp[0].VehicleList);
             //   console.log("json"+JSON.stringify(component.get('v.vehicleRecords')));
             //   console.log("jsontemp[0]"+JSON.stringify(temp[0]));
             //     console.log("jsontemp[0]"+JSON.stringify(temp[0].VehicleList));
              //  console.log("json"+JSON.stringify(temp));
                const found = temp.find(element => element.header == 'vehicle_information');
           //     console.log("json"+JSON.stringify(found))
                var  n=temp.indexOf(found);
             //   console.log("n"+n);
                var cut= temp.splice(n,1);
            //    console.log("cut"+JSON.stringify(cut))
           //     console.log("temp"+JSON.stringify(temp))
                temp.splice(0, 0, cut[0]);
               // console.log("temp1"+JSON.stringify(temp))
                for(var i=0;i<temp.length;i++){
                    var str =temp[i].header;
                    var res = str.split("_");
                    var arr=[];
                    for(var j=0;j<res.length;j++){
                        const nameCapitalized = res[j].charAt(0).toUpperCase() + res[j].slice(1)
                        arr.push(nameCapitalized);
                    }
               //     console.log('hiiiiiiiii'+arr.join());
                    var te=arr.join();
                    var newStr = te.replace(/,/g, ' ');
                //    console.log('newStr'+newStr);
                    temp[i].header=newStr;
                }
                component.set('v.listOfSecionToShow',temp);
             //   console.log("json22"+JSON.stringify( component.get('v.listOfSecionToShow')));
                for(var i=0;i<temp.length;i++){
                    var t=temp[i].fieldsString;
                  //  console.log('t'+JSON.stringify(t));
                    const found = t.find(element => element == 'Re_enter_VIN_Number__c');
                    if(found){
                        temp[i].renter=true;
                        var  n=t.indexOf(found);
                        t.splice(n, 1);
                    }
                    const orignal = t.find(element => element == 'VIN_Number__c');
                    if(orignal){
                        temp[i].orignal=true;
                        var  n=t.indexOf(orignal);
                        t.splice(n, 1);
                    }
                    temp[i].others=true;   
                }
                component.set('v.listOfSecionToShow',temp);
            console.log("json22333333333"+JSON.stringify( component.get('v.listOfSecionToShow'))); 
            }
        });
        $A.enqueueAction(action);
    }   
})