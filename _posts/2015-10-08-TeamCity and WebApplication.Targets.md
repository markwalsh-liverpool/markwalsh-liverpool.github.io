---
layout: post
category : development
tagline: 
tags : [teamcity, development, c#]
title : TeamCity and WebApplication.targets
description: How to solve the WebApplication.targets problem
---
{% include JB/setup %}

## Prerequisites

Visual Studio 2010-2015, TeamCity instance installed 

## Problem

Attempting to build a web based project (Web API 2 project for instance) will fail if the appropriate WebApplication.Targets are not on the target build server

## Solution

A solution is copy your locally installed BuildTargets folder or even to install the Microsoft Visual Studio 2010 Shell (Integrated) Redistributable Package.  Both of these are actually, pretty bad ideas because it requires RDP'ing to the server and messing around with installs or folder copies.  You're best off adding [this Nuget Package](https://www.nuget.org/packages/MSBuild.Microsoft.VisualStudio.Web.targets/) to a project and editing the .csproj file of the project changing this line...

{% highlight xml %}

 <Import Project="$(VSToolsPath)\WebApplications\Microsoft.WebApplication.targets" Condition="'$(VSToolsPath)' != ''" />

{% endhighlight %}  

To this (or whatever path it is to your Nuget packages folder)

{% highlight xml %}

<Import Project="..\..\Packages\\MSBuild.Microsoft.VisualStudio.Web.targets.14.0.0\tools\VSToolsPath\WebApplications\Microsoft.WebApplication.targets" Condition="'$(VSToolsPath)' != ''" />

{% endhighlight %}  

This means you don't have to touch your build server and when the target version increases, all you have to do is update the Nuget package.
