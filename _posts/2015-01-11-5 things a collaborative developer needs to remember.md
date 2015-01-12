---
layout: post
category : development
tagline: 
tags : [methodology]
title : 5 things a collaborative developer needs to remember
description: A sensible checklist for every developer to bear in mind
---
{% include JB/setup %}

## Overview

I've had about 5 years commercial experience in development and I've worked for various companies in a collaborative manner and I'd like to share some rules of thumb I've tried to adopt.  Some of these are specific to compliable languages.

## 1. Only check in code that builds/runs

 This one is fairly obvious; no one wants to check out broken code.  If possible, I checkout the code to a new location on the file system and check it builds/runs...which leads me onto the next point

## 2. Do not use absolute paths

 Absolute paths assume your collaborators have the same file structure as yourself and checkout location.  This is naive.  Use relative paths instead.

 It's common in tests to see external files be referenced absolutely i.e.

 'C:\Project\testfiles\testfile1.txt'

 When this could easily be rewritten as 

 '..\testfiles\testfile1.txt'

Which would ensure you make no assumptions about other peoples folders!

## 3. Don't use WIP and commit often

We're all guilty, admit it.  Write sensible commit messages and commit often (which includes pushing to remote repos)

## 4. Write clean, readable and self documenting code

Unfortunately, some development departments require unnecessary code commenting.  This is not only a massive time drain it's also a maintainability nightmare...changing a function/method signature results in you having to update comments.

The alternative is writing maintainable, readable clean code, only commenting when absolutely necessary, my (C#) Login Controller should demonstrate this:

{% highlight csharp %}
        public IHttpActionResult Login([FromBody] LoginRequest credentials)
        {
            var loginResponse = new LoginResponse {Authenticated = false};
            var user = GetUser(credentials.Email);

            if (user == null)
                return this.HttpActionResultWithMessage(Constants.Constants.ErrorUserNotValidOrIncorrectCredentials, HttpStatusCode.NotFound);

            if (!TryLogonWithCredentials(user, credentials.Password))
                return this.HttpActionResultWithMessage(Constants.Constants.ErrorUserNotValidOrIncorrectCredentials, HttpStatusCode.BadRequest);

            loginResponse.Token = _tokenProvider.GenerateToken(credentials.Email);
            loginResponse.Authenticated = true;

            return Ok(loginResponse);
        }
{% endhighlight %}

Using comments for this would, in my opinion, be completely unnecessary.  This isn't the case when using hacks, especially hacks around framework/language limitations as these need to be explained to the audience.

## 5. Some documentation is needed such as high level communication documentation

If you've got components talking to each other in most codebases this isn't immediately apparent.  A high level flowchart or component diagram showing communication between modules makes it a lot easier as a developer to get to grips with a codebase.  Ideally, I'd like to be able to checkout a codebase and get the basic gist of architecture and dataflow through a small amount of documentation. 





