
## Summary

### Run with Malformed URL
- Shows both good data and malformed data  
- Example:  
![Malformed Data](https://github.com/tingqu/Fetch_Recipe_Repo/blob/main/MalformedURLExample.gif)

---

### Run with Empty URL
- Shows empty results  
- Example:  
![alt text](https://github.com/tingqu/Fetch_Recipe_Repo/blob/main/EmptyURLExample.PNG)


## Focus Areas

### Parts I prioritize
- Smooth View to display the data from URL because a user friendly UI is the key part to make the user stay in the app 
- Cache URL results to SwiftData for local  in order to save time for next time access and reduce redudant remote request.
- Cache Image to file manager for local in order to reduce redundant remote image request

## Time Spent
- I spent around 5 hours for this project. I spent around 1 hour to plan out the basic strucure for the app.
  I choose MVVM for this project to make structure organized and scalable in the future. For the rest of time, it were spent on building the structure and cache results.

## Trade-offs and Decisions
- I decided to cache API results and image separatly because API results can be decode into a list of Recipes and SwiftData works as a local databas, so for the later scalability,
  like adding more models, we can build the relations between Recipe Model and other new model. However, image is better to cache inside of File Manager because File Manager has direct
  access to disk, so it is fast and save memory space. The trade off may be increasing the complexity of code.

## Weakest Part of the Project
- I think the weakest part of this project is Error Handling, even though most of edge cases are handle in the project, but it should be better error response view to show when
  the function throws a error






