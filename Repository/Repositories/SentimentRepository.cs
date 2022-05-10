using Domain.Entities;
using Infrastructure.Contexts;
using Microsoft.EntityFrameworkCore;
using Repository.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Repository.Repositories
{
    public class SentimentRepository: ISentimentRepository
    {
        private readonly DbSet<Sentiment> _sentiments;

        public SentimentRepository(DatabaseContext databaseContext)
        {
            _sentiments = databaseContext.Sentiments;
        }

        public List<Sentiment> GetSentimentsByMovie(string movieTitle)
        {
            return _sentiments
                .Include(x => x.Movie)
                .Where(x => x.Movie.Title.ToLower().Equals(movieTitle))
                .OrderByDescending(x => x.Date)
                .ToList();
        }
    }
}
