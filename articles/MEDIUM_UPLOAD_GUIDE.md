# Uploading Articles to Medium

This guide explains how to publish your articles to Medium using the Medium API.

## Prerequisites

1. **Medium Account** — with a publication (or personal account)
2. **Integration Token** — get from https://medium.com/me/settings under "Integration Tokens"
3. **GitHub Pages Published** — your article images must be accessible via HTTPS

## Step 1: Get Your Medium Integration Token

1. Go to https://medium.com/me/settings
2. Scroll to "Integration tokens"
3. Enter a token description (e.g., "Publishing from GitHub Pages")
4. Click "Create token"
5. Copy the token immediately (you won't see it again)

Store it securely:

```bash
export MEDIUM_TOKEN='your_token_here'
```

## Step 2: Ensure Images Are Pushed to GitHub Pages

Before uploading, commit and push any new images to ensure they're publicly accessible:

```bash
# From the briancolfer.github.io directory
git add articles/lsp-cicd/images/
git commit -m "Add images for LSP-CICD article"
git push origin master
```

Then verify the image is live:

```bash
# Should return the SVG content
curl https://briancolfer.github.io/articles/lsp-cicd/images/cicd_lsp_model.svg
```

## Step 3: Prepare Your Article for Medium

Medium's API accepts:

- **Title** — extracted from your article frontmatter
- **Content** — HTML or Markdown
- **Tags** — keywords for discoverability
- **Publication** — (optional) if you're publishing to a publication

### Convert Markdown to HTML (if needed)

If Medium requires HTML instead of Markdown, use a converter:

```bash
# Using pandoc (install if needed: brew install pandoc)
pandoc -f markdown -t html articles/lsp-cicd/index.md -o lsp-cicd.html
```

## Step 4: Get Your User ID

You need your Medium user ID to publish. Retrieve it with:

```bash
curl -H "Authorization: Bearer $MEDIUM_TOKEN" \
  https://api.medium.com/v1/me
```

This returns JSON with your `id`. Save it:

```bash
export MEDIUM_USER_ID='your_user_id_here'
```

## Step 5: Create the API Request

### Basic Upload (Personal Publication)

```bash
curl -X POST https://api.medium.com/v1/users/$MEDIUM_USER_ID/posts \
  -H "Authorization: Bearer $MEDIUM_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "From Pipeline Gates to Decision Systems: Applying LSP to DevOps",
    "contentFormat": "markdown",
    "content": "# Your article content here...",
    "tags": ["devops", "cicd", "lsp", "dora"],
    "publishStatus": "draft"
  }'
```

### Using a Script

Create `upload_to_medium.sh`:

```bash
#!/bin/bash

# Configuration
ARTICLE_TITLE="From Pipeline Gates to Decision Systems: Applying LSP to DevOps"
ARTICLE_FILE="articles/lsp-cicd/index.md"
TAGS='["devops", "cicd", "lsp", "decision-systems"]'
PUBLISH_STATUS="draft"  # Change to "public" when ready

# Validate token and user ID
if [ -z "$MEDIUM_TOKEN" ] || [ -z "$MEDIUM_USER_ID" ]; then
  echo "Error: MEDIUM_TOKEN and MEDIUM_USER_ID environment variables must be set"
  exit 1
fi

# Extract content (remove frontmatter)
CONTENT=$(tail -n +5 "$ARTICLE_FILE")

# Create the request payload
PAYLOAD=$(cat <<EOF
{
  "title": "$ARTICLE_TITLE",
  "contentFormat": "markdown",
  "content": $(echo "$CONTENT" | jq -R -s '.'),
  "tags": $TAGS,
  "publishStatus": "$PUBLISH_STATUS"
}
EOF
)

# Send to Medium API
RESPONSE=$(curl -s -X POST https://api.medium.com/v1/users/$MEDIUM_USER_ID/posts \
  -H "Authorization: Bearer $MEDIUM_TOKEN" \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD")

# Check response
if echo "$RESPONSE" | jq -e '.data.id' > /dev/null 2>&1; then
  POST_ID=$(echo "$RESPONSE" | jq -r '.data.id')
  POST_URL=$(echo "$RESPONSE" | jq -r '.data.url')
  echo "✓ Article uploaded successfully!"
  echo "Draft URL: $POST_URL"
  echo "Post ID: $POST_ID"
else
  echo "✗ Upload failed:"
  echo "$RESPONSE" | jq '.'
  exit 1
fi
```

Make it executable:

```bash
chmod +x upload_to_medium.sh
```

## Step 6: Upload Your Article

Set your environment variables:

```bash
export MEDIUM_TOKEN='your_token_here'
export MEDIUM_USER_ID='your_user_id_here'
```

Run the upload:

```bash
./upload_to_medium.sh
```

The script will:
1. Extract your article content (skipping frontmatter)
2. Send it to Medium as a **draft**
3. Return the URL where you can review it

## Step 7: Review and Publish

1. Visit the URL returned by the script
2. Review the draft on Medium
3. Check:
   - Images render correctly
   - Formatting looks good
   - Links work
4. Once satisfied, either:
   - Publish directly on Medium's interface, OR
   - Update the script with `"publishStatus": "public"` and re-run

## Troubleshooting

**Error: Invalid token**
- Verify your token is copied correctly
- Tokens expire after 60 days — get a new one if needed

**Error: User ID invalid**
- Ensure you ran Step 4 and have the correct ID
- Check: `curl -H "Authorization: Bearer $MEDIUM_TOKEN" https://api.medium.com/v1/me`

**Images not rendering**
- Verify image URLs are publicly accessible
- Test with: `curl https://briancolfer.github.io/articles/lsp-cicd/images/cicd_lsp_model.svg`
- Medium may not support SVG — convert to PNG/JPG if needed:
  ```bash
  brew install imagemagick
  convert articles/lsp-cicd/images/cicd_lsp_model.svg articles/lsp-cicd/images/cicd_lsp_model.png
  ```

**Markdown formatting issues**
- Medium's Markdown support is limited
- Use `contentFormat: "html"` and convert with pandoc if needed
- Avoid complex Markdown features (some tables, custom formatting)

## API Reference

**Get User Info**
```bash
curl -H "Authorization: Bearer $MEDIUM_TOKEN" https://api.medium.com/v1/me
```

**Get Publications** (if you have multiple)
```bash
curl -H "Authorization: Bearer $MEDIUM_TOKEN" https://api.medium.com/v1/users/$MEDIUM_USER_ID/publications
```

**Create Post Options**
- `title` — (required) article title
- `content` — (required) article body
- `contentFormat` — `"html"` or `"markdown"` (default: `"html"`)
- `publishStatus` — `"draft"`, `"published"`, or `"unlisted"` (default: `"published"`)
- `tags` — array of strings, max 5 tags
- `canonicalUrl` — (optional) link to original article

## Notes

- **Drafts vs. Published**: Use `"draft"` status to preview before publishing
- **Canonical URLs**: If publishing to both your site and Medium, set `canonicalUrl` to your original article
- **Rate Limiting**: Medium allows 600 posts per hour per user
- **Republishing**: You can create multiple drafts but can't edit published posts via API (edit manually on Medium)
