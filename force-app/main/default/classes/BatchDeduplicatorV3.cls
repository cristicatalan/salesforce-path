public class BatchDeduplicatorV3 implements Database.Batchable<SObject> {
    public Database.QueryLocator Start(Database.BatchableContext bc) {
        return Database.getQueryLocator('select Id from Duplicate_Thingy__c');
    }

    public void Execute(Database.BatchableContext bc, List<Duplicate_Thingy__c> duplicateThingies) {
        List<Middle_Thingy__c> recordsToDelete = new List<Middle_Thingy__c>();

        for (Duplicate_Thingy__c duplicateThingy : duplicateThingies) {
            List<Middle_Thingy__c> middleThingies = [
                select Id, Description__c
                from Middle_Thingy__c
                where Duplicate_Thingy__c = :duplicateThingy.Id
                order by Description__c
            ];

            string lastDescription = '';
            for (Middle_Thingy__c middleThingy : middleThingies) {
                if (middleThingy.Description__c == lastDescription) {
                    recordsToDelete.add(middleThingy);
                }
                else {
                    lastDescription = middleThingy.Description__c;
                }
            }
        }

        delete recordsToDelete;
    }

    public void Finish(Database.BatchableContext bc) {
    }
}
