public class BatchGenerator implements Database.Batchable<sObject>, Database.Stateful {
    private integer recordsProcessed = 0;

    public Database.QueryLocator Start(Database.BatchableContext bc) {
        return Database.getQueryLocator('select Id, Name__c from Duplicate_Thingy__c');
    }

    public void Execute(Database.BatchableContext bc, List<Duplicate_Thingy__c> duplicateThingies) {
        Duplicate_Configuration_Thingy__c duplicateConfigurationThingy = [select Id from Duplicate_Configuration_Thingy__c limit 1];
        List<Middle_Thingy__c> middleThingies = new List<Middle_Thingy__c>();
        for (Duplicate_Thingy__c duplicateThingy : duplicateThingies) {
            Middle_Thingy__c middleThnigy = new Middle_Thingy__c(
                Name__c='Middle thingy from ' + duplicateThingy.Name__c, 
                Duplicate_Thingy__c=duplicateThingy.Id, 
                Duplicate_Configuration_Thingy__c=duplicateConfigurationThingy.Id);
            
            for (integer i=0; i<5; i++ ) {
                Middle_Thingy__c clonedMiddleThnigy = middleThnigy.clone();
                clonedMiddleThnigy.Description__c = 'Description ' + i;
                middleThingies.Add(clonedMiddleThnigy);
            }

            for (integer i=0; i<5; i++) {
                Middle_Thingy__c clonedMiddleThnigy = middleThnigy.clone();
                clonedMiddleThnigy.Description__c = 'Common description';
                middleThingies.Add(clonedMiddleThnigy);
            }
        }
        
        insert middleThingies;
        
        recordsProcessed += middleThingies.size();
    }

    public void Finish(Database.BatchableContext bc) {
        System.debug(recordsProcessed + ' records processed.');
    }
}