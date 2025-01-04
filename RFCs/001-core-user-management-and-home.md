# RFC 001: Temel Kullanıcı Yönetimi ve Ana Sayfa

## Özet
Bu RFC, BudgetBuddy uygulamasının temel kullanıcı yönetimi ve ana sayfa özelliklerini tanımlar.

## Motivasyon
Kullanıcıların uygulamaya güvenli bir şekilde erişebilmeleri ve temel finansal durumlarını görüntüleyebilmeleri için gerekli altyapıyı oluşturmak.

## Tasarım Detayları

### 1. Kullanıcı Yönetimi
#### Özellikler
- E-posta/şifre ile kayıt
- Sosyal medya ile kayıt (Apple, Google)
- Oturum yönetimi
- Şifre sıfırlama
- İki faktörlü kimlik doğrulama (2FA)

#### Teknik Gereksinimler
- JWT tabanlı kimlik doğrulama
- Secure Keychain entegrasyonu
- OAuth 2.0 entegrasyonu
- Şifreleme ve güvenlik protokolleri

### 2. Ana Sayfa
#### Özellikler
- Toplam bakiye gösterimi
- Gelir/gider özeti kartı
- Hızlı işlem butonları (Gelir/Gider/Bütçe)
- Son işlemler listesi
- Kategori bazlı harcama analizi
- Aylık harcama özeti ve grafikler

#### UI Bileşenleri
- BalanceSummaryView
- QuickActionButtons
- RecentTransactionsList
- SpendingCategoryChart
- MonthlySpendingGraph

### 3. Veri Modelleri

```swift
struct User {
    let id: String
    let email: String
    let name: String
    let profileImage: URL?
    let createdAt: Date
    let settings: UserSettings
}

struct UserSettings {
    var preferredCurrency: Currency
    var notificationsEnabled: Bool
    var theme: AppTheme
}

struct Transaction {
    let id: String
    let amount: Decimal
    let type: TransactionType
    let category: Category
    let date: Date
    let note: String?
}

enum TransactionType {
    case income
    case expense
}
```

## Depolama Gereksinimleri
- CoreData ile yerel depolama
- iCloud ile senkronizasyon
- Keychain ile hassas veri depolama

## Test Gereksinimleri
- Kullanıcı yönetimi için unit testler
- UI testleri
- Güvenlik testleri
- Performans testleri

## Aşamalar
1. Temel kullanıcı yönetimi
2. Ana sayfa UI
3. API entegrasyonları
4. Veri entegrasyonu
5. Test ve optimizasyon

## Zaman Tahmini
- Kullanıcı Yönetimi: 1 hafta
- Ana Sayfa UI: 1 hafta
- API Entegrasyonları: 1 hafta
- Veri Entegrasyonu: 4 gün
- Test ve Optimizasyon: 4 gün

Toplam: ~4 hafta

## Riskler
- Sosyal medya API değişiklikleri
- iCloud senkronizasyon sorunları
- Güvenlik açıkları

## Bağımlılıklar
- SwiftUI
- Combine
- CoreData
- Keychain
- Firebase Auth (opsiyonel)

## Alternatifler
- Firebase Authentication kullanımı
- Realm veritabanı kullanımı
- Custom auth sistemi geliştirme

## Referanslar
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [Firebase Auth Documentation](https://firebase.google.com/docs/auth)
- [Apple Sign In Documentation](https://developer.apple.com/sign-in-with-apple) 