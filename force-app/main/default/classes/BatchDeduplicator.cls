public class BatchDeduplicator implements Database.Batchable<sObject> {
    public Database.QueryLocator Start(Database.BatchableContext bc) {
        return Database.getQueryLocator('select Id from Duplicate_Thingy__c');
    }

    public void Execute(Database.BatchableContext bc, List<Duplicate_Thingy__c> duplicateThingies) {
        List<Middle_Thingy__c> recordsToDelete = new List<Middle_Thingy__c>();
        
        for (Duplicate_Thingy__c duplicateThingy : duplicateThingies) {
            List<AggregateResult> results = [
                select count(Id) Duplicates, Description__c, Duplicate_Thingy__c 
                from Middle_Thingy__c 
                where Duplicate_Thingy__c = :duplicateThingy.Id
                group by Duplicate_Thingy__c, Description__c
                having Count(id) > 1
            ];
            
            for (AggregateResult ar : results) {
                integer count = (integer) ar.get('Duplicates');
                string description = (string) ar.get('Description__c');
                Id duplicateThingyId = (Id) ar.get('Duplicate_Thingy__c');
                
                List<Middle_Thingy__c> duplicates = [
                    select Id
                    from Middle_Thingy__c 
                    where Description__c = :description 
                    and Duplicate_Thingy__c = :duplicateThingyId
                    limit :count-1
                ];
                recordsToDelete.AddAll(duplicates);
                
                System.debug(duplicates.size());
            }
        }
        
        delete recordsToDelete;
        
        System.debug(recordsToDelete.size());
    }

    public void Finish(Database.BatchableContext bc) {
    }
}