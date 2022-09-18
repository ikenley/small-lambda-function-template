# small-lambda-function-template

Template for a small (no dependencies, no complex logic) Lambda Function written in Typescript for the Node.js runtime

Lambda Functions have two sustainable equilibria:

1. Small:
   - Quick and dirty
   - A few lines of code that would fit in one `main.js` file
   - Zero external dependencies
   - 30 years ago these would have been Perl scripts
   - Managed via a zip archive in an S3 bucket
   - These tend to solve jobs like "when an S3 object drops, publish a message to an SQS queue"
2. Big:
   - Fully featured services, with tests, a boostrapping service, etc.
   - Similar to a large REST API, except it uses a Lambda event for an entry point rather than a controller
   - External package dependencies
   - Managed via a Docker image that extends the base Lambda image
   - These exist because a Lambda hook is the only option available (e.g. Cognito event hook)

This repository has boilerplate code for (1), the quick-and-dirty function. It nevertheless uses Typescript, because we are not savages.

---

## Getting Started

---

## Building the Source Function

```
cd s3-notify-function
npm i
npm run build
```
