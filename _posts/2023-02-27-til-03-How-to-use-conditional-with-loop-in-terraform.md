---
title: TIL 03 - How to use conditional & loop in terraform
layout: single
permalink: /til/03
date: '2023-02-27'
tags:
  - til
  - today-i-learned
  - terraform
  - conditional
  - loop
classes: wide
author_profile: true

excerpt: "Today I learned - How to use conditional & loop in terraform"

header:
    overlay_image: /assets/images/splash/billy-freeman-koRmF1nz8iw-unsplash.jpg
    teaser: /assets/images/splash/billy-freeman-koRmF1nz8iw-unsplash.jpg
    overlay_filter: 0.5
    caption: "Photo by Billy Freeman on [**Unsplash**](https://unsplash.com/photos/koRmF1nz8iw)"
    image_description: Photo by Billy Freeman on Unsplash
    
--- 
# Today I Learned #03

f you use terraform, you know that **HCL** doesn't work exactly like a programming language, so you might run into some problems with complex logic now and then.

I was working on an upgrade for a Kubernetes module we use to manage our environments. After some time, I realized that I should control a specific setting for a specific environment (dev cluster only). So, it should be something like with count to enable this resource, right?

Yes, it should be if this resource doesn't already have a `for_each` loop, so I need to use a different approach to achieve this.

## Conditional Expression in Terraform

In the Terraform documentation you can read this explanation about **Conditional Expressions**. [https://developer.hashicorp.com/terraform/language/expressions/conditionals](https://developer.hashicorp.com/terraform/language/expressions/conditionals) 

> A conditional expression uses the value of a boolean expression to select one of two values.
  ```
  condition ? true_val : false_val
  ```
> If condition is true then the result is `true_val`. If condition is false then the result is `false_val`.

I had a code similar to this:

```terraform
locals {
  # use this for all roles 
  filenames = [
    "not-so-random-name-01",
    "not-so-random-name-02",
  ]
}

resource "local_file" "file" {
  for_each = toset(local.filenames)

  content  = "Content of ${each.key}.txt"
  filename = "${path.module}/${each.key}.txt"
}
```

When I try to add a count to apply this block, it fails with this result:

```terraform
$ terraform plan

  Error: Invalid combination of "count" and "for_each"
...
  The "count" and "for_each" meta-arguments are mutually-exclusive, only one should
  be used to be explicit about the number of resources to be created.
```

## How to fix it?

It's possible to combine the logic of the `for_each` loop and also check for conditions. In this example, I check the condition `var.env == dev`:

```terraform
for_each = var.env == "dev" ? toset(local.filenames) : toset([])
```
I could also replace this comparison with a boolean variable.

```terraform
for_each = var.enable == true ? toset(local.filenames) : toset([])
```

I could also check more than one condition:

```terraform
for_each = var.env == "dev" || var.env == "stg" ? toset(local.filenames) : toset([])
```

## Final code

With this extension of the original code, it was possible to do what I wanted, which was to apply it only in a desired environment, namely `env = dev`. 

```terraform
variable "env" {
  type    = string
  default = "dev"
}

locals {
  filenames = [
    "not-so-random-name-01",
    "not-so-random-name-02",
  ]
}

resource "local_file" "file" {
  for_each = var.env == "dev" ? toset(local.filenames) : toset([])

  content  = "Content of ${each.key}.txt"
  filename = "${path.module}/${each.key}.txt"
}
```

### Plan output

```terraform
$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  + create

Terraform will perform the following actions:

  # local_file.file["not-so-random-name-01"] will be created
  + resource "local_file" "file" {
      + content              = "Content of not-so-random-name-01.txt"
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "./not-so-random-name-01.txt"
      + id                   = (known after apply)
    }

  # local_file.file["not-so-random-name-02"] will be created
  + resource "local_file" "file" {
      + content              = "Content of not-so-random-name-02.txt"
      + directory_permission = "0777"
      + file_permission      = "0777"
      + filename             = "./not-so-random-name-02.txt"
      + id                   = (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.
```

Now it's possible to write more complex logic in your terraform modules. 😀
