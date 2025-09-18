### Script de acesso e tratamento dos dados do CAGED

# Bibliotecas a serem usadas:

library(archive)
library(readr)
library(tidyverse)

### Realizando o download dos microdados diretamente da FTP do MTE através do R:

download.file("ftp://ftp.mtps.gov.br/pdet/microdados/NOVO%20CAGED/2025/202507/CAGEDMOV202507.7z", # Sinaliza o caminho a ser seguido pelo R e qual arquivo baixar, só mudar as datas para a competência de interesse.
              destfile = "CAGEDMOV202507.7z", # Define onde e com qual nome o arquivo será salvo no seu computador.
              mode = "wb", # instrui o R a baixar o arquivo em modo binário para arquivos do tipo .zip, .7z, .xlsx, .pdf, .jpg
              method = "libcurl") # Este argumento especifica o método que o R usará para fazer o download. Para este caso será o libcurl.

### Fazendo o R extrair o arquivo .7z :

archive_extract(archive = "C:/Users/est.wmp/Desktop/Well/Caged/caged mensal/CAGEDMOV202507.7z", # Indica Qual será o arquivo a ser extraido.
                dir = "C:/Users/est.wmp/Desktop/Well/Caged/caged mensal") # Informa onde o arquivo extraído deve ser guardado.

### Importando os microdados que foram extraídos:

caged <- read.csv2("CAGEDMOV202507.txt", encoding = "UTF-8")

### Tratamento dos microdados

# Selecionando Variáveis de interesse para este exemplo:
# Resaltando que a adição de uma varíavel implica em um novo tratamento e, esse novo tratamento, deve ser conforme o dicionário dos dados.

caged <- caged %>%
  select(competênciamov, região, uf, município, seção, saldomovimentação, graudeinstrução, idade, raçacor, sexo, salário)

# Criando variável com os grandes setores da economia:

caged <-  caged %>% 
  mutate(setor = ifelse(seção %in% "A", "AGRICULTURA",
                        ifelse(seção %in% c("B","C","D","E"),"INDUSTRIA",
                               ifelse(seção %in% "F", "CONSTRUÇÃO",
                                      ifelse(seção %in% "G", "COMÉRCIO",
                                             ifelse(seção %in% c("H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "U", "T"), "SERVIÇOS", "DESCONHECIDO"))))))

# Recodificando as seções com os seus respectivos nomes:

caged <- caged %>% 
  mutate(seção = recode(seção,
                        "A" = "AGRICULTURA, PECUÁRIA E SERVIÇOS RELACIONADOS",
                        "B" = "INDUSTRIA EXTRATIVA",
                        "C" = "INDUSTRIA DE TRANSFORMAÇÃO",
                        "D" = "ELETRICIDADE E GÁS",
                        "E" = "AGUA, ESGOTO, ATIVIDADES DE GESTÃO DE RESÍDUOS E DESCONTAMINAÇÃO",
                        "F" = "CONSTRUÇÃO",
                        "G" = "COMÉRCIO, REPARAÇÃO DE VEÍCULOS E MOTOCICLETAS",
                        "H" = "TRANSPORTE, ARMAZENAGEM E CORREIO",
                        "I" = "ALOJAMENTO E ALIMENTAÇÃO",
                        "J" = "INFORMAÇÃO E COMUNICAÇÃO",
                        "K" = "ATIVIDADES FINANCEIRAS, DE SEGUROS E SERVIÇOS RELACIONADOS",
                        "L" = "ATIVIDADES IMOBILIÁRIAS",
                        "M" = "ATIVIDADES PROFISSIONAIS, CIENTÍFICAS E TÉCNICAS",
                        "N" = "ATIVIDADES ADMINISTRATIVAS E SERVIÇOS COMPLEMENTARES",
                        "O" = "ADMINISTRAÇÃO PÚBLICA, DEFESA E SEGURIDADE SOCIAL",
                        "P" = "EDUCAÇÃO",
                        "Q" = "SAÚDE HUMANA E SERVIÇOS SOCIAIS",
                        "R" = "ARTES, CULTURA, ESPORTE E RECREAÇÃO",
                        "S" = "OUTRAS ATIVIDADES DE SERVIÇOS",
                        "T" = "SERVIÇOS DOMÉSTICOS",
                        "U" = "ORGANISMOS INTERNACIONAIS E OUTRAS INSTITUIÇÕES EXTRATERRITORIAIS",
                        .default = "Desconhecido"))

# Recodificando as regiões conforme seus respectivos nomes:

caged <- caged %>% 
  mutate(região = recode(região,
                         "1" = "Norte",
                         "2" = "Nordeste",
                         "3" = "Sudeste",
                         "4" = "Sul",
                         "5" = "Centro-Oeste",
                         .default = "Desconhecido"))

# Recodificando os estados com seus respectivos nomes:

caged <- caged %>% 
  mutate(uf = recode(uf,
                     "11" = "Rondônia",
                     "12" = "Acre",
                     "13" = "Amazonas",
                     "14" = "Roraima",
                     "15" = "Pará",
                     "16" = "Amapá",
                     "17" = "Tocantins",
                     "21" = "Maranhão",
                     "22" = "Piauí",
                     "23" = "Ceará",
                     "24" = "Rio Grande do Norte",
                     "25" = "Paraíba",
                     "26" = "Pernambuco",
                     "27" = "Alagoas",
                     "28" = "Sergipe",
                     "29" = "Bahia",
                     "31" = "Minas Gerais",
                     "32" = "Espírito Santo",
                     "33" = "Rio de Janeiro",
                     "35" = "São Paulo",
                     "41" = "Paraná",
                     "42" = "Santa Catarina",
                     "43" = "Rio Grande do Sul",
                     "50" = "Mato Grosso do Sul",
                     "51" = "Mato Grosso",
                     "52" = "Goiás",
                     "53" = "Distrito Federal",
                     .default = "Desconhecido"))

# Substituir os códigos dos graus de instrução por seus respectivos nomes:

caged <- caged %>%
  mutate(graudeinstrução = recode(graudeinstrução,
                                  "1" = "Analfabeto",
                                  "2" = "Até 5º Incompleto",
                                  "3" = "5º Completo Fundamental",
                                  "4" = "6º a 9º Fundamental",
                                  "5" = "Fundamental Completo",
                                  "6" = "Médio Incompleto",
                                  "7" = "Médio Completo",
                                  "8" = "Superior Incompleto",
                                  "9" = "Superior Completo",
                                  "10" = "Mestrado",
                                  "11" = "Doutorado",
                                  "80" = "Pós-graduação completa",
                                  .default = "Desconhecido"))

# Recodificando os códigos de raça/cor por seus respectivos nomes:

caged <- caged %>%
  mutate(raçacor = recode(raçacor,
                          "1" = "Branca",
                          "2" = "Preta",
                          "3" = "Parda",
                          "4" = "Amarela",
                          "5" = "Indígena",
                          .default = "Desconhecido"))

# Recodificando os códigos dos sexos por seus respectivos nomes:

caged <- caged %>%
  mutate(sexo = recode(sexo,
                       "1" = "Homem",
                       "3" = "Mulher",
                       .default = "Desconhecido"))

# Criando variável para indentificar os admitidos e os demitidos

caged <- caged %>%
  mutate(situação = ifelse(saldomovimentação > 0, "admitido", ifelse(saldomovimentação < 0, "demitido", "Desconhecido")))

