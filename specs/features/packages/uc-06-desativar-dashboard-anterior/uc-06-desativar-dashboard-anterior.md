# UC-06 - Desativar Dashboard Anterior no Organizer

- **Caso de Uso Geral:** -
- **Ator Principal:** Desenvolvedor
- **Atores Secundários:** -
- **Resumo:** Este caso de uso representa o processo de desativação do dashboard local anterior no Organizer após a migração bem-sucedida para o package `@linka/ui`. O dashboard anterior deixará de ser renderizado em qualquer contexto da plataforma.
- **Pré-condições:** Integração do package no Organizer concluída (UC-04). Todas as funcionalidades validadas.
- **Pós-condições:** Dashboard local anterior removido ou desativado.

### Cenário Principal

| Ações do Ator | Ações do Sistema |
|---------------|------------------|
| 1. Verificar que todas as funcionalidades estão disponíveis no novo dashboard | |
| 2. Identificar código do dashboard anterior | |
| 3. Remover ou comentar imports do dashboard antigo | |
| 4. Garantir que rota still aponta para mesma URL | |
| 5. Executar build final | |
| 6. Testar em ambiente de staging | |

### Localização do Dashboard Anterior

```
apps/organizer/src/ui/pages/dashboard/
```

### Restrições/Validações

- O novo dashboard deve ocupar exatamente o mesmo ponto de acesso
- Todas as informações anteriormente exibidas devem estar disponíveis

### Cenário Alternativo

| # | Condição | Ação |
|---|----------|------|
| 1 | Funcionalidade ainda não migrada | Manter temporariamente até migração completa |

### Cenário de Exceção

| # | Condição | Ação |
|---|----------|------|
| 1 | Falha em produção após desativação | Reverter para versão anterior |
| 2 | Usuário reporta problema | Restaurar temporariamente e investigar |

### Requisitos Não-Funcionais

- ** atomicidade:** Substituição deve ser atômica
- **Disponibilidade:** Sem período de indisponibilidade

---

## Critérios de Aceite

- [ ] Todas funcionalidades do dashboard antigo disponíveis no novo
- [ ] Rota mantida (mesmo endpoint)
- [ ] Dashboard local removido ou desativado
- [ ] Código não utilizado removido
- [ ] Build executa com sucesso
- [ ] Deploy em produção sem incidentes
