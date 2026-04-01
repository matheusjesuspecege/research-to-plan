# UC-04 - Integrar Package no Organizer

- **Caso de Uso Geral:** -
- **Ator Principal:** Desenvolvedor
- **Atores Secundários:** -
- **Resumo:** Este caso de uso representa o processo de integração do package `@linka/ui` no app Organizer. O objetivo é substituir o dashboard local pela versão do package, mantendo os hooks de data fetching existentes no Organizer.
- **Pré-condições:** Package `@linka/ui` com `DashboardPage` disponível (UC-03). App Organizer configurado.
- **Pós-condições:** Organizer usando `DashboardPage` do package.

### Cenário Principal

| Ações do Ator | Ações do Sistema |
|---------------|------------------|
| 1. Instalar `@linka/ui` como dependência no Organizer | |
| 2. Identificar imports do dashboard atual | |
| 3. Substituir imports locais por `@linka/ui/pages/Dashboard` | |
| 4. Adaptar componente para usar `DashboardPage` com eventId | |
| 5. Manter hooks existentes em `apps/organizer/src/ui/hooks/` | |
| 6. Manter services de API em `apps/organizer/src/api/` | |
| 7. Executar build do Organizer | Valida integração |
| 8. Testar aplicação localmente | |

### Caminho de Import

```typescript
// Antes (dashboard local)
import { Dashboard } from './ui/pages/dashboard';

// Depois (package)
import { DashboardPage } from '@linka/ui/pages/Dashboard';
```

### Restrições/Validações

- Hooks de data fetching devem permanecer no Organizer
- Services de API devem permanecer no Organizer
- O acesso pelo menu lateral deve continuar idêntico

### Cenário Alternativo

| # | Condição | Ação |
|---|----------|------|
| 1 | Dashboard tem funcionalidades extras | Adicionar via props ou extender componente |

### Cenário de Exceção

| # | Condição | Ação |
|---|----------|------|
| 1 | Build falha por conflito de dependências | Ajustar versões no root do monorepo |
| 2 | Funcionalidade breaking | Avaliar manutenção local temporária |

### Requisitos Não-Funcionais

- **Transparência:** Usuário não deve perceber mudança除除
- **Performance:** Tempo de carregamento deve ser equivalente ou melhor

---

## Critérios de Aceite

- [ ] `@linka/ui` instalado no Organizer
- [ ] Imports do dashboard substituídos
- [ ] Hooks mantidos no Organizer
- [ ] Build do Organizer executa com sucesso
- [ ] Dashboard acessível pelo menu lateral
- [ ] Dados exibidos corretamente (não-regressão)
