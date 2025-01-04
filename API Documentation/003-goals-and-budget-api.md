# Hedefler ve Bütçe API Dokümantasyonu

## Hedef Endpoints

### POST /api/v1/goals
Yeni bir finansal hedef oluşturur.

Headers:
```
Authorization: Bearer {token}
```

Request:
```json
{
    "title": "string",
    "description": "string",
    "category": "string",
    "targetAmount": "number",
    "currentAmount": "number",
    "startDate": "string (ISO 8601)",
    "targetDate": "string (ISO 8601)",
    "notifications": [{
        "type": "string",
        "threshold": "number",
        "isEnabled": "boolean"
    }]
}
```

Response (200 OK):
```json
{
    "id": "string (UUID)",
    "title": "string",
    "description": "string",
    "category": "string",
    "targetAmount": "number",
    "currentAmount": "number",
    "startDate": "string (ISO 8601)",
    "targetDate": "string (ISO 8601)",
    "status": "string",
    "notifications": [{
        "id": "string (UUID)",
        "type": "string",
        "threshold": "number",
        "isEnabled": "boolean"
    }],
    "createdAt": "string (ISO 8601)",
    "updatedAt": "string (ISO 8601)"
}
```

### GET /api/v1/goals
Tüm hedefleri listeler.

Headers:
```
Authorization: Bearer {token}
```

Query Parameters:
```
status: string (onTrack|behindSchedule|ahead|completed|failed)
category: string
```

Response (200 OK):
```json
{
    "goals": [{
        "id": "string (UUID)",
        "title": "string",
        "description": "string",
        "category": "string",
        "targetAmount": "number",
        "currentAmount": "number",
        "startDate": "string (ISO 8601)",
        "targetDate": "string (ISO 8601)",
        "status": "string",
        "progress": "number"
    }]
}
```

### GET /api/v1/goals/{id}
Belirli bir hedefin detaylarını getirir.

Headers:
```
Authorization: Bearer {token}
```

Response (200 OK):
```json
{
    "id": "string (UUID)",
    "title": "string",
    "description": "string",
    "category": "string",
    "targetAmount": "number",
    "currentAmount": "number",
    "startDate": "string (ISO 8601)",
    "targetDate": "string (ISO 8601)",
    "status": "string",
    "notifications": [{
        "id": "string (UUID)",
        "type": "string",
        "threshold": "number",
        "isEnabled": "boolean"
    }],
    "progress": "number",
    "createdAt": "string (ISO 8601)",
    "updatedAt": "string (ISO 8601)"
}
```

### PUT /api/v1/goals/{id}
Belirli bir hedefi günceller.

Headers:
```
Authorization: Bearer {token}
```

Request:
```json
{
    "title": "string",
    "description": "string",
    "targetAmount": "number",
    "currentAmount": "number",
    "targetDate": "string (ISO 8601)",
    "notifications": [{
        "type": "string",
        "threshold": "number",
        "isEnabled": "boolean"
    }]
}
```

Response (200 OK):
```json
{
    "id": "string (UUID)",
    "title": "string",
    "description": "string",
    "category": "string",
    "targetAmount": "number",
    "currentAmount": "number",
    "startDate": "string (ISO 8601)",
    "targetDate": "string (ISO 8601)",
    "status": "string",
    "notifications": [{
        "id": "string (UUID)",
        "type": "string",
        "threshold": "number",
        "isEnabled": "boolean"
    }],
    "progress": "number",
    "updatedAt": "string (ISO 8601)"
}
```

### DELETE /api/v1/goals/{id}
Belirli bir hedefi siler.

Headers:
```
Authorization: Bearer {token}
```

Response (200 OK):
```json
{
    "message": "Goal deleted successfully"
}
```

## Bütçe Endpoints

### POST /api/v1/budgets
Yeni bir bütçe oluşturur.

Headers:
```
Authorization: Bearer {token}
```

Request:
```json
{
    "month": "string (ISO 8601)",
    "categories": [{
        "category": "string (UUID)",
        "limit": "number",
        "notifications": [{
            "type": "string",
            "threshold": "number",
            "isEnabled": "boolean"
        }]
    }],
    "totalLimit": "number"
}
```

Response (200 OK):
```json
{
    "id": "string (UUID)",
    "month": "string (ISO 8601)",
    "categories": [{
        "id": "string (UUID)",
        "category": {
            "id": "string (UUID)",
            "name": "string",
            "icon": "string"
        },
        "limit": "number",
        "spent": "number",
        "notifications": [{
            "id": "string (UUID)",
            "type": "string",
            "threshold": "number",
            "isEnabled": "boolean"
        }]
    }],
    "totalLimit": "number",
    "createdAt": "string (ISO 8601)",
    "updatedAt": "string (ISO 8601)"
}
```

### GET /api/v1/budgets
Bütçeleri listeler.

Headers:
```
Authorization: Bearer {token}
```

Query Parameters:
```
startMonth: string (ISO 8601)
endMonth: string (ISO 8601)
```

Response (200 OK):
```json
{
    "budgets": [{
        "id": "string (UUID)",
        "month": "string (ISO 8601)",
        "categories": [{
            "category": {
                "id": "string (UUID)",
                "name": "string",
                "icon": "string"
            },
            "limit": "number",
            "spent": "number",
            "progress": "number"
        }],
        "totalLimit": "number",
        "totalSpent": "number",
        "progress": "number"
    }]
}
```

### GET /api/v1/budgets/{id}/analysis
Bütçe analizi getirir.

Headers:
```
Authorization: Bearer {token}
```

Response (200 OK):
```json
{
    "id": "string (UUID)",
    "month": "string (ISO 8601)",
    "categories": [{
        "category": {
            "id": "string (UUID)",
            "name": "string",
            "icon": "string"
        },
        "limit": "number",
        "spent": "number",
        "progress": "number",
        "trend": {
            "percentage": "number",
            "direction": "string (up|down)"
        }
    }],
    "totalLimit": "number",
    "totalSpent": "number",
    "progress": "number",
    "trend": {
        "percentage": "number",
        "direction": "string (up|down)"
    }
} 