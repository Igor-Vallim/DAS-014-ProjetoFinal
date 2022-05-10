using Domain.Entities;
using Repository.Interfaces;
using Service.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Service.Services
{
    public class SentimentService: ISentimentService
    {
        private readonly ISentimentRepository _sentimentRepository;

        public SentimentService(ISentimentRepository sentimentRepository)
        {
            _sentimentRepository = sentimentRepository;
        }

        public List<Sentiment> GetSentimentsByMovie(string movieTitle)
        {
            return _sentimentRepository.GetSentimentsByMovie(movieTitle.ToLower());
        }
    }
}
