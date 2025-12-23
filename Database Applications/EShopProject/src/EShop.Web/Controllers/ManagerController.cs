using Microsoft.AspNetCore.Mvc;
using EShop.Application.Services;
using EShop.Application.DTO;
using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace EShop.Web.Controllers
{
    public class ManagerController : Controller
    {
        private readonly ProductService _productService;

        public ManagerController(ProductService productService)
        {
            _productService = productService;
        }

        public async Task<IActionResult> Index()
        {
            var products = await _productService.GetAllProductsForManagerAsync();
            return View(products);
        }

        [HttpGet]
        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Create(ProductDto dto, string tagsInput)
        {
            if (!ModelState.IsValid) return View(dto);

            if (!string.IsNullOrWhiteSpace(tagsInput))
            {
                dto.Tags = tagsInput.Split(',').Select(t => t.Trim()).ToList();
            }

            await _productService.CreateProductAsync(dto);
            return RedirectToAction(nameof(Index));
        }

        [HttpGet]
        public async Task<IActionResult> Edit(Guid id)
        {
            var product = await _productService.GetByIdAsync(id);
            if (product == null) return NotFound();

            var dto = new ProductDto
            {
                Id = product.Id,
                Name = product.Name,
                Description = product.Description,
                Price = product.Price.Amount,
                Sku = product.SKU,
                Tags = product.Tags
            };

            ViewBag.TagsString = product.Tags != null ? string.Join(", ", product.Tags) : "";

            return View(dto);
        }

        [HttpPost]
        public async Task<IActionResult> Edit(ProductDto dto, string tagsInput)
        {
            if (!ModelState.IsValid) return View(dto);

            if (!string.IsNullOrWhiteSpace(tagsInput))
            {
                dto.Tags = tagsInput.Split(',').Select(t => t.Trim()).ToList();
            }
            else 
            {
                dto.Tags = new List<string>();
            }

            try 
            {
                await _productService.UpdateProductAsync(dto);
                return RedirectToAction(nameof(Index));
            }
            catch (Exception)
            {
                return NotFound();
            }
        }

        [HttpPost]
        public async Task<IActionResult> Delete(Guid id)
        {
            await _productService.DeleteProductAsync(id);
            return RedirectToAction(nameof(Index));
        }
    }
}