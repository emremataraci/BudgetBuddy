# RFC 003: Hedefler ve Bütçe Yönetimi

## Özet
Bu RFC, BudgetBuddy uygulamasının finansal hedef belirleme ve bütçe yönetimi özelliklerini tanımlar.

## Motivasyon
Kullanıcıların finansal hedeflerini belirleyebilmeleri, bu hedeflere ulaşmak için bütçe oluşturabilmeleri ve ilerlemeyi takip edebilmeleri için gerekli altyapıyı oluşturmak.

## Tasarım Detayları

### 1. Finansal Hedefler
#### Özellikler
- Hedef oluşturma
  - Hedef adı ve açıklaması
  - Hedef tutarı
  - Hedef tarihi
  - Hedef kategorisi
  - Başlangıç tutarı
- Hedef ilerleme takibi
- Hedef bildirimleri
- Hedef güncelleme
- Hedef tamamlama
- Hedef istatistikleri

#### Hedef Kategorileri
- Tasarruf
- Yatırım
- Borç Ödeme
- Büyük Alım (Ev, Araba vb.)
- Tatil
- Eğitim
- Diğer

### 2. Bütçe Yönetimi
#### Özellikler
- Kategori bazlı bütçe oluşturma
- Aylık bütçe limitleri
- Bütçe takibi
- Bütçe uyarıları
- Bütçe analizi
- Tasarruf önerileri
- Bütçe raporları

### 3. Veri Modelleri

```swift
struct Goal {
    let id: UUID
    var title: String
    var description: String?
    var category: GoalCategory
    var targetAmount: Decimal
    var currentAmount: Decimal
    var startDate: Date
    var targetDate: Date
    var status: GoalStatus
    var notifications: [GoalNotification]
    var createdAt: Date
    var updatedAt: Date
}

enum GoalStatus {
    case onTrack
    case behindSchedule
    case ahead
    case completed
    case failed
}

struct GoalNotification {
    let id: UUID
    var type: GoalNotificationType
    var threshold: Decimal
    var isEnabled: Bool
}

struct Budget {
    let id: UUID
    var month: Date
    var categories: [BudgetCategory]
    var totalLimit: Decimal
    var createdAt: Date
    var updatedAt: Date
}

struct BudgetCategory {
    let id: UUID
    var category: TransactionCategory
    var limit: Decimal
    var spent: Decimal
    var notifications: [BudgetNotification]
}

struct BudgetNotification {
    let id: UUID
    var type: BudgetNotificationType
    var threshold: Decimal
    var isEnabled: Bool
}
```

## UI Bileşenleri
- GoalsListView
- GoalDetailView
- AddGoalView
- GoalProgressView
- BudgetOverviewView
- BudgetCategoryView
- BudgetSettingsView

## İş Mantığı
- Hedef ilerleme hesaplaması
- Bütçe limit kontrolü
- Bildirim tetikleme mantığı
- Tasarruf önerileri algoritması
- Hedef tamamlanma tahminleri

## Test Gereksinimleri
- Hedef CRUD operasyonları için unit testler
- Bütçe hesaplamaları için unit testler
- İlerleme takibi için integration testler
- Bildirim mantığı testleri
- UI testleri

## Aşamalar
1. Hedef yönetimi temel özellikleri
2. Bütçe yönetimi temel özellikleri
3. API entegrasyonları
4. İlerleme takip sistemi
5. Bildirim sistemi
6. Raporlama ve analiz
7. Test ve optimizasyon

## Zaman Tahmini
- Hedef Yönetimi: 1 hafta
- Bütçe Yönetimi: 1 hafta
- API Entegrasyonları: 1 hafta
- İlerleme Takibi: 3 gün
- Bildirim Sistemi: 3 gün
- Raporlama: 4 gün
- Test ve Optimizasyon: 1 hafta

Toplam: ~5 hafta

## Riskler
- Karmaşık hedef hesaplamalarının performans etkileri
- Bildirim zamanlaması hassasiyeti
- Kullanıcı hedef motivasyonunun sürdürülebilirliği

## Bağımlılıklar
- RFC 001: Temel Kullanıcı Yönetimi ve Ana Sayfa
- RFC 002: İşlem Yönetimi
- Local Notifications Framework
- Charts Framework

## Alternatifler
- Manuel hedef güncelleme
- Basitleştirilmiş bütçe sistemi
- Üçüncü parti grafik kütüphaneleri

## Referanslar
- [Local Notifications Framework](https://developer.apple.com/documentation/usernotifications)
- [Charts Framework](https://developer.apple.com/documentation/charts)
- [SwiftUI Animations](https://developer.apple.com/documentation/swiftui/animation) 