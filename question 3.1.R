library(httr2)

# 1. Define the Request
# Based on documentation, the base URL is https://mdblist.p.rapidapi.com/
# and the search parameter is 's'.
req <- request("https://mdblist.p.rapidapi.com/") |>
  req_headers(
    "x-rapidapi-key" = "91e0b3a56fmsh19fbcfc946006e8p1bb5a4jsnc667c6cb97e8",
    "x-rapidapi-host" = "mdblist.p.rapidapi.com"
  ) |>
  req_url_query(s = "Christmas")

# 2. Perform the Request and Fetch Data
resp <- req |> req_perform()
data <- resp |> resp_body_json()

# 3. Extract the first movie's Title and ID
# The API typically returns a list of results in 'search' or 'result' key, 
# or directly as a list depending on the specific endpoint version.
# Assuming 'search' list or direct list:
first_movie <- data$search[[1]] # Adjust index based on actual JSON structure

# Print the results
print(paste("Title:", first_movie$title))
print(paste("ID:", first_movie$id)) # or first_movie$imdb_id depending on response