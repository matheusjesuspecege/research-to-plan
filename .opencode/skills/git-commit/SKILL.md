---
name: git-commit
description: Faz o commit da feature que está sendo desenvolvida e sincroniza as verificações dos critérios de aceite do plan e doc. do caso de uso. Use durante o desenvolvimento quando precisar commitar o critério de aceite concluido. 
---

# Introdução

Esta SKILL commita o proximo critério de aceite do **use case** que está sendo desenvolvido.

--- 

## Regras Fundamentais

- A ordem das casos de uso pode ser encontrada no arquivo **plan.md** da feature.
- Os critérios de aceite devem ser verificados na documentação do caso de uso especifico.
- Marque como verificado o primeiro critério do caso de uso que ainda não foi marcado.

--- 

## Passo a Passo

**Obs:** Siga as **Regras Fundamentais**

1. Solicite ao usuario o nome da feature, e o nome do caso de uso que está trabalhando, encerre caso a feature não exista.
2. Leia os critérios de aceite da feature na documentação do caso de uso **uc-*.md** que está localizado na pasta especifica do caso de uso.
3. Marque o critério de aceite como verificado e realize o commit das alterações seguindo os padrôes de commit do projeto. A mensagem do commit deve ser o nome do critério de aceite que foi verificado.

---

## Saída

Informe um feedback amigavel para o usuario e instruções de proximos passos.