using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using EShop.Web.Models;
using EShop.Application.Services; 

namespace EShop.Web.Controllers;

public class HomeController : Controller
{
    private readonly ProductService _productService;

    public HomeController(ProductService productService)
    {
        _productService = productService;
    }

    public async Task<IActionResult> Index()
    {
        var products = await _productService.GetBrowseableProductsAsync();
        return View(products);
    }

    public async Task<IActionResult> Details(Guid id)
    {
        var product = await _productService.GetByIdAsync(id);
        
        if (product == null)
        {
            return NotFound();
        }

        return View(product);
    }

    public IActionResult Privacy()
    {
        return View();
    }

    [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
    public IActionResult Error()
    {
        return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
    }
}