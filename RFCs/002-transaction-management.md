# RFC 002: İşlem Yönetimi

## Özet
Bu RFC, BudgetBuddy uygulamasının gelir ve gider işlemlerinin yönetimi için gerekli özellikleri tanımlar.

## Motivasyon
Kullanıcıların gelir ve giderlerini kolayca takip edebilmeleri, kategorize edebilmeleri ve analiz edebilmeleri için gerekli altyapıyı oluşturmak.

## Tasarım Detayları

### 1. İşlem Ekleme
#### Gelir İşlemleri
- Gelir miktarı
- Gelir kategorisi seçimi
- Tarih seçimi
- Not ekleme
- Tekrarlayan gelir tanımlama
- Gelir kaynağı belirleme

#### Gider İşlemleri
- Gider miktarı
- Gider kategorisi seçimi
- Tarih seçimi
- Not ekleme
- Fatura/makbuz fotoğrafı ekleme
- Konum bilgisi (opsiyonel)

### 2. Kategori Yönetimi
#### Gelir Kategorileri
- Maaş
- Yatırım Gelirleri
- Serbest Çalışma
- İş Gelirleri
- Diğer Gelirler

#### Gider Kategorileri
- Günlük Harcamalar
- Faturalar
- Kişisel Harcamalar
- Ulaşım
- Sağlık
- Eğitim
- Diğer Giderler

### 3. Veri Modelleri

```swift
struct Transaction {
    let id: UUID
    var amount: Decimal
    var type: TransactionType
    var category: TransactionCategory
    var date: Date
    var note: String?
    var attachments: [Attachment]?
    var location: Location?
    var isRecurring: Bool
    var recurringDetails: RecurringDetails?
    var createdAt: Date
    var updatedAt: Date
}

struct TransactionCategory {
    let id: UUID
    var name: String
    var type: TransactionType
    var icon: String
    var color: Color
    var isDefault: Bool
}

struct RecurringDetails {
    var frequency: RecurringFrequency
    var startDate: Date
    var endDate: Date?
    var lastProcessed: Date?
}

enum RecurringFrequency {
    case daily
    case weekly
    case monthly
    case yearly
}

struct Attachment {
    let id: UUID
    var url: URL
    var type: AttachmentType
    var uploadDate: Date
}

struct Location {
    var latitude: Double
    var longitude: Double
    var placeName: String?
}
```

## UI Bileşenleri
- NewTransactionView
- TransactionListView
- TransactionDetailView
- CategorySelectionView
- RecurringTransactionView
- AttachmentPickerView
- LocationPickerView

## Depolama Gereksinimleri
- CoreData ile yerel depolama
- iCloud ile senkronizasyon
- Dosya depolama için CloudKit
- Offline çalışma desteği

## Test Gereksinimleri
- İşlem CRUD operasyonları için unit testler
- Kategori yönetimi için unit testler
- Tekrarlayan işlem mantığı için integration testler
- UI testleri
- Offline mod testleri

## Aşamalar
1. Temel işlem yönetimi
2. Kategori sistemi
3. API entegrasyonları
4. Tekrarlayan işlemler
5. Dosya ekleme sistemi
6. Offline mod
7. Test ve optimizasyon

## Zaman Tahmini
- Temel İşlem Yönetimi: 1 hafta
- Kategori Sistemi: 3 gün
- API Entegrasyonları: 1 hafta
- Tekrarlayan İşlemler: 4 gün
- Dosya Ekleme: 3 gün
- Offline Mod: 4 gün
- Test ve Optimizasyon: 1 hafta

Toplam: ~5 hafta

## Riskler
- Offline-online senkronizasyon çakışmaları
- Büyük dosya eklerinin performans etkileri
- Tekrarlayan işlemlerin zamanında işlenmesi

## Bağımlılıklar
- RFC 001: Temel Kullanıcı Yönetimi ve Ana Sayfa
- CoreData
- CloudKit
- FileManager

## Alternatifler
- Realm veritabanı kullanımı
- Firebase Storage kullanımı
- SQLite kullanımı

## Referanslar
- [Core Data Programming Guide](https://developer.apple.com/documentation/coredata)
- [CloudKit Documentation](https://developer.apple.com/documentation/cloudkit)
- [FileManager Documentation](https://developer.apple.com/documentation/foundation/filemanager) 