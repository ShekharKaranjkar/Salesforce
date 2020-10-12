({
    addRow: function(component, event, helper) {
        helper.addJournalRecord(component, event);
    },
    removeRow : function(component, event, helper) {
        console.log('Step1');
        console.log(event.getSource().get("v.name"));
        var index = parseInt(event.getSource().get("v.name"));
        let newDailyLst = [];
        var arr = component.get("v.DailyList");
        
        for(var i = 0;i<arr.length;i++){
            if(i != index){
               newDailyLst.push(arr[i]); 
            }
        }
        console.log(index);
        //arr = arr.splice(index-1,1);
        var rmIds = component.get('v.removeLogIds');
        if(arr[index].Id){
            rmIds.push(arr[index].Id);
            component.set('v.removeLogIds',rmIds);
        }
        component.set("v.DailyList",newDailyLst);
        //helper.removeJournalRecord(component, event);
    },
    doInit: function(component, event, helper) {
        helper.loadData(component, event);
        var today = $A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
    	component.set('v.today', today);
    },
    gotoURL : function (component, event, helper) {
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
          "url": "/lightning/o/Event/home"
        });
        urlEvent.fire();
    },
    /*  removeRow: function(component, event, helper) {
        var DailyList = component.get("v.DailyList");
        var selectedItem = event.currentTarget;
        var index = selectedItem.dataset.record;
        DailyList.splice(index, 1);
        component.set("v.DailyList", DailyList);
    },*/
    save: function(component, event, helper) {
        	console.log('save');
            if (helper.validateDailyList(component, event)) 
                helper.saveDaiylList(component, event);
    },
})