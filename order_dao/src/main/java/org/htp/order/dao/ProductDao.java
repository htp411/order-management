package org.htp.order.dao;

import org.htp.order.dto.IdDto;
import org.htp.order.entity.Product;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("productDao")
public interface ProductDao {
    List<Product> selectAll();
    void addProduct(List<Product> products);

    Product selectBySku(String sku);

    void update(Product product);
    
    void delete(String sku);

    List<Product> getBySearchOption(String search_option);

    void batchDelete(List<IdDto> skuList);
}
