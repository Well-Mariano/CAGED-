### Exemplos de tabelas para visualização

# Tabela saldo por região
tabela_br <- caged %>%
  group_by(região) %>%
  filter(!is.na(região)) %>%
  filter(!is.na(saldomovimentação)) %>%
  summarise(saldo = sum(saldomovimentação, na.rm = T)) %>%
  arrange(desc(saldo))

Total_br <- tibble(
  região = "Brasil",
  saldo = sum(tabela_br$saldo, na.rm = T)
)

tabela_saldo_br <- bind_rows(tabela_br, Total_br)

tabela_saldo_br %>%
  mutate(
    percentual = saldo / Total_br$saldo
  ) %>%
  gt() %>%
  tab_header(
    title = md("***Saldo por Região Brasileira***")
  ) %>%
  fmt_percent(
    columns = percentual,
    decimals = 2,
    dec_mark = ",",
    sep_mark = "."
  ) %>%
  cols_label(
    região = "Região",
    saldo = "Saldo",
    percentual = "Participação"
  )

# Tabela Saldo por Setor da economia na região Nordeste
tab_saldo_setor <- caged %>%
  group_by(uf, setor) %>%
  filter(região == "Nordeste") %>%
  filter(!is.na(uf)) %>%
  summarise(saldo = sum(saldomovimentação, na.rm = TRUE), .groups = 'drop') %>%
  pivot_wider(
    names_from = "uf",
    values_from = "saldo"
  ) %>%
  mutate(Total = rowSums(select(., where(is.numeric)), na.rm = TRUE)) %>%
  arrange(desc(Total))


tab_saldo_setor %>%  gt() %>% tab_header(
  title = md("***Saldo por setor da economia no Nordeste***")
)
