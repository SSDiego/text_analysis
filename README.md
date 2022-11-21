# Introduction

So, on my first internship I worked at a virtual marketing company, in a business intelligence team. The project where I was allocated at had the main goal of determine, by Search Engine Optimization standards, some characteristics of our client. I’m not going to talk much about it, so the company product can be kept secret, but I want to explain that these techniques I’m going to show here are the results of my own studies, research and try and error. At first, I developed and implemented this analysis in order to have some extra insights about my data, but after while I use it to gain strategic advantages in the project development and also to minimize the overall time to 1/3 of the its total length. At the majority of the time, I was working on the code only on my free time, or when I had no tasks to do.

Since I don’t want to do the exactly project that I developed in the internship, I’m going to show the main techniques that I used, but applied to my current job. So, while my goal back then was totally aligned to word classification, right now my goal is How to mine insights from a text (book, paper, website, document etc) after doing some analyses from it. 
We want to analyze a group of texts, not just one. For this project, all the texts belong to the same group and talk about the same thing and because of that, before I start to loot at all the files, first I want to see what the main file can tell me. My end goal here is not to find a perfect analyses where I will have a complete understand of my data or text, but actually be able to open a number of files and retrieve from them some important group of words that might help me finding a direction in which pdfs start to look first and what could be topics on each.

One thing someone could argue is: Should we not being looking through all the pdfs, thought? That’s hard to answer. The person in charge of the project will always find it useful to look all the files, but as an analyst, my understand is that we have to know where to look at, and also be mindful about where we can find the most value for our time.  


## Python PDF Extraction

Before we dive into the project, a while back I mostly used the data provided to me through Search Engine Optimization platforms and Web scraps that I developed, here I’m going for a different approach, where I’m building a Python script to extract text from some PDF files. Then saving them as to analyze. 
