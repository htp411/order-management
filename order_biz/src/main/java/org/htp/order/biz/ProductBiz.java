package org.htp.order.biz;

import org.htp.order.dto.IdDto;
import org.htp.order.entity.Product;

import java.util.List;

public interface ProductBiz{
    List<Product> getAll();
    void createProduct(List<Product> products);

    Product getBySku(String sku);

    void update(Product product);

    void remove(String sku);

    List<Product> gatBySearchOption(String search_option);

    void batchDelete(List<IdDto> skuList);
}
