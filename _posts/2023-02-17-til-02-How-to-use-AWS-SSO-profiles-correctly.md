---
title: TIL 02 - How to use AWS SSO profiles correctly
layout: single
permalink: /til/02
date: '2023-02-17'
tags:
  - til
  - today-i-learned
  - aws
  - sso
  - credentials
  - ecr
classes: wide
author_profile: true

excerpt: "Today I learned - How to use AWS SSO profiles correctly with aws-cli commands"

header:
    overlay_image: /assets/images/splash/kevin-horvat-Pyjp2zmxuLk-unsplash.jpg
    teaser: /assets/images/splash/kevin-horvat-Pyjp2zmxuLk-unsplash.jpg
    # overlay_filter: 0.5
    caption: "Photo by Aaron Burden [**Unsplash**](https://unsplash.com/photos/6jYoil2GhVk)"
    image_description: Photo by Aaron Burden on Unsplash
--- 
# Today I Learned #02

## What is SSO?

> "Single sign-on (SSO) is an authentication solution that allows users to log in to multiple applications and websites with one-time user authentication. Given that users today frequently access applications directly from their browsers, organizations are prioritizing access management strategies that improve both security and the user experience. SSO delivers both aspects, as users can access all password-protected resources without repeated logins once their identity is validated." <https://aws.amazon.com/what-is/sso/>

Using SSO is a very secure way to authenticate applications. It's much more secure than traditional methods, such as one username and password per application, and it brings many benefits to enterprise user management and system integration. I won't explain in detail how it works or how to configure it, you can find lots of good information from experts, such as this post from Okta, <https://www.okta.com/uk/blog/2022/04/benefits-of-single-sign-on/>. 

## AWS with SSO

In the company I work for, we use AWS, which is integrated with our user platform, and the connection to that is through SSO.

So to use `aws-cli`, I need to authenticate with SSO first and then use the cli as it should be used. However, since I no longer have a static `.aws/credentials`, some commands need to be changed a bit to work properly.

### Login with SSO on aws-cli

```bash
aws sso login --profile <PROFILE_NAME>
```

To start the authentication process, use the `aws-cli` command. This command will open the browser and you'll need to log in with your online user platform and then authorize the process to get the credentials in cli. Once authorized, the credentials are specified as `ENV _VARIABLES`.

After that, you can execute commands normally in `aws-cli`. However, some commands require reading credentials from your computer, such as `ecr login`.

If you simply try to log in with the regular command, it won't work.

```bash
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 99999999999.dkr.ecr.us-east-2.amazonaws.com
```

It will fail with this:
```bash
Unable to locate credentials. You can configure credentials by running "aws configure".
```

The command fails because it cannot find the AWS credentials in the default `.aws/credentials` location. This can be fixed by passing the profile name as ENV _VARIABLE before the command: `AWS_PROFILE=<PROFILE_NAME>`

```bash
AWS_PROFILE=<PROFILE_NAME> aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 99999999999.dkr.ecr.us-east-2.amazonaws.com
Login Succeeded
```

From now on, if the command does not get authentication, try to show to `aws-cli` which profile you want to use.

### References
- [https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)
- [https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html)
- [https://docs.aws.amazon.com/cli/latest/userguide/sso-configure-profile-token.html](https://docs.aws.amazon.com/cli/latest/userguide/sso-configure-profile-token.html)
- [https://edenhare.medium.com/a-five-minute-overview-of-aws-single-sign-on-8816a73e1cfc](https://edenhare.medium.com/a-five-minute-overview-of-aws-single-sign-on-8816a73e1cfc)
- [https://github.com/awslabs/amazon-ecr-credential-helper/issues/229#issuecomment-1254972492](https://github.com/awslabs/amazon-ecr-credential-helper/issues/229#issuecomment-1254972492)
