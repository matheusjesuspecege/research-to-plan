# Research - Checkout

## 1. Contexto do Produto

O Linka Eventos é uma plataforma de gestão e venda de ingressos para eventos. O checkout representa o momento crítico onde a intenção de participação se converte em inscrição concretizada. O processo atual apresenta fragilidades de arquitetura e usabilidade que impactam diretamente na conversão e experiência do usuário.

A plataforma oferece dois tipos de ingresso: **nominal** (vinculado a um participante específico) e **não nominal** (sem vinculação). Além disso, eventos podem ter ingressos pagos ou gratuitos, resultando em quatro combinações de checkout distintas.

A proposta é consolidar o checkout em uma **tela única com rolagem vertical**, organizada em três blocos sequenciais: dados dos participantes, recebimento do ingresso e pagamento. Essa estrutura elimina navegações entre telas e reduz a percepção de complexidade para o participante.

---

## 2. Problema do Negócio

O checkout atual do Linka Eventos apresenta três problemas principais:

1. **Fragmentação de tela**: O processo atual requer navegação entre múltiplas telas, elevando o atrito e abandonos.

2. **Barreira de acesso**: A obrigatoriedade de conta antes da compra é um dos principais fatores de abandono documentado em plataformas de e-commerce e eventos.

3. **Arquitetura frágil**: O processo atual apresenta fragilidades tanto em arquitetura quanto em usabilidade, impactando a eficiência do fluxo e a experiência do usuário.

Essas questões resultam em **perda de conversão**, **abandono de carrinho** e **experiência negativa** para o participante.

---

## 3. Objetivo da Feature

O objetivo desta feature é transformar o checkout do Linka Eventos em referência entre plataformas de eventos, com foco em:

- **Velocidade**: Reduzir etapas obrigatórias ao mínimo necessário
- **Segurança**: Proteger transações e dados dos participantes
- **Usabilidade**: Interface clara com feedback imediato de validações
- **Conversão**: Eliminar barreiras de entrada, especialmente a obrigatoriedade de conta prévia
- **Transparência**: Visualização completa do pedido antes da confirmação

---

## 4. Cenário de Uso

O participante acessa a página de um evento, seleciona os ingressos desejados e inicia o checkout. O sistema exibe uma tela única com três blocos progressivos:

No **Bloco 1** (apenas para checkout nominal), o participante preenche os dados de cada participante conforme o tipo do ingresso. No **Bloco 2**, seleciona quem será o responsável pelo recebimento dos ingressos e aceita os termos. No **Bloco 3**, escolhe o método de pagamento, preenche os dados do comprador e confirma a transação.

Durante todo o processo, um painel lateral exibe o resumo do pedido com valores e um contador regressivo de 15 minutos. Ao concluir, uma conta é criada automaticamente (quando aplicável) e o participante recebe os ingressos por e-mail.

---

## 5. Atores

| Ator | Descrição | Estereótipo |
|------|-----------|-------------|
| **Participante** | Usuário que deseja adquirir ingressos para um evento | — |
| **Organizador** | Responsável pela criação e configuração do evento e ingressos na plataforma | — |
| **Sistema de Pagamento** | Gateway externo que processa transações (Pay) | `<<system>>` |
| **Sistema de E-mail** | Serviço responsável pelo envio de comunicações transacionais | `<<system>>` |

---

## 6. Casos de Uso

| UC | Nome | Tipo | Referência |
|----|------|------|------------|
| UC-01 | Realizar Checkout Nominal Pago | Primário | [Ver caso de uso](./uc-01-realizar-checkout-nominal-pago/) |
| UC-02 | Realizar Checkout Nominal Gratuito | Primário | [Ver caso de uso](./uc-02-realizar-checkout-nominal-gratuito/) |
| UC-03 | Realizar Checkout Não Nominal Pago | Primário | [Ver caso de uso](./uc-03-realizar-checkout-nao-nominal-pago/) |
| UC-04 | Realizar Checkout Não Nominal Gratuito | Primário | [Ver caso de uso](./uc-04-realizar-checkout-nao-nominal-gratuito/) |
| UC-05 | Processar Pagamento | Primário | [Ver caso de uso](./uc-05-processar-pagamento/) |
| UC-06 | Preencher Dados dos Participantes | Secundário | [Ver caso de uso](./uc-06-preencher-dados-participantes/) |
| UC-07 | Selecionar Responsável pelos Ingressos | Secundário | [Ver caso de uso](./uc-07-selecionar-responsavel-ingressos/) |
| UC-08 | Aplicar Cupom de Desconto | Secundário | [Ver caso de uso](./uc-08-aplicar-cupom-desconto/) |
| UC-09 | Criar Conta Automaticamente | Secundário | [Ver caso de uso](./uc-09-criar-conta-automatica/) |
| UC-10 | Exibir Resumo do Pedido | Secundário | [Ver caso de uso](./uc-10-exibir-resumo-pedido/) |
| UC-11 | Gerenciar Tempo de Expiração | Secundário | [Ver caso de uso](./uc-11-gerenciar-expiracao-checkout/) |
| UC-12 | Enviar E-mails Transacionais | Secundário | [Ver caso de uso](./uc-12-enviar-emails-transacionais/) |

---

## 7. Documentação dos Casos de Uso

Cada caso de uso está documentado em arquivo separado dentro de sua própria pasta, conforme estrutura:

```
specs/features/checkout/
├── research.md
├── uc-01-realizar-checkout-nominal-pago/
│   └── uc-01-realizar-checkout-nominal-pago.md
├── uc-02-realizar-checkout-nominal-gratuito/
│   └── uc-02-realizar-checkout-nominal-gratuito.md
├── uc-03-realizar-checkout-nao-nominal-pago/
│   └── uc-03-realizar-checkout-nao-nominal-pago.md
├── uc-04-realizar-checkout-nao-nominal-gratuito/
│   └── uc-04-realizar-checkout-nao-nominal-gratuito.md
├── uc-05-processar-pagamento/
│   └── uc-05-processar-pagamento.md
├── uc-06-preencher-dados-participantes/
│   └── uc-06-preencher-dados-participantes.md
├── uc-07-selecionar-responsavel-ingressos/
│   └── uc-07-selecionar-responsavel-ingressos.md
├── uc-08-aplicar-cupom-desconto/
│   └── uc-08-aplicar-cupom-desconto.md
├── uc-09-criar-conta-automatica/
│   └── uc-09-criar-conta-automatica.md
├── uc-10-exibir-resumo-pedido/
│   └── uc-10-exibir-resumo-pedido.md
├── uc-11-gerenciar-expiracao-checkout/
│   └── uc-11-gerenciar-expiracao-checkout.md
├── uc-12-enviar-emails-transacionais/
│   └── uc-12-enviar-emails-transacionais.md
└── prd.md
```

O diagrama de casos de uso abaixo ilustra as relações entre os atores e os casos de uso:

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           FRONTEIRA DO SISTEMA                              │
│                              CHECKOUT LINKA                                 │
│                                                                             │
│   ┌──────────────────┐           ┌──────────────────────────────────────┐   │
│   │                  │           │                                      │   │
│   │  ┌────────────┐  │           │  ┌───────────────────────────────┐   │   │
│   │  │UC-01       │  │           │  │UC-02                          │   │   │
│   │  │Checkout    │◄─┼───────────┼──│Checkout                       │   │   │
│   │  │Nominal     │  │           │  │Nominal                        │   │   │
│   │  │Pago        │  │           │  │Gratuito                       │   │   │
│   │  └────────────┘  │           │  └───────────────────────────────┘   │   │
│   │         │        │           │                                      │   │
│   │         ▼        │           │                                      │   │
│   │  ┌────────────┐  │           │                                      │   │
│   │  │UC-03       │  │           │                                      │   │
│   │  │Checkout    │◄─┼───────────┼──────────────────────────────────────┤   │
│   │  │Não Nominal │  │           │                                      │   │
│   │  │Pago        │  │           │                                      │   │
│   │  └────────────┘  │           │                                      │   │
│   │         │        │           │                                      │   │
│   │         ▼        │           │                                      │   │
│   │  ┌────────────┐  │           │                                      │   │
│   │  │UC-04       │  │           │                                      │   │
│   │  │Checkout    │  │           │                                      │   │
│   │  │Não Nominal │  │           │                                      │   │
│   │  │Gratuito    │  │           │                                      │   │
│   │  └────────────┘  │           │                                      │   │
│   │                  │           │                                      │   │
│   └──────────────────┘           │                                      │   │
│                                  └──────────────────────────────────────┘   │
│                                                                             │
│   ┌──────────────────────────────────────────────────────────────────────┐  │
│   │                         CASOS DE USO SECUNDÁRIOS                     │  │
│   │                                                                      │  │
│   │  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌────────────┐  │  │
│   │  │UC-05         │ │UC-06         │ │UC-07         │ │UC-08       │  │  │
│   │  │Processar     │ │Preencher     │ │Selecionar    │ │Aplicar     │  │  │
│   │  │Pagamento     │ │Dados         │ │Responsável   │ │Cupom       │  │  │
│   │  └──────────────┘ └──────────────┘ └──────────────┘ └────────────┘  │  │
│   │                                                                      │  │
│   │  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌────────────┐  │  │
│   │  │UC-09         │ │UC-10         │ │UC-11         │ │UC-12       │  │  │
│   │  │Criar Conta  │ │Exibir        │ │Gerenciar     │ │Enviar      │  │  │
│   │  │Automática    │ │Resumo Pedido │ │Expiração     │ │E-mails     │  │  │
│   │  └──────────────┘ └──────────────┘ └──────────────┘ └────────────┘  │  │
│   │                                                                      │  │
│   └──────────────────────────────────────────────────────────────────────┘  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘

┌──────────────────┐     ┌──────────────────┐     ┌──────────────────────┐
│   PARTICIPANTE    │     │    ORGANIZADOR   │     │  SISTEMA PAGAMENTO   │
│                  │     │                  │     │                      │
│  ◄──────────────►│     │                  │     │  ◄─────────────────► │
│                  │     │                  │     │                      │
└──────────────────┘     └──────────────────┘     └──────────────────────┘

┌──────────────────────┐
│   SISTEMA E-MAIL      │
│                      │
│  ◄─────────────────► │
│                      │
└──────────────────────┘
```

---

## 8. Associações

### 8.1. Generalização/Especialização

```
           ┌────────────────────┐
           │ UC-01             │
           │ Checkout          │
           │ Nominal           │
           │ Pago              │
           └─────────┬──────────┘
                     │
                     │ herança
                     ▼
┌─────────────────────────────────────────────────────────────────┐
│                      CHECKOUT NOMINAL                           │
│                                                                 │
│  ┌──────────────────────┐    ┌─────────────────────────────┐  │
│  │ UC-02                │    │ UC-03                        │  │
│  │ Checkout Nominal     │    │ Checkout Não Nominal         │  │
│  │ Gratuito             │    │ Pago                         │  │
│  │ (herda UC-01)        │    │                              │  │
│  └──────────────────────┘    └──────────────┬───────────────┘  │
│                                              │                 │
└──────────────────────────────────────────────┼─────────────────┘
                                               │ herança
                                               ▼
                              ┌──────────────────────────────┐
                              │ UC-04                        │
                              │ Checkout Não Nominal          │
                              │ Gratuito                     │
                              │ (herda UC-03)                │
                              └──────────────────────────────┘
```

### 8.2. Inclusão

```
┌──────────────────────────────────────────────────────────────────────┐
│                        CHECKOUT NOMINAL PAGO                         │
│                         (UC-01)                                      │
│                                                                      │
│   ┌────────────────────────────────────────────────────────────────┐ │
│   │ 1. Preencher Dados dos Participantes (UC-06)                  │ │
│   │    «include» ──► obrigatório em todo checkout nominal          │ │
│   └────────────────────────────────────────────────────────────────┘ │
│   ┌────────────────────────────────────────────────────────────────┐ │
│   │ 2. Selecionar Responsável pelos Ingressos (UC-07)              │ │
│   │    «include» ──► obrigatório para definir destinatário         │ │
│   └────────────────────────────────────────────────────────────────┘ │
│   ┌────────────────────────────────────────────────────────────────┐ │
│   │ 3. Exibir Resumo do Pedido (UC-10)                             │ │
│   │    «include» ──► exibido durante todo o checkout              │ │
│   └────────────────────────────────────────────────────────────────┘ │
│   ┌────────────────────────────────────────────────────────────────┐ │
│   │ 4. Gerenciar Tempo de Expiração (UC-11)                        │ │
│   │    «include» ──► reserva ingresso por 15 minutos               │ │
│   └────────────────────────────────────────────────────────────────┘ │
│   ┌────────────────────────────────────────────────────────────────┐ │
│   │ 5. Aplicar Cupom de Desconto (UC-08)                           │ │
│   │    «include» ──► opcional durante preenchimento               │ │
│   └────────────────────────────────────────────────────────────────┘ │
│   ┌────────────────────────────────────────────────────────────────┐ │
│   │ 6. Processar Pagamento (UC-05)                                 │ │
│   │    «include» ──► obrigatório para checkout pago                │ │
│   └────────────────────────────────────────────────────────────────┘ │
│   ┌────────────────────────────────────────────────────────────────┐ │
│   │ 7. Criar Conta Automaticamente (UC-09)                        │ │
│   │    «include» ──► após conclusão do checkout                    │ │
│   └────────────────────────────────────────────────────────────────┘ │
│   ┌────────────────────────────────────────────────────────────────┐ │
│   │ 8. Enviar E-mails Transacionais (UC-12)                        │ │
│   │    «include» ──► após criação de conta e confirmação          │ │
│   └────────────────────────────────────────────────────────────────┘ │
│                                                                      │
└──────────────────────────────────────────────────────────────────────┘
```

### 8.3. Extensão

```
┌──────────────────────────────────────────────────────────────────────┐
│                        CHECKOUT NOMINAL PAGO                         │
│                         (UC-01)                                      │
│                                                                      │
│   ┌────────────────────────────────────────────────────────────────┐ │
│   │ UC-08: Aplicar Cupom de Desconto                               │ │
│   │    «extend» ◄── só executado se participante inserir cupom     │ │
│   │                                                                │ │
│   │    [Condição: participante inserir código de cupom]            │ │
│   └────────────────────────────────────────────────────────────────┘ │
│                                                                      │
└──────────────────────────────────────────────────────────────────────┘
```

### 8.4. Estereótipos

| Estereótipo | Uso | Representação |
|-------------|-----|---------------|
| `<<system>>` | Atores não-humanos (Sistema de Pagamento, Sistema de E-mail) | Indicado na descrição do ator |
| `<<include>>` | Inclusão obrigatória de um UC em outro | Setas com linha sólida |
| `<<extend>>` | Extensão opcional de um UC | Setas com linha tracejada |
| `generalização` | Herança entre casos de uso | Seta com linha grossa |

### 8.5. Pontos de Extensão

| UC Base | Ponto de Extensão | UC Estendido | Condição |
|---------|-------------------|--------------|----------|
| UC-01, UC-02, UC-03 | `após_validação_participantes` | UC-08 | cupom_inserido = true |

### 8.6. Multiplicidade

| Associação | Multiplicidade | Descrição |
|------------|----------------|-----------|
| Participante → UC-01 a UC-04 | 1:N | Um participante pode realizar múltiplos checkouts |
| Participante → UC-06 | 1:N | Um participante pode preencher dados de N participantes |
| Sistema de Pagamento → UC-05 | 1:1 | Cada checkout tem exatamente um processamento de pagamento |

---

## 9. Fronteira de Sistema

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │
│   ┌─────────────────────────────────────────────────────────────────────┐   │
│   │                         LINKA EVENTOS                                │   │
│   │                                                                      │   │
│   │   ┌──────────────────────────────────────────────────────────────┐  │   │
│   │   │                     FRONTEIRA CHECKOUT                        │  │   │
│   │   │                                                               │  │   │
│   │   │   [Bloco 1]        [Bloco 2]          [Bloco 3]              │  │   │
│   │   │   Dados            Recebimento       Pagamento               │  │   │
│   │   │   Participantes    Ingresso          Comprador              │  │   │
│   │   │                                                               │  │   │
│   │   │                    [Resumo do Pedido]                         │  │   │
│   │   │                    [Contador 15min]                          │  │   │
│   │   │                                                               │  │   │
│   │   └──────────────────────────────────────────────────────────────┘  │   │
│   │                                                                      │   │
│   └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
│   EXTERNO AO SISTEMA:                                                      │
│   • Sistema de Pagamento (Gateway Pay)                                     │
│   • Sistema de E-mail (Serviço de envio)                                   │
│   • Organizador (Configura evento/ingressos, não interage no checkout)    │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## 10. Jobs To Be Done

**Job principal:**
> Como participante, eu quero finalizar a compra de ingressos de forma rápida e segura, sem precisar criar uma conta previamente, para que eu consiga garantir minha vaga no evento com o menor atrito possível.

**Jobs secundários:**

| # | Job | Justificativa |
|---|-----|---------------|
| 1 | Preencher dados dos participantes | Permite vincular ingresso nominal a pessoa específica |
| 2 | Selecionar responsável pelos ingressos | Garante que os ingressos cheguem à pessoa correta |
| 3 | Escolher método de pagamento | Oferece flexibilidade entre Pix, cartão e boleto |
| 4 | Aplicar cupom de desconto | Permite economia em compras com código promocional |
| 5 | Visualizar resumo do pedido | Proporciona transparência sobre valores e itens |
| 6 | Receber e-mails com ingressos | Confirmação e comprovação da compra realizada |

---

## 11. Métricas de Sucesso

**Métricas de produto:**

| Métrica | Meta | Indicador |
|---------|------|-----------|
| Taxa de conversão do checkout | +15% em 3 meses | checkouts iniciados / checkouts concluídos |
| Taxa de abandono de carrinho | < 25% | checkouts abandonados / checkouts iniciados |
| Tempo médio de checkout | < 5 minutos | tempo entre início e conclusão |
| Satisfação do usuário (NPS) | > 50 | pesquisa pós-checkout |

**Métricas técnicas:**

| Métrica | Meta | Indicador |
|---------|------|-----------|
| Tempo de resposta do checkout | < 2s | p95 de latência |
| Disponibilidade do checkout | 99.9% | uptime mensal |
| Taxa de erros de pagamento | < 3% | erros / total de tentativas |
| E-mails entregues | 99% | entregas /envios |
