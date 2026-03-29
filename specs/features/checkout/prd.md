# Checkout - PRD

Tópico 1 - Contextualização 🧭
O checkout do Linka Eventos é o momento mais crítico de toda a jornada do participante. É nele que a intenção de participar de um evento se converte em uma inscrição ou compra, e qualquer fricção nesse processo representa diretamente perda de conversão, abandono de carrinho e experiência negativa para o participante;

Mais do que pontos isolados de melhoria, o problema central identificado está no próprio processo de checkout, que hoje apresenta fragilidades tanto do ponto de vista de arquitetura quanto de usabilidade, impactando diretamente a eficiência do fluxo e a experiência do usuário;

Além da fragmentação visual, existe uma barreira crítica de acesso: atualmente, realizar qualquer compra ou inscrição na plataforma exige que o participante possua uma conta previamente criada. Esse requisito eleva o atrito no início do processo, especialmente para participantes que estão acessando o Linka pela primeira vez. Em plataformas modernas de eventos e e-commerce, a obrigatoriedade de criação de conta antes da compra é um dos principais fatores de abandono documentados;

A proposta desta refatoração é consolidar o checkout em uma tela única organizada em três blocos sequenciais e progressivos: dados dos participantes, responsável pelos ingressos e pagamento e dados do comprador. Essa nova estrutura reduz a percepção de complexidade, melhora a legibilidade do fluxo, elimina navegações desnecessárias entre telas e permite que o participante visualize e edite todas as informações antes de confirmar a compra. Ao mesmo tempo, a refatoração introduz a criação automática de conta para os tipos de checkout que permitem compra sem login, eliminando a barreira de entrada sem abrir mão da gestão de ingressos vinculada a um perfil na plataforma;

O objetivo é que o checkout do Linka se torne referência em plataformas de eventos: rápido, seguro e com a menor quantidade possível de etapas obrigatórias para o participante;

👉 Protótipo
Tópico 2 - Estrutura geral do checkout 🏗️

O checkout deve ser exibido em uma tela única, com rolagem vertical contínua, organizada em três blocos sequenciais:
Bloco 1 — Dados dos participantes
Bloco 2 — Recebimento do ingresso
Bloco 3 — Pagamento e dados do comprador

O sistema deve exibir um painel lateral direito com o resumo do pedido, contendo o nome do evento, as datas, a discriminação dos ingressos selecionados com seus respectivos valores, o desconto aplicado via cupom quando houver, e o valor total da compra;

O botão de ação principal deve estar posicionado ao final do terceiro bloco, com o texto "Avançar para pagamento". Esse botão só deve ser habilitado quando todos os campos obrigatórios dos três blocos estiverem corretamente preenchidos e validados;

O contador de tempo deve ser exibido no painel de resumo do pedido, indicando o tempo restante para conclusão da compra. O comportamento do sistema ao expirar esse tempo está descrito no Tópico 8.

Tópico 3 - Bloco 1: Dados dos participantes 👤

Tópico 3.1 - Checkout nominal (pago ou gratuito)

No checkout nominal, o sistema deve exibir um card de preenchimento para cada ingresso selecionado, identificado pelo tipo do ingresso e seu valor. Cada card deve conter os campos obrigatórios: nome do participante, e-mail e celular. O campo de celular deve conter seletor de DDI com bandeira do país, com o Brasil pré-selecionado como padrão;

O organizador pode configurar campos adicionais por ingresso, como CPF, empresa, cargo ou qualquer outro campo customizado. Quando configurados, esses campos devem aparecer nos cards de participante do respectivo ingresso, abaixo dos campos padrão, e devem seguir as regras de obrigatoriedade definidas pelo organizador no momento da criação do ingresso;

Todos os campos obrigatórios devem ser validados antes que o participante consiga avançar para o próximo bloco. Caso algum campo não esteja preenchido ou contenha dado inválido, o sistema deve destacar o campo com indicação visual de obrigatoriedade e exibir uma mensagem explicativa abaixo do campo correspondente;

Tópico 3.2 - Checkout não nominal (pago ou gratuito)

No checkout não nominal, o Bloco 1 não deve ser exibido. O sistema não solicita nenhum dado por ingresso, pois o ingresso não é vinculado a um participante no momento da compra. O checkout deve iniciar diretamente no Bloco 2 — Recebimento do ingresso.

Tópico 4 - Bloco 2: Recebimento do ingresso 📬

O Bloco 2 deve exibir um campo do tipo dropdown com o label "Responsável pelos ingressos";

O dropdown deve listar como opções os nomes de todos os participantes informados no Bloco 1, seguidos da opção "Outro". No caso do checkout não nominal, onde o Bloco 1 não é exibido, o dropdown não deve ser exibido;

Quando o participante seleciona uma das opções da lista de participantes, o sistema deve usar automaticamente o e-mail daquele participante como destinatário dos ingressos. Nenhum campo adicional precisa ser exibido;

Quando o participante seleciona a opção "Outro", o sistema deve exibir os campos: nome completo, e-mail e celular, todos obrigatórios. Esses dados serão usados para identificar o responsável pelos ingressos e para criação automática de conta, conforme descrito no Tópico 6;

O bloco deve exibir também os seguintes elementos obrigatórios antes do avanço:
checkbox com o texto "Eu li e concordo com os termos e condições" com link para a página correspondente
checkbox com o texto "Aceito receber contato e informações sobre o evento". Esse checkbox não deve ser obrigatório para avanço

O sistema deve exibir uma nota informativa abaixo dos checkboxes indicando que uma conta será criada automaticamente no Linka com o e-mail informado, sendo esse e-mail o responsável pela gestão dos ingressos adquiridos;

Tópico 5 - Bloco 3: Pagamento e dados do comprador 💳

Tópico 5.1 - Seleção do método de pagamento

O sistema deve exibir as opções de método de pagamento disponíveis para o evento: Pix, Cartão de crédito e Boleto. Apenas os métodos habilitados pelo organizador devem ser exibidos;

O participante deve selecionar um método antes de prosseguir.

Tópico 5.2 - Dados do comprador

O bloco deve exibir um campo dropdown com o label "Responsável pelo pagamento";

O dropdown deve listar os nomes de todos os participantes informados no Bloco 1 e a opção "Outro". No checkout não nominal, onde o Bloco 1 não foi exibido, o dropdown não deve ser exibido;

Esse campo é independente do campo "Responsável pelos ingressos" do Bloco 2. O participante pode escolher pessoas diferentes para cada responsabilidade;

Quando o participante seleciona um dos participantes listados, o sistema deve pré-preencher os campos de dados do comprador com as informações já fornecidas no Bloco 1 para aquele participante;

Quando o participante seleciona "Outro", o sistema deve exibir campos para preenchimento manual dos dados do comprador;
Tópico 5.3 - Salvar dados para compras futuras

Caso o participante esteja logado e tenha optado por salvar os dados em uma compra anterior, o sistema deve pré-preencher automaticamente os campos do comprador com os dados salvos e exibir o cartão salvo como opção de pagamento, exigindo apenas o preenchimento do CVV para confirmar;
Os dados de compra devem ficar vinculados ao usuário logado, e não ao método de pagamento, ou seja, caso a primeira compra de um usuário seja realizada via Pix e ele opte por salvar os dados, o sistema deve armazenar as informações pessoais. Em uma compra posterior, caso o pagamento seja realizado com cartão, o sistema deverá preencher automaticamente os dados pessoais já salvos, enquanto os dados do cartão devem permanecer em branco, uma vez que ainda não foram cadastrados. Assim, as informações devem ser vinculadas ao usuário, e não ao método de pagamento utilizado;
Caso o usuário possua dados salvos, preenchidos automaticamente pelo sistema, mas realize alguma alteração antes de prosseguir com a compra, essas informações atualizadas devem passar a ser consideradas como os novos dados salvos. Dessa forma, na próxima compra, o sistema deverá retornar os dados mais recentes informados pelo usuário, mantendo sempre a versão mais atualizada das informações inseridas;
Caso o usuário possua dados salvos, preenchidos automaticamente pelo sistema, mas em uma nova compra desmarque a opção de manter os dados salvos e atualizados, o sistema não deverá manter essas informações armazenadas. Dessa forma, na próxima compra realizada pelo usuário, todos os campos deverão ser exibidos vazios, sendo necessário realizar o preenchimento novamente;
Embora o sistema preencha automaticamente os dados quando disponíveis, o usuário deve ter total autonomia para editar ou alterar qualquer um dos campos antes de concluir o processo;
Para "dados de pagamento armazenados no sistema" entende-se:
Dados que devem ser salvos e reutilizados:
Nome completo do comprador
E-mail
CPF/CNPJ/Passaporte
Telefone
Dados que NÃO devem ser salvos no banco de dados:
Para pagamentos com cartão, o sistema deve armazenar apenas o card_id retornado pelo Pay, que permitirá recuperar o cartão previamente utilizado, sem armazenar dados sensíveis;
O sistema deve exibir uma opção de checkbox com o texto "Salvar dados para futuras compras". Quando marcada, o sistema deve armazenar os dados do comprador e os dados do cartão para uso em compras futuras do mesmo usuário logado;

Tópico 5.4 - Checkout gratuito

Quando o evento ou ingresso for gratuito, o Bloco 3 não deve exibir os campos de método de pagamento nem os dados do comprador. O sistema deve exibir apenas o botão de confirmação da inscrição;

Tópico 6 - Criação automática de conta 🔐

Tópico 6.1 - Checkout nominal pago e nominal gratuito

Ao concluir o checkout com sucesso, o sistema deve criar automaticamente uma conta na plataforma usando os dados do responsável pelos ingressos definido no Bloco 2. Se o participante selecionou um dos participantes informados no Bloco 1, a conta deve ser criada com o nome e e-mail daquele participante. Se o participante selecionou "Outro", a conta deve ser criada com os dados informados manualmente.

Tópico 6.2 - Checkout não nominal pago

O comportamento de criação de conta deve seguir a mesma lógica do checkout nominal: a conta é criada com os dados do responsável pelos ingressos informado no Bloco 2, seja um participante selecionado ou a opção "Outro" preenchida manualmente.

Tópico 6.3 - Checkout não nominal gratuito

No checkout não nominal gratuito, o participante deve obrigatoriamente estar autenticado para acessar o checkout. Caso o participante tente avançar sem estar logado, o sistema deve redirecioná-lo para a tela de login ou cadastro. Após autenticação, o sistema deve retornar o participante ao checkout no ponto em que estava.

Tópico 6.4 - E-mail informado já possui conta existente

Quando o e-mail informado no campo "Responsável pelos ingressos" já estiver cadastrado na base da plataforma, o sistema deve usar a conta existente automaticamente, sem criar uma nova conta duplicada. O participante não precisa fazer login para concluir a compra nos tipos de checkout que permitem compra sem autenticação. Os ingressos serão vinculados à conta já existente com aquele e-mail.

Tópico 6.5 - Comunicações enviadas após criação automática de conta

Após a criação automática de conta, o sistema deve enviar dois e-mails distintos para o responsável pelos ingressos: o primeiro é um e-mail de boas-vindas à plataforma solicitando que o participante defina sua senha de acesso. O segundo é o e-mail com os ingressos adquiridos, enviado após a confirmação do pagamento conforme as regras descritas no Tópico 9.

Tópico 7 - Cupom de desconto 🎟️

O campo de cupom deve estar disponível no painel de resumo do pedido, com um campo de texto e um botão com o texto "Adicionar";

A validação do cupom deve ocorrer no momento em que o participante clica no botão "Adicionar";

Quando o cupom for válido, o sistema deve exibir o desconto aplicado no resumo do pedido, com o nome do cupom e o valor descontado em destaque, além de disponibilizar uma opção para remover o cupom aplicado;

Quando o cupom for inválido, expirado ou não encontrado, o sistema deve exibir uma mensagem de erro imediatamente abaixo do campo, informando o motivo da rejeição de forma clara ao usuário;

Apenas um cupom pode estar ativo por pedido. O sistema não deve aplicar regras de restrição por CPF ou e-mail do participante.

Tópico 8 - Expiração do tempo de checkout ⏱️

O sistema deve reservar os ingressos selecionados pelo participante durante o preenchimento do checkout por um período de 15 minutos, exibido como contador regressivo no painel de resumo do pedido;

O comportamento do sistema ao atingir zero no contador é redirecionar o participante para a página do evento com os ingressos liberados, permitindo que o participante reinicie o checkout caso os ingressos ainda estejam disponíveis.

Tópico 9 - Confirmação de pagamento e tela de sucesso ✅

Tópico 9.1 - Pagamento via cartão de crédito

Após o envio dos dados do cartão, o sistema deve processar o pagamento e aguardar a resposta da operadora. Caso o pagamento seja aprovado, o sistema deve exibir a tela de confirmação de compra;

Quando o cartão for recusado, o sistema deve retornar ao bloco de pagamento mantendo todos os dados preenchidos, exibir a mensagem de erro retornada de forma clara e com instruções para o participante. O participante pode tentar novamente com o mesmo cartão ou alterar o método de pagamento;

Tópico 9.2 - Pagamento via Pix

Após a seleção do Pix como método de pagamento e a confirmação do comprador, o sistema deve gerar e exibir o QR Code e o código Pix copia e cola, juntamente com o tempo restante para pagamento. A tela de confirmação completa deve ser exibida somente após a confirmação do pagamento pelo sistema financeiro, mediante recebimento do webhook de pagamento confirmado;

Tópico 9.3 - Pagamento via Boleto

O comportamento pós-seleção de boleto deve considerar o tempo de compensação desse meio de pagamento. Após a escolha, o usuário deve ser direcionado para uma tela de “Aguardando pagamento”, onde poderá visualizar as instruções, baixar o boleto e/ou copiar o código para pagamento.

Tópico 9.4 - Tela de confirmação

A tela de confirmação deve ser a mesma já existente hoje no sistema.

Tópico 9.5 - E-mails transacionais pós-checkout

Após a confirmação do pagamento, o sistema deve enviar ao responsável pelos ingressos o e-mail com os ingressos adquiridos em PDF. O sistema já envia hoje o e-mail de confirmação de compra e o comprovante de compra quando aplicável, e esses comportamentos devem ser mantidos. Para contas criadas automaticamente, o e-mail de boas-vindas com link de criação de senha deve ser enviado conforme descrito no Tópico 6.5.

Tópico 10 - Proteção e segurança do checkout 🔒

A definir com o time dev

Tópico 11 - Comportamento por tipo de ingresso - regras para consulta ✏️

O sistema deve se comportar de forma diferente em cada combinação de tipo de ingresso e contexto de autenticação. Os tópicos abaixo consolidam as regras principais para orientar a implementação:

No checkout nominal pago: exibe Bloco 1 com campos por participante, exibe Bloco 2 com dropdown de responsável, exibe Bloco 3 com métodos de pagamento, cria conta automaticamente com os dados do responsável pelos ingressos ao concluir;

No checkout nominal gratuito: exibe Bloco 1 com campos por participante, exibe Bloco 2 com dropdown de responsável, não exibe Bloco 3 apenas com os campos de pagamento, cria conta automaticamente com os dados do responsável pelos ingressos ao concluir;

No checkout não nominal pago: não exibe Bloco 1, exibe Bloco 2 sem o dropdown, exibe Bloco 3 com métodos de pagamento, cria conta automaticamente com os dados do responsável pelos ingressos ao concluir;

No checkout não nominal gratuito: exige autenticação do participante antes de acessar o checkout. Caso não esteja logado, redireciona para login ou cadastro ao tentar avançar. Após autenticação, retorna ao checkout. Não exibe Bloco 1. Exibe Bloco 2. Não exibe o Bloco 3.
