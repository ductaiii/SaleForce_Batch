// 10. Batch kết hợp Chain (chạy batch khác sau khi xong)
// Mục tiêu: Sử dụng Database.Stateful và chaining.
// start: Query Account
// execute: Update hoặc debug
// finish: Gọi Database.executeBatch(new AnotherBatchClass()) để chạy tiếp batch khác
// Bạn có 2 công việc cần làm tuần tự:

// Batch 1: Rửa chén (làm sạch dữ liệu).

// Batch 2: Lau bàn (xử lý tiếp dữ liệu).

// Bạn muốn: chỉ lau bàn sau khi đã rửa chén xong.
// 👉 Đây chính là batch chaining.
global with sharing class Bai10Batch implements Database.Batchable<SObject>, Database.Stateful {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id FROM Account');
    }

    global void execute(Database.BatchableContext bc, List<SObject> scope) {
        List<Account> accsToUpdate = new List<Account>();
        for (SObject s : scope) {
            Account acc = (Account)s;
            acc.Description = 'Đã rửa chén'; // ví dụ: cập nhật dữ liệu
            accsToUpdate.add(acc);
        }
        if (!accsToUpdate.isEmpty()) {
            update accsToUpdate;
        }
    }

    global void finish(Database.BatchableContext bc) {
        System.debug('Xong Batch 1: Rửa chén.');

        // Gọi batch lau bàn
        Database.executeBatch(new Bai10SecondBatch(), 200);
    }
}