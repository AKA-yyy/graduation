package com.wulaobo.mapper;


import com.wulaobo.bean.Source;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface SourceMapper {

    int insertSource(String filename, String filepath);

    boolean addSource(Source source);

    List<Source> getSourceList();

    boolean deleteSourceById(Integer id);

    Source getSourceById(Integer id);
}
