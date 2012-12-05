use strict;
use warnings;

use HTML::Strip;
use JSON::XS;
use HTTP::Tiny;
use ElasticSearch;
use Data::Dumper::Perltidy;

my $json   = JSON::XS->new;
my $es     = ElasticSearch->new;
my $client = HTTP::Tiny->new;

my $apiurl = 'https://www.googleapis.com/blogger/v3/blogs';
my $apikey = 'your_api_key';
my $blogid = '3615332969083650973'; # sysadvent blog id

# dont analyze on html tags, exclude content/lables/updated to be displayed in _source
$es->create_index(
  index    => 'advent',
  settings => {
    analysis => {
      analyzer => {
        default => {
          tokenizer   => 'standard',
          char_filter => ['html_strip']
        }
      }
    }
  },
  mappings => { sysadvent => { "_source" => { "excludes" => ["content", "lables", "updated"] } } }
);

my $index;
$index = sub {
  my $pageToken = shift;
  my $response;
  my $data;
  my $posts;
  my $nextPageToken;
  if ( !$pageToken ) {    # first page
    $response = $client->get("$apiurl/$blogid/posts?key=$apikey");
  }
  else {
    $response =
      $client->get("$apiurl/$blogid/posts?key=$apikey&pageToken=$pageToken");
  }

  $data          = $json->utf8->decode( $response->{content} );
  $posts         = $data->{items};

  for my $post (@$posts) {
    my ( $content, $published, $updated, $url, $labels, $title ) =
      map ( $post->{$_},
      ( 'content', 'published', 'updated', 'url', 'labels', 'title' ) );
    $title =~ s/^Day \d+\W+//;
    $es->index(
      index => "advent",
      type  => "sysadvent",
      data  => {
        'content'   => $content,
        'published' => $published,
        'updated'   => $updated,
        'url'       => $url,
        'lables'    => $labels,
        'title'     => $title
      }
    );
  }
  
  $nextPageToken = $data->{nextPageToken};
  exit if !$nextPageToken; # last page
  $index->($nextPageToken);
};

$index->();
