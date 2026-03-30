# PRD - Dashboard

Tópico 1 - Contextualização 📋
O painel do organizador no Linka Eventos conta atualmente com um dashboard que centraliza as principais informações de acompanhamento de um evento, exibindo dados de inscrições, vendas, check-ins, acessos e receita em tempo real. Esse dashboard é acessado diretamente pelo menu lateral do painel do organizador e representa uma das telas mais estratégicas da plataforma, sendo o ponto central de monitoramento durante a realização de um evento;
O cenário atual apresenta um problema de natureza arquitetural com impacto direto na evolução do produto. O componente de dashboard está implementado de forma isolada, sem estar organizado como um package compartilhável dentro do monorepo da plataforma. Isso limita a capacidade do time de desenvolvimento de reutilizar, manter e evoluir esse componente de maneira eficiente, gerando acoplamento desnecessário e dificultando futuras expansões;
Como consequência, qualquer evolução no dashboard exige esforço desproporcional, aumenta o risco de inconsistências entre ambientes e torna o ciclo de desenvolvimento mais lento. A ausência de uma estrutura padronizada também compromete a escalabilidade da plataforma a longo prazo;
A proposta é migrar o dashboard para um package dentro do monorepo e integrá-lo ao painel do organizador, substituindo definitivamente o componente anterior. Essa migração será acompanhada de mudanças visuais no dashboard, entregando ao mesmo tempo uma melhoria arquitetural e uma experiência atualizada para o organizador;
Os benefícios esperados são a padronização da arquitetura da plataforma, maior facilidade de manutenção e evolução do dashboard, redução do risco de regressões em futuras entregas e uma interface mais moderna e consistente para o organizador acompanhar seus eventos em tempo real.
Tópico 2 - Migração e desativação do dashboard anterior 🔁
Com a conclusão da migração do dashboard para o novo package no monorepo, o componente anterior deve ser definitivamente desativado, deixando de ser renderizado em qualquer contexto da plataforma;
O novo dashboard deve ocupar exatamente o mesmo ponto de acesso do anterior dentro do menu lateral do painel do organizador, garantindo continuidade na experiência de navegação sem impacto na jornada do organizador;

O time de desenvolvimento deve validar, antes da desativação do dashboard anterior, que todas as informações anteriormente exibidas estão disponíveis e funcionando corretamente no novo componente.
Tópico 6 - Critérios de não-regressão 🧪

A migração não deve alterar nenhuma das regras de negócio já existentes relacionadas ao cálculo e exibição dos dados de inscrições, vendas, check-ins e receita;

O acesso ao dashboard pelo menu lateral deve continuar funcionando para todos os organizadores com eventos ativos na plataforma, sem necessidade de qualquer ação adicional por parte deles;

Caso a migração seja realizada com o ambiente de produção ativo, o time deve garantir que a substituição do componente ocorra de forma atômica, sem período de indisponibilidade do dashboard para os organizadores.

## Descrição Técnica

Atualmente o linka eventos funciona em um monorepo usando turborepo, e possui os seguintes projetos:
- organizador(react/react query)
- backoffice(react/react query)

Atualmente o organizador utilzia powerbi como dashboard incorporado, e agora ele foi descontinuado e removido. No lugar foi contruido um novo dashboard nativo em react com react query que já está em funcionamento.

O backoffice tambem usa o powerbi, e deverá ser removido para ser substituido pelo novo dashboard usado no organizador. Para isso, será criado um **package-dashboard** com os componentes e telas funcionando para que seja instanciado e usado por ambos os projetos.

Esta tarefa é exclusivamente de migração do dashboard existente para o monorepo compartilhado, e uso nos dois projetos.