#### Render county level reports

render_report = function(fips, id, county_name, state_name) {
  rmarkdown::render(
    "county_template.Rmd", params = list(
      fips = fips,
      state_county_id = id,
      county_name = county_name, 
      state_name = state_name
    ),
    output_file = paste0("county_reports/Report_", id, ".html")
  )
}

df <- read_csv("data/current_county_cases_NYT.csv") %>% 
  mutate(id = paste0(state,"_",county)) %>% 
  mutate(id = sub(" ", "_", id)) %>% 
  group_by(id, state, county, fips) %>% summarise() %>% 
  filter(state == 'California')

for(fp in df$fips){

  state_id <- (df %>% filter(fips == fp))$state
  
  county_id <- (df %>% filter(fips == fp))$county
  
  state_county_id <- (df %>% filter(fips == fp))$id
  
  render_report(fips = fp, id = state_county_id, state_name = state_id, county_name= county_id)
}

#render_report(fips = id, county_name = "ABCD", state_name = "Alabama")