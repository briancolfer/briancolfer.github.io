# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Purpose

This is Brian Colfer's personal professional website, a GitHub Pages site built with Jekyll using the Midnight theme. The site showcases Brian's professional qualifications and experience as a Release Engineer.

## Architecture

This is a minimal Jekyll site with the following structure:
- `_config.yml` - Jekyll configuration specifying the `jekyll-theme-midnight` theme
- `README.md` - Main content that serves as the homepage
- Jekyll generates the site into `_site/` directory during build
- GitHub Pages automatically builds and deploys the site from the `master` branch

The site uses GitHub's built-in Jekyll processing, so it doesn't require local Jekyll folders like `_layouts`, `_includes`, or `_posts` as it relies on the remote theme.

## Local Development

To work with this site locally:

```bash
# Install dependencies (first time only)
bundle install

# Serve the site locally with live reload
bundle exec jekyll serve --livereload

# Build the site for production
bundle exec jekyll build

# View the built site
open _site/index.html
```

The site will be available at `http://localhost:4000` when running locally.

## Deployment

This site is automatically deployed via GitHub Pages. To make changes:

```bash
# Ensure you're on the master branch
git checkout master

# Pull latest changes
git pull origin master

# Make your changes, then commit and push
git add .
git commit -m "Update site content"
git push origin master
```

GitHub Pages will automatically rebuild and deploy the site within a few minutes. The site is available at `https://briancolfer.github.io`.

## Content Updates

The main content is in `README.md`, which serves as the homepage. This file contains Brian's professional summary and qualifications. Updates to this file will be reflected on the live site after pushing to the `master` branch.

## Theme Customization

The site uses the `jekyll-theme-midnight` theme specified in `_config.yml`. To customize:
- Override theme files by creating corresponding files in the repository
- Add custom CSS in `assets/css/style.scss`
- Modify site configuration in `_config.yml`
