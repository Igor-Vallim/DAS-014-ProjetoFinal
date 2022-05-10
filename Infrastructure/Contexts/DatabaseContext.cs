using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infrastructure.Contexts
{
    public class DatabaseContext: Microsoft.EntityFrameworkCore.DbContext
    {
        public DatabaseContext(DbContextOptions<DatabaseContext> options) : base(options) { }

        public DbSet<Movie> Movies { get; set; }
        public DbSet<Sentiment> Sentiments { get; set; }
        public DbSet<Tweet> Tweets { get; set; }
    }
}
