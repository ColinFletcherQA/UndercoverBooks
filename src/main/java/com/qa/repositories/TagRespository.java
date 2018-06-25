package com.qa.repositories;

import com.qa.models.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.CrudRepository;

public interface TagRespository extends CrudRepository<Tag, Integer> {

}
