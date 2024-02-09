# Desafio Lighthouse - Cientista de Dados
Abaixo estão as respostas para os itens 2, 3 e 4 do Desafio Lighthouse Cientista de Dados

# 2.a. Supondo que uma pessoa esteja pensando em investir em um apartamento para alugar na plataforma, onde seria mais indicada a compra?
A resposta para essa pergunta depende dos objetivos do comprador. Vou considerar que o comprador deseja maximizar o retorno do aluguel e não está preocupado com o investimento inicial necessário. Acredito que também seja válido considerar a disponibilidade ao responder essa pergunta, uma vez que apartamentos com menor disponibilidade devem ficar alugados por um período maior do ano, gerando, consequentemente, mais lucro para o investidor.

Durante as análises realizadas no EDA e nas hipóteses de negócio, foi possível observar que o distrito de Manhattan possui a maior média de preços e também o maior número de apartamentos com uma disponibilidade inferior a 30 dias. Portanto, um investidor que não estivesse preocupado com o investimento inicial deveria considerar a compra de um apartamento no distrito de Manhattan. Dessa forma, ele poderia receber um alto valor de aluguel e também teria uma alta demanda pelo seu imóvel recém-adquirido.

Optei por responder essa pergunta usando os distritos (variável “bairro_group”) em vez dos bairros (variável “bairro”), pois alguns bairros possuem um número muito pequeno de observações e esse fato poderia distanciar a resposta dessa pergunta da realidade da cidade de Nova York.

# 2.b. O número de mínimo de noites e a disponibilidade ao longo do ano interferem no preço?
As variáveis referentes ao mínimo de noites e à disponibilidade ao longo do ano interferem de maneira sutil na variável preço. Decidi utilizar ambas as variáveis no meu modelo, pois, com base no meu conhecimento do mundo real, muitas das variáveis presentes no conjunto de dados não representavam fontes confiáveis de informação para prever o preço do aluguel. Assim sendo, qualquer variável que apresentasse informações novas a serem capturadas pelo modelo e que tivesse alguma influência na variável dependente deveria ser considerada.

# 2.c. Existe algum padrão no texto do nome do local para lugares de mais alto valor?
Não tenho certeza se compreendi completamente a pergunta. Não consegui identificar padrões muito claros na variável “nome”. O mais próximo que encontrei de um padrão foi que, entre os 330 apartamentos de maior valor do conjunto de dados (a quantidade de 330 corresponde ao percentil 99 da variável “price”), as palavras “luxury”, “bedroom” e “townhouse” aparecem na variável “nome” em pelo menos 35 apartamentos. O código com as funções que usei para chegar a essa conclusão está anexado nesta pasta do diretório no arquivo "buscando_padrões". 

Caso a pergunta esteja relacionada à variável “bairro_group”, durante a minha Análise Exploratória de Dados (EDA), pude constatar que a maioria dos imóveis de alto valor está localizada em Manhattan. Portanto, é possível afirmar que existe um padrão onde a categoria Manhattan da variável “bairro_group” tende a se repetir em imóveis de maior valor.
