using ApiPoC.Entities;
using System;
using System.Collections.Generic;
using System.Linq;

namespace ApiPoC.Infra
{
    public class ProductRepository : IProductRepository
    {
        public List<Category> GetAllCategoriesWithProducts()
        {
            var categories = GetListOfProductCategories();
            var products = GetProducts().ToList();

            if (!products.Any())
            {
                return categories;
            }

            foreach (var category in categories)
            {
                category.Products = products.Where(product =>
                    string.Equals(product.Category, category.Name, StringComparison.CurrentCultureIgnoreCase)).ToList();
            }

            return categories;
        }

        public List<Category> GetListOfProductCategories()
        {
            var productCategories =
                Environment.GetEnvironmentVariable("GetListOfProductCategories", EnvironmentVariableTarget.Process);

            if (productCategories == null)
            {
                throw new NullReferenceException(
                    "Please put the categories in the environment variable local settings in azure config");
            }

            var formatProductCategories = productCategories.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries)
                .Select((category, index) => new Category
                    { Name = category.Trim(), NumberEquivalent = (index + 1).ToString() })
                .ToList();
            return formatProductCategories;
        }

        public IEnumerable<Product> GetProductsByCategory(string category)
        {
            var products = GetProducts();
            return products.Where(product =>
                string.Equals(product.Category, category, StringComparison.CurrentCultureIgnoreCase));
        }

        // Products dummy data
        private static IEnumerable<Product> GetProducts()
        {
            return new List<Product>
            {
                new()
                {
                    Name = "Jacket 1",
                    Category = "Party",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/party%2Fjacket1.png?alt=media&token=a37b4f10-293d-4975-b676-119556fa20ac",
                    NumberEquivalent = "11"
                },
                new()
                {
                    Name = "Jacket 2",
                    Category = "Party",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/party%2Fjacket2.jpg?alt=media&token=9dde9e0d-3199-4f2f-87f5-dccd83d984eb",
                    NumberEquivalent = "12"
                },
                new()
                {
                    Name = "Blazer and Pants",
                    Category = "Party",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/party%2Fblazerandpants.jpg?alt=media&token=61628aed-36d8-4dac-b682-acd94823486a",
                    NumberEquivalent = "13"
                },
                new()
                {
                    Name = "Dress 1",
                    Category = "Party",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/party%2Fdress1.jpg?alt=media&token=cb71b130-5ef3-4a14-ab4a-b0cb22efec2b",
                    NumberEquivalent = "14"
                },
                new()
                {
                    Name = "Dress 2",
                    Category = "Party",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/party%2Fdress2.jpg?alt=media&token=e5c771f9-54e1-40ac-9f2c-6ca923b69538",
                    NumberEquivalent = "15"
                },
                new()
                {
                    Name = "Dress 3",
                    Category = "Party",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/party%2Fdress3.jpg?alt=media&token=110f351e-9035-43a8-a96f-23d087403036",
                    NumberEquivalent = "16"
                },
                new()
                {
                    Name = "Dress 4",
                    Category = "Party",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/party%2Fdress4.png?alt=media&token=68a8ce82-ba70-4268-b8ff-c52bd769c28e",
                    NumberEquivalent = "17"
                },
                new()
                {
                    Name = "Wedding 1",
                    Category = "Wedding",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/wedding%2Fwedding1.png?alt=media&token=da464a44-dda6-44a4-af14-cf61936fab93",
                    NumberEquivalent = "18"
                },
                new()
                {
                    Name = "Wedding 2",
                    Category = "Wedding",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/wedding%2Fwedding2.png?alt=media&token=0336e2d9-fba4-4049-8460-ea341e3e6cfb",
                    NumberEquivalent = "19"
                },
                new()
                {
                    Name = "Wedding 3",
                    Category = "Wedding",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/wedding%2Fwedding3.png?alt=media&token=5f9205e8-692d-4923-99c8-3f42c3218e0b",
                    NumberEquivalent = "20"
                },
                new()
                {
                    Name = "Wedding 4",
                    Category = "Wedding",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/wedding%2Fwedding4.png?alt=media&token=78da2099-2a2a-489a-9416-296028034879",
                    NumberEquivalent = "21"
                },
                new()
                {
                    Name = "Business 1",
                    Category = "Business",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/business%2Fbusiness1.png?alt=media&token=c30d4f17-6a1e-42fb-b723-1436873c1e5f",
                    NumberEquivalent = "22"
                },
                new()
                {
                    Name = "Business 2",
                    Category = "Business",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/business%2Fbusiness2.png?alt=media&token=2e4b7e7d-e981-41b4-9550-2a7f974a3095",
                    NumberEquivalent = "23"
                },
                new()
                {
                    Name = "Business 3",
                    Category = "Business",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/business%2Fbusiness3.png?alt=media&token=a3c634e3-8d9b-4d56-87d5-289fe558eaf4",
                    NumberEquivalent = "24"
                },
                new()
                {
                    Name = "Business 4",
                    Category = "Business",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/business%2Fbusiness4.png?alt=media&token=f666dae1-fdf2-4060-9dc5-42f27738df93",
                    NumberEquivalent = "25"
                },
                new()
                {
                    Name = "Beach 1",
                    Category = "Beach",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/beach%2Fbeach1.png?alt=media&token=d2f5d06c-0b00-48b2-aa47-d07522e30e2b",
                    NumberEquivalent = "26"
                },
                new()
                {
                    Name = "Beach 2",
                    Category = "Beach",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/beach%2Fbeach2.png?alt=media&token=c52c3d40-58ad-44bd-9ad9-8b4d93507577",
                    NumberEquivalent = "27"
                },
                new()
                {
                    Name = "Beach 3",
                    Category = "Beach",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/beach%2Fbeach3.png?alt=media&token=acce52de-44bc-4ae5-a732-f9dad4ec3f37",
                    NumberEquivalent = "28"
                },
                new()
                {
                    Name = "Beach 4",
                    Category = "Beach",
                    ImageUrl =
                        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/beach%2Fbeach4.png?alt=media&token=4b34d5c0-d4c1-4310-8d32-61b8d2970e39",
                    NumberEquivalent = "29"
                },
                //intentionally comment out to be null in FE
                //new()
                //{
                //    Name = "Sports 1",
                //    Category = "Sports",
                //    ImageUrl = 
                //        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/sports%2Fsports1.jpg?alt=media&token=00ff60bf-e429-47ff-a109-efc416c4bd32",
                //    NumberEquivalent = "30"
                //},
                //new()
                //{
                //    Name = "Sports 2",
                //    Category = "Sports",
                //    ImageUrl = 
                //        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/sports%2Fsports2.jpg?alt=media&token=e16a570b-339a-4840-ba3d-e52ef1a64e1b",
                //    NumberEquivalent = "31"
                //},
                //new()
                //{
                //    Name = "Sports 3",
                //    Category = "Sports",
                //    ImageUrl =
                //        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/sports%2Fsports3.png?alt=media&token=928a2da1-9e01-405b-b117-d9bed091928b",
                //    NumberEquivalent = "32"
                //},
                //new()
                //{
                //    Name = "Sports 4",
                //    Category = "Sports",
                //    ImageUrl =
                //        "https://firebasestorage.googleapis.com/v0/b/closetapp-c815a.appspot.com/o/sports%2Fsports4.png?alt=media&token=d83efb3c-83be-4b57-a875-6db478b56c57",
                //    NumberEquivalent = "33"
                //}
            };
        }
    }
}