tmin_2021 <- readr::read_csv("data/raw/tmin/tmin_2017_2021.csv") |> 
  dplyr::select(
    ubigeo, `20170101_temperature_2m_min`:`20211231_temperature_2m_min`
  )
tmin_2022 <- readr::read_csv("data/raw/tmin/tmin_2022_2022.csv") |> 
  dplyr::select(
    ubigeo, `20220101_temperature_2m_min`:`20221231_temperature_2m_min`
  )

dates_2021 <- seq.Date(as.Date("2017-01-01"), as.Date("2021-12-31"), by = "day")
colnames(tmin_2021) <- c(
  "ubigeo", paste0("mintemp_", stringr::str_replace_all(dates_2021, "-", ""))
)

dates_2022 <- seq.Date(as.Date("2022-01-01"), as.Date("2022-12-31"), by = "day")
colnames(tmin_2022) <- c(
  "ubigeo", paste0("mintemp_", stringr::str_replace_all(dates_2022, "-", ""))
)

tmin <- dplyr::inner_join(tmin_2021, tmin_2022, by = "ubigeo")

tmin_iquitos_2022 <- tmin |> 
  dplyr::filter(ubigeo == "160101") |> 
  tidyr::pivot_longer(
    cols = !ubigeo,
    names_prefix = "mintemp_",
    names_to = "fecha",
    values_to = "temp_min"
  ) |> 
  dplyr::mutate(fecha = lubridate::ymd(fecha)) |> 
  dplyr::filter(fecha >= as.Date("2022-01-01"))

readr::write_csv(tmin_iquitos_2022, "data/tmin_iquitos_2022.csv")

