# Bài tập luyện Batch Apex từ dễ đến khó

Dưới đây là 10 bài tập giúp bạn làm quen dần với Batch Apex trong Salesforce. Mỗi bài có mô tả yêu cầu, gợi ý về `start`, `execute`, `finish` và cách chạy batch.

---

## 1. In ra tất cả Account
**Mục tiêu:** Làm quen với batch cơ bản.
- `start`: Query `SELECT Id, Name FROM Account`
- `execute`: `System.debug(Name)`
- `finish`: In ra `"Hoàn thành batch in Account"`

---

## 2. Cập nhật Phone của Contact rỗng thành `'000-000'`
**Mục tiêu:** Batch update dữ liệu.
- `start`: Query `SELECT Id, Phone FROM Contact WHERE Phone = null`
- `execute`: Gán `Phone = '000-000'` và `update`
- `finish`: Log `"Đã update xong Contact thiếu Phone"`

---

## 3. Xóa Lead có `Status = 'Inactive'`
**Mục tiêu:** Batch delete.
- `start`: Query `SELECT Id FROM Lead WHERE Status = 'Inactive'`
- `execute`: `delete scope`
- `finish`: Log `"Đã xóa xong Lead Inactive"`

---

## 4. Đếm số lượng Opportunity theo Stage
**Mục tiêu:** Sử dụng `Database.Stateful` để lưu biến đếm.
- `start`: Query `SELECT Id, StageName FROM Opportunity`
- `execute`: Dùng Map `<String, Integer>` để đếm theo Stage
- `finish`: `System.debug(map kết quả)`

---

## 5. Tự động gán `Industry = 'Technology'` cho Account không có Industry
**Mục tiêu:** Update có điều kiện.
- `start`: Query `SELECT Id, Industry FROM Account WHERE Industry = null`
- `execute`: Update `Industry = 'Technology'`
- `finish`: Debug tổng số record đã update

---

## 6. Gửi email sau khi batch chạy xong
**Mục tiêu:** Dùng logic trong `finish`.
- `start`: Query `Account`
- `execute`: Không cần xử lý phức tạp
- `finish`: Tạo `Messaging.SingleEmailMessage` và gửi đến admin

---

## 7. Cập nhật số lượng Contact vào custom field trên Account (`Number_of_Contacts__c`)
**Mục tiêu:** Batch xử lý liên quan giữa nhiều object.
- `start`: Query `SELECT Id, (SELECT Id FROM Contacts) FROM Account`
- `execute`: Đếm số Contact và update field
- `finish`: Log `"Hoàn thành cập nhật số lượng Contact"`

---

## 8. Chia nhỏ batch size và so sánh kết quả
**Mục tiêu:** Hiểu batch size ảnh hưởng thế nào.
- `start`: Query `Account`
- `execute`: Debug `"Scope size: " + scope.size()`
- **Khi chạy thử:** Thay batch size `10`, `200`, `2000` để quan sát log

---

## 9. Xử lý dữ liệu lớn với QueryLocator
**Mục tiêu:** Truy vấn > 50.000 record.
- `start`: Dùng `Database.getQueryLocator('SELECT Id FROM Account')`
- `execute`: Debug Id
- `finish`: Log `"Xử lý dữ liệu lớn xong"`

---

## 10. Batch kết hợp Chain (chạy batch khác sau khi xong)
**Mục tiêu:** Sử dụng `Database.Stateful` và chaining.
- `start`: Query `Account`
- `execute`: Update hoặc debug
- `finish`: Gọi `Database.executeBatch(new AnotherBatchClass())` để chạy tiếp batch khác

---

## Cách chạy batch
Tạo file Anonymous Apex và chạy trong VSCode hoặc Developer Console:

```apex
BatchTemplate myBatch = new BatchTemplate();
Database.executeBatch(myBatch, 200);
