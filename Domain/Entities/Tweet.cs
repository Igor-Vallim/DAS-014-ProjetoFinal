using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain.Entities
{
    public class Tweet
    {
        public long Id { get; set; }
        public string Text { get; set; }
        public bool Favorited { get; set; }
        public long FavoriteCount { get; set; }
        public DateTime Created { get; set; }
        public string ScreenName { get; set; }
        public long RetweetCount { get; set; }
        public bool IsRetweet { get; set; }
        public string Language { get; set; }
        public long MovieId { get; set; }
        public Movie Movie { get; set; }
    }
}
