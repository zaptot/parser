# Parser

Project helps to parse csv files and export then into console output

TODO: Write specs

## Installation
    $ git clone
    $ bundle install

## Usage

```ruby
require 'parser'
parsed_file = Parsers::Csv.new('./spec/test_files_to_parse/simple_test.csv').parse
table = ExportStructures::Table.new(parsed_file)
Exporters::Console.export(table)
```

