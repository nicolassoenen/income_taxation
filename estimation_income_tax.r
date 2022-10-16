source("libraries.R")

#parameters
yearly_income <- 60000 #input income

tax_free_income <- 9050

taxation <-
    tibble(
        bracket = seq(1, 4),
        amount = c(13540, 23900, 41360, NA),
        rate = c(0.25, 0.4, 0.45, 0.5)) %>%
    mutate(taxation = amount * rate)


#estimations
taxable_income <- yearly_income - tax_free_income
taxation %<>%
    mutate(taxation_income =
        case_when(taxable_income > amount ~ taxation,
                  TRUE ~ (taxable_income - lag(amount)) * rate)