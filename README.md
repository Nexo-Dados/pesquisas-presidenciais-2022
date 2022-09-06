# Pesquisas para presidente - 2022

Repositório para o gráfico de pesquisas eleitorais da newsletter 'Durma com essa', do Nexo Jornal.

## Dados


### Resultado agregado

| Candidato  |  Percentual  | 
| ------------------- | ------------------- |
|  Lula (PT) |  43,3% |
|  Bolsonaro (PL) | 34,6% |
|  Ciro (PDT) |  7,6% |
|  Outros | 6,4% |
|  Brancos, nulos, indecisos |  8,1% |

Atualizado em **06/09/2022**.

### Pesquisas mais recentes

| Data término | Instituto | Registro |  Lula  | Bolsonaro | Ciro | Outros | BNI |
| ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
2022-09-05 | Ipec | BR-00922/2022 | 44 | 31 | 8 | 4 | 2 | 11            
2022-09-05 | Paraná Pesquisas | BR-09446/2022 | 40 | 36 | 7 | 4 | 3 | 10
2022-09-04 | FSB | BR-01786/2022 | 42 | 34 | 8 | 6 | 3 | 7              
2022-09-01 | Ipespe | BR-09344/2022 | 44 | 35 | 9 | 5 | 2 | 5           
2022-09-01 | Datafolha | BR-00433/2022 | 45 | 32 | 9 | 5 | 3 | 6        
2022-09-01 | Gerp | BR-09102/2022 | 38 | 39 | 11 | 6 | 1 | 5            


Valores podem ser arredondados. 

Atualizado em **06/09/2022**.

### Dados completos

Acesse todos os registros no arquivo [pesquisas_1t.csv](https://github.com/Nexo-Dados/pesquisas-presidenciais-2022/blob/main/pesquisas_1t.csv).

## Metodologia

A metodologia de coleta e agregação é detalhada aqui. Qualquer alteração no procedimento também será registrada nesta página.

### Linha de tendência

A linha de tendência foi gerada a partir do método de regressão local. Como o objetivo é apresentar tendências mais gerais, o argumento span, que determina o quão suave será a curva, foi de .90 (que tende a dar bastante suavidade para a linha).

O intervalo de confiança se refere ao intervalo do erro padrão em torno de linha, gerado pelo método de regressão local.

### Pesquisas consideradas

Foram consideradas as pesquisas, com registro no TSE, publicadas ao longo do ano de divulgação.

A princípio, todos os institutos foram considerados, independente do tamanho amostral e método de entrevista. Algumas considerações:

* A pesquisa do Sigma está na tabela mas não é utilizada nos gráficos. Os resultados deste instituto são completamente divergentes dos demais. Os testes realizados pelo **Nexo** de viés dos institutos justifica a exclusão dessa pesquisa.

* As pesquisas dos institutos Gerp e Futura apresentam o candidato Jair Bolsonaro (PL) consistentemente mais bem posicionado nas pesquisas do que os demais institutos. No entanto, um critério objetivo para retirar essas pesquisas iria remover as pesquisas de institutos, como o Datafolha, que apontam Lula (PT) melhor do que nos demais institutos. Por ora, essas pesquisas foram todas mantidas.

* Quando havia mais de um cenário pesquisado (isso ocorreu sobretudo nas pesquisas do primeiro semestre), foi considerado apenas o cenário A ou cenário 1, por ser entendido como o cenário principal.

### Padronização dos dados

A maioria dos institutos disponibiliza o resultado da pesquisa sem nenhuma casa decimal. Para padronizar os valores na tabela, os dados dos que disponibilizam os percentuais com decimal foram arredondados para o número inteiro mais próximo. Quando o decimal terminava em 5, foi arrendodado para cima (ex: 1,5% ficou 2%).

A data na tabela se refere ao último dia de coleta das entrevistas.

### Candidatos considerados

Os três primeiros candidatos (Lula, Bolsonaro e Ciro) estão inclusos no gráfico.

O **Nexo** também coletou os dados da candidata Simone Tebet (MDB), mas sua linha é agregada com o "Outros" no gráfico. Isso foi feito para deixar o gráfico mais simples de ser visualizado.

Se ela ou outro candidato ultrapassar a marca de 6% dos votos, será incluída a posteriori aa linha no gráfico.

Os dados BNI se referem à soma de brancos, nulos e indecisos. A categoria Outros se refere à soma dos candidatos que não são exibidos no gráfico (guardada a consideração acima exposta sobre o percentual de Tebet). 

A soma foi aferida pela subtração de todos os outros valores de 100. Exemplo:

* Lula 40%
* Bolsonaro 30%
* Ciro 5%
* Tebet 3%
* BNI 15%
* Outros = 100% - (40%+30%+5%+3%+15%) = 7%

### Alterações na metodologia

- 31/08/2022: As pesquisas da Futura/Modalmais foram retiradas do gráfico e do resultado agregado. Isso foi feito por conta da decisão de uma decisão do TSE (PJe 0600876-28.2022.6.00.000) que põe em dúvida a metodologia do instituto. Os dados de todos os institutos, como sempre, continuam disponíveis na planilha csv dispinibilizada pelo **Nexo**.

## Uso e contato

Os dados originais são dos institutos de pesquisa. A coleta deles é feita sob responsabilidade da equipe de Gráficos do **Nexo Jornal**. O uso deles é autorizado, desde que seja citado o **Nexo**.

Em caso de dúvidas ou sugestões, contatar:

* Equipe de Gráficos:
dados@nexojornal.com.br












