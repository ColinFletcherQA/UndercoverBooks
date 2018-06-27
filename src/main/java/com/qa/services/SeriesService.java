package com.qa.services;

import com.qa.models.Series;
import com.qa.models.Tag;
import com.qa.repositories.SeriesRepository;
import com.qa.repositories.TagRespository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SeriesService {

    @Autowired
    private SeriesRepository seriesRepository;

    public Iterable<Series> getSeries() {

        return seriesRepository.findAll();
    }
}
