To give access to a webhook secret token across all repositories in Bitbucket, follow these steps:

### 1. **Generate the Webhook Secret Token:**
   - If you haven't already, generate a secret token that will be used to verify requests coming from Bitbucket.

### 2. **Set Up the Webhook with the Secret Token:**
   - Go to your Bitbucket repository.
   - Navigate to **Repository settings** > **Webhooks**.
   - Click on **Add webhook**.
   - Fill in the **Title** and **URL** for the webhook.
   - In the **Secret** field, enter the secret token you generated.

### 3. **Share the Secret Token Across Repositories:**
   - If you want to use the same secret token across multiple repositories, you'll need to manually set up the webhook in each repository using the same secret token.

### 4. **Automate the Process (Optional):**
   - You can use Bitbucket's API to automate the process of setting up the same webhook with the same secret token across multiple repositories.

   Here's a sample script using cURL:

   ```bash
   curl -X POST -u username:password \
   -H "Content-Type: application/json" \
   -d '{
         "description": "My Webhook",
         "url": "https://example.com/webhook",
         "active": true,
         "events": ["repo:push", "pullrequest:created", "pullrequest:updated"],
         "configuration": {
             "secret": "your_secret_token_here"
         }
       }' \
   https://api.bitbucket.org/2.0/repositories/your_workspace/your_repo_slug/hooks
   ```

   Replace the following placeholders:
   - `username:password`: Your Bitbucket username and password (or app password).
   - `https://example.com/webhook`: The URL of your webhook endpoint.
   - `your_secret_token_here`: The secret token you generated.
   - `your_workspace`: Your Bitbucket workspace.
   - `your_repo_slug`: The slug of the repository where you want to add the webhook.

   Repeat the API call for each repository, or create a script to loop through all your repositories.

### 5. **Verify the Setup:**
   - Once the webhooks are set up, you can test them to ensure that the secret token is being sent correctly and that your endpoint is validating it properly.

This process ensures that the same webhook secret token is used across all your repositories, allowing consistent security and verification for incoming requests.
