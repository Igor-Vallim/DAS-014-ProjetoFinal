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
    public class TweetRepository: ITweetRepository
    {
        private readonly DbSet<Tweet> _tweets;

        public TweetRepository(DatabaseContext databaseContext)
        {
            _tweets = databaseContext.Tweets;
        }
    }
}
