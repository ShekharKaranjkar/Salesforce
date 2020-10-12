({
     toggleIconcolor:function(component, event, helper){
         debugger;
     var temp =event.getSource().getLocalId();
        /// alert('!!'+temp);
      var cmpTarget = component.find(temp);
    //component.set("v.overAllTemperature",temp);
     var iconname=cmpTarget.get("v.iconName");
        var iconcolor=  event.getSource().get("v.title");
        if(iconname == 'utility:routing_offline'){
            cmpTarget.set("v.iconName","utility:record"); component.set("v.eventobj.Over__c",iconcolor);}
            else{
                cmpTarget.set("v.iconName","utility:routing_offline");component.set("v.eventobj.Over__c",'');}
        var colors = ['Red','Yellow','Green'];
        for(var i=0;i<colors.length;i++){
            if(colors[i]!=iconcolor){
                var Targetcmp = component.find(colors[i]);
                Targetcmp.set("v.iconName","utility:routing_offline");}  
        }
},
    edit :  function(component, event, helper) {
      component.set ("v.Meeting",false)  
      component.set ("v.Save",true) 
    },
    edit1 :  function(component, event, helper) {
        debugger;
       // var color = component.get("v.eventobj.Over__c");
        //if(color == 'Red'){
             //var cmpTarget = component.find("Redicon");
          // cmpTarget.set("v.iconName","utility:record");
        /*}
        else if(color == 'Yellow'){
            var Targetcmp = component.find('Yellow');
                Targetcmp.set("v.iconName","utility:record");
        }else if(color == 'Green'){
            var Targetcmp = component.find('Green');
                Targetcmp.set("v.iconName","utility:record");
        }*/
      component.set ("v.Save",true);
            component.set ("v.Overfall",false);
        
    },
  OnCancel :  function(component, event, helper) {
      //alert(component.get("v.actualeventobj.Meeting_Summary__c"));
     // alert(component.get("v.eventobj.Meeting_Summary__c"));
       component.set("v.eventobj.Meeting_Summary__c",component.get("v.actualeventobj.Meeting_Summary__c"));
      //alert(component.get("v.actualeventobj.Meeting_Summary__c"));
      component.set("v.eventobj.Over__c",component.get("v.actualeventobj.Over__c"));
      component.set ("v.Save",false);
            component.set ("v.Overfall",true); 
      component.set ("v.Meeting",true);
    },
    OnSubmit : function(component, event, helper) {
          var action = component.get("c.updateeventvalues");
 var  newEvent = component.get('v.eventobj');
        console.log('@@@'+JSON.stringify(newEvent));
       action.setParams({ 
       "jsonEvent": JSON.stringify(newEvent)
           
    }); 
         action.setCallback(this, function(a) {
             var state = a.getState();
          if (state === "SUCCESS") {
               component.set ("v.Save",false);
            component.set ("v.Overfall",true); 
      component.set ("v.Meeting",true);
          }
         });
              
         $A.enqueueAction(action);
         
     },
    doInit : function(component, event, helper) {
        debugger;
        var Targetcmp = component.find('Redicon');
         var action = component.get("c.geteventvalues");
 var  newEvent = component.get('v.recordId');
       action.setParams({ 
       "id": newEvent
    }); 
         action.setCallback(this, function(a) {
             //alert('set call back');
              debugger;
             //$A.get('e.force:refreshView').fire();
             var state = a.getState();
          if (state === "SUCCESS") {
              debugger;
              var returnval = a.getReturnValue();
              //alert('dd '+ returnval.eventObj);
                component.set("v.eventobj",returnval.eventObj);
                component.set("v.actualeventobj",returnval.eventObj);
             var taskwrapp = returnval.TaskList;
              console.log(taskwrapp);
              //alert(taskwrapp);
              for(var i=0;i<taskwrapp.length;i++){
                  if(taskwrapp[i].SectionName=='Vehicles')
                       component.set("v.TaskList1",taskwrapp[i].Tasks);
                  else if (taskwrapp[i].SectionName=='Operations')
                       component.set("v.TaskList2",taskwrapp[i].Tasks);
                    else if (taskwrapp[i].SectionName=='Drivers')
                       component.set("v.TaskList3",taskwrapp[i].Tasks);
                    else if (taskwrapp[i].SectionName=='New Opportunities')
                       component.set("v.TaskList4",taskwrapp[i].Tasks);
                    else if (taskwrapp[i].SectionName=='Threats')
                       component.set("v.TaskList5",taskwrapp[i].Tasks);
                    else if (taskwrapp[i].SectionName=='Technology')
                       component.set("v.TaskList6",taskwrapp[i].Tasks);
              }
               var t = component.get("v.TaskList1");
              for(var i=0;i<t.length;i++){
                  console.log('Task: '+t[i]);
                  console.log('Task: '+t[i].Subject);
              }
              var t1 = component.get("v.TaskList2");
              for(var i=0;i<t1.length;i++){
                  console.log('Task: '+t1[i]);
                  console.log('Task: '+t1[i].Subject);
              }
              $A.get('e.force:refreshView').fire();
              //alert('Success');
          }
         });
              
         $A.enqueueAction(action);
    }
	
})