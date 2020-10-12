({
    
    doInit : function(component, event, helper) {      
         component.set("v.selected", true);
        helper.opporunityProduct(component, event, helper);
    },
    
    handleFlat : function(component,event,helper) {

        var tabelList=component.get("v.tabelSelectedInstance"); 
        component.set("v.selected", true);
        console.log('1tabelList'+JSON.stringify(tabelList));
        tabelList.showFlat=true;
        tabelList.showSlab=false;
        component.set("v.tabelSelectedInstance", tabelList);
        console.log('2tabelList'+JSON.stringify(tabelList));
    },
    
    handleSlab : function(component,event,helper) {
        
         
    component.set("v.selected", false);
        
// var buttonstate = cmp.get('v.buttonstate');
 //cmp.set('v.buttonstate', !buttonstate);
        
        var tabelListSlab=component.get("v.tabelSelectedInstance"); 

        console.log('1tabelListSlab'+JSON.stringify(tabelListSlab));
        tabelListSlab.showFlat=false;
        tabelListSlab.showSlab=true;
        component.set("v.tabelSelectedInstance", tabelListSlab);
        console.log('2tabelListSlab'+JSON.stringify(tabelListSlab));
    },   
})