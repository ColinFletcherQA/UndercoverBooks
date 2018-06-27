package com.qa.models;

import org.junit.Test;

import java.util.*;

import static org.junit.Assert.*;

public class PurchaseTest {

    @Test
    public void getBooksAsGenericList() {
        Book book = new Book();

        Purchase p = new Purchase();
        Set<Book> bookSet = new HashSet<>();
        bookSet.add(book);
        p.setBooks(bookSet);

        List<Book> bookList = new ArrayList<>();
        bookList.add(book);

        assertEquals(p.getBooksAsGenericList(), bookList);
    }
}