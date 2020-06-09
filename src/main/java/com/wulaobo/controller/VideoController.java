package com.wulaobo.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wulaobo.bean.Video;
import com.wulaobo.service.VideoService;
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
import java.io.*;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;


@Controller
public class VideoController {

    static String fileLocation = "D:/restaurantRes/";//资源访问路径
    static String fileLocation1 = "/restaurantRes/";//资源访问路径
    //存储预返回页面的结果对象
    private Map<String, Object> result = new HashMap<>();

    @Autowired
    private VideoService videoService;

    @PostMapping("/addVideo")
    @ResponseBody
    public Map<String, Object> uploadVideo(String title, @RequestParam("file") MultipartFile file, HttpServletRequest request) {
        //获取提交文件名称
        String filename = file.getOriginalFilename();
        //定义上传文件存放的路径

        String path = request.getSession().getServletContext().getRealPath(fileLocation);//此处为tomcat下的路径，服务重启路径会变化
        //返回保存的url，根据url可以进行文件查看或者下载
        String filePath = fileLocation + filename;

        String pictureFileURL = filePath;//根路径+文件名
        File file1 = new File(filename);
        System.out.println(pictureFileURL);
        String size = getSize(file.getSize());
        String suffix = filename.substring(filename.lastIndexOf(".") + 1);
        //写入文件
        try {
            file.transferTo(file1);
            videoService.insertVideo(title, size, suffix, filePath);
            result.put("Result", "添加视频信息成功");
        } catch (IOException e) {
            e.printStackTrace();
            result.put("Result", "添加视频信息失败");
        }
        return result;
    }

    @PostMapping(value = "/videoUpload")
    public String videoUpload(String title, MultipartFile file, HttpServletRequest request) throws IOException {
        Video video = new Video();

        String str = FastDFSClient.uploadFile(file);
        String filepath = FastDFSClient.getResAccessUrl(str);

        String videoName = file.getOriginalFilename();  //获取上传后的文件名
        video.setPath(filepath);
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        video.setUploadTime(timestamp);
        video.setTitle(title);
        video.setSize(this.getSize(file.getSize()));
        video.setType(this.getFileExt(videoName));
        boolean result = videoService.addVideo(video);
        if (result) {
            return "admin/uploadSuccess";
        }

        return "failed";
    }

    //管理员
    @GetMapping(value = "/getVideoList")
    public String getVideoList(@RequestParam(value = "pageNum", defaultValue = "1") Integer num, ModelMap model) {
        PageHelper.startPage(num, 5);
        PageHelper.orderBy("uploadTime desc");
        List<Video> videoList = videoService.getVideoList();

        PageInfo pageInfo = new PageInfo(videoList);
        model.addAttribute("pageInfo", pageInfo);
        return "admin/video/videoList";
    }

    //普通用户
    @GetMapping(value = "/getVideoListByUser")
    public String getVideoListByUser(@RequestParam(value = "pageNum", defaultValue = "1") Integer num, ModelMap model) {
        PageHelper.startPage(num, 5);
        PageHelper.orderBy("uploadTime desc");
        List<Video> videoList = videoService.getVideoList();

        PageInfo pageInfo = new PageInfo(videoList);
        model.addAttribute("pageInfo", pageInfo);
        return "frontPage/videoList";
    }


    //管理员点击播放按钮，开始播放视频
    @GetMapping(value = "/videoPlayByIdAndAdmin")
    public String videoPlayByIdAndAdmin(Integer id, ModelMap model,HttpServletRequest request) {
        Video video = videoService.getVideoById(id);
        String name = video.getPath().substring(17);
        String path = request.getScheme() + "://" + request.getServerName() + ":"
                + request.getServerPort() + fileLocation1 + name;
        System.out.println(path);
        model.addAttribute("title", video.getTitle());
        model.addAttribute("path", path);
        return "videoPlay";
    }

    @GetMapping(value = "/deleteVideoById")
    public String deleteVideoById(Integer id, ModelMap model) {
        Video video = videoService.getVideoById(id);
        if (video != null) {
            File file = new File(video.getPath());
            if (file.exists()) {
                try {
                    boolean result = file.delete();
                    if (result) {
                        videoService.deleteVideoById(id);
//                    File file = new File(video.getPath());
//                    if (file.exists()) {
//                        file.delete();
                        return "forward:/getVideoList";
//                    }
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return "failed";

            }
        }
        return "failed";
    }

    @GetMapping(value = "/downloadVideoById")
    public String downloadVideoById(Integer id, ModelMap model, HttpServletResponse response) throws IOException {

        Video video = videoService.getVideoById(id);
        response.setHeader("content-type", "application/octet-stream");
        response.setContentType("application/octet-stream");
        File file = new File(video.getPath());
        String name = video.getPath().substring(17);
        // 下载文件能正常显示中文
        response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(name, "UTF-8"));
        if (file.exists()) {
            System.out.println("进来了！");
            byte[] buffer = new byte[1024];
            FileInputStream fis = null;
            BufferedInputStream bis = null;
            try {
                fis = new FileInputStream(file);
                bis = new BufferedInputStream(fis);
                OutputStream outputStream = response.getOutputStream();
                int i = bis.read(buffer);
                while (i != -1) {
                    outputStream.write(buffer, 0, i);
                    i = bis.read(buffer);
                }
                return "下载成功";
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (bis != null) {
                    try {
                        bis.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
                if (fis != null) {
                    try {
                        fis.close();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return "forward:/getVideoListByUser";
    }


//        String dict = "D:/upload/";
//        File file = new File(dict, video.getPath());
//
//        try {
//            response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode(video.getPath(), "UTF-8"));
//        } catch (UnsupportedEncodingException e) {
//            e.printStackTrace();
//        }
//
//        FileInputStream fis = null;
//
//        OutputStream fos = response.getOutputStream();
//
//        if (file.exists()) {
//            fis = new FileInputStream(file);
//            byte[] buffer = new byte[1024];
//            int len = 0;
//            while ((len = fis.read(buffer)) > 0) {
//                fos.write(buffer, 0, len);
//            }
//
//        }
//        fis.close();
//        fos.close();


    /**
     * 获取文件扩展名
     *
     * @return string
     */
    private String getFileExt(String fileName) {
        return fileName.substring(fileName.lastIndexOf("."));
    }

    /**
     * 依据原始文件名生成新文件名
     *
     * @return
     */
    private String getName(String fileName) {
        Random random = new Random();
        return "" + random.nextInt(10000) + System.currentTimeMillis();

    }

    /**
     * 文件大小，返回kb.mb
     *
     * @return
     */
    private String getSize(long fileLength) {
        String size = "";
        DecimalFormat df = new DecimalFormat("#.00");
        if (fileLength < 1024) {
            size = df.format((double) fileLength) + "BT";
        } else if (fileLength < 1048576) {
            size = df.format((double) fileLength / 1024) + "KB";
        } else if (fileLength < 1073741824) {
            size = df.format((double) fileLength / 1048576) + "MB";
        } else {
            size = df.format((double) fileLength / 1073741824) + "GB";
        }

        return size;

    }
}

