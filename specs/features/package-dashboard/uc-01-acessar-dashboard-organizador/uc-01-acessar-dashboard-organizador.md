# UC-01 - Acessar Dashboard do Organizador

- **Ator Principal:** Organizador - Usuário que acessa o painel do Linka Eventos para acompanhar dados de seus eventos.
- **Atores Secundários:** Sistema (React Query) para atualização automática dos dados.
- **Resumo:** Este caso de uso representa o processo pelo qual um Organizador acessa o dashboard do painel do Organizador no Linka Eventos. O Organizador seleciona a opção "Dashboard" no menu lateral e o sistema exibe uma tela com cards e gráficos mostrando os dados do evento atualmente selecionado: total de inscrições, vendas realizadas, check-ins feitos e receita gerada. Os dados são atualizados automaticamente via polling.

- **Pré-condições:**
  - Organizador deve estar autenticado no sistema
  - Organizador deve ter pelo menos um evento ativo
  - Evento deve estar selecionado no contexto atual

- **Pós-condições:**
  - Dashboard exibido com dados atualizados do evento
  - Atualização automática dos dados continua em background

---

## Cenário Principal

| Ações do Ator | Ações do Sistema |
|---------------|------------------|
| 1. Acessa o painel do Organizador | 1. Exibe menu lateral com opção "Dashboard" |
| 2. Clica na opção "Dashboard" | 2. Carrega o componente Dashboard via `package-dashboard` |
| | 3. Exibe estado de loading |
| | 4. Busca dados de inscrições, vendas, check-ins e receita via API |
| | 5. Renderiza 4 cards com os dados |
| 6. Visualiza os dados | 6. Inicia polling para atualização automática |

---

## Restrições/Validações

1. Os dados exibidos devem corresponder exclusivamente ao **evento selecionado** no contexto atual
2. Os dados exibidos são: **Inscrições**, **Vendas**, **Check-ins** e **Receita**
3. Atualização dos dados ocorre via **polling** (React Query com `refetchInterval`)
4. Tempo de carregamento deve ser inferior a **3 segundos**
5. Em caso de erro na API, exibir mensagem de erro amigável com opção de retry

---

## Cenário Alternativo

**Cenário A: Sem eventos ativos**

| Ações do Ator | Ações do Sistema |
|---------------|------------------|
| 1. Acessa o painel | 1. Verifica que não há eventos ativos |
| | 2. Exibe mensagem "Nenhum evento ativo" |
| | 3. Não exibe cards de dados |

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

1. **Desempenho:** Tempo de carregamento inicial < 3 segundos
2. **Disponibilidade:** Dashboard deve estar disponível 99.9% do tempo
3. **Responsividade:** Interface deve funcionar em diferentes tamanhos de tela
4. **Acessibilidade:** Navegação por teclado e leitores de tela compatíveis

---

## Critérios de Aceite

- [ ] Menu lateral exibe opção "Dashboard" quando Organizador está autenticado
- [ ] Click na opção "Dashboard" carrega o componente do `package-dashboard`
- [ ] Exibe 4 cards: Inscrições, Vendas, Check-ins, Receita
- [ ] Dados correspondem ao evento selecionado no contexto
- [ ] Dados são atualizados automaticamente via polling
- [ ] Mensagem de erro exibida em caso de falha na API
- [ ] Opção de retry disponível após falha
