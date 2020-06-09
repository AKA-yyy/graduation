package com.wulaobo.service;

import com.wulaobo.bean.Source;

import java.util.List;

public interface SourceService {
    boolean addSource(Source source);

    List<Source> getSourceList();

    int addSource(String filename, String filepath);

    boolean deleteSourceById(Integer id);

    Source getSourceById(Integer id);
}
