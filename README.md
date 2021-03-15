
# Immunity Unity

[![Project Status: Concept – Minimal or no implementation has been done yet, or the repository is only intended to be a limited example, demo, or proof-of-concept.](https://www.repostatus.org/badges/latest/concept.svg)](https://www.repostatus.org/#concept) 
[![immunityunity](https://github.com/codecreative/immunityunity/actions/workflows/immunityunity.yml/badge.svg)](https://github.com/codecreative/immunityunity/actions/workflows/immunityunity.yml)


Repo for the experimental Twitter bot [@immunityunity](https://twitter.com/immunityunity). 

# Why?

The goal was to learn about Github Actions and set up a workflow using an R script. But it is better to learn with a project.

# Concept

> Only if we end the pandemic everywhere can we end the pandemic anywhere. 
> 
> — [Max Roser](https://twitter.com/MaxCRoser/status/1366674487039692801) (Our World in Data)

That quote inspired [a wonderful project by David Bauer](https://labs.davidbauer.ch/vaxillology/) which has in turn inspired this one. I am applying the same idea to a single country, using vaccination data for the 50 US states. Each state is trying to complete its own circle based on the percentage of fully vaccinated people. No circle can truly be complete unless they all are.

> Herd immunity thresholds for Covid-19 are only estimates at this point. But experts generally agree that somewhere between 70% and 85% of the population must be protected to suppress the spread, a range that Dr. Anthony Fauci, director of the National Institute of Allergy and Infectious Diseases has recently cited.
> 
> — [CNN](https://www.cnn.com/2021/03/05/health/herd-immunity-usa-vaccines-alone/index.html)

To fully complete a circle, the state must reach 85% vaccinated population. That may a stretch, but as it is the upper end of the range mentioned by Dr. Fauci, that is our target.


# Data source
The data is compiled by [Our World in Data](https://ourworldindata.org/), a small team doing big work. Please consider [donating](https://ourworldindata.org/donate). You can find their covid vaccination data [on GitHub](https://github.com/owid/covid-19-data/tree/master/public/data/vaccinations).

# Is this a data visualization?
Not exactly. It is flawed in that sense. For starters, the outside lines will be much longer than those on the inside for the same percentage. There are deliberately no labels to make it more abstract. It also goes along with the idea that we need all the circles to be complete so there is less focus on the individuals. Let's call it data art... using "art" in the loosest of definitions.

# Tech
This repo contains a [GitHub Action](https://github.com/features/actions) that runs once a day - about 10pm UK time. It runs an R script that fetches the vaccination data, builds the graphic in [ggplot2](https://ggplot2.tidyverse.org/index.html) and posts the result to [@immunityunity](https://twitter.com/immunityunity) on Twitter using [{rtweet}](https://docs.ropensci.org/rtweet/).

This repo exists because of other people openly sharing their knowledge. I ~~stole~~ borrowed the GitHub action setup heavily from Matt Dray's [londonmapbot](https://www.rostrum.blog/2020/09/21/londonmapbot/) and Matt Kerlogue's [post on scraping PDFs](https://lapsedgeographer.london/2020-04/covid19-scraping/) to set up this project.

# Design inspiration
[A love letter to coord_polar()](https://ijeamaka-anyene.netlify.app/posts/2021-01-04-radial-patterns-in-ggplot2/) by [Ijeamaka Anyene](https://twitter.com/ijeamaka_a). I'm an R novice, so wasn't sure how to accomplish what I was aiming for. This was perfect and inspiring for many reasons. So much to learn here, definitely going to dig into the more complex examples.

For more circular inspiration, I recommend [The Book of Circles](https://www.amazon.co.uk/Book-Circles-Manuel-Lima/dp/1616895284/) by Manuel Lima and checking out some of [Nadieh Bremer's work](https://www.visualcinnamon.com/portfolio/).


# Special thanks

* [Simon Willison](https://simonwillison.net/) for his [lightning talk](https://www.twitter.com/simonw/status/1367632117127995393) at NICAR21 that piqued my curiousity into GitHub Actions and the possibilities for newsroom applications.

# Other resources
[Github actions with R](https://ropenscilabs.github.io/actions_sandbox/)
