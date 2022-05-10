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
    public class MovieRepository: IMovieRepository
    {
        private readonly DbSet<Movie> _movies;

        public MovieRepository(DatabaseContext databaseContext)
        {
            _movies = databaseContext.Movies;
        }
    }
}
