public class ServiceCenterController {
    @AuraEnabled
    public static sortDistanceWrapperclass getservicecenter(Id IssueId) {
        Issues__c issue = [SELECT Id, Current_Location__Latitude__s, Current_Location__Longitude__s,Vehicle__r.City__c,Service_Center__c FROM Issues__c Where Id=:IssueId];
       sortDistanceWrapperclass wrapper = New sortDistanceWrapperclass();
        if(issue.Current_Location__Latitude__s != null && issue.Current_Location__Longitude__s != Null){
        if(issue.Service_Center__c ==null ){
            List<sortDistanceWrapper>sortDistanceWrapperList = New List<sortDistanceWrapper>();
            Boolean queryall =true;
            if(issue.Vehicle__r.City__c !=Null){
                For(Service_Center__c center:[SELECT Id,Name,State_Province__c, Location__Latitude__s, Location__Longitude__s,
                                              Street__c, Located_City__c,Located_City__r.Name,
                                              Country__c FROM Service_Center__c where Located_City__C=:issue.Vehicle__r.City__c]){
                    Location loc1 = Location.newInstance(issue.Current_Location__Latitude__s,issue.Current_Location__Longitude__s);
                    Location loc2 = Location.newInstance(center.Location__Latitude__s,center.Location__Longitude__s);
                    Double distance = loc1.getDistance(loc2, 'mi');
                    sortDistanceWrapperList.add(New sortDistanceWrapper(center.Id,distance,center.Name));
                    queryall = false;
                }
            }
            if(queryall){
                For(Service_Center__c center:[SELECT Id,Name,State_Province__c, Location__Latitude__s, Location__Longitude__s, Street__c, 
                                              Located_City__c,Located_City__r.Name, Country__c FROM Service_Center__c]){
                    Location loc1 = Location.newInstance(issue.Current_Location__Latitude__s,issue.Current_Location__Longitude__s);
                    Location loc2 = Location.newInstance(center.Location__Latitude__s,center.Location__Longitude__s);
                    Double distance = loc1.getDistance(loc2, 'km');
                    sortDistanceWrapperList.add(New sortDistanceWrapper(center.Id,distance,center.Name));
                }
            }
            sortDistanceWrapperList.sort();
            wrapper.sortDistanceWrapperList = sortDistanceWrapperList;
            wrapper.servicecenterID = issue.Service_Center__c;
            return wrapper;
        }else{
            wrapper.sortDistanceWrapperList = null;
            wrapper.servicecenterID = issue.Service_Center__c;
            return wrapper;
        }
        }
        return null;
           }
    
    Public class sortDistanceWrapper implements comparable {
        @AuraEnabled
        Public Id recordid {get;set;}
        @AuraEnabled
        Public double distance {get;set;}
        @AuraEnabled
        Public String CenterName {get;set;}
        Public sortDistanceWrapper (Id recordid,double distance,String CenterName){
            This.recordid = recordid;
            This.distance = distance;
            This.CenterName = CenterName;
        }
        Public integer compareTo (Object compareTo) {
            sortDistanceWrapper wrap = (sortDistanceWrapper)compareTo;
            integer returnValue = 0;
            If (distance > wrap.distance) {
                returnValue = 1;
            } else if (distance < wrap.distance) {
                returnValue = -1;
            }
            Return returnValue; 
        }
    }
    
    @AuraEnabled
    public static Issues__c updateIssue(Issues__c issue){
        update issue;
        issue = [Select id,Vehicle__c,Service_Center__c from Issues__c where id=:issue.id];
        Vehicle__c Vehiclerecord = New Vehicle__c(id=issue.Vehicle__c,Base_Service_Center__c=issue.Service_Center__c);
        update Vehiclerecord;
        return null; 
    }
     public Class sortDistanceWrapperclass{
        @AuraEnabled
        Public String servicecenterID {Set;Get;}
        @AuraEnabled
        Public List<sortDistanceWrapper>sortDistanceWrapperList{Set;Get;}
       
    }
}