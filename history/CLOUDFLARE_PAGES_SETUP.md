# Cloudflare Pages Deployment Setup

This document explains how to deploy prazefarm.co.uk to Cloudflare Pages.

## Prerequisites

The site is already using Cloudflare for DNS, so we're adding Cloudflare Pages for hosting.

## Build Process

The site uses `redo` (goredo) for building:
- Source files: `*.html.in` files
- Build command: `redo all`
- Output directory: `public/`
- Dependencies: m4, toc (go package)

## Deployment Options

### Option 1: GitHub Actions (Recommended)

A GitHub Actions workflow has been created at `.github/workflows/cloudflare-pages.yml`.

**Setup Steps:**

1. Get your Cloudflare Account ID:
   - Go to https://dash.cloudflare.com/
   - Click on "Workers & Pages"
   - Your Account ID is shown in the right sidebar

2. Create a Cloudflare API Token:
   - Go to https://dash.cloudflare.com/profile/api-tokens
   - Click "Create Token"
   - Use the "Edit Cloudflare Workers" template or create custom with:
     - Account > Cloudflare Pages > Edit
   - Save the token

3. Add GitHub Secrets:
   - Go to your GitHub repository settings
   - Navigate to Secrets and variables > Actions
   - Add these secrets:
     - `CLOUDFLARE_API_TOKEN`: Your API token from step 2
     - `CLOUDFLARE_ACCOUNT_ID`: Your account ID from step 1

4. Push to main branch - the workflow will automatically deploy!

### Option 2: Wrangler CLI

You can use Wrangler for local development and manual deployment:

```bash
# Install Wrangler
npm install -g wrangler

# Login to Cloudflare
wrangler login

# Deploy
wrangler pages deploy public --project-name prazefarm
```

### Option 3: Cloudflare Dashboard

1. Go to https://dash.cloudflare.com/
2. Navigate to "Workers & Pages"
3. Click "Create application" > "Pages" > "Connect to Git"
4. Select your GitHub repository
5. Configure build settings:
   - Build command: `redo all`
   - Build output directory: `public`
   - Add build environment variables if needed

## Custom Domain

To use prazefarm.co.uk as the custom domain:

1. In Cloudflare Pages dashboard, go to your project
2. Click "Custom domains" tab
3. Click "Set up a custom domain"
4. Enter `prazefarm.co.uk` and `www.prazefarm.co.uk`
5. Cloudflare will automatically configure the DNS records

## Migration from AWS S3

The current setup uses AWS S3 (see `upload.do`). After Cloudflare Pages is working:

1. Test the Cloudflare Pages deployment thoroughly
2. Update DNS to point to Cloudflare Pages
3. Keep S3 as backup or decommission
4. Update or remove `upload.do` as needed

## Testing

After deployment, verify:
- [ ] Homepage loads: https://prazefarm.co.uk/
- [ ] Cottage page: https://prazefarm.co.uk/cottage/
- [ ] Curtains page: https://prazefarm.co.uk/curtains/
- [ ] Enquiry page: https://prazefarm.co.uk/enquiry/
- [ ] Static assets load (CSS, images)
- [ ] Table of contents works on cottage pages
