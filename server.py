from flask import Flask, request, jsonify
from flask_cors import CORS
import google.generativeai as genai
import os
import wikipedia

import json

def get_api_key():
    with open('config.json') as config_file:
        config = json.load(config_file)
        return config.get('API_KEY')


# Initialize Flask app
app = Flask(__name__)
CORS(app)
# Set the API key from environment variable
os.environ['GOOGLE_API_KEY'] = get_api_key()

# Configure the GenAI library
genai.configure(api_key=os.environ['GOOGLE_API_KEY'])

# Create a Generative Model instance
model = genai.GenerativeModel('gemini-pro')

# Initialize a chat history
history = []

# Start a chat session
chat = model.start_chat(history=history)


# Route to receive voice input from the HTML file
@app.route('/gemini', methods=['POST'])
def receive_voice_input():
    data = request.json
    voice_input = data.get('gemini', '')
    response = chat.send_message(voice_input)
    # response = chat.send_message(voice_input + " only return the answer to the question and nothing else")
    ai_response = response.text
    return jsonify({'ai_response': ai_response})

@app.route('/wiki_summary', methods=['POST'])
def get_wikipedia_summary():
    data = request.json
    search_query = data.get('search_query', '')
    # Fetch the Wikipedia summary for the given search query
    summary = wikipedia.summary(search_query, sentences=3)
    return jsonify({'summary': summary})

if __name__ == '__main__':
    app.run(debug=True)