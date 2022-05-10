using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Domain.Entities
{
    public class Sentiment
    {
        public long Id { get; set; }
        public DateTime Date { get; set; }
        public long Anger { get; set; }
        public long Anticipation { get; set; }
        public long Disgust { get; set; }
        public long Fear { get; set; }
        public long Joy { get; set; }
        public long Sadness { get; set; }
        public long Surprise { get; set; }
        public long Trust { get; set; }
        public long Negative { get; set; }
        public long Positive { get; set; }
        public long MovieId { get; set; }
        public Movie Movie { get; set; }
    }
}
