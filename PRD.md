# Rules for AI

These rules get shown to the AI on all chats and Command-K sessions.

You are an expert AI programmer assistant with 200 IQ
- Follow the user's requirements carefully & to the letter
- First think step-by-step - describe your plan for what to build in pseudocode, written out in great detail
- Explain it with gradually increasing complexity
- Visualize the state after each reasoning step
- Always read and update from project_progress.md 

# BudgetBuddy PRD

## 1. Giriş
BudgetBuddy, kullanıcıların kişisel finansal durumlarını yönetmelerine, bütçe oluşturup takip etmelerine ve finansal farkındalıklarını artırmalarına yardımcı olan bir mobil ve web uygulamasıdır. Bu doküman, uygulamanın fonksiyonel ve teknik gereksinimlerini, tasarlanan kullanıcı deneyimini ve projenin genel hedeflerini tanımlar.

---

## 2. Amaç ve Hedefler

1. **Kişisel Finans Yönetimi**  
   - Günlük, haftalık ve aylık harcamaların pratik takibini sağlamak  
   - Finansal farkındalığı artırmak

2. **Bilinçli Harcama**  
   - Gelir-gider analizi, tasarruf hedefleri ve finansal planlama araçlarını kullanıcılara sunmak  
   - Kullanıcıların harcama alışkanlıklarını gözden geçirip iyileştirmelerine olanak tanımak

3. **Hedef Odaklı Tasarruf**  
   - Kısa ve uzun vadeli finansal hedefler için bir planlama altyapısı oluşturmak  
   - Birikim hedeflerine ulaşmayı teşvik eden bildirim ve öneriler sunmak

4. **Kolay Erişim ve Etkileşim**  
   - Hem mobil hem de web platformlarından rahat erişilebilen, kullanıcı dostu arayüzler sağlamak  
   - Her yerden finansal durumun kontrol edilebilmesini sağlamak

5. **Bireysel Finansal Sağlamlık**  
   - Kullanıcının uzun vadede finansal sağlığını iyileştirmek  
   - Borç yükünü azaltıcı tavsiyeler ve araçlar sunmak

---

## 3. Kapsam

- Uygulama, kişisel finans yönetimine odaklanmakla birlikte, aile/ortak hesap yönetimi (opsiyonel) gibi ileri seviye özellikleri barındırabilir.  
- Bireysel kullanıcılara ek olarak, küçük ölçekli ekip veya aile gruplarının da ortak bütçe yönetimi için kullanabileceği bir altyapı sağlanabilir.  
- Temel ürün, gelir-gider takibi, hedef belirleme, raporlar, banka entegrasyonu ve bildirim sistemlerinden oluşacaktır.

---

## 4. Proje Paydaşları

| Paydaş               | Rol ve Sorumluluk                                           |
|----------------------|-------------------------------------------------------------|
| **Ürün Sahibi (PO)** | Uygulamanın stratejik hedeflerini ve önceliklerini belirler |
| **Proje Yöneticisi** | Zaman çizelgesi, bütçe ve proje yönetimini üstlenir         |
| **Geliştirme Ekibi** | Frontend, backend ve mobil uygulama geliştirmeden sorumludur|
| **Tasarım Ekibi**    | Kullanıcı deneyimi ve arayüz tasarımını yapar               |
| **QA/Test Ekibi**    | Uygulamanın test süreçleri ve kalite kontrolünden sorumlu   |
| **Kullanıcılar**     | Bireysel veya aile olarak uygulamayı kullanacak son kullanıcılar |

---

## 5. Kullanıcı Hikayeleri

1. **Yeni Kayıt**  
   > “Bir kullanıcı olarak, uygulamaya e-posta adresim veya sosyal medya hesabımla hızlıca kaydolabilmek istiyorum; böylece harcamalarımı takip etmeye hemen başlayabilirim.”  

2. **Gelir ve Gider Girme**  
   > “Bir kullanıcı olarak, günlük harcamalarımı birkaç dokunuşla eklemek ve kategorize etmek istiyorum; böylece hangi kategoride ne kadar harcadığımı görebilirim.”  

3. **Finansal Hedef Belirleme**  
   > “Bir kullanıcı olarak, gelecek yaz tatili için birikim yapmak istiyorum; bu nedenle aylık veya haftalık ne kadar birikim yapmam gerektiğini gösteren bir hedef belirleme özelliğine ihtiyacım var.”  

4. **Banka Entegrasyonu**  
   > “Bir kullanıcı olarak, manuel veri girmekle uğraşmadan, banka hesap hareketlerimi uygulamaya otomatik olarak aktarabilmek istiyorum; böylece gerçek zamanlı olarak bakiyemi ve gider kalemlerimi görebilirim.”  

5. **Bütçe Raporları ve Analizler**  
   > “Bir kullanıcı olarak, aylık gider dağılımımı grafikler halinde görmek ve önceki aylarla kıyaslamak istiyorum; böylece hangi kategoride tasarruf edebileceğimi anlayabilirim.”  

6. **Bildirim ve Hatırlatmalar**  
   > “Bir kullanıcı olarak, borç ödeme tarihlerim veya bütçe hedeflerime yaklaştığım anlarda uygulamanın beni uyarmasını istiyorum; böylece finansal kayıplar veya gecikmeler yaşamam.”  

7. **Çoklu Para Birimi Desteği**  
   > “Yurt dışında çalışan bir kullanıcı olarak, birden fazla para biriminde gelir ve gider eklemek istiyorum; böylece farklı para birimlerindeki kazançlarımı ve giderlerimi tek bir yerde yönetebilirim.”  

8. **Ekip/Kullanıcı Paylaşımı** *(Opsiyonel)*  
   > “Bir aile olarak, ortak bir bütçeye katkı sağlamak ve harcamaları şeffaf biçimde yönetmek istiyoruz; bu nedenle uygulamada birkaç hesap arasında veri paylaşımı yapabilmeliyiz.”  

---

## 6. Gereksinimler

### 6.1 Fonksiyonel Gereksinimler

1. **Kullanıcı Yönetimi**  
   - Kullanıcı kaydı (e-posta veya sosyal medya hesabı)  
   - Giriş yapma ve çıkış yapma  
   - Parola sıfırlama  
   - Profil bilgileri düzenleme  

2. **Gelir & Gider İşlemleri**  
   - Manuel gelir/gider ekleme  
   - Gelir/gider kategorileri oluşturma ve düzenleme  
   - Otomatik banka entegrasyonu (API veya CSV/Excel yükleme)  

3. **Bütçe Oluşturma ve Takip**  
   - Aylık/haftalık bütçe belirleme  
   - Bütçe hedeflerine ulaşma durumu takibi  
   - Harcama limitleri aşıldığında veya yaklaşırken uyarılar  

4. **Raporlar & Analizler**  
   - Anlık gösterge paneli (dashboard)  
   - Kategori bazlı harcama grafikleri  
   - Zaman bazlı (haftalık, aylık, yıllık) gelir/gider analizi  
   - Dönemsel karşılaştırma raporları  

5. **Finansal Hedef Yönetimi**  
   - Kısa ve uzun vadeli hedefler belirleme  
   - Hedefe kalan süre ve gereken tasarruf miktarı hesaplama  
   - Hedef tutarlarına göre otomatik tasarruf önerileri  

6. **Bildirim Sistemi**  
   - Harcama sınırına yaklaşıldığında bildirim  
   - Ödeme ve borç hatırlatmaları  
   - Hedef güncelleme ve tamamlanmaya yakın olduğunda uyarı  

7. **Çoklu Para Birimi Desteği** *(Opsiyonel)*  
   - Farklı para birimleri arasında otomatik veya manuel kur dönüştürme  
   - Döviz kuru güncellemeleri  

8. **Veri Güvenliği & Yedekleme**  
   - SSL/TLS şifrelemeli veri aktarımı  
   - Düzenli veri yedekleme  
   - İki faktörlü kimlik doğrulama (2FA) (Opsiyonel)  

### 6.2 Teknik Gereksinimler

1. **Platform & Teknolojiler**  
   - **Web Uygulaması**: React, Vue veya Angular gibi bir frontend framework’ü  
   - **Mobil Uygulama**: React Native veya Flutter  
   - **Sunucu Tarafı**: Node.js (Express.js veya Nest.js), Python (Django veya Flask) vb.  
   - **Veritabanı**: SQL (PostgreSQL/MySQL) veya NoSQL (MongoDB)  

2. **Banka Entegrasyonu & Ödeme API’leri**  
   - Banka API’leri veya entegrasyon servisleri (Plaid vb.)  
   - CSV/Excel dosyası import özelliği  

3. **Güvenlik & Kimlik Doğrulama**  
   - OAuth 2.0 veya benzeri standart kimlik doğrulama protokolü  
   - SSL/TLS sertifikaları ile veri şifreleme  
   - Düzenli veri yedekleme ve saklama politikası  

4. **Bulut Altyapısı & Dağıtım**  
   - AWS, Azure veya Google Cloud gibi servisler  
   - CI/CD araçları (GitHub Actions, Jenkins, GitLab CI vb.)  
   - Yatay ve dikey ölçeklenebilir mimari  

5. **Analitik & Raporlama**  
   - Google Analytics veya benzeri kullanıcı davranış izleme araçları  
   - BI araçlarıyla (Tableau, Power BI) gelişmiş raporlama *(Opsiyonel)*  

6. **Uygulama İçi Bildirim Altyapısı**  
   - E-posta bildirimleri için Mailgun, SendGrid vb.  
   - Push bildirimleri için Firebase Cloud Messaging (FCM) veya benzeri servis  

7. **Performans ve Ölçeklenebilirlik**  
   - Caching stratejileri (Redis vb.)  
   - Load balancer kullanımı  
   - Mikro servis mimarisi *(Opsiyonel, proje büyüklüğüne göre)*  

---

## 7. Başarı Kriterleri (Success Metrics)

- **Aktif Kullanıcı Sayısı (MAU)**: Uygulamanın aylık aktif kullanıcı sayısı  
- **Günlük İşlem Adedi**: Günlük eklenen gelir-gider işlemlerinin sayısı  
- **Kullanıcı Memnuniyeti**: Uygulama içi geri bildirimler, App Store/Play Store puanları  
- **Hedef Tamamlama Oranı**: Kullanıcıların belirledikleri hedefleri tamamlama yüzdesi  
- **Kullanıcı Tutundurma Oranı (Retention)**: Kullanıcıların uygulamayı tekrar ziyaret etme sıklığı  
- **Entegrasyon Oranı**: Banka entegrasyonunu aktif olarak kullanan kullanıcı sayısı  

---

## 8. Zaman Çizelgesi (Roadmap)

| Aşama                                  | Süre           | Görevler                                                                                      |
|----------------------------------------|---------------|-----------------------------------------------------------------------------------------------|
| **Araştırma & Tasarım**               | 2-4 Hafta     | Pazar araştırması, Wireframe’ler, UX/UI tasarımları                                           |
| **Prototip ve MVP**                   | 4-6 Hafta     | Temel kullanıcı yönetimi, gelir-gider ekleme, basit raporlar                                  |
| **Bankacılık Entegrasyonu**           | 2-4 Hafta     | Banka API’leri entegrasyonu, CSV/Excel import özelliği                                        |
| **Gelişmiş Raporlama & Bildirimler**  | 2-3 Hafta     | Kategori bazlı grafikler, ödeme hatırlatmaları, anlık uyarılar                                |
| **Test & QA Süreci**                  | Devamlı       | Unit test, entegrasyon testleri, kullanıcı kabul testleri                                     |
| **Lansman**                            | Yol Haritasına göre | Ürünün ilk sürümünün canlıya alınması                                                        |
| **Sürekli İyileştirme**               | Lansman sonrası | Kullanıcı geribildirimlerine göre yeni özellikler, iyileştirmeler, performans optimizasyonu   |

---

## 9. Riskler ve Varsayımlar

1. **Bankacılık Entegrasyon Riskleri**  
   - Yerel bankaların API sunmaması veya entegrasyon süreçlerinde yaşanabilecek gecikmeler  
   - Farklı ülkelerdeki regülasyon ve entegrasyon gereksinimleri

2. **Güvenlik Endişeleri**  
   - Kişisel finansal verilerin korunması ve yasal mevzuata uyum (KVKK, GDPR vb.)  
   - Veri sızıntıları veya DDoS saldırılarına karşı ek önlemler

3. **Ölçeklenebilirlik Varsayımları**  
   - Başlangıçta kullanıcı tabanı düşük olsa da, ürün başarı kazandıkça artabilecek yüksek trafikle başa çıkabilmek için bulut tabanlı mimari kullanımı

4. **Kullanıcı Adapte Oluş Süresi**  
   - Kişisel finans yönetimi davranışsal bir alışkanlık gerektirir; kullanıcıların düzenli veri girişi yapmaya ikna edilmesi önemli bir zorluktur

---

## 10. Ekler

- Kullanıcı Arayüzü Taslakları (Wireframe veya Mockup)  
- Örnek API Dokümantasyonu (Banka/ödeme entegrasyonları için)  
- Güvenlik ve Şifreleme Politikaları

---

Bu **PRD** dokümanı, *BudgetBuddy* uygulamasının geliştirme sürecinde tüm paydaşlar için ortak bir referans noktası olarak kullanılacaktır. Gereksinimlerin revize edilmesi veya ek ihtiyaçların doğması halinde bu doküman güncellenmelidir.