# Part of Speech Tagger

Utilizes [`engtagger`](https://github.com/yohasebe/engtagger) to tag parts of speech in a text file.

It can either return a JSON object via a Rake Task or display [graphs](https://www.chartkick.com) on the results.

## Install/Setup

Specified Ruby version is 2.4.1.

`bundle install`

## Usage

Start server:

```
bundle exec rails s
```

Navigate to [localhost:3000](http://localhost:3000)

Attach file, hit the submit button, and it'll show bar graphs of the parts of speech counts after it's done calculating.

![Graphs](examples/htsw_graphs.png)

### Rake Task

Proper Nouns/Nouns/Verbs/Adjectives:
```
bundle exec rake pos_tagger:tag_text['spec/fixtures/test.txt','count']
```

Just Proper Nouns:
```
bundle exec rake pos_tagger:proper_nouns['spec/fixtures/test.txt','count',5]
```

- 1st argument is the path to the file to tag.
- 2nd argument (optional) is the ordering. Default is by count. Alternative options: `alpha` for alphabetical ordering.
- 3rd argument (optional) is how many words to return. Default is 10. If a negative number is put in, all words will be returned.

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
