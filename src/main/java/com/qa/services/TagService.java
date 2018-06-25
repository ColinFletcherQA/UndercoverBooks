package com.qa.services;

import com.qa.models.Tag;
import com.qa.repositories.TagRespository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TagService {

    @Autowired
    private TagRespository tagRepository;

    public Iterable<Tag> getTags() {

        return tagRepository.findAll();
    }
}
