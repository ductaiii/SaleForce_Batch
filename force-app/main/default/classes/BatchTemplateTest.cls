public with sharing class BatchTemplateTest {
  public static void execute() {
        BatchTemplate batch = new BatchTemplate();
        Database.executeBatch(batch);
    }
}