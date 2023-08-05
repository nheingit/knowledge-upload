# CSV Knowledge Chatbot

CSV Knowledge Chatbot is a Rails application that allows users to upload a CSV file (Just from Readwise currently) and then interact with the data through a chat interface. It's designed to make data exploration easier and more intuitive, without the need for advanced technical knowledge or database querying skills.

## Features

- Upload Readwise CSV files and embed them in the application.
- Interact with your data through a user-friendly chat interface.
- Ask questions about your data and get immediate answers.

## Tech Stack
This uses the [LangchainRB](https://github.com/andreibondarev/langchainrb) as the main way to interact with the AI apis. When you upload a CSV it will try to use the OpenAI ada embedding model on all of the rows in the CSV that you uploaded. 
It will store the notes along with the note's vector representation in a PGVector store.
You could connect to a local instance, but I opted to use Supabase for this app.


## Installation

This application requires Ruby, Rails, and Node.js. It also uses Yarn for package management.

To install the application:

1. Clone the repository:

    ```
    git clone https://github.com/nheingit/knowledge-retrieval.git
    ```

2. Change into the application directory:

    ```
    cd knowledge-retrieval
    ```

3. Install the required gems:

    ```
    bundle install
    ```

4. Install the required Node.js packages:

    ```
    yarn install
    ```

5. Set up the database:

    ```
    rails db:setup
    ```

6. Start the app:

    ```
    bin/dev
    ```

## Usage

To use the application:

1. Navigate to the application in your web browser (the default address is http://localhost:3000).
2. Use the interface to upload a CSV file.
3. Once the file is uploaded, you can start asking questions about your data in the chat interface.

## Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) and our [Code of Conduct](CODE_OF_CONDUCT.md) for details on our code of conduct and the process for submitting pull requests to us.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
