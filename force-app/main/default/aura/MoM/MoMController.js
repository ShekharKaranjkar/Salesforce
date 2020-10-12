({  
    toggleIconcolor:function(component, event, helper){
    //alert('Event red: '+event.getSource().get("v.name"));
   // var temp =event.getSource().getLocalId();
    
   // component.set("v.overAllTemperature",temp);
    //alert(component.get("v.overAllTemperature"))
     var temp =event.getSource().getLocalId();
      var cmpTarget = component.find(temp);
    component.set("v.overAllTemperature",temp);
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
   redclassfunction:function(component, event, helper){
       //alert('colorclass');
       //debugger;
       var temp =event.getSource().getLocalId();
  var cmpTarget = component.find(temp);
       var value = cmpTarget.get("v.alternativeText");
      // var value1 = event.getSource().get("v.alternativeText");
       //alert('value:'+value+';;'+value1);
        //$A.util.removeClass(cmpTarget, 'black');
        var classname = cmpTarget.get("v.class");
       //alert('ClassName:'+classname);
       $A.util.toggleClass(cmpTarget, 'likeicon1');
       if(value.length == 9){
           var index = value.substring(8,9);
          var cmpTarget1 = component.find('FIREICON'+index);
       $A.util.removeClass(cmpTarget1, 'likeicon1'); 
           var elements = component.find('show_combo'+index);
        $A.util.addClass(elements, 'slds-hide');
           let newTaskLst = [];
           index = parseInt(index) +1;
           component.set("v.TaskList"+index,newTaskLst);
       }else{
          var cmpTarget1 = component.find('FIREICON');
       $A.util.removeClass(cmpTarget1, 'likeicon1'); 
           var elements = component.find('show_combo');
        $A.util.addClass(elements, 'slds-hide');
           let newTaskLst = [];
           component.set("v.TaskList1",newTaskLst);
       }
      if(component.get("v.eventobj."+temp) == false)
       component.set("v.eventobj."+temp,true);
       else if(component.get("v.eventobj."+temp) == true)
           component.set("v.eventobj."+temp,false);
       else
          component.set("v.eventobj."+temp,false); 

},
  red1 : function(component,event,helper){
      debugger;
      //alert('kk'+event.getSource().getLocalId());
      var value = event.getSource().getLocalId();
      //var temp = value.split('-');
      //alert('@@@'+value.split('-'));
      //var target = event.getSource(); 
      var temp=  event.getSource().get("v.title") ;
      var index = temp.split('-');
      //alert('!!'+index.split('-'));
     // var index1=  event.getSource().get("v.name");
      //alert('!!'+index1.split('-'));
      var arr = component.get("v."+index[0]);
      arr[index[2]].Temperature__c=index[1];
component.set("v."+index[0],arr);
       //alert(component.get("v."+index[0]));
      console.log('NAmE ',index);
      var classname = event.getSource().get("v.class") ;
        var cmpTarget = component.find(value) ;
      var element = document.getElementById(temp);
   element.classList.add(classname+'1');
      
      	//console.log('cmpTarget ' + cmpTarget);
      //console.log('cmpTarget ' + cmpTarget1);
            //$A.util.addClass(cmpTarget, classname+'1');
  },
  red2 : function(component,event,helper){
      //alert('kk'+event.getSource().getLocalId());
      var value = event.getSource().getLocalId();
      //var target = event.getSource(); 
         var index=  event.getSource().get("v.title") ;
      var arr = component.get("v.TaskList2");
      arr[index].Temperature__c=value;
component.set("v.TaskList2",arr);
      //alert(component.get("v.TaskList2"))
        
  },
  red3 : function(component,event,helper){
      //alert('kk'+event.getSource().getLocalId());
      var value = event.getSource().getLocalId();
      //var target = event.getSource(); 
         var index=  event.getSource().get("v.title") ;
      var arr = component.get("v.TaskList3");
      arr[index].Temperature__c=value;
component.set("v.TaskList3",arr);
       //alert(component.get("v.TaskList3"))
        
  },
  red4: function(component,event,helper){
      //alert('kk'+event.getSource().getLocalId());
      var value = event.getSource().getLocalId();
      //var target = event.getSource(); 
         var index=  event.getSource().get("v.title") ;
      var arr = component.get("v.TaskList4");
      arr[index].Temperature__c=value;
component.set("v.TaskList4",arr);
       //alert(component.get("v.TaskList4"))
        
  },
  red5: function(component,event,helper){
      //alert('kk'+event.getSource().getLocalId());
      var value = event.getSource().getLocalId();
      //var target = event.getSource(); 
         var index=  event.getSource().get("v.title") ;
      var arr = component.get("v.TaskList5");
      arr[index].Temperature__c=value;
component.set("v.TaskList5",arr);
       //alert(component.get("v.TaskList5"))
        
  },
  red6 : function(component,event,helper){
      //alert('kk'+event.getSource().getLocalId());
      var value = event.getSource().getLocalId();
      //var target = event.getSource(); 
         var index=  event.getSource().get("v.title") ;
      var arr = component.get("v.TaskList6");
      arr[index].Temperature__c=value;
component.set("v.TaskList6",arr);
       //alert(component.get("v.TaskList6"))
        
  },
  
    addRow: function(component, event, helper) {
        helper.addRecord(component, event);
    },
     removeRow : function(component, event, helper) {
        console.log('Step1');
        console.log(event.getSource().get("v.name"));
        var index = parseInt(event.getSource().get("v.name"));
        let newTaskLst = [];
        var arr = component.get("v.TaskList1");
        
        for(var i = 0;i<arr.length;i++){
            if(i != index){
               newTaskLst.push(arr[i]); 
            }
        }
        console.log(index);
        //arr = arr.splice(index-1,1);
        var rmIds = component.get('v.removeLogIds');
        if(arr[index].Id){
            rmIds.push(arr[index].Id);
            component.set('v.removeLogIds',rmIds);
        }
        component.set("v.TaskList1",newTaskLst);
        //helper.removeJournalRecord(component, event);
    },
    
    add: function(component, event, helper) {
        helper.add1(component, event);
    },
     remove : function(component, event, helper) {
        console.log('Step1');
        console.log(event.getSource().get("v.name"));
        var index = parseInt(event.getSource().get("v.name"));
        let newTaskLst1 = [];
        var arr = component.get("v.TaskList2");
        
        for(var i = 0;i<arr.length;i++){
            if(i != index){
               newTaskLst1.push(arr[i]); 
            }
        }
        console.log(index);
        //arr = arr.splice(index-1,1);
        var rmIds = component.get('v.removeLogIds');
        if(arr[index].Id){
            rmIds.push(arr[index].Id);
            component.set('v.removeLogIds',rmIds);
        }
        component.set("v.TaskList2",newTaskLst1);
        //helper.removeJournalRecord(component, event);
    },
 addRow3: function(component, event, helper) {
        helper.addRecord3(component, event);
    },
     removeRow3 : function(component, event, helper) {
        console.log('Step1');
        console.log(event.getSource().get("v.name"));
        var index = parseInt(event.getSource().get("v.name"));
        let newTaskLst2 = [];
        var arr = component.get("v.TaskList3");
        
        for(var i = 0;i<arr.length;i++){
            if(i != index){
               newTaskLst2.push(arr[i]); 
            }
        }
        console.log(index);
        //arr = arr.splice(index-1,1);
        var rmIds = component.get('v.removeLogIds');
        if(arr[index].Id){
            rmIds.push(arr[index].Id);
            component.set('v.removeLogIds',rmIds);
        }
        component.set("v.TaskList3",newTaskLst2);
        //helper.removeJournalRecord(component, event);
    },
  addRow4: function(component, event, helper) {
        helper.addRecord4(component, event);
    },
     removeRow4 : function(component, event, helper) {
        console.log('Step1');
        console.log(event.getSource().get("v.name"));
        var index = parseInt(event.getSource().get("v.name"));
        let newTaskLst4 = [];
        var arr = component.get("v.TaskList4");
        
        for(var i = 0;i<arr.length;i++){
            if(i != index){
               newTaskLst4.push(arr[i]); 
            }
        }
        console.log(index);
        //arr = arr.splice(index-1,1);
        var rmIds = component.get('v.removeLogIds');
        if(arr[index].Id){
            rmIds.push(arr[index].Id);
            component.set('v.removeLogIds',rmIds);
        }
        component.set("v.TaskList4",newTaskLst4);
        //helper.removeJournalRecord(component, event);
    },
  addRow5: function(component, event, helper) {
        helper.addRecord5(component, event);
    },
     removeRow5 : function(component, event, helper) {
        console.log('Step1');
        console.log(event.getSource().get("v.name"));
        var index = parseInt(event.getSource().get("v.name"));
        let newTaskLst5 = [];
        var arr = component.get("v.TaskList5");
        
        for(var i = 0;i<arr.length;i++){
            if(i != index){
               newTaskLst5.push(arr[i]); 
            }
        }
        console.log(index);
        //arr = arr.splice(index-1,1);
        var rmIds = component.get('v.removeLogIds');
        if(arr[index].Id){
            rmIds.push(arr[index].Id);
            component.set('v.removeLogIds',rmIds);
        }
        component.set("v.TaskList5",newTaskLst5);
        //helper.removeJournalRecord(component, event);
    },
  addRow6: function(component, event, helper) {
        helper.addRecord6(component, event);
    },
     removeRow6: function(component, event, helper) {
        console.log('Step1');
        console.log(event.getSource().get("v.name"));
        var index = parseInt(event.getSource().get("v.name"));
        let newTaskLst6 = [];
        var arr = component.get("v.TaskList6");
        
        for(var i = 0;i<arr.length;i++){
            if(i != index){
               newTaskLst6.push(arr[i]); 
            }
        }
        console.log(index);
        //arr = arr.splice(index-1,1);
        var rmIds = component.get('v.removeLogIds');
        if(arr[index].Id){
            rmIds.push(arr[index].Id);
            component.set('v.removeLogIds',rmIds);
        }
        component.set("v.TaskList6",newTaskLst6);
        //helper.removeJournalRecord(component, event);
    },
 show : function(component,event,helper){
debugger;
     var cmpTarget1 = component.find('FIREICON');
       $A.util.toggleClass(cmpTarget1, 'likeicon1');
        var elements = component.find('show_combo');
        $A.util.removeClass(elements, 'slds-hide');
		$A.util.addClass(elements, 'slds-show');
      var cmpTarget = component.find('Vehicles__c');
        $A.util.removeClass(cmpTarget, 'likeicon1');
     if(component.get("v.eventobj.Vehicles__c") == false)
       component.set("v.eventobj.Vehicles__c",true);
       else if(component.get("v.eventobj.Vehicles__c") == true)
           component.set("v.eventobj.Vehicles__c",false);
       else
          component.set("v.eventobj.Vehicles__c",false);
     
     var TaskList = component.get("v.TaskList1");
     if(TaskList.length == 0){
        TaskList.push({});
         component.set("v.TaskList1", TaskList);}
    },
    show1 : function(component,event,helper){
        var cmpTarget1 = component.find('FIREICON1');
       $A.util.toggleClass(cmpTarget1, 'likeicon1');
        var elements = component.find('show_combo1');
        $A.util.removeClass(elements, 'slds-hide');
		$A.util.addClass(elements, 'slds-show');
         var cmpTarget = component.find('Operations__c');
        $A.util.removeClass(cmpTarget, 'likeicon1');
        if(component.get("v.eventobj.Operations__c") == false)
       component.set("v.eventobj.Operations__c",true);
       else if(component.get("v.eventobj.Operations__c") == true)
           component.set("v.eventobj.Operations__c",false);
       else
          component.set("v.eventobj.Operations__c",false); 
        var TaskList = component.get("v.TaskList2");
        if(TaskList.length == 0){
        TaskList.push({});
         component.set("v.TaskList2", TaskList);}
    },
  
    show2 : function(component,event,helper){
        var cmpTarget1 = component.find('FIREICON2');
       $A.util.toggleClass(cmpTarget1, 'likeicon1');
        var elements = component.find('show_combo2');
        $A.util.removeClass(elements, 'slds-hide');
		$A.util.addClass(elements, 'slds-show');
         var cmpTarget = component.find('Drivers__c');
        $A.util.removeClass(cmpTarget, 'likeicon1');
        if(component.get("v.eventobj.Drivers__c") == false)
       component.set("v.eventobj.Drivers__c",true);
       else if(component.get("v.eventobj.Drivers__c") == true)
           component.set("v.eventobj.Drivers__c",false);
       else
          component.set("v.eventobj.Drivers__c",false); 
        
        var TaskList = component.get("v.TaskList3");
        if(TaskList.length == 0){
        TaskList.push({});
            component.set("v.TaskList3", TaskList);}
    },
  
    show3 : function(component,event,helper){
        var cmpTarget1 = component.find('FIREICON3');
       $A.util.toggleClass(cmpTarget1, 'likeicon1');
        var elements = component.find('show_combo3');
        $A.util.removeClass(elements, 'slds-hide');
		$A.util.addClass(elements, 'slds-show');
         var cmpTarget = component.find('New_Opportunities__c');
        $A.util.removeClass(cmpTarget, 'likeicon1');
        if(component.get("v.eventobj.New_Opportunities__c") == false)
       component.set("v.eventobj.New_Opportunities__c",true);
       else if(component.get("v.eventobj.New_Opportunities__c") == true)
           component.set("v.eventobj.New_Opportunities__c",false);
       else
          component.set("v.eventobj.New_Opportunities__c",false);
        
        var TaskList1 = component.get("v.TaskList4");
        if(TaskList1.length == 0){
        TaskList1.push({});
            component.set("v.TaskList4", TaskList1);}
    },
  
    show4 : function(component,event,helper){
var cmpTarget1 = component.find('FIREICON4');
       $A.util.toggleClass(cmpTarget1, 'likeicon1');
        var elements = component.find('show_combo4');

        $A.util.removeClass(elements, 'slds-hide');
		$A.util.addClass(elements, 'slds-show');
         var cmpTarget = component.find('Threats__c');
        $A.util.removeClass(cmpTarget, 'likeicon1');
        if(component.get("v.eventobj.Threats__c") == false)
       component.set("v.eventobj.Threats__c",true);
       else if(component.get("v.eventobj.Threats__c") == true)
           component.set("v.eventobj.Threats__c",false);
       else
          component.set("v.eventobj.Threats__c",false);
        
        var TaskList1 = component.get("v.TaskList5");
        if(TaskList1.length == 0){
        TaskList1.push({});
            component.set("v.TaskList5", TaskList1);}
    },
  
    show5 : function(component,event,helper){
var cmpTarget1 = component.find('FIREICON5');
       $A.util.toggleClass(cmpTarget1, 'likeicon1');
        var elements = component.find('show_combo5');

        $A.util.removeClass(elements, 'slds-hide');
		$A.util.addClass(elements, 'slds-show');
         var cmpTarget = component.find('Technology__c');
        $A.util.removeClass(cmpTarget, 'likeicon1');
        if(component.get("v.eventobj.Technology__c") == false)
       component.set("v.eventobj.Technology__c",true);
       else if(component.get("v.eventobj.Technology__c") == true)
           component.set("v.eventobj.Technology__c",false);
       else
          component.set("v.eventobj.Technology__c",false);
        
        var TaskList1 = component.get("v.TaskList6");
        if(TaskList1.length == 0){
        TaskList1.push({});
            component.set("v.TaskList6", TaskList1);}
    },
    
    OnSubmit : function (component,event,helper){
       // alert('calling');
        debugger;
       var Targetcmp = component.find('savebutton');
                Targetcmp.set("v.disabled",true);
         //helper.showspinner(component,event);
        helper.hidespopup(component,event);
         //alert(component.get('v.eventobj.Meeting_Summary__c'));
         var eventrec = component.get("v.eventobj");
        eventrec.id= component.get("v.recordId");
              var task = component.get("v.TaskList1");
        if(task.length!=0 && (task[0].Subject != 'undefined' || task[0].Discussion_Points__c !='undefined' || task[0].ActivityDate != 'undefined') && eventrec.Vehicles__c == false)
           eventrec.Vehicles__c = true; 
            //alert(task[0].OwnerId );
        var task1 = component.get("v.TaskList2");
        if(task1.length!=0 && (task1[0].Subject != 'undefined' || task1[0].Discussion_Points__c !='undefined' || task1[0].ActivityDate != 'undefined') && eventrec.Operations__c == false)
           eventrec.Operations__c = true; 
          var task2 = component.get("v.TaskList3");
        if(task2.length!=0 && (task2[0].Subject != 'undefined' || task2[0].Discussion_Points__c !='undefined' || task2[0].ActivityDate != 'undefined') && eventrec.Drivers__c == false)
           eventrec.Drivers__c = true;
          var task3 = component.get("v.TaskList4");
        if(task3.length!=0 && (task3[0].Subject != 'undefined' || task3[0].Discussion_Points__c !='undefined' || task3[0].ActivityDate != 'undefined') && eventrec.New_Opportunities__c == false)
           eventrec.New_Opportunities__c = true;
          var task4 = component.get("v.TaskList5");
        if(task4.length!=0 && (task4[0].Subject != 'undefined' || task4[0].Discussion_Points__c !='undefined' || task4[0].ActivityDate != 'undefined') && eventrec.Threats__c == false)
           eventrec.Threats__c = true;
          var task5 = component.get("v.TaskList6");
        if(task5.length!=0 && (task5[0].Subject != 'undefined' || task5[0].Discussion_Points__c !='undefined' || task5[0].ActivityDate != 'undefined') && eventrec.Technology__c == false)
           eventrec.Technology__c = true;
       // alert(task1[0].Subject);
        //for(var i=0;i<task1.length;i++){
           // alert('!@@@@@@@@@@@@@'+task1[i].OwnerId); 
        //}
        task=task.concat(task1);
        task=task.concat(task2); 
        task=task.concat(task3); 
        task=task.concat(task4); 
        task=task.concat(task5); 
       // task=task.concat(task6); 

                //task=task.concat(task1); 
              var execute = true;
        if(task.length>0){
        for(var i=0;i<task.length;i++){
            //console.log('Task list :'+task[i].OwnerId);
            //alert(task[i].OwnerId);
            if(task[i].OwnerId == 'undefined' || task[i].OwnerId == '' || task[i].OwnerId == null){
                execute = false;
                break;
            }
        }}
        if(execute == true){
             var Targetcmp = component.find('savebutton');
                Targetcmp.set("v.disabled",true);
      var action = component.get("c.updateeventinserttask");
        action.setParams({'eventre':eventrec.id,'tasklist':task,'over':component.get("v.overAllTemperature"),'meet':JSON.stringify(eventrec),'MeetingSummary':component.get('v.eventobj.Meeting_Summary__c')});
              
         action.setCallback(this, function(a) {
            //alert('set call back');
                
             debugger;
             
             var state = a.getState();
            // $A.get('e.force:refreshView').fire();
          if (state === "SUCCESS") {
                 window.location.reload();

              $A.get('e.force:refreshView').fire();
              //alert('Success');
          }else{
            helper.showToast(component, event,"Update failed.Please contact system administrator.","warning","Warning");

          }
		//helper.hidespinhttps://mail.google.com/mail/ca/u/1/ner(component,event);
         });
              
            $A.enqueueAction(action);
        }else{
           // helper.hidespinner(component,event);
            helper.showpopup(component,event);
            var Targetcmp = component.find('savebutton');
                Targetcmp.set("v.disabled",false);
        }
    }, 
    doInit : function(component,event,helper){
       
        var action  = component.get ("c.getevent");
      action.setParams({'eventid':component.get("v.recordId")});
        action.setCallback(this, function(a) {
            //alert('set call back');
             debugger;
             var state = a.getState();
          if (state === "SUCCESS") {
              var returnmap = a.getReturnValue();
              var eventrec = returnmap.eventrecord; 
              if(new Date() >= new Date(eventrec.StartDateTime)) {
                 // helper.showToast(component, event, 'You cannot create a MOM for future date','Warning','Review');
                  component.set("v.CheckDate",true);
                 // component.set("v.eventobj",eventrec);
                 component.set("v.eventobj.Vehicles__c",eventrec.Vehicles__c);
                  component.set("v.eventobj.Drivers__c",eventrec.Drivers__c);
                  component.set("v.eventobj.Operations__c",eventrec.Operations__c);
                  component.set("v.eventobj.New_Opportunities__c",eventrec.New_Opportunities__c);
                  component.set("v.eventobj.Technology__c",eventrec.Technology__c);
                  component.set("v.eventobj.Threats__c",eventrec.Threats__c);
              }else{
                  component.set("v.CheckDate1",true);
                 /*helper.showToast(component, event,"You cannot create a MOM for future date","warning","Warning");
                  var dismissActionPanel = $A.get("e.force:closeQuickAction");
                  dismissActionPanel.fire();*/
              }
          }
         });
              
         $A.enqueueAction(action);
    }, 
        
    /* var TaskList = component.get("v.TaskList1");
        TaskList.push({});
        component.set("v.TaskList1", TaskList);
        
        var TaskList1 = component.get("v.TaskList2");
        TaskList1.push({});
        component.set("v.TaskList2", TaskList1);
        
         var TaskList2 = component.get("v.TaskList3");
        TaskList2.push({});
        component.set("v.TaskList3", TaskList2); 
         
        var TaskList3 = component.get("v.TaskList4");
        TaskList3.push({});
        component.set("v.TaskList4", TaskList3); 
                    
        var TaskList4 = component.get("v.TaskList5");
        TaskList4.push({});
        component.set("v.TaskList5", TaskList4); 
        
        var TaskList5 = component.get("v.TaskList6");
       TaskList5.push({});
        component.set("v.TaskList6", TaskList5); */
               
    handleComponentEvent : function(component, event, helper) {
      debugger;
      var selecteduserGetFromEvent = event.getParam("recordByEvent");
      var selectedtime = event.getParam("passingid");
      var selectedindex = event.getParam("indexnum");
      var selectedtaskList = event.getParam("whichtaskList");
      var arr = component.get("v."+selectedtaskList);
      if(selectedtime == true){
      arr[selectedindex].OwnerId=selecteduserGetFromEvent.Id;
      }
      else{
          arr[selectedindex].OwnerId=null;
          //alert('removing userId');
      }
      component.set("v."+selectedtaskList,arr);
    },
  handleTemperatureIconEvent : function(component, event, helper) {
      debugger;
        var selectedcolor = event.getParam("iconcolor");
      var selectedindex = event.getParam("indexnum");
      var selectedtaskList = event.getParam("whichtaskList");
var arr = component.get("v."+selectedtaskList);
      arr[selectedindex].Temperature__c=selectedcolor;
component.set("v."+selectedtaskList,arr);

    },
    handlepopup : function(component, event,helper){
    helper.hidespopup(component,event);
}
})