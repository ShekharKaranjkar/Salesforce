({
    getIssue : function(component, event, helper) {     
        var action = component.get("c.getIssue");
        var  recordId = component.get('v.recordId');
        action.setParams({ 
            "recordId": recordId
        }); 
        action.setCallback(this, function(a) {
            var state = a.getState();
            if (state === "SUCCESS") {
                
                
                var returnval = a.getReturnValue();
                component.set("v.issuesRec",returnval);
              //  console.log('returnvalTest'+JSON.stringify(returnval));
            //    console.log('returnval.issue.length'+returnval.issue.length);
                
                if(returnval.issue.length>0){
                    component.set("v.issueFlag", true);
                    if(returnval.jobCard && returnval.jobCard.length>0){
                        component.set("v.job",true);
              //          console.log('jobCard');
                        var inventoryObjList=[];
                        var swapObjList=[]; 
                        var generalObjList=[];
                        var jliObj ={};
                  //      console.log('jobCard');
                       
                        var inventoryObj=     
                            {
                                "id": "",
                                "cityName":"" ,
                                "vehicleId":"" ,
                                "inventory": "",
                                "InventoryId":"",
                                "RecordTypeId":"",
                                "InventoryName":"",
                                "avaliableQuantity": "",
                                "issue": "",
                                "quantity": "",
                                "atleastOneFlag":false,
                                "type": "Inventory",
                                "parts": ""
                                
                            }
                        
                        var swapObj={
                            "id": "",
                            "issue": "",
                            "actiontaken": "",
                            "fromVehicle": "",
                            "partname": "",
                            "RecordTypeId":"",
                            "type": "Swapped"
                        }
                        
                        
                        var gernalObj={
                            "id": "",
                            "issue": "",
                            "parts": "",
                            "type": "General",
                            "actiontaken": ""
                            
                        }
                        generalObjList.push(gernalObj);
                        swapObjList.push(swapObj);
                        inventoryObjList.push(inventoryObj);
                        
                        if(returnval.jobCard[0].Job_Card_Line_Items__r){
                            var temp=returnval.jobCard[0].Job_Card_Line_Items__r;
                       //     console.log('temp'+JSON.stringify(temp));
                            
                            for(var i=0;i<temp.length ;i++){
                    //            console.log('temp[i].Parts__c'+temp[i].Parts__c);
                                if(temp[i].Parts__c){
                                    if(temp[i].Parts__c=="Inventory"){
                                        
                                        
                                        var newObj=                            {
                                            "id":temp[i].Id,
                                            "cityName":returnval.issue[0].Vehicle__r.City__r.Name,
                                            "vehicleId": returnval.issue[0].Vehicle__c ,
                                            "inventory":temp[i].Inventory_Product__c ,
                                            "avaliableQuantity": temp[i].Available_Products__c,
                                            "issue": temp[i].Issue__c,
                                            "InventoryId":temp[i].Inventory_Product__c,
                                            "InventoryName":temp[i].Inventory_Product__r.Name,
                                            "quantity": temp[i].Quantity__c,
                                            "type": "Inventory",
                                                "atleastOneFlag":false,
                                            "parts": ""
                                            
                                        }
                                        
                                        inventoryObjList.push(newObj);
//console.log('inventoryObjList'+JSON.stringify(inventoryObjList));
                                    }
                                    else if(temp[i].Parts__c=="General"){
                                        
                                        var newObj={
                                            "id":temp[i].Id,
                                            
                                            "cityName":returnval.issue[0].Vehicle__r.City__r.Name,
                                            "vehicleId": returnval.issue[0].Vehicle__c ,
                                            "actiontaken":temp[i].Action_Taken__c ,
                                            "fromVehicle": temp[i].From_which_Vehicle__c,
                                            "issue": temp[i].Issue__c,
                                            "type": "General",
                                            "partname": temp[i].Part_Name__c
                                            
                                        }
                                        generalObjList.push(newObj);
                                    }
                                        else{
                                            
                                            var newObj={
                                                "id":temp[i].Id,
                                                
                                                "cityName":returnval.issue[0].Vehicle__r.City__r.Name,
                                                "vehicleId": returnval.issue[0].Vehicle__c ,
                                                "actiontaken":temp[i].Action_Taken__c ,
                                                "fromVehicle": temp[i].From_which_Vehicle__c,
                                                "issue": temp[i].Issue__c,
                                                "type": "Swapped",
                                                "partname": temp[i].Part_Name__c
                                                
                                            }
                                            
                                            swapObjList.push(newObj);
                                    //        console.log('swapObjList'+JSON.stringify(swapObjList));
                                        }
                                }
                                
                            }
                        }
                        
                        
                        
                        
                        
                        jliObj=
                            
                            {
                            "jobcardId":returnval.jobCard[0].Id,
                            "date": returnval.jobCard[0].Date__c,
                            "reading": returnval.jobCard[0].Odometer_Reading__c,
                            "technicianName":returnval.jobCard[0].Technician_Name__c,
                            "showAction": false,
                            "showInventory": true,
                            "campusId":returnval.jobCard[0].Campus__c,
                            "campusName":returnval.jobCard[0].Campus__r.Name,
                            "vehicle": returnval.issue[0].Vehicle__r.Name,
                            "issue": returnval.issue[0].Name,
                            "swapped":swapObjList,
                            "inventory": inventoryObjList,
                            "general":generalObjList
                        };
                      //  console.log('campusYTe '+JSON.stringify(jliObj));
                    }
                    else{
                        var campus= {};//new Object();//{"Id":"","Name":""};
                        
                  //      console.log('Step 2');
                        jliObj=
                            {
                            "Id":"",
                            "date": "",
                            "reading": "",
                            "technicianName": "",
                            "showAction": false,
                            "showInventory": true,
                            "campus":"",
                            "vehicle": returnval.issue[0].Vehicle__r.Name,
                            "issue": returnval.issue[0].Name,
                            
                            "swapped": [
                                {
                                    "id": "",
                                    "issue": "",
                                    "actiontaken": "",
                                    "fromVehicle": "",
                                    "partname": "",
                                    "RecordTypeId":"",
                                    "type": "Swapped"
                                }
                            ],
                            "inventory": [
                                {
                                    "id":"",
                                    "cityName":  returnval.issue[0].Vehicle__r.City__r.Name,
                                    "vehicleId": returnval.issue[0].Vehicle__c ,
                                    "inventory": "",
                                    "InventoryId":"",
                                    "RecordTypeId":"",
                                    "InventoryName":"",
                                    "avaliableQuantity": "",
                                    "issue": "",
                                    "quantity": "",
                                    "type": "Inventory",
                                     "atleastOneFlag":false,
                                    "parts": ""
                                    
                                }
                            ],
                            "general":[
                                {
                                    "id": "",
                                    "issue": "",
                                    "parts": "",
                                    "type": "General",
                                    "actiontaken": ""
                                    
                                }
                            ]
                        };
                        
                        
                    }
                    component.set("v.jobCardLineItemList", jliObj);
          //          console.log('tempppppppppp===========999'+JSON.stringify(component.get("v.jobCardLineItemList")));
                }
                
                
                
                
            }else if(returnval.issue.length==0)  {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error',
                    message: 'Not having permission to create Job Card for this profile '+returnval.name ,
                    key: 'info_alt',
                    type: 'error',
                    mode: 'pester'
                });
                toastEvent.fire();
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
    },
    createObject : function(component,event,helper) {
        var jobValue = component.get("v.jobCardLineItemList");
     //   console.log("jobValue"+JSON.stringify(jobValue));
        
        var temp= jobValue.swapped;
      //  console.log('templength'+temp.length);
     //   console.log('temp'+JSON.stringify(temp));
        var swappedObj = {
            "issue": "",
            "actiontaken": "",
            "fromVehicle": "",
            "type": "Swapped",
            "partname": ""
        };
        jobValue.swapped.push(swappedObj);
     //   console.log("jobValue"+JSON.stringify(jobValue));
        component.set("v.jobCardLineItemList",jobValue);
    //    console.log("jobValue"+JSON.stringify(component.get("v.jobCardLineItemList")));
    },
    createObjectGeneral: function(component,event,helper) {
        var jobValue = component.get("v.jobCardLineItemList");
     //   console.log("jobValuegeneral"+JSON.stringify(jobValue));
        var temp= jobValue.general;
    //    console.log('templength'+temp.length);
      //  console.log('temp'+JSON.stringify(temp));
        var inventorydObj =   {
            
            
            "issue": "",
            "actiontaken": "",
            "type": "General"
        }
        jobValue.general.push(inventorydObj);
    //    console.log("jobValue"+JSON.stringify(jobValue));
        component.set("v.jobCardLineItemList",jobValue);
    //    console.log("jobValue3333"+JSON.stringify(component.get("v.jobCardLineItemList")));
    },
    
    createObjectIventory: function(component,event,helper) {
        var jobValue = component.get("v.jobCardLineItemList");
    //    console.log("jobValue"+JSON.stringify(jobValue));
        var temp= jobValue.inventory;
   //     console.log('templength'+temp.length);
   //     console.log('temp'+JSON.stringify(temp));
        var inventorydObj =   {
            "cityName": component.get("v.city")  ,
            "vehicleId": "",
            "inventory": "",
            "avaliableQuantity": "",
            "issue": "",
            "InventoryId":"",
            "InventoryName":"",
            "type": "Inventory",
                "atleastOneFlag":false,
            "quantity": "",
            "parts": ""
        }
        jobValue.inventory.push(inventorydObj);
      //  console.log("jobValue"+JSON.stringify(jobValue));
        component.set("v.jobCardLineItemList",jobValue);
    //    console.log("jobValue"+JSON.stringify(component.get("v.jobCardLineItemList")));
    },
    removeDeletedRowSwapped : function(component,event,helper) {
        var index = event.getParam("indexVar"); 
        var DeleteoneD= component.get("v.DeleteoneDList");
    //    console.log('index========'+index);
        var swappedList = component.get("v.jobCardLineItemList");
    //    console.log('returnvalytesttt'+JSON.stringify(swappedList));
        var temp= swappedList.swapped;
   //     console.log('temp.id'+temp[0].id);
        DeleteoneD.push(temp[index].id) ;
        temp.splice(index, 1);
        
        
        
        component.set("v.DeleteoneDList", DeleteoneD);
    //    console.log('returnval'+JSON.stringify(temp));
    //    console.log('delete'+JSON.stringify( component.get("v.DeleteoneDList")));
        component.set("v.jobCardLineItemList", swappedList);
    },
    removeDeletedRowIventory : function(component,event,helper) {
        var index = event.getParam("indexVar"); 
        var DeleteoneD= component.get("v.DeleteoneDList");
    //    console.log('index========'+index);
        var iventoryList = component.get("v.jobCardLineItemList");
  //      console.log('returnvalytesttt'+JSON.stringify(iventoryList));
        var temp= iventoryList.inventory;
  //      console.log('temp.id'+temp[index].id);
        DeleteoneD.push(temp[index].id) ;
        temp.splice(index, 1);
        
        
        
        component.set("v.DeleteoneDList", DeleteoneD);
   //     console.log('delete'+JSON.stringify( component.get("v.DeleteoneDList")));
   //     console.log('returnval'+JSON.stringify(temp));
        component.set("v.jobCardLineItemList", iventoryList);
    },
    removeDeletedRowGeneral:  function(component,event,helper) {
        var index = event.getParam("indexVar"); 
        var DeleteoneD= component.get("v.DeleteoneDList");
        var iventoryList = component.get("v.jobCardLineItemList");
        var temp= iventoryList.general;
        DeleteoneD.push(temp[index].id) ;
        temp.splice(index, 1);
        component.set("v.DeleteoneDList", DeleteoneD);
        component.set("v.jobCardLineItemList", iventoryList);
    },
    
    gotoIssueRecord : function(component,event,helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({
            "recordId":component.get("v.recordId") ,
            "slideDevName": "detail"
        });
        navEvt.fire();   
    },
    
    JobCardAndJobLineItems : function(component,event,helper) {
       
            var action = component.get("c.createRecord");
            action.setParams({ 
                'DeleteoneDList' :component.get("v.DeleteoneDList"),
                'recordId' :component.get('v.recordId'),
                "jobcar":jobcar,
                "generalList"  :generalList,          
                "updatejobCardLine":jobCardLineItemUpdate
            }); 
            action.setCallback(this, function(a) {
                var state = a.getState();
                if (state === "SUCCESS") {
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
                    var returnval = a.getReturnValue();
   //                 console.log('jobCardLineItemUpdate==========returnval='+JSON.stringify(returnval));
                    var navEvt = $A.get("e.force:navigateToSObject");
                    navEvt.setParams({
                        "recordId":returnval[0].Id ,
                        "slideDevName": "detail"
                    });
                    navEvt.fire();   
                    
                    
                }                else if (state === "ERROR") {
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
        
    },
})