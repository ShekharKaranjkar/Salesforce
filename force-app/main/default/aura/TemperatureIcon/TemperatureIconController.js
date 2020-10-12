({
	toggleIconcolor:function(component, event, helper){
        debugger;
        var value = event.getSource().getLocalId();
        var cmpTarget = component.find(value);
       var iconname=cmpTarget.get("v.iconName");
        var iconcolor=  event.getSource().get("v.title");
        if(iconname == 'utility:routing_offline'){
            cmpTarget.set("v.iconName","utility:record"); }
            else{
                cmpTarget.set("v.iconName","utility:routing_offline");}
        var colors = ['tempred','tempyellow','tempgreen'];
        for(var i=0;i<colors.length;i++){
            if(colors[i]!=value){
                var Targetcmp = component.find(colors[i]);
                Targetcmp.set("v.iconName","utility:routing_offline");}  
        }
        var compEvent = component.getEvent("SelectedTemperatureIconcolor");
        // set the Selected sObject Record to the event attribute.  
        compEvent.setParams({"iconcolor" : iconcolor,"indexnum": component.get("v.index"),"whichtaskList":component.get("v.whichtaskList")});  
        // fire the event  
        compEvent.fire();
},
})