package org.htp.order.utils;

import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.htp.order.entity.Orders;
import org.htp.order.entity.Product;
import org.htp.order.global.Constant;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class FileUtils {
    public static List<Orders> orderImport(HttpServletRequest request){
        List<Orders> orders = new ArrayList<Orders>();
        try {
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
            List<MultipartFile> fileItems = multipartRequest.getFiles("file");
            for(MultipartFile item : fileItems){
                Workbook workbook = WorkbookFactory.create(item.getInputStream());
                Sheet sheet = workbook.getSheetAt(0);
                int rowNumber = sheet.getLastRowNum();
                for(int i=1;i<rowNumber;i++){
                    Orders order = new Orders();
                    Row row = sheet.getRow(i);
                    String id = row.getCell(0).getStringCellValue();
                    if(id.indexOf(',')!=-1){
                        id=id.substring(0,id.indexOf(','));
                    }
                    order.setId(id);
                    String type = "";
                    type = row.getCell(1).getCellTypeEnum().toString();
                    if(type.equals("STRING")){
                        String dateString = row.getCell(1).getStringCellValue();
                        String format = "yyyy-MM-dd HH:mm:ss";
                        Date date = new SimpleDateFormat(format).parse(dateString);
                        order.setCreateTime(date);
                    }else{
                        order.setCreateTime(row.createCell(1).getDateCellValue());
                    }
                    type = row.getCell(2).getCellTypeEnum().toString();
                    if(type.equals("STRING")){
                        String dateString = row.getCell(2).getStringCellValue();
                        String format = "yyyy-MM-dd HH:mm:ss";
                        Date date = new SimpleDateFormat(format).parse(dateString);
                        order.setDeliveryTime(date);
                    }else{
                        order.setDeliveryTime(row.getCell(2).getDateCellValue());
                    }
                    order.setChannel(row.getCell(3).getStringCellValue());
                    order.setTrackingNumber(row.getCell(4).getStringCellValue());
                    order.setOrderStatus(row.getCell(5).getStringCellValue());
                    order.setProductName(row.getCell(6).getStringCellValue());
                    order.setProductOnlineSku(row.getCell(7).getStringCellValue());
                    order.setProductLinkSku(row.getCell(8).getStringCellValue());
                    type=row.getCell(9).getCellTypeEnum().toString();
                    if(type.equals("STRING")){
                        String str = row.getCell(9).getStringCellValue();
                        str=str.substring(1);
                        order.setProductPrice(new BigDecimal(Double.parseDouble(str)));
                    }else{
                        order.setProductPrice(new BigDecimal(row.getCell(9).getNumericCellValue()));
                    }
                    if(type.equals("STRING")){
                        String temp = row.getCell(10).getStringCellValue();
                        order.setProductQuantity(Integer.parseInt(temp));
                    }else{
                        order.setProductQuantity((int)row.getCell(10).getNumericCellValue());
                    }
                    order.setProductImageUrl(row.getCell(11).getStringCellValue());
                    order.setUsername(row.getCell(12).getStringCellValue());
                    order.setTel(row.getCell(13).getStringCellValue());
                    order.setCountry(row.getCell(14).getStringCellValue());
                    order.setState(row.getCell(15).getStringCellValue());
                    order.setCity(row.getCell(16).getStringCellValue());
                    order.setAddress(row.getCell(17).getStringCellValue());
                    order.setZipCode(row.getCell(18).getStringCellValue());
                    orders.add(order);
                }
            }
        } catch (InvalidFormatException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        }

        return orders;
    }

    public static Workbook createWorkbook(List<Orders> ordersList) {
        Workbook workbook;
        workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet();
        sheet.setColumnWidth(1,100*256);
        Row headerRow = sheet.createRow(0);
        for(int sell=0;sell< Constant.getExcelHeader().size();sell++){
            headerRow.createCell(sell).setCellValue(Constant.getExcelHeader().get(sell));
            sheet.setColumnWidth(sell,24*256);
        }
        for(int i=0;i<ordersList.size();i++){
            Row orderRow = sheet.createRow(i+1);
            orderRow.createCell(0).setCellValue(ordersList.get(i).getId());
            orderRow.createCell(1).setCellValue(Utils.parseDate(ordersList.get(i).getCreateTime(),"yyyy-MM-dd HH:ss:mm"));
            orderRow.createCell(2).setCellValue(Utils.parseDate(ordersList.get(i).getDeliveryTime(),"yyyy-MM-dd HH:ss:mm"));
            orderRow.createCell(3).setCellValue(ordersList.get(i).getChannel());
            orderRow.createCell(4).setCellValue(ordersList.get(i).getTrackingNumber());
            orderRow.createCell(5).setCellValue(ordersList.get(i).getOrderStatus());
            orderRow.createCell(6).setCellValue(ordersList.get(i).getProductName());
            orderRow.createCell(7).setCellValue(ordersList.get(i).getProductOnlineSku());
            orderRow.createCell(8).setCellValue(ordersList.get(i).getProductLinkSku()==null?"":ordersList.get(i).getProductLinkSku());
            orderRow.createCell(9).setCellValue(ordersList.get(i).getProductPrice().doubleValue());
            orderRow.createCell(10).setCellValue(ordersList.get(i).getProductQuantity());
            orderRow.createCell(11).setCellValue(ordersList.get(i).getProductImageUrl());
            orderRow.createCell(12).setCellValue(ordersList.get(i).getUsername());
            orderRow.createCell(13).setCellValue(ordersList.get(i).getTel());
            orderRow.createCell(14).setCellValue(ordersList.get(i).getCountry());
            orderRow.createCell(15).setCellValue(ordersList.get(i).getState());
            orderRow.createCell(16).setCellValue(ordersList.get(i).getCity());
            orderRow.createCell(17).setCellValue(ordersList.get(i).getAddress());
            orderRow.createCell(18).setCellValue(ordersList.get(i).getZipCode());
        }
        return workbook;
    }

    public static String exportExcel(HttpServletRequest request, List<Orders> ordersList) {
        Workbook workbook = FileUtils.createWorkbook(ordersList);
        String rootPath = request.getSession().getServletContext().getRealPath("/");
        String relativePath = "resources/exportFiles/";
        String fileName = System.currentTimeMillis()+".xlsx";
        try {
            FileOutputStream fileOutputStream = new FileOutputStream(rootPath+relativePath+fileName);
            workbook.write(fileOutputStream);
            //读取文件
            FileInputStream inputStream = new FileInputStream(rootPath+relativePath+fileName);
            byte[] bytes = new byte[inputStream.available()];
            inputStream.read(bytes);
            workbook.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return rootPath+relativePath+fileName;
    }

    public static List<Product> getProducts(HttpServletRequest request){
        List<Product>  products = new ArrayList<Product>();
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        String[] names = multipartRequest.getParameterValues("name");
        String[] nicknames = multipartRequest.getParameterValues("nickname");
        String[] prices = multipartRequest.getParameterValues("price");
        String[] notes = multipartRequest.getParameterValues("note");
        String[] skus = multipartRequest.getParameterValues("sku");
        List<MultipartFile> fileItems = multipartRequest.getFiles("imageUrl");
        for(int i=0;i<names.length;i++){
            Product product = new Product();
            String imageUrl = imageUpload(fileItems.get(i),request);
            if(imageUrl!=null){
                product.setImageUrl("/order/"+imageUrl);
            }
            product.setName(names[i]);
            product.setNickname(nicknames[i]);
            product.setPrice(new BigDecimal(Double.parseDouble(prices[i])));
            product.setNote(notes[i]);
            product.setSku(skus[i]);
            product.setCreateTime(new Date());
            products.add(product);
        }
        return products;
    }

    public static String imageUpload(MultipartFile multipartFile,HttpServletRequest request){
        if(multipartFile != null && multipartFile.getOriginalFilename() != null && multipartFile.getOriginalFilename().length()>0){
            String rootPath = request.getSession().getServletContext().getRealPath("/");
            String relativePath = "resources/productImages/";
            String fileName = System.currentTimeMillis()+".jpg";
            File file = new File(rootPath+relativePath+fileName);
            try {
                multipartFile.transferTo(file);
            } catch (IOException e) {
                e.printStackTrace();
            }
            return relativePath+fileName;
        }
        return null;
    }
}
