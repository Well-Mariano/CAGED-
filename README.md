# CAGED

Projeto para acesso, tratamento e visualização de microdados do CAGED utilizando a linguagem R. O objetivo é facilitar a análise de empregabilidade por meio de tabelas, gráficos e mapas, tornando os dados acessíveis para analistas e pesquisadores da área.

## Objetivo

Este projeto demonstra como acessar, tratar e gerar outputs a partir dos microdados do CAGED, facilitando o processo de análise e tomada de decisão para profissionais interessados no mercado de trabalho brasileiro.

## Público-alvo

Destinado a analistas de empregabilidade, profissionais de RH, pesquisadores e interessados em dados sobre o mercado de trabalho.

## Funcionalidades

- **Acesso aos microdados do CAGED**  
  Scripts em R para baixar e ler os dados diretamente dos repositórios oficiais.

- **Tratamento dos dados**  
  Limpeza, filtragem e organização dos dados para análise eficiente.

- **Geração de outputs**  
  - **Tabelas**: Resumos estatísticos dos principais indicadores de empregabilidade.
  - **Gráficos**: Visualizações para facilitar o entendimento dos dados.
  - **Mapas**: Distribuição geográfica das informações.

## Como utilizar

### 1. Instalação dos pacotes necessários

```
install.packages(c("tidyverse", "sf", "ggplot2", "readr"))
```

### 2. Execução dos scripts

Os códigos estão disponíveis em dois arquivos principais:

- `acesso_e_tratamento.R`: Realiza o download e tratamento dos microdados.
- `visualizacao.R`: Gera tabelas, gráficos e mapas dos dados tratados.

#### Exemplo de uso

```r
source("acesso_e_tratamento.R")
dados <- tratar_caged("microdados.csv")

source("visualizacao.R")
gerar_graficos(dados)
gerar_mapas(dados)
```

## Estrutura do projeto

```
├── acesso_e_tratamento.R
├── visualizacao.R
├── README.md
└── exemplos/
    ├── exemplo_tabela.png
    ├── exemplo_grafico.png
    └── exemplo_mapa.png
```

## Exemplos de outputs

Veja abaixo exemplos de outputs gerados pelo projeto:

- **Tabela**: ![Tabela de exemplo](exemplos/exemplo_tabela.png)
- **Gráfico**: ![Gráfico de exemplo](exemplos/exemplo_grafico.png)
- **Mapa**: ![Mapa de exemplo](exemplos/exemplo_mapa.png)

## Créditos

Desenvolvido por [Well-Mariano](https://github.com/Well-Mariano)  
Referências:  
- Ministério do Trabalho – CAGED  
- Documentação oficial dos microdados

## Licença

Este projeto está sob a licença MIT.