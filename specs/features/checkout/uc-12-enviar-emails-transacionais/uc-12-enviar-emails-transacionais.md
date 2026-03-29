# UC-12 - Enviar E-mails Transacionais

- **Ator Principal:** Sistema de E-mail
- **Resumo:** Este caso de uso representa o envio de comunicações por e-mail após eventos do checkout. Cada tipo de e-mail possui gatilho e conteúdo específicos.
- **Pré-condições:** Evento do checkout triggered; E-mail do destinatário válido.
- **Pós-condições:** E-mail enviado e entregue ao destinatário.

### Tipos de E-mail

| # | Tipo | Gatilho | Destinatário |
|---|------|---------|--------------|
| 1 | Boas-vindas | Criação automática de conta | Responsável pelos ingressos |
| 2 | Confirmação de compra | Pagamento aprovado | Responsável pelos ingressos |
| 3 | Ingressos em PDF | Pagamento confirmado | Responsável pelos ingressos |
| 4 | Comprovante | Quando aplicável | Comprador |

### Cenário Principal

| Ações do Sistema | Ações do Sistema de E-mail |
|------------------|---------------------------|
| 1. Evento triggered | 1.1. Prepara payload do e-mail |
| 2. Identifica template correto | 2.1. Carrega template apropriado |
| 3. Popula variáveis do template | 3.1. Nome, e-mail, dados do pedido |
| 4. Envia e-mail | 4.1. Entrega ao servidor de e-mail |
| 5. Recebe confirmação | 5.1. Registra envio bem-sucedido |

### E-mail 1: Boas-Vindas

**Gatilho:** Criação automática de conta

**Conteúdo:**
- Saudação personalizada com nome
- Aviso de conta criada automaticamente
- Credenciais de acesso (e-mail + link de definição de senha)
- Informações sobre gerenciamento de ingressos
- Suporte/ajuda

### E-mail 2: Confirmação de Compra

**Gatilho:** Pagamento aprovado

**Conteúdo:**
- Confirmação da compra realizada
- Resumo do pedido (evento, ingressos, valores)
- Status do pagamento
- Número do pedido

### E-mail 3: Ingressos em PDF

**Gatilho:** Confirmação de pagamento

**Conteúdo:**
- Agradecimento pela compra
- Anexos: Ingressos em PDF
- Informações do evento (data, local, instruções)
- QR Code para acesso

### Cenário de Exceção

**CE-01: E-mail não entregue**
| Ações do Sistema | Ações do Sistema de E-mail |
|------------------|---------------------------|
| | 1.1. Retry automático (3 tentativas) |
| | 1.2. Registrar falha após esgotar retries |
| | 1.3. Alertar equipe de suporte |

**CE-02: E-mail inválido**
| Ações do Sistema | Ações do Sistema de E-mail |
|------------------|---------------------------|
| | 1.1. Identificar formato inválido na validação |
| | 1.2. Impedir envio; notificar admin |

### Requisitos Não-Funcionais

- **Confiabilidade:** Taxa de entrega > 99%
- **Performance:** Envio < 5s após gatilho
- **Design:** Templates responsivos para mobile
- **Segurança:** Links únicos e temporários para definições de senha
