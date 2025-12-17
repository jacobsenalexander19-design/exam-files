# Exercise 4 --------------------------------------------------------------
# json
req <- request("http://165.22.92.178:8080") %>% 
  req_url_path("responses") %>%
  req_url_query(format = "json") %>%
  req_headers(authorization = "DM_DV_123#!")

response <- req %>% 
  req_perform()
response # Inspect content type
response %>%
  resp_body_json()

# html
req <- request("http://165.22.92.178:8080") %>% 
  req_url_path("responses") %>%
  req_url_query(format = "html") %>%
  req_headers(authorization = "DM_DV_123#!")

response <- req %>% 
  req_perform()
response # Inspect content type
response %>%
  resp_body_html()

# Exercise 5 --------------------------------------------------------------
n <- 70
x1 <- rnorm(n = n)
x2 <- rnorm(n = n)
y <- 2*x1 + 3*x2 + rnorm(n = n)
df <- round(data.frame(y = y, x1 = x1, x2 = x2))
# Construct a request including the data
req <- request("http://165.22.92.178:8080") %>% 
  req_url_path("lm") %>%
  req_body_json(as.list(df)) %>%
  req_headers(authorization = "DM_DV_123#!")
# Send the request to the API
resp <- req %>% 
  req_perform()
# View the result
resp %>%
  resp_body_json()

# Exercise 6 --------------------------------------------------------------

req <- request("https://google-translate113.p.rapidapi.com/api/v1/translator/detect-language") %>% 
  req_headers('X-RapidAPI-Key' = "INSERT_YOUR_OWN_API_KEY",
              'X-RapidAPI-Host' = 'google-translate113.p.rapidapi.com' ) %>%
  req_body_json(list(text = "Hej verden!"))

resp <- req %>% 
  req_perform()
result <- resp %>%
  resp_body_json()

result$source_lang
result$trust_level
