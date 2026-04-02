---
name: git-commit
description: Faz o commit da feature que está sendo desenvolvida e sincroniza as verificações dos critérios de aceite do plan e doc. do caso de uso. Use durante o desenvolvimento quando precisar commitar o critério de aceite concluido. 
---

# Introdução

Esta SKILL commita o proximo critério de aceite do **use case** que está sendo desenvolvido.

--- 

## Regras Fundamentais

- **SIGA O REQUISITO ORIGINAL EXATAMENTE COMO FORNECIDO. SEM INVENTAR, ADICIONAR OU SUPOR ALGO QUE NÃO ESTEJA EXPRESSAMENTE DEFINIDO NA US.**
- Se há ambiguidade, pergunte ao usuário antes de prosseguir.
- A ordem das casos de uso pode ser encontrada no arquivo **plan.md** da feature.
- Os critérios de aceite devem ser verificados na documentação do caso de uso especifico.
- Editar **uc-*.md** marcando [x] nos critérios
- Leia os critério de aceite do caso de uso, e compare com o que foi implementado para saber quais critérios de aceite deve verificar.
- Todos os critérios de aceite devem ser verificados se devem ou não serem marcados como concluido, baseado na analise das alterações que foram feitas.
- Consulte os 3 ultimos commits no historico do git caso necessário.
- Critérios já marcados com [x] não devem ser verificados novamente.
- **Verificar todos os critérios restantes**.
- Caso o **uc** esteja com todos os critérios de aceite verificado, edite o **plan.md** identificando tudo relacionado ao caso de uso como concluído.

--- 

## Passo a Passo

**Obs:** Siga as **Regras Fundamentais**

1. Solicite ao usuario o nome da feature, e o nome do caso de uso que está trabalhando, encerre caso a feature não exista.
2. Leia os critérios de aceite da feature na documentação do caso de uso **uc-*.md** que está localizado na pasta especifica do caso de uso.
3. Use a SKILL **spec-sync** para verificar se o que foi implementado no código está seguindo a especificação corretamente. **Não realize commit se tiver alguma inconsistência** exija que o usuário corrija as inconsistências antes de continuar.
3. Marque cada critério de aceite como verificado e realize o commit das alterações seguindo os padrôes de commit do projeto. A mensagem do commit deve ser o nome do critério de aceite que foi verificado.

---

## Saída

Informe um feedback amigavel para o usuario e instruções de proximos passos.