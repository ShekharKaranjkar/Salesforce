({
    fetchRecordType : function(component, event, helper) {
        var action = component.get("c.fetchRecordTypeValues");
        action.setCallback(this, function(response) {
            component.set("v.lstOfRecordType", response.getReturnValue());
            var id=     component.get('v.recordTypeId');
            var temp=     response.getReturnValue();
            var val;
            console.log(JSON.stringify(response.getReturnValue()))
            
            
            for (var i in temp) {
                
                
                
                console.log(i);
                if(i==id){
                    val=temp[i];
                    console.log('val'+val);
                }
            }
            if(val=='Accessory List'){
                component.set('v.assecary',true);
            }
            if(val=='Daily Checklist'){
                component.set('v.daily',true);
            }
            if(val=='Monthly Checklist'){
                component.set('v.monthly',true);
            }
            if(val=='PDI'){
                component.set('v.pdi',true);
            }
            if(val=='Weekly Checklist'){
                component.set('v.weekly',true);
                
            
            }
            if(val=='Issue Checklist'){
                component.set('v.issuecheck',true);
                
            
            }
        });
        $A.enqueueAction(action);
    }
})