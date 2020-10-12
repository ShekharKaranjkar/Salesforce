({
    // Handle component initialization
    doInit : function(component, event, helper) {
        
        // Dynamically create the feed with the specified type
        /*$A.createComponent("forceChatter:feed", {"type": "groups"}, function(feed) {
            var feedContainer = component.find("feedContainer");
            feedContainer.set("v.body", feed);
        });*/
        
        /*$A.createComponent("forceChatter:publisher", {"context": "GLOBAL"}, function(feed) {
            var feedContainer = component.find("feedContainer");
            feedContainer.set("v.body", feed);
        });*/
    }
})