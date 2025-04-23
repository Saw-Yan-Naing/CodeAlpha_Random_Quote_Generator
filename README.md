## This is internship project(Task One) from codeAlpha 

### The project name is Quote Generator

### Libraries I Used

This project uses the following library:

- **dio**: For making API requests to fetch random quotes.
- **riverpod**: For State management and DI.
- **flutter_hooks**: For the state within the widget which doesn't need to expose
- **responsive_framework**: For the responsive Ui.
- **window_manager**: For the the minimum screen size
- **envied**: For the env with generator 

### API Used

For the API, I used [Dummy Json](https://dummyjson.com/docs/quotes).

### Documentation 

#### API Call Documentation

This project contains one API call to fetch random quotes. Below are the details:

- **Endpoint**: `https://dummyjson.com/quotes/random`
- **Method**: GET
- **Description**: Fetches a randomly generated quote from the Dummy Json API.
- **Response Example**:
    ```json
    {
        "id": 1,
        "quote": "Life isn’t about getting and having, it’s about giving and being.",
        "author": "Kevin Kruse"
    }
    ```
- **Usage**: The API call is made using the `dio` library, and the response is managed using `riverpod` for state management.