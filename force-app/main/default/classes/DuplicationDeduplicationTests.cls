@IsTest
private class DuplicationDeduplicationTests {
    @IsTest
    private static void WhenGenerateThenCreateSomeDuplicateThingiesAndDuplicateConfigurationThigies() {
        Utils.GenerateData();

        List<Duplicate_Thingy__c> duplicateThingies = [select Id from Duplicate_Thingy__c];
        System.assertEquals(10, duplicateThingies.size());

        List<Duplicate_Configuration_Thingy__c> duplicateConfigurationThingies = [select Id from Duplicate_Configuration_Thingy__c];
        System.AssertEquals(10, duplicateConfigurationThingies.size());
    }

    @IsTest
    private static void GivenDuplicateThigiesWhenDeduplicateMiddleThingiesThenCreateDuplicates() {
        // Arrange
        Utils.GenerateData();

        Test.startTest();

        BatchGenerator batchGenerator = new BatchGenerator();
        Database.executeBatch(batchGenerator);

        Test.stopTest();

        // Assert
        List<AggregateResult> duplicateResults = [
            select count(Id) Duplicates, Description__c, Duplicate_Thingy__c 
            from Middle_Thingy__c 
            group by Duplicate_Thingy__c, Description__c
            having Count(id) > 1
        ];
        System.assertEquals(10, duplicateResults.size());

        List<AggregateResult> uniqueResults = [
            select count(Id) Duplicates, Description__c, Duplicate_Thingy__c 
            from Middle_Thingy__c 
            group by Duplicate_Thingy__c, Description__c
            having Count(id) = 1
        ];
        System.assertEquals(50, uniqueResults.size());
    }

    @IsTest
    private static void GivenDuplicateThigiesWhenDuplicateAndDeduplicateMiddleThigiesThenOnlyUniqueMiddleThingiesShouldRemain() {
        // Arrange
        Utils.GenerateData();

        Test.startTest();

        BatchGenerator batchGenerator = new BatchGenerator();
        Database.executeBatch(batchGenerator);

        BatchDeduplicator batchDeduplicator = new BatchDeduplicator();
        Database.executeBatch(batchDeduplicator);

        Test.stopTest();
        
        // Assert
        List<AggregateResult> results = [
            select count(Id) Duplicates, Description__c, Duplicate_Thingy__c 
            from Middle_Thingy__c 
            group by Duplicate_Thingy__c, Description__c
            having Count(id) > 1
        ];
        System.assertEquals(0, results.size());
    }
}