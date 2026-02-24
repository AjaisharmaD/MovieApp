# MovieApp

This is a movie app which displays the list of movies from the TMDB API Repository. Here the architecture followed is MVVM which is the recommended architecture by Apple and this also promotes better separate of layers between UI, Business Logic and Data. 

Setup:
 - Clone the Repo
 - Go to TMDB website (https://www.themoviedb.org/)
 - Generate the API Key
 - Paste the API key inside the /Utils/Constants on the apiKey variable

Assumptions:
 - Need to Display the List of popular Movies on the home screen with Favourite indicator.
 - Home page should have the Search feature.
 - On clicking a Movie should display the details of the movie, and Also have a feature to display the trailer on Youtube.
 - On the Details page we can Add the movie to the favourite.

Implemted features:
 - Movie List for Popular movies (/movie/popular/)
 - Details of Movie (/movie/id/)
 - Search Movies from the Home screen (/search/movie?api_key="key"&query="query")
 - Adding the movie to the list of favourites, this has been handled using UserDefaults to ensure the data is getting persisted even after app killed.
 - From the Movie Details Screen, added a option to view the trailer in the Web View.

Known limitations & Further Enhancements:
 - To enhance user experience we could persist the data inside the Core data, so when internet is unstable we could display some data to the user.
 - We could add the pull to refresh.
 - List of favorite movies screen could be added to view the user's favourited movies.
 - Movie can be favourited from the Home Screen Cell View.
