using System.Collections.Generic;

namespace ApiPoC.Entities
{
    public class Category
    {
        public string Name { get; set; }
        public string NumberEquivalent { get; set; }
        public List<Product> Products { get; set; }
    }
}