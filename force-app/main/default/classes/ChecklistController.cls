public class ChecklistController {
    @AuraEnabled
 public static List < Vehicle__c > fetchAccount(String searchKeyWord) {
  String searchKey = searchKeyWord + '%';
  List <Vehicle__c> returnList = new List <Vehicle__c> ();
  List <Vehicle__c> lstOfVehicle = [select id, Name from Vehicle__c where Name LIKE: searchKey];
 
  for (Vehicle__c vh: lstOfVehicle) {
     returnList.add(vh);
     }
  return returnList;
 }
     @AuraEnabled
 public static List < Service_Provider__c > fetchDriver(String searchKeyWord) {
  String searchKey = searchKeyWord + '%';
  List <Service_Provider__c> returnList = new List <Service_Provider__c> ();
  List <Service_Provider__c> lstOfDriver = [select id, Name from Service_Provider__c  where Name LIKE: searchKey];
 
  for (Service_Provider__c dr: lstOfDriver) {
     returnList.add(dr);
     }
  return returnList;
 }
    
}