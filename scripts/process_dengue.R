dengue_raw <- readr::read_csv("data/raw/datos_abiertos_vigilancia_dengue.csv")

dengue_maynas <- dengue_raw |> 
  dplyr::filter(
    ano %in% c("2018", "2019"),
    provincia == "MAYNAS"
  ) |> 
  dplyr::mutate(
    localcod = ifelse(localcod == "0", NA, localcod)
  )

readr::write_csv(dengue_maynas, "data/dengue_maynas_2018-2019.csv")
