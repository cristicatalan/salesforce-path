public class BatchDeduplicatorV4 implements Database.Batchable<SObject>, Database.Stateful {
    private string lastCompositeKey = '';

    public Database.QueryLocator Start(Database.BatchableContext bc) {
        return Database.getQueryLocator('select Id, Duplicate_Thingy__c, Description__c from Middle_Thingy__c order by Duplicate_Thingy__c, Description__c');
    }

    public void Execute(Database.BatchableContext bc, List<Middle_Thingy__c> middleThingies) {
        List<Middle_Thingy__c> recordsToDelete = new List<Middle_Thingy__c>();

        for (Middle_Thingy__c middleThingy : middleThingies) {
            string compositeKey = middleThingy.Duplicate_Thingy__c + '|' + middleThingy.Description__c;

            if (compositeKey == lastCompositeKey) {
                recordsToDelete.add(middleThingy);
            }
            else {
                lastCompositeKey = compositeKey;
            }
        }

        delete recordsToDelete;
    }

    public void Finish(Database.BatchableContext bc) {
    }
}
