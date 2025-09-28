### Exemplos de Gráficos

# Gráfico Saldo por regiões do Brasil
caged %>%
  group_by(região) %>%
  summarise(saldo = sum(saldomovimentação, na.rm = T)) %>% 
  filter(região != "Desconhecido") %>% 
  mutate(região = fct_reorder(região, saldo)) %>%
  ggplot(aes(x = região, y = saldo, fill = região)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Saldo das Movimentações por Região",
       caption = "Ministério do Trabalho e Emprego (MTE)",
       x = "Região", 
       y = "Saldo Movimentação") +
  theme_minimal() +
  coord_flip() +
  geom_label(aes(label = saldo), hjust = 0.75, show.legend = F)

# Gráfico Saldo por regiões do Brasil
caged %>%
  group_by(região) %>%
  summarise(saldo = sum(saldomovimentação, na.rm = T)) %>% 
  filter(região != "Desconhecido") %>% 
  mutate(região = fct_reorder(região, saldo)) %>%
  ggplot(aes(x = região, y = saldo, fill = região)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Saldo das Movimentações por Região",
       caption = "Ministério do Trabalho e Emprego (MTE)",
       x = "Região", 
       y = "Saldo Movimentação") +
  theme_minimal() +
  coord_flip() +
  geom_label(aes(label = saldo), hjust = 0.75, show.legend = F)
