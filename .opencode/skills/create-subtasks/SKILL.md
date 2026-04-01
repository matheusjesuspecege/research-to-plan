---
name: create-subtasks
description: Cria as subtarefas da US que está no Azure DevOps para cada use case da feature. Use quando estiver com o plano de implantação pronto para desenvolver para manter backlog alinhado com o andamento da implementação.
---

# Introdução

Esta skill se conecta ao backlog do projeto que está no azure devops usando a skill **azure-mcp-connect** para realizar a criação das subtarefas no card da US.

---

## Regras Fundamentais

- **SIGA O REQUISITO ORIGINAL EXATAMENTE COMO FORNECIDO. NÃO INVENTE, NÃO ADICIONE E NÃO SUPONHA NADA QUE NÃO ESTEJA EXPRESSAMENTE DEFINIDO NA US.**
- Se a US não menciona algo, não inclua. Se há ambiguidade, pergunte ao usuário antes de supor.
- Siga a mesma ordem dos **use cases** especificados no arquivo **plan.md** que está na raiz da pasta da feature informada pelo usuário.
- Deve ser criado uma subtarefa para cada **use case** com a descrição detalhada preenchida, os detalhes podem ser encontrados nas **documentações de caso de uso** específicos de cada **use case**, que podem ser encontrados na pasta pasta especifica e no arquivo **.md** especifico do **uc**.
- A descrição das subtarefas devem estar visualmente formatada no azure devops para facilitar a compreensão humana, mantendo a formatação padrão do azure devops evitando quebras de formatação.
- Atribua a primeira subtarefa automaticamente no azure devops ao usuario. 

---

## Passo a Passo

1. Verifique se o usuário já está conectado ao azure devops, caso não esteja, use a skill **azure-mcp-connect** para que ele possa se conectar ao backlog do azure devops.
2. Com a conexão realizada, solicite para o usuário o **nome da feature** e o **id do card do backlog** que será criada as subtarefas.
3. Encontre a US no azure devops pelo id informado pelo usuário e crie as subtarefas no card seguindo as **Regras Fundamentais**.   

---

## Saída

Informe o usuario através de um feedback resumido tudo que foi feito e os proximos passos.