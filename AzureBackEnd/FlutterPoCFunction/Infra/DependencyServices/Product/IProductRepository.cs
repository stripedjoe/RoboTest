using ApiPoC.Entities;
using System.Collections.Generic;

namespace ApiPoC.Infra
{
    public interface IProductRepository
    {
        List<Category> GetAllCategoriesWithProducts();
        List<Category> GetListOfProductCategories();
        IEnumerable<Product> GetProductsByCategory(string category);
    }
}