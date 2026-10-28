# Clean Architecture - CineRating

## Estrutura de Diretórios

```
lib/
├── domain/                    # Camada de Domínio (Regras de Negócio)
│   ├── entities/             # Entidades do domínio
│   │   ├── user.dart
│   │   ├── movie.dart
│   │   └── tv_show.dart
│   ├── repositories/         # Interfaces de repositórios (abstratas)
│   │   ├── auth_repository.dart
│   │   ├── movie_repository.dart
│   │   └── tv_repository.dart
│   └── usecases/             # Casos de uso (lógica de negócio)
│       ├── login_usecase.dart
│       ├── get_movies_usecase.dart
│       ├── search_movies_usecase.dart
│       ├── get_tv_shows_usecase.dart
│       └── search_tv_shows_usecase.dart
│
├── data/                     # Camada de Dados (Implementação)
│   ├── datasources/          # Fontes de dados (API, Local)
│   │   ├── auth_remote_datasource.dart
│   │   ├── auth_remote_datasource_impl.dart
│   │   ├── movie_remote_datasource.dart
│   │   ├── movie_remote_datasource_impl.dart
│   │   ├── tv_remote_datasource.dart
│   │   └── tv_remote_datasource_impl.dart
│   ├── models/               # Models DTOs (Data Transfer Objects)
│   │   ├── crew_model.dart
│   │   ├── movie_detail_model.dart
│   │   ├── movie_simple_model.dart
│   │   ├── tv_crew_model.dart
│   │   ├── tv_show_model.dart
│   │   └── user_model.dart
│   └── repositories/         # Implementações de repositórios
│       ├── auth_repository_impl.dart
│       ├── movie_repository_impl.dart
│       └── tv_repository_impl.dart
│
├── presentation/             # Camada de Apresentação (UI)
│   ├── bloc/                # Blocs/Cubits (ainda em core/logic/cubit por compatibilidade)
│   ├── controllers/         # Controllers
│   ├── pages/               # Páginas (ainda em views por compatibilidade)
│   └── widgets/             # Widgets reutilizáveis
│
├── core/                     # Configurações e utilitários globais
│   ├── locator.dart         # Service Locator (Get It)
│   ├── services/            # Serviços legados (serão removidos gradualmente)
│   └── logic/               # Blocs/Cubits
│
├── shared/                   # Recursos compartilhados
│   ├── themes/              # Temas
│   └── env.dart             # Variáveis de ambiente
│
└── main.dart                # Ponto de entrada
```

## Fluxo de Dados

```
Presentation (UI)
    ↓ (chama)
Use Cases
    ↓ (chama)
Repositories (Interfaces)
    ↓ (implementado por)
Repository Implementations
    ↓ (usa)
DataSources
    ↓ (retorna)
Models (DTOs)
    ↓ (converte para)
Entities
```

## Exemplo de Fluxo: Login

1. **Presentation**: `LoginController` chama `LoginUseCase`
2. **Domain**: `LoginUseCase` chama `AuthRepository` (interface)
3. **Data**: `AuthRepositoryImpl` implementa `AuthRepository`
4. **Data**: `AuthRepositoryImpl` usa `AuthRemoteDataSource`
5. **Data**: `AuthRemoteDataSourceImpl` faz requisição HTTP
6. **Data**: Retorna `UserModel` (DTO)
7. **Data**: `AuthRepositoryImpl` converte para `User` (Entity)
8. **Domain**: `LoginUseCase` retorna `User` (Entity)
9. **Presentation**: `LoginController` recebe `User` e atualiza UI

## Benefícios

### 1. Separação de Responsabilidades
- Cada camada tem uma responsabilidade específica
- Domain não depende de frameworks (Flutter, Dio, etc.)
- Data lida apenas com fontes de dados
- Presentation lida apenas com UI

### 2. Testabilidade
- **Domain**: Testes unitários sem dependências externas
- **Data**: Testes com mocks de datasources
- **Presentation**: Testes com mocks de use cases

### 3. Manutenibilidade
- Mudanças na API afetam apenas Data layer
- Mudanças na UI afetam apenas Presentation layer
- Regras de negócio ficam isoladas no Domain

### 4. Escalabilidade
- Fácil adicionar novas features
- Fácil trocar implementações (ex: mudar de Dio para outra lib HTTP)
- Fácil adicionar caching, logging, etc.

## Próximos Passos

1. ❌ Remover serviços legados (`AuthService`, `MovieService`, `TvService`)
2. ❌ Mover controllers para `presentation/controllers`
3. ❌ Mover views para `presentation/pages`
4. ❌ Mover widgets para `presentation/widgets`
5. ❌ Mover blocs/cubits para `presentation/bloc`
6. ❌ Adicionar use cases para getCurrentUser e logout
7. ❌ Adicionar repository local (SQLite/SharedPreferences)
8. ❌ Adicionar testes unitários

## Legado vs Clean Architecture

### Legado (Antes)
```
Views → Controllers → Services → API
```

### Clean Architecture (Agora)
```
Pages → Controllers → Use Cases → Repositories → DataSources → API
```

## Como Adicionar Nova Feature

1. **Domain**: Criar Entity em `domain/entities/`
2. **Domain**: Criar Repository interface em `domain/repositories/`
3. **Domain**: Criar Use Case em `domain/usecases/`
4. **Data**: Criar DataSource em `data/datasources/`
5. **Data**: Criar Repository implementation em `data/repositories/`
6. **Data**: Criar Model em `data/models/` (se necessário)
7. **Presentation**: Criar Controller/Bloc em `presentation/`
8. **Presentation**: Criar Page em `presentation/pages/`
9. **Core**: Registrar tudo no `locator.dart`
