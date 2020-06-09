package com.wulaobo.mapper;


import com.wulaobo.bean.Video;

import java.util.List;

public interface VideoMapper {

    int insertVideo(String title, String size, String type, String path);

    boolean addVideo(Video video);

    List<Video> getVideoList();

    Video getVideoById(Integer id);

    boolean deleteVideoById(Integer id);
}
