class GraphQLQueries {
  static const String getNewArrivalProducts = """
query GetNewArrivalProducts(\$page: Int!, \$limit: Int!, \$search: String) {
  getNewArrivalProducts(page: \$page, limit: \$limit, search: \$search) {
    products {
    price
      category
      createdAt
      description
      id
      isNewArrival
      isTrending
      name
      size
      stock
      storeId
      updatedAt
    }
  }
}
""";

  static const String getNewArrivalProductsForExplore = """
query GetNewArrivalProducts(\$page: Int!, \$limit: Int!,\$gender:Gender) {
  getNewArrivalProducts(page: \$page, limit: \$limit,gender : \$gender) {
      totalCount
    products {
      mainImage
      id
      name
      price
      description
    }
  }
}
""";

  static const String getUser = """
query GetUser(\$getUserId: String!) {
  getUser(id: \$getUserId) {
    addresses {
      address
      city
      country
      createdAt
      landmark
      id
      pincode
      state
      tag
      updatedAt
      userId
    }
    name
    email
    id
  }
}
""";

  static const String getCategory = """
query GetProductCategories {
  getProductCategories {
    name
    thumbnail
    id
  }
}
""";

  static const String getNotification = """
query NotificationByUser(\$userId: String!) {
  notificationByUser(userId: \$userId) {
    id
    title
    message
    firstImage
    secondImage
    isRead
    createdAt
  }
}
""";

  static const String getSizes = """
query GetProductSizes {
  getProductSizes {
    name
    id
  }
}
""";

  static const String getColors = """
query GetColors {
  getColors {
    id
    name
  }
}
""";

  static const String getBrand = """
query GetBrands(\$storeType: StoreType!, \$page: Int, \$limit: Int, \$search: String) {
  getBrands(storeType: \$storeType, page: \$page, limit: \$limit, search: \$search) {
    data {
      type
      description
      id
      isDeleted
      logo
      name
      createdAt
    }
    total
    totalPages
    currentPage
  }
}
""";

  static const String getOrderReturns = """
query GetOrderReturns(\$userId: String!, \$orderId: String!) {
  getOrderReturns(userId: \$userId, orderId: \$orderId) {
    createdAt
    id
    orderId
    reason
    replacementId
    status
    updatedAt
    userId
  }
}
""";

  static const String getOrders = """
query CustomerOrders(\$userId: ID!) {
  customerOrders(userId: \$userId) {
    items {
      id
      price
      productId
      quantity
      total
      product {
        mainImage
        name
        store {
          name
        }
      }
    }
    id
    totalAmount
    createdAt
    shippingInfo
    paymentInfo
    status
  }
}
""";

  static const String getProductReviews = """
query GetProductInteractions(\$productId: String!) {
  getProductInteractions(productId: \$productId) {
    id
    userId
    user {
      name
      profileImage
    }
    productId
    liked
    disliked
    viewed
    rating
    comment
    createdAt
    updatedAt
  }
}
""";

  static const String getProducts = """
query GetProducts(\$params: GetProduct!) {
  getProducts(params: \$params) {
       data {
      productImages
      mainImage
      name
      price
      storeId
      store {
        id
        userId
        name
        description
        type
        logo
        createdAt
        updatedAt
        isDeleted
        reasonToDelete
      }
      colors {
        color {
          id
          hexCode
          createdAt
          name
        }
      }
      sizes {
        productId
        sizeId
        size {
          id
          name
          createdAt
          updatedAt
        }
      }
      colors {
        color {
          id
          hexCode
          createdAt
          name
        }
      }
      description
      customReturnPolicy
      customShippingPolicy
      categoryId
      id
    }
    total
    currentPage
    totalPages
  }
}
""";

  static const String getProductsForExplore = """
query GetProducts(\$params: GetProduct!) {
  getProducts(params: \$params) {
    data {
      mainImage
      id
      name
      price
    }
  }
}
""";

  static const String getProductsForSearch = """
query GetProducts(\$params: GetProduct!) {
  getProducts(params: \$params) {
    data {
      id
      storeId
      store {
        logo
        name
        id
      }
      name
      description
      categoryId
      category {
        id
        name
      }
      price
      stock
      isNewArrival
      isTrending
      trendingScore
      variants
      sizes {
        size {
          name
          id
        }
      }
      createdAt
      updatedAt
      isDeleted
      reasonToDelete
      gender
      customReturnPolicy
      customShippingPolicy
      productImages
      mainImage
    }
  }
}
""";

  static const String getProductDescription = """
query GetProductDetails(\$productId: String!) {
  getProductDetails(productId: \$productId) {
    productImages
      mainImage
      name
      price
      colors {
        color {
          id
          hexCode
          createdAt
          name
        }
      }
      sizes {
        productId
        sizeId
        size {
          id
          name
          createdAt
          updatedAt
        }
      }
      colors {
        color {
          id
          hexCode
          createdAt
          name
        }
      }
      description
      customReturnPolicy
      customShippingPolicy
      categoryId
      id
     store {
      id
      name
      logo
    }
  }
}
""";

//   static const String getTrendingProducts = """
// query GetTrendingProducts(\$page: Int!, \$limit: Int!, \$search: String) {
//   getTrendingProducts(page: \$page, limit: \$limit, search: \$search) {
//     products {
//       category
//       createdAt
//       description
//       id
//       isNewArrival
//       isTrending
//       name
//       price
//       size
//       stock
//       storeId
//       updatedAt
//     }
//     totalCount
//   }
// }
// """;

  static const String getTrendingProducts = """
query GetTrendingProducts(\$page: Int!, \$limit: Int!,\$gender:Gender) {
  getTrendingProducts(page: \$page, limit: \$limit,gender : \$gender) {
    totalCount
    products {
      mainImage
      id
      name
      price
      description
    }
  }
}
""";

  static const String getStoreInventory = """
query GetStoreInventory(\$storeId: String!, \$page: Int, \$limit: Int) {
  getStoreInventory(storeId: \$storeId, page: \$page, limit: \$limit) {
    product {
      mainImage
      name
      id
      price
      store {
        name
        logo
      }
    }
  }
}
""";

  static const String getUsers = """
query GetUsers(\$page: Int!, \$limit: Int!, \$search: String) {
  getUsers(page: \$page, limit: \$limit, search: \$search) {
    currentPage
    data {
      authProvider
      createdAt
      email
      id
      role
      updatedAt
    }
    total
    totalPages
  }
}
""";

  static const String getCartItems = """
query GetCartItems(\$userId: String!) {
  getCartItems(userId: \$userId) {
    createdAt
    id
    item
    updatedAt
    userId
  }
}
""";

  static const String getUserClosets = """
query GetUserClosets(\$userId: ID!) {
  getUserClosets(userId: \$userId) {
    clothingItems {
      name
      imageUrl
      id
      createdAt
    }
    name
    id
    createdAt
  }
}
""";

  static const String getClosetById = """
query GetCloset(\$getClosetId: ID!) {
  getCloset(id: \$getClosetId) {
    user {
      id
      name
    }
    name
    id
    createdAt
    clothingItems {
      name
      imageUrl
      id
      createdAt
    }
  }
}
""";

  static const String getSavedItemsToCloset = """
query GetSavedItems(\$userId: ID!, \$clothingItemId: ID) {
  getSavedItems(userId: \$userId, clothingItemId: \$clothingItemId) {
    clothingItem {
      id
      name
      createdAt
    }
    id
    createdAt
    product {
      productImages
      mainImage
      name
      price
      isDeleted
      id
      gender
      description
    }
  }
}
""";
}
