({
    recorddetailspage : function(component, event,recid) {
       // debugger;
       
        var navEvt = $A.get("e.force:navigateToSObject");
        navEvt.setParams({"recordId": recid,"slideDevName": "detail"});
        console.log('navEvt'+navEvt);
        navEvt.fire();
        
    }, 
      getFields : function(component, event, helper) {
         // debugger;
        var action = component.get('c.getFieldswithSectionHeaders');
          action.setParams({ RecordtypeID : component.get("v.RecordTypeId") });//RecordTypeId
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                let temp = response.getReturnValue();
               component.set('v.showbuttons',true);
            console.log('templength::::::'+JSON.stringify(temp));
                //const found = temp.find(element => element.header == 'Accident_Details');
                //debugger;
                //var  n=temp.indexOf(found);
                //var cut= temp.splice(n,1);
                //temp.splice(0, 0, cut[0]);
                //console.log('length::::::'+temp.length);
                for(var i=0;i<temp.length;i++){
                    var str =temp[i].header;
                    var res = str.split("_");
                    var arr=[];
                    for(var j=0;j<res.length;j++){
                        const nameCapitalized = res[j].charAt(0).toUpperCase() + res[j].slice(1)
                        arr.push(nameCapitalized);
                    }
                    var te=arr.join();
                    var newStr = te.replace(/,/g, ' ');
                 console.log('newStr'+newStr);
                    temp[i].header=newStr;
                    var fields = temp[i].fieldsString;
                    var finalfields = [];
                    for(var k=0;k<fields.length;k++){
                        //debugger;
                        var fieldval = {};
                        var defaultlookup = component.get("v."+fields[k]);
                        if(defaultlookup != undefined)
                            fieldval = {"fieldAPI":fields[k],"fieldval":defaultlookup};
                            else
                            fieldval = {"fieldAPI":fields[k],"fieldval":undefined};
                        finalfields.push(fieldval);
                    }
                    temp[i].fieldsString=finalfields;
                }
                component.set('v.listOfSecionToShow',temp);
                
                //alert('cmp '+component.get('v.showbuttons'));
                       /*  for(var i=0;i<temp.length;i++){
                   // var t=temp[i].fieldsString;
                         
                 temp[i].others=true; 
                         }
                 component.set('v.listOfSecionToShow',temp);*/
            }
        });
        $A.enqueueAction(action);
    }   
})