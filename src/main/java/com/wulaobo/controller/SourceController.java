package com.wulaobo.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wulaobo.bean.Source;
import com.wulaobo.service.SourceService;
import com.wulaobo.utils.DateUtil;
import com.wulaobo.utils.FastDFSClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class SourceController {

    static String fileLocation = "D:/restaurantRes/";//图片资源访问路径
    //存储预返回页面的结果对象
    private Map<String, Object> result = new HashMap<>();

    @Autowired
    private SourceService sourceService;

    @PostMapping("/addSource")
    @ResponseBody
    public Map<String, Object> uploadSource(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
        //获取提交文件名称
        String filename = file.getOriginalFilename();
        System.out.println(file.getOriginalFilename());
        System.out.println(filename);
        //定义上传文件存放的路径
        String path = request.getSession().getServletContext().getRealPath(fileLocation);//此处为tomcat下的路径，服务重启路径会变化
        System.out.println(path);
        //返回保存的url，根据url可以进行文件查看或者下载
        String filePath = fileLocation + filename;
        String pictureFileURL = filePath;//根路径+文件名
        File file1=new File(filename);
        System.out.println(pictureFileURL);
        //插入这条Food数据
        //写入文件
        try {
            file.transferTo(file1);
            sourceService.addSource(filename,pictureFileURL);
            result.put("Result", "添加资料信息成功");
        } catch (IOException e) {
            e.printStackTrace();
            result.put("Result", "添加资料信息失败");
        }
        return result;
    }
    @PostMapping(value = "/sourceUpload")
    public String sourceUpload(MultipartFile file, HttpServletRequest request) {
        Source source = new Source();
//          String path = request.getServletContext().getRealPath("source");
//          String path = "D:/upload/source/";
//        source.setPubtime(DateUtil.getNowTime());
        String filename = file.getOriginalFilename();
        source.setFilename(filename);

        //上传文件的关键两行代码
        String str = FastDFSClient.uploadFile(file);
        String filepath = FastDFSClient.getResAccessUrl(str);

        source.setPubtime(DateUtil.getNowTime());

        source.setFilepath(filepath);
        boolean result = sourceService.addSource(source);
        if (result) {
            try {
//                file.transferTo(fileDir);
                return "admin/uploadSuccess";
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return "failed";
    }


    @GetMapping(value = "/getSourceListByUser")
    public String getSourceListByUser(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                                      ModelMap model) {
        PageHelper.startPage(pageNum, 5);
        PageHelper.orderBy("pubtime desc");

        List<Source> sourceList = sourceService.getSourceList();

        PageInfo pageInfo = new PageInfo(sourceList);

        model.addAttribute("sourceList", pageInfo);
        return "frontPage/sourceList";
    }

    /**
     * 管理员
     * @param pageNum
     * @param model
     * @return
     */
    @GetMapping(value = "/getSourceList")
    public String getSourceList(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                                ModelMap model) {

        PageHelper.startPage(pageNum, 5);
        PageHelper.orderBy("pubtime desc");

        List<Source> sourceList = sourceService.getSourceList();

        PageInfo pageInfo = new PageInfo(sourceList);

        model.addAttribute("sourceList", pageInfo);
        return "admin/source/sourceList";
    }

    @GetMapping(value = "/deleteSourceById")
    public String deleteSourceById(Integer id, ModelMap model) {

        Source source = sourceService.getSourceById(id);
        if (source != null) {
            //删除目标文件
            File file = new File(source.getFilepath());
            System.out.println(file);
            System.out.println(file.exists());
            if (file.exists()) {
                System.out.println("1");
                boolean result = file.delete();
                if (result) {
                    System.out.println("2");
                    sourceService.deleteSourceById(id);
                    return "forward:/getSourceList";
                }
                return "failed";
            }
        }

        return "failed";
    }

    @GetMapping(value = "/downloadSourceById")
    @ResponseBody
    public String downloadSourceById(Integer id, ModelMap model,HttpServletResponse response) throws IOException {

        Source source = sourceService.getSourceById(id);
        File file = new File(source.getFilepath());
        System.out.println(file);
        response.setHeader("content-type", "application/octet-stream");
        response.setContentType("application/octet-stream");
        // 下载文件能正常显示中文
        response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(source.getFilename(), "UTF-8"));
        // 实现文件下载
        byte[] buffer = new byte[1024];
        FileInputStream fis = null;
        BufferedInputStream bis = null;
        try {
            fis = new FileInputStream(file);
            bis = new BufferedInputStream(fis);
            OutputStream os = response.getOutputStream();
            int i = bis.read(buffer);
            while (i != -1) {
                os.write(buffer, 0, i);
                i = bis.read(buffer);
            }
            System.out.println("下载文件：" + file.getName() + " 成功");
            model.addAttribute("msgfile", "下载成功");
        } catch (Exception e) {
            System.out.println(e);
            System.out.println("下载失败！");
            model.addAttribute("msgfile", "下载失败");
        }
        return "forward:/getSourceListByUser";
    }
//        if (result) {
//            System.out.println("下载文件：" + file.getName() + " 成功");
//            model.addAttribute("msgfile","下载成功");
//        } else {
//            System.out.println("下载失败！");
//            model.addAttribute("msgfile","下载失败");
//        }
//        return "forward:/getSourceListByUser";

//        try {
//            response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(source.getFilepath(), "UTF-8"));
//        } catch (UnsupportedEncodingException e) {
//            e.printStackTrace();
//        }
//
//        FileInputStream fis = new FileInputStream(source.getFilepath());
//        OutputStream fos =  null;
//        try {
//            fos = response.getOutputStream();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//        byte[] buffer = new byte[1024];
//        int len = 0;
//
//        while((len = fis.read(buffer))>0) {
//            fos.write(buffer,0,len);
//        }
//
//        fis.close();
//        fos.close();

    }
