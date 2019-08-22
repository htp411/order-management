package org.htp.order.biz.impl;

import org.htp.order.biz.ProductBiz;
import org.htp.order.dao.ProductDao;
import org.htp.order.dto.IdDto;
import org.htp.order.entity.Product;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.List;
@Service("productBiz")
public class ProductBizImpl implements ProductBiz {
    private final ProductDao productDao;

    public ProductBizImpl(@Qualifier("productDao") ProductDao productDao) {
        this.productDao = productDao;
    }

    public List<Product> getAll() {
        return productDao.selectAll();
    }
    public void createProduct(List<Product> products) {
        productDao.addProduct(products);
    }

    public Product getBySku(String sku) {
        return productDao.selectBySku(sku);
    }

    public void update(Product product) {
        productDao.update(product);
    }

    public void remove(String sku) {
        productDao.delete(sku);
    }

    public List<Product> gatBySearchOption(String search_option) {
        return productDao.getBySearchOption(search_option);
    }

    public void batchDelete(List<IdDto> skuList) {
        productDao.batchDelete(skuList);
    }
}
