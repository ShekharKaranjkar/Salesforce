@isTest
public class MapMarkerControllerTest {

    @isTest
    public static void unitTest1(){
        String oppActualId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Actual').getRecordTypeId();
        
        Opportunity opp = new Opportunity();
        
        opp.StageName = 'M1: Solution Sent for Approval';
        opp.RecordTypeId = oppActualId;
        opp.Name = 'Test';
        opp.CloseDate = System.today();
        insert opp;
        Universe_Input__c ui = new Universe_Input__c();
        ui.Opportunity__c = opp.Id;
        ui.EV_ICE__c = 'EV';
        insert ui;
        Final_EV_Input__c fi = new Final_EV_Input__c();
        fi.Opportunity__c = opp.Id;
        insert fi;
        
        ApexPages.StandardController controller = new ApexPages.StandardController(opp);
     	MapMarkerController mc = new MapMarkerController(controller);   
        mc.getUniverseInputs();
        mc.getFinalEVInputs();
    }
}