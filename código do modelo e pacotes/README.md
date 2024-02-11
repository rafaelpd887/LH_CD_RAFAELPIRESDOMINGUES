# Desafio Lighthouse - Cientista de Dados
Abaixo estão as respostas para os itens 2, 3 e 4 do Desafio Lighthouse Cientista de Dados

Arquivo .rdata contendo o modelo pode ser baixado [aqui](https://drive.google.com/file/d/1PD8bEIlNgQxHZXGApU667fpE2UEhugYM/view?usp=sharing).

# 2.a. Supondo que uma pessoa esteja pensando em investir em um apartamento para alugar na plataforma, onde seria mais indicada a compra?
A resposta para essa pergunta depende dos objetivos do comprador. Vou considerar que o comprador deseja maximizar o retorno do aluguel e não está preocupado com o investimento inicial necessário. Acredito que também seja válido considerar a disponibilidade ao responder essa pergunta, uma vez que apartamentos com menor disponibilidade devem ficar alugados por um período maior do ano, gerando, consequentemente, mais lucro para o investidor.

Durante as análises realizadas no EDA e nas hipóteses de negócio, foi possível observar que o distrito de Manhattan possui a maior média de preços e também o maior número de apartamentos com uma disponibilidade inferior a 30 dias. Portanto, um investidor que não estivesse preocupado com o investimento inicial deveria considerar a compra de um apartamento no distrito de Manhattan. Dessa forma, ele poderia receber um alto valor de aluguel e também teria uma alta demanda pelo seu imóvel recém-adquirido.

Optei por responder essa pergunta usando os distritos (variável “bairro_group”) em vez dos bairros (variável “bairro”), pois alguns bairros possuem um número muito pequeno de observações e esse fato poderia distanciar a resposta dessa pergunta da realidade da cidade de Nova York.

# 2.b. O número de mínimo de noites e a disponibilidade ao longo do ano interferem no preço?
As variáveis referentes ao mínimo de noites e à disponibilidade ao longo do ano interferem de maneira sutil na variável preço. Decidi utilizar ambas as variáveis no meu modelo, pois, com base no meu conhecimento do mundo real, muitas das variáveis presentes no conjunto de dados não representavam fontes confiáveis de informação para prever o preço do aluguel. Assim sendo, qualquer variável que apresentasse informações novas a serem capturadas pelo modelo e que tivesse alguma influência na variável dependente deveria ser considerada.

# 2.c. Existe algum padrão no texto do nome do local para lugares de mais alto valor?
Não tenho certeza se compreendi completamente a pergunta. Não consegui identificar padrões muito claros na variável “nome”. O mais próximo que encontrei de um padrão foi que, entre os 330 apartamentos de maior valor do conjunto de dados (a quantidade de 330 corresponde ao percentil 99 da variável “price”), as palavras “luxury”, “bedroom” e “townhouse” aparecem na variável “nome” em pelo menos 35 apartamentos. O código com as funções que usei para chegar a essa conclusão pode ser visto [aqui](https://rpubs.com/rafaelpd/1147233).

Caso a pergunta esteja relacionada à variável “bairro_group”, durante a minha Análise Exploratória de Dados (EDA), pude constatar que a maioria dos imóveis de alto valor está localizada em Manhattan. Portanto, é possível afirmar que existe um padrão onde a categoria Manhattan da variável “bairro_group” tende a se repetir em imóveis de maior valor.


# 3. Explique como vc faria a previsão do preço a partir dos dados. Quais variáveis e/ou suas transformações você utilizou e por quê?
Acredito que a melhor maneira de abordar um problema que envolve a previsão de dados é buscar compreender, primeiramente, todas as informações contidas nos dados e nas relações entre eles. Também é importante conhecer o modelo de negócio no qual esses dados estão inseridos para que seja possível fazer inferências corretas quanto às variáveis presentes nos dados.

No caso do desafio proposto, deveria ser criado um modelo preditivo que faria a previsão do preço de apartamentos em Nova York com base nos dados fornecidos. Ao analisar os dados sob a ótica da minha vivência no mundo real, constatei que muitas das variáveis presentes não poderiam servir de parâmetro definidor para o preço dos apartamentos. Por esse motivo, optei por eliminar muitas das variáveis presentes e criei o modelo final utilizando apenas as variáveis “bairro”, “room_type”, “minimo_noites” e “disponibilidade_365” como preditoras, e “price” como variável alvo. Além disso, também eliminei outliers das variáveis "minimo_noites" e "price" antes de utilizá-las na criação do modelo.

Com exceção de “bairro_group”, “latitude” e “longitude”, todas as outras variáveis foram eliminadas sem muitas análises. No entanto, essas três foram testadas juntamente com as outras quatro e optei por eliminá-las do modelo porque estava obtendo resultados melhores utilizando apenas as outras quatro.

A única transformação utilizada foi a dummização (one-hot coding) das variáveis qualitativas para que elas pudessem ser usadas nos modelos a serem testados.

# Qual o tipo de problema estamos resolvendo (regressão, classificação)?
Estamos resolvendo um problema de regressão porque nossa variável dependente é quantitativa.

# Qual modelo melhor se aproxima dos dados e quais seus prós e contras?
Em minhas tentativas de prever o preço dos apartamentos usando as variáveis especificadas anteriormente, obtive os melhores resultados utilizando um modelo XGBoost Tree. Também tentei resolver o problema utilizando floresta aleatória e regressão linear. Dentre os modelos testados, o modelo baseado no algoritmo de XGBoost Tree foi capaz de alcançar medidas de desempenho superiores aos demais.

Dentre as vantagens do XGBoost Tree, destacam-se a sua flexibilidade e a capacidade de proporcionar alto desempenho. Por outro lado, suas desvantagens incluem a complexidade inerente ao modelo e a necessidade de considerável capacidade computacional.

O XGBoost Tree provavelmente superou os outros modelos testados devido à sua natureza iterativa, que busca minimizar os resíduos a cada nova iteração. Essa característica faz com que o XGBoost Tree se beneficie de conjuntos de dados com um grande número de observações, que é exatamente o caso do conjunto de dados fornecido para o desafio. Portanto, devido aos grandes resíduos apresentados nas primeiras iterações e ao grande volume de observações, é compreensível que este modelo tenha se ajustado bem ao desafio proposto.

# Qual a medida de performance do modelo foi escolhida e por quê?
A medida de performance utilizada foi o coeficiente de determinação (R²), comummente utilizada na avaliação de modelos preditivos. O R² pode ser expresso em um número entre 0 e 1, e expressa a quantidade da variância dos dados que é explicada pelo modelo. Logo, quanto mais próximo de 1, maior a quantidade de variância explicada pelo modelo.


# 4.Supondo um apartamento com as sequintes características (características descritas no arquivo que descreve o desafio):
# Qual seria a sua sugestão de preço?
225,1202.


