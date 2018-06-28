package com.qa.util;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

public class PasswordHasherTest {

    private PasswordHasher passwordHasher;

    private final String INPUT_STRING = "Irrelevant String";

    @Before
    public void setUp(){
        passwordHasher = PasswordHasher.getInstance();
    }

    @Test
    public void testGetInstance() {
        assertNotNull(passwordHasher);
    }

    @Test
    public void testEncryptCompressionWhereStringLengthIsLessThanThirtyTwo() {
        assertEquals(32, passwordHasher.encrypt(INPUT_STRING).length());
    }

    @Test
    public void testEncryptCompressionWhereStringLengthIsGreaterThanThirtyTwo() {
        assertEquals(32, passwordHasher.encrypt(INPUT_STRING.concat(INPUT_STRING)).length());
    }

    @Test
    public void testEncryptCompressionWhereStringIsNull() {
        assertEquals(null, passwordHasher.encrypt(null));
    }

    @Test
    public void testEncryptOutput() {
        assertEquals("e7db91e37a2168191f3562109a0341b9", passwordHasher.encrypt(INPUT_STRING));
    }

    @After
    public void tearDown(){
        passwordHasher = null;
    }
}