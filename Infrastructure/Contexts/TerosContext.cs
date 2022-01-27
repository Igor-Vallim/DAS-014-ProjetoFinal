using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infrastructure.Contexts
{
    public class TerosContext: DbContext
    {
        public TerosContext(DbContextOptions<TerosContext> options) : base(options) { }
    }
}
