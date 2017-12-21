# Part of Speech Tagger

Utilizes [`engtagger`](https://github.com/yohasebe/engtagger) to tag parts of speech in a text file. Outputs it into a ruby hash but the provided rake task outputs into JSON.

## Install/Setup

Specified Ruby version is 2.4.1.

`bundle install`

## Usage

```
bundle exec rake pos_tagger:tag_text['spec/fixtures/test.txt','count']
```

- 1st argument is the path to the file to tag.
- 2nd argument (optional) is the ordering. Default is by count. Alternative options: `alpha` for alphabetical ordering.

The Rakefile outputs the data into a pretty JSON array:

```
{
  "proper_nouns": {
    "Cyclone": 1,
    "Fla'neiel": 1,
    "Flana": 1,
    "King": 3
  },
  "nouns": {
    "Cyclone": 1,
    "Fla'neiel": 1,
    "Flana": 1,
    "King": 3,
    "lead": 1,
    "name": 2,
    "speech": 1,
    "times": 2,
    "way": 1
  },
  "adjectives": {
    "many": 2,
    "own": 2
  },
  "verbs": {
    "know": 1,
    "mulling": 1,
    "said": 2,
    "tag": 1,
    "wanted": 1,
    "was": 2
  }
}
```
