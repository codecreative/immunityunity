library('dplyr')
library('rtweet')
library('ggplot2')

# Learning R is part of my reason for this project, so proceed with caution

# The data has entities beyond the 50 states, so will be filtering down to just the states
states <- c('Alabama','Alaska','Arizona','Arkansas','California','Colorado','Connecticut','Delaware','Florida','Georgia','Hawaii','Idaho','Illinois','Indiana','Iowa','Kansas','Kentucky','Louisiana','Maine','Maryland','Massachusetts','Michigan','Minnesota','Mississippi','Missouri','Montana','Nebraska','Nevada','New Hampshire','New Jersey','New Mexico','New York State','North Carolina','North Dakota','Ohio','Oklahoma','Oregon','Pennsylvania','Rhode Island','South Carolina','South Dakota','Tennessee','Texas','Utah','Vermont','Virginia','Washington','West Virginia','Wisconsin','Wyoming')

#obtain twitter token
token <- rtweet::create_token(
  app = "alottabot",
  consumer_key =    Sys.getenv("TWITTER_CONSUMER_API_KEY"),
  consumer_secret = Sys.getenv("TWITTER_CONSUMER_API_SECRET"),
  access_token =    Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret =   Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")
)

# get the raw data from Our World in Data
# you can support their work here https://ourworldindata.org/donate
usa_raw <- read.csv( url("https://covid.ourworldindata.org/data/vaccinations/us_state_vaccinations.csv")) 


# getting the highest value for each row
# choosing only the states
# adding in a couple of properties we want based on "fully vaccinated"
usa <- usa_raw %>%
  group_by(location) %>% 
  slice(which.max(people_fully_vaccinated_per_hundred)) %>%
  ungroup() %>%
  filter(location %in% states ) %>%
  arrange( location ) %>%
  mutate( 
    y = row_number(),
    yend = y,
    x = 0,
    xend = people_fully_vaccinated_per_hundred
  ) %>%
  select( c('location', 'people_fully_vaccinated_per_hundred', 'people_vaccinated_per_hundred', 'x', 'xend', 'y', 'yend'))

min <- min(usa$people_fully_vaccinated_per_hundred)
max <- max(usa$people_fully_vaccinated_per_hundred)


# draw it!
# Note: setting a limit of 85 on the x scale
# 85 is the high end of the herd immunity range currently quoted (https://www.cnn.com/2021/03/05/health/herd-immunity-usa-vaccines-alone/index.html)
p <- ggplot(data = usa) +
  geom_segment(aes(x = x, y = y,
                   xend = xend, 
                   yend = yend,),
               size = 1, 
               lineend = "butt",
               linejoin = "round",
               color = "white") +
  #geom_text(size=2, colour="white", aes(x=0, y=y,  label = location, hjust = 'right'), check_overlap = FALSE) +
  scale_x_continuous(limits = c(0, 85), breaks = c(25, 50, 75, 100), expand = c(0, 0)) +
  scale_y_continuous(limits = c(-15, 50), expand = c(0, 0)) +
  coord_polar()  +
  theme(
    aspect.ratio=1,
    panel.border = element_blank(),
    plot.background = element_rect(fill =  "#003e75", colour = "#003e75"),
    panel.background = element_rect(fill =  "#003e75"),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    plot.margin = unit(c(0,0,0,0), 'mm'),
    legend.position = "none",
    axis.title = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank()
  )

# save to a temp file
file <- tempfile( fileext = ".png")
ggsave( file, plot = p, device = "png", dpi = 144, width = 8, height = 8, units = "in" )

# format the date
today <- Sys.time() %>%
  format( format="%Y-%m-%d")

# create a twitter status with the date, min and max
status <- paste(
  today,
  ' | ',
  'States range from ',
  min,
  '% to ',
  max,
  '% fully vaccinated. (A full circle is 85% - more details in the project notes https://github.com/codecreative/immunityunity#concept)',
  sep=""
)

# post it
rtweet::post_tweet( 
  status = status,
  media = file,
  token = token
)

# save the data
dir.create(file.path('data') )
write.csv( usa, file.path("data/pct-vax.csv") )
