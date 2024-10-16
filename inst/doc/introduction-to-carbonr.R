## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- eval = FALSE------------------------------------------------------------
#  # install.packages("devtools")
#  devtools::install_github("IDEMSInternational/carbonr")

## ---- message = FALSE, warning = FALSE----------------------------------------
library(carbonr)

## ---- message = FALSE, warning = FALSE, eval=FALSE, include=TRUE--------------
#  airport_finder(name = "Vancouver")

## ---- message = FALSE, warning = FALSE, echo = FALSE--------------------------
airport_finder(name = "Vancouver") %>%
  knitr::kable()

## ---- message = FALSE, warning = FALSE, eval=FALSE, include=TRUE--------------
#  airport_finder(name = "Toronto")

## ---- message = FALSE, warning = FALSE, echo = FALSE--------------------------
airport_finder(name = "Toronto") %>%
  knitr::kable()

## ---- message = FALSE, warning = FALSE----------------------------------------
airplane_emissions("YVR", "YTZ")

## ---- message = FALSE, warning = FALSE, eval=FALSE, include=TRUE--------------
#  seaport_finder(country = "Australia", city = "Melbourne")

## ---- message = FALSE, warning = FALSE, echo = FALSE--------------------------
seaport_finder(country = "Australia", city = "Melbourne") %>%
  knitr::kable()

## ---- message = FALSE, warning = FALSE, eval=FALSE, include=TRUE--------------
#  seaport_finder(country = "US", city = "New York")

## ---- message = FALSE, warning = FALSE, echo = FALSE--------------------------
seaport_finder(country = "US", city = "New York") %>%
  knitr::kable()

## ---- message = FALSE, warning = FALSE----------------------------------------
ferry_emissions("POR", "BOY", round_trip = TRUE)

## ---- message = FALSE, warning = FALSE, eval=FALSE, include=TRUE--------------
#  multiple_ind <- tibble::tribble(~ID, ~station,
#                          "From", "Bristol",
#                          "To", "Edinburgh",
#                          "Via", "Birmingham")
#  purrr::map(.x = multiple_ind$station, .f = ~rail_finder(.x)) %>%
#    dplyr::bind_rows()

## ---- message = FALSE, warning = FALSE, echo=FALSE----------------------------
multiple_ind <- tibble::tribble(~ID, ~station,
                        "From", "Bristol",
                        "To", "Edinburgh",
                        "Via", "Birmingham")
purrr::map(.x = multiple_ind$station, .f = ~rail_finder(.x)) %>%
  dplyr::bind_rows() %>%
  knitr::kable()

## ---- message = FALSE, warning = FALSE----------------------------------------
rail_emissions(from = "Bristol Temple Meads", to = "Edinburgh", via = "Birmingham New Street")

## ---- message = FALSE, warning = FALSE, eval=FALSE, include=TRUE--------------
#  multiple_ind <- tibble::tribble(~ID, ~rail_from, ~rail_to, ~air_from, ~air_to, ~air_via,
#                          "Clint", "Bristol Temple Meads", "Paddington", "LHR", "KIS", "NBO",
#                          "Zara", "Bristol Temple Meads", "Paddington", "LHR", "LAX", "ORL")
#  multiple_ind %>%
#    dplyr::rowwise() %>%
#    dplyr::mutate(plane_emissions = airplane_emissions(air_from,
#                                                air_to,
#                                                air_via)) %>%
#    dplyr::mutate(train_emissions = rail_emissions(rail_from,
#                                            rail_to)) %>%
#    dplyr::mutate(total_emissions = plane_emissions + train_emissions)

## ---- message = FALSE, warning = FALSE, echo = FALSE--------------------------
multiple_ind <- tibble::tribble(~ID, ~rail_from, ~rail_to, ~air_from, ~air_to, ~air_via,
                        "Clint", "Bristol Temple Meads", "Paddington", "LHR", "KIS", "NBO",
                        "Zara", "Bristol Temple Meads", "Paddington", "LHR", "LAX", "ORL")
multiple_ind %>%
  dplyr::rowwise() %>%
  dplyr::mutate(plane_emissions = airplane_emissions(air_from,
                                              air_to,
                                              air_via)) %>%
  dplyr::mutate(train_emissions = rail_emissions(rail_from,
                                          rail_to)) %>%
  dplyr::mutate(total_emissions = plane_emissions + train_emissions) %>%
  knitr::kable()

## ---- message = FALSE, warning = FALSE----------------------------------------
office_emissions(specify = TRUE, electricity_kWh = 255.2, water_supply = 85, heat_kWh = 8764)

## ---- message = FALSE, warning = FALSE, eval=FALSE, include=TRUE--------------
#  df <- data.frame(time = c("10/04/2000", "10/04/2000", "11/04/2000", "11/04/2000", "12/04/2000", "12/04/2000"),
#  theatre = rep(c("A", "B"), times = 3),
#  desflurane = c(30, 0, 25, 0, 28, 0),
#  isoflurane = c(0, 37, 0, 30, 0, 35),
#  clinical_waste = c(80, 90, 80, 100, 120, 110),
#  electricity_kwh = c(100, 110, 90, 100, 100, 110),
#  general_waste = c(65, 55, 70, 50, 60, 30))

## ---- message = FALSE, warning = FALSE, echo=FALSE----------------------------
data.frame(time = c("10/04/2000", "10/04/2000", "11/04/2000", "11/04/2000", "12/04/2000", "12/04/2000"),
theatre = rep(c("A", "B"), times = 3),
desflurane = c(30, 28, 25, 0, 0, 0),
isoflurane = c(0, 0, 0, 30, 37, 35),
clinical_waste = c(80, 90, 80, 100, 120, 110),
electricity_kwh = c(100, 110, 90, 100, 100, 110),
general_waste = c(65, 55, 70, 50, 60, 30)) %>%
  knitr::kable()

## ---- message = FALSE, warning = FALSE, eval=FALSE, include=TRUE--------------
#  # get emissions and CPI (carbon price index)
#  clinical_theatre_data(df, time = time, name = theatre,
#                    wet_clinical_waste = clinical_waste,
#                    wet_clinical_waste_unit = "kg",
#                    average = general_waste,
#                    plastic_units = "kg",
#                    electricity_kWh = electricity_kwh,
#                    include_cpi = TRUE,
#                    jurisdiction = "Australia",
#                    year = 2023)

## ---- message = FALSE, warning = FALSE, echo=FALSE----------------------------
# get emissions and CPI (carbon price index)
df <- data.frame(time = c("10/04/2000", "10/04/2000", "11/04/2000", "11/04/2000", "12/04/2000", "12/04/2000"),
theatre = rep(c("A", "B"), times = 3),
desflurane = c(30, 0, 25, 0, 28, 0),
isoflurane = c(0, 37, 0, 30, 0, 35),
clinical_waste = c(80, 90, 80, 100, 120, 110),
electricity_kwh = c(100, 110, 90, 100, 100, 110),
general_waste = c(65, 55, 70, 50, 60, 30))
results <- clinical_theatre_data(df, time = time, name = theatre,
                  wet_clinical_waste = clinical_waste,
                  wet_clinical_waste_unit = "kg",
                  average = general_waste,
                  plastic_units = "kg",
                  electricity_kWh = electricity_kwh,
                  include_cpi = TRUE,
                  jurisdiction = "Australia",
                  year = 2023)
results[[1]] %>% knitr::kable()

## ---- eval = FALSE------------------------------------------------------------
#  shiny_emissions()

