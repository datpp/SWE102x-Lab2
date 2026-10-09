# SWE102x - Lab 2: Design Patterns (Java)

Chạy thử mã nguồn ví dụ của 8 mẫu thiết kế từ
[refactoring.guru/design-patterns/examples](https://refactoring.guru/design-patterns/examples)
với ngôn ngữ **Java**.

| # | Mẫu thiết kế | Nhóm | Mã nguồn | Kết quả chạy |
|---|---|---|---|---|
| 1 | Factory Method | Creational | [src/.../factory_method](src/refactoring_guru/factory_method/example) | [outputs/factory_method.txt](outputs/factory_method.txt) |
| 2 | Strategy | Behavioral | [src/.../strategy](src/refactoring_guru/strategy/example) | [outputs/strategy.txt](outputs/strategy.txt) |
| 3 | Visitor | Behavioral | [src/.../visitor](src/refactoring_guru/visitor/example) | [outputs/visitor.txt](outputs/visitor.txt) |
| 4 | Decorator | Structural | [src/.../decorator](src/refactoring_guru/decorator/example) | [outputs/decorator.txt](outputs/decorator.txt) |
| 5 | Iterator | Behavioral | [src/.../iterator](src/refactoring_guru/iterator/example) | [outputs/iterator.txt](outputs/iterator.txt) |
| 6 | Observer | Behavioral | [src/.../observer](src/refactoring_guru/observer/example) | [outputs/observer.txt](outputs/observer.txt) |
| 7 | Proxy | Structural | [src/.../proxy](src/refactoring_guru/proxy/example) | [outputs/proxy.txt](outputs/proxy.txt) |
| 8 | Flyweight | Structural | [src/.../flyweight](src/refactoring_guru/flyweight/example) | [outputs/flyweight.txt](outputs/flyweight.txt) |

## Tóm tắt từng mẫu

1. **Factory Method** - `Dialog` khai báo phương thức `createButton()`, lớp con `HtmlDialog` / `WindowsDialog`
   quyết định tạo `HtmlButton` hay `WindowsButton`. Client chỉ làm việc với interface `Button`.
2. **Strategy** - `Order` xử lý thanh toán qua interface `PayStrategy`; người dùng chọn
   `PayByPayPal` hoặc `PayByCreditCard` lúc chạy.
3. **Visitor** - `XMLExportVisitor` thêm chức năng xuất XML cho các hình (`Dot`, `Circle`,
   `Rectangle`, `CompoundShape`) mà không sửa các lớp hình.
4. **Decorator** - `FileDataSource` được bọc bởi `CompressionDecorator` và `EncryptionDecorator`
   để nén + mã hóa dữ liệu khi ghi và giải mã khi đọc.
5. **Iterator** - `FacebookIterator` / `LinkedInIterator` duyệt danh sách bạn bè, đồng nghiệp
   mà `SocialSpammer` không cần biết cấu trúc bên trong của mạng xã hội.
6. **Observer** - `Editor` có `EventManager`; các listener (`LogOpenListener`,
   `EmailNotificationListener`) đăng ký và nhận thông báo khi file được mở / lưu.
7. **Proxy** - `YouTubeCacheProxy` bọc `ThirdPartyYouTubeClass`, cache kết quả nên lần tải thứ hai
   nhanh hơn nhiều (so sánh thời gian ở cuối `outputs/proxy.txt`).
8. **Flyweight** - 1.000.000 cây chỉ dùng chung 2 đối tượng `TreeType` (tên, màu, texture),
   giảm bộ nhớ từ ~36MB xuống ~7MB. Demo mở cửa sổ Swing vẽ khu rừng.

## Môi trường

- JDK 21 (OpenJDK 21.0.12)
- macOS, bash

## Cách chạy

```bash
# chạy cả 8 mẫu, kết quả ghi vào outputs/<pattern>.txt
./run.sh

# chạy 1 hoặc vài mẫu
./run.sh proxy flyweight

# chỉ định JDK cụ thể
JAVA_HOME=/path/to/jdk-21 ./run.sh
```

Chạy thủ công một mẫu:

```bash
mkdir -p build out
javac -encoding UTF-8 -d build $(find src -name "*.java")
java -cp build refactoring_guru.observer.example.Demo
```

Ghi chú:
- **Strategy** và **Iterator** đọc dữ liệu từ bàn phím. `run.sh` lấy dữ liệu mẫu trong
  [`inputs/`](inputs) và đưa vào từng dòng (vì mỗi lớp tạo `BufferedReader` riêng trên `System.in`).
  Khi chạy thủ công có thể nhập tay.
- **Decorator** ghi file `out/OutputDemo.txt` (nội dung đã nén + mã hóa), được sao lưu ở
  [`outputs/decorator_file_content.txt`](outputs/decorator_file_content.txt).
- **Flyweight** mở cửa sổ Swing; `run.sh` tự đóng sau 5 giây.
- Mỗi thư mục `example/` còn giữ file `OutputDemo.txt` gốc để đối chiếu - kết quả chạy khớp với file gốc.

## Bản quyền

Mã nguồn ví dụ: *Refactoring.Guru: Design Patterns in Java* © Alexander Shvets,
[github.com/RefactoringGuru/design-patterns-java](https://github.com/RefactoringGuru/design-patterns-java),
giấy phép [CC BY-NC-ND 4.0](LICENSE.txt). Mã nguồn được giữ nguyên, chỉ dùng cho mục đích học tập.
