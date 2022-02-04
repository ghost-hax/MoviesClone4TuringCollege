# Movies
# Functionalities
1.User can search Movies and will see list of movies, on selection of a movie it will show the details of tht ovie
2.User can mark searched movies as favourite
3.Favourite marked movies will be persisted and be visible on relaunch of app

# Architecture

1. It is using MVVM architecture
2. It is using coreData framework to store favourite movies
3. The UI is created using UIKit framework
4. It is  using combine framework for data binding
5. It uses repositorty pattern to communictate between network layer and storage layer
6. Other patterns used are: singleton, protocol extension, dependancy injections

#Testing

1.Unit Test cases are there for viewmodel
2.Mocking and stubbing is used to test network layer and core data layer
