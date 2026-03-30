# UC-02 - Acessar Dashboard do Backoffice

- **Ator Principal:** Backoffice - Sistema administrativo que utiliza o `package-dashboard` para exibir dados de gestão.
- **Atores Secundários:** Sistema (React Query) para atualização automática dos dados.
- **Resumo:** Este caso de uso representa o processo pelo qual o Backoffice acessa o dashboard através do `package-dashboard` compartilhado. O Backoffice substitui o PowerBI pelo novo dashboard nativo, mantendo a mesma estrutura visual e funcionalidades, mas agora utilizando o package compartilhado do monorepo.

- **Pré-condições:**
  - Backoffice deve estar autenticado
  - `package-dashboard` deve estar instalado e importado no projeto Backoffice

- **Pós-condições:**
  - Dashboard exibido com dados específicos do contexto Backoffice
  - Atualização automática dos dados continua em background

---

## Cenário Principal

| Ações do Ator | Ações do Sistema |
|---------------|------------------|
| 1. Acessa o painel do Backoffice | 1. Exibe menu lateral com opção "Dashboard" |
| 2. Clica na opção "Dashboard" | 2. Carrega o componente Dashboard via `package-dashboard` |
| | 3. Exibe estado de loading |
| | 4. Busca dados de inscrições, vendas, check-ins e receita via API |
| | 5. Renderiza 4 cards com os dados |
| 6. Visualiza os dados | 6. Inicia polling para atualização automática |

---

## Restrições/Validações

1. O Backoffice utiliza o **mesmo** `package-dashboard` do Organizador
2. Os dados exibidos são: **Inscrições**, **Vendas**, **Check-ins** e **Receita**
3. A estrutura visual é **idêntica** ao dashboard do Organizador
4. Atualização dos dados ocorre via **polling** (React Query com `refetchInterval`)
5. Em caso de erro na API, exibir mensagem de erro amigável com opção de retry

---

## Cenário Alternativo

**Cenário A: Package não disponível**

| Ações do Ator | Ações do Sistema |
|---------------|------------------|
| 1. Tenta acessar Dashboard | 1. Verifica que `package-dashboard` não está disponível |
| | 2. Exibe mensagem de erro de configuração |
| | 3. Registra erro no sistema de logging |

---

## Cenário de Exceção

**Exceção 1: Falha na API**

| Ações do Ator | Ações do Sistema |
|---------------|------------------|
| | 1. Tenta buscar dados da API |
| | 2. API retorna erro (5xx) |
| | 3. Exibe mensagem de erro com botão "Tentar novamente" |
| | 4. Aguarda ação do usuário |

---

## Requisitos Não-Funcionais

1. **Consistência:** Interface idêntica ao dashboard do Organizador
2. **Desempenho:** Tempo de carregamento inicial < 3 segundos
3. **Manutenibilidade:** Uma única base de código para ambos os dashboards

---

## Critérios de Aceite

- [ ] Menu lateral do Backoffice exibe opção "Dashboard"
- [ ] Click na opção "Dashboard" carrega o `package-dashboard`
- [ ] Exibe 4 cards: Inscrições, Vendas, Check-ins, Receita
- [ ] Estrutura visual idêntica ao dashboard do Organizador
- [ ] Dados são específicos do contexto Backoffice
- [ ] Dados são atualizados automaticamente via polling
- [ ] Mensagem de erro exibida em caso de falha na API
- [ ] Opção de retry disponível após falha
