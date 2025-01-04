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

\`\`\`swift
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
\`\`\`

## API Endpoints

### Kullanıcı Yönetimi

#### POST /api/v1/auth/register
Yeni kullanıcı kaydı oluşturur.

Request:
\`\`\`json
{
    "email": "string",
    "password": "string",
    "name": "string",
    "preferredCurrency": "string (ISO 4217)",
    "notificationsEnabled": "boolean"
}
\`\`\`

Response (200 OK):
\`\`\`json
{
    "id": "string (UUID)",
    "email": "string",
    "name": "string",
    "createdAt": "string (ISO 8601)",
    "settings": {
        "preferredCurrency": "string",
        "notificationsEnabled": "boolean",
        "theme": "string"
    },
    "token": "string (JWT)"
}
\`\`\`

#### POST /api/v1/auth/login
Kullanıcı girişi yapar.

Request:
\`\`\`json
{
    "email": "string",
    "password": "string"
}
\`\`\`

Response (200 OK):
\`\`\`json
{
    "token": "string (JWT)",
    "user": {
        "id": "string (UUID)",
        "email": "string",
        "name": "string",
        "settings": {
            "preferredCurrency": "string",
            "notificationsEnabled": "boolean",
            "theme": "string"
        }
    }
}
\`\`\`

#### POST /api/v1/auth/logout
Kullanıcı oturumunu sonlandırır.

Headers:
\`\`\`
Authorization: Bearer {token}
\`\`\`

Response (200 OK):
\`\`\`json
{
    "message": "Logged out successfully"
}
\`\`\`

#### POST /api/v1/auth/reset-password
Şifre sıfırlama isteği gönderir.

Request:
\`\`\`json
{
    "email": "string"
}
\`\`\`

Response (200 OK):
\`\`\`json
{
    "message": "Password reset email sent"
}
\`\`\`

#### GET /api/v1/auth/me
Mevcut kullanıcı bilgilerini getirir.

Headers:
\`\`\`
Authorization: Bearer {token}
\`\`\`

Response (200 OK):
\`\`\`json
{
    "id": "string (UUID)",
    "email": "string",
    "name": "string",
    "profileImage": "string (URL)",
    "createdAt": "string (ISO 8601)",
    "settings": {
        "preferredCurrency": "string",
        "notificationsEnabled": "boolean",
        "theme": "string"
    }
}
\`\`\`

### Ana Sayfa Verileri

#### GET /api/v1/dashboard/summary
Ana sayfa özet verilerini getirir.

Headers:
\`\`\`
Authorization: Bearer {token}
\`\`\`

Query Parameters:
\`\`\`
timeRange: string (today|week|month|year), default: month
currency: string (ISO 4217), default: user's preferred currency
\`\`\`

Response (200 OK):
\`\`\`json
{
    "balance": {
        "total": "number",
        "currency": "string",
        "lastUpdated": "string (ISO 8601)"
    },
    "income": {
        "total": "number",
        "count": "number"
    },
    "expenses": {
        "total": "number",
        "count": "number"
    },
    "trend": {
        "percentage": "number",
        "direction": "string (up|down)"
    }
}
\`\`\`

#### GET /api/v1/transactions/recent
Son işlemleri getirir.

Headers:
\`\`\`
Authorization: Bearer {token}
\`\`\`

Query Parameters:
\`\`\`
limit: number (default: 10, max: 50)
offset: number (default: 0)
type: string (income|expense|all), default: all
\`\`\`

Response (200 OK):
\`\`\`json
{
    "transactions": [{
        "id": "string (UUID)",
        "amount": "number",
        "currency": "string",
        "type": "string (income|expense)",
        "category": {
            "id": "string (UUID)",
            "name": "string",
            "icon": "string"
        },
        "date": "string (ISO 8601)",
        "note": "string"
    }],
    "pagination": {
        "total": "number",
        "limit": "number",
        "offset": "number",
        "hasMore": "boolean"
    }
}
\`\`\`

#### GET /api/v1/spending/categories
Kategori bazlı harcama analizini getirir.

Headers:
\`\`\`
Authorization: Bearer {token}
\`\`\`

Query Parameters:
\`\`\`
timeRange: string (week|month|year), default: month
currency: string (ISO 4217), default: user's preferred currency
\`\`\`

Response (200 OK):
\`\`\`json
{
    "categories": [{
        "id": "string (UUID)",
        "name": "string",
        "icon": "string",
        "color": "string (hex)",
        "amount": "number",
        "percentage": "number",
        "trend": {
            "percentage": "number",
            "direction": "string (up|down)"
        }
    }],
    "total": "number",
    "currency": "string"
}
\`\`\`

#### GET /api/v1/spending/monthly
Aylık harcama verilerini getirir.

Headers:
\`\`\`
Authorization: Bearer {token}
\`\`\`

Query Parameters:
\`\`\`
months: number (default: 12, max: 24)
currency: string (ISO 4217), default: user's preferred currency
\`\`\`

Response (200 OK):
\`\`\`json
{
    "months": [{
        "month": "string (YYYY-MM)",
        "income": "number",
        "expenses": "number",
        "savings": "number"
    }],
    "currency": "string"
}
\`\`\`

## Hata Yanıtları

Tüm endpoint'ler için standart hata yanıtı formatı:

\`\`\`json
{
    "error": {
        "code": "string",
        "message": "string",
        "details": "object (optional)"
    }
}
\`\`\`

Yaygın Hata Kodları:
- 400: Bad Request - İstek parametreleri geçersiz
- 401: Unauthorized - Kimlik doğrulama gerekli
- 403: Forbidden - Yetkisiz erişim
- 404: Not Found - Kaynak bulunamadı
- 422: Unprocessable Entity - İş mantığı hatası
- 429: Too Many Requests - Rate limit aşıldı
- 500: Internal Server Error - Sunucu hatası

## Güvenlik Gereksinimleri
- Tüm API istekleri SSL/TLS üzerinden yapılmalı
- Hassas veriler cihazda şifrelenmiş olarak saklanmalı
- Oturum tokenları güvenli bir şekilde yönetilmeli
- Rate limiting uygulanmalı

## Test Gereksinimleri
- Kullanıcı kayıt/giriş akışları için unit testler
- Ana sayfa veri gösterimi için integration testler
- UI testleri için SwiftUI preview'ları
- Güvenlik testleri (penetrasyon testi)

## Aşamalar
1. Kullanıcı yönetimi altyapısı
2. Ana sayfa UI bileşenleri
3. API entegrasyonları
4. Veri persistence katmanı
5. Test ve optimizasyon

## Zaman Tahmini
- Kullanıcı Yönetimi: 1 hafta
- Ana Sayfa UI: 1 hafta
- API Entegrasyonları: 1 hafta
- Test ve Optimizasyon: 1 hafta

Toplam: ~4 hafta

## Riskler
- Sosyal medya entegrasyonlarında yaşanabilecek API değişiklikleri
- Kullanıcı verilerinin güvenliği
- Performans optimizasyonu gereksinimleri

## Alternatifler
- Firebase Authentication kullanımı
- SwiftUI yerine UIKit
- Realm yerine CoreData

## Referanslar
- [Apple Authentication Services](https://developer.apple.com/documentation/authenticationservices)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [JWT Authentication Best Practices](https://auth0.com/blog/jwt-authentication-best-practices/) 