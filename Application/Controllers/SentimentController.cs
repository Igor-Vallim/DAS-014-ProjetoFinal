using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Service.Interfaces;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Application.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SentimentController : ControllerBase
    {
        private readonly ISentimentService _sentimentService;

        public SentimentController(ISentimentService sentimentService)
        {
            _sentimentService = sentimentService;
        }

        [HttpGet]
        public IActionResult GetSentimentsByMovie(string movieTitle = "")
        {
            try
            {
                if (string.IsNullOrEmpty(movieTitle)) movieTitle = "";
                var resultado = _sentimentService.GetSentimentsByMovie(movieTitle);
                Response.StatusCode = StatusCodes.Status200OK;
                return new ObjectResult(new { Sentiments = resultado});
            }
            catch (Exception e)
            {
                Response.StatusCode = StatusCodes.Status500InternalServerError;
                return new ObjectResult(new { e.Message });
            }
        }
    }
}
