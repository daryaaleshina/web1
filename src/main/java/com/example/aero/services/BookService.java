package com.example.aero.services;

import com.example.aero.models.Image;
import com.example.aero.models.Book;
import com.example.aero.models.User;
import com.example.aero.repositories.BookRepository;
import com.example.aero.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class BookService {
    private final BookRepository bookRepository;
    private final UserRepository userRepository;

    public List<Book> listBooks(String title) {
        if (title != null) return bookRepository.findByTitle(title);
        return bookRepository.findAll();
    }

    public void saveBook(Principal principal, Book book, MultipartFile file1, MultipartFile file2) throws IOException {
        book.setUser(getUserByPrincipal(principal));
        Image image1;
        Image image2;
        if (file1.getSize() != 0) {
            image1 = toImageEntity(file1);
            image1.setPreviewImage(true);
            book.addImageToBook(image1);
        }
        if (file2.getSize() != 0) {
            image2 = toImageEntity(file2);
            book.addImageToBook(image2);
        }
        log.info("Saving new book. Title: {}; Author email: {}", book.getTitle(), book.getUser().getEmail());
        Book bookFromDb = bookRepository.save(book);
        bookFromDb.setPreviewImageId(bookFromDb.getImages().get(0).getId());
        bookRepository.save(book);
    }

    public User getUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }

    private Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();
        image.setName(file.getName());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());
        return image;
    }

    public void deleteBook(User user, Long id) {
        Book book = bookRepository.findById(id)
                .orElse(null);
        if (book != null) {
            if (book.getUser().getId().equals(user.getId())) {
                bookRepository.delete(book);
                log.info("Book with id = {} was deleted", id);
            } else {
                log.error("User: {} haven't this book with id = {}", user.getEmail(), id);
            }
        } else {
            log.error("Book with id = {} is not found", id);
        }    }

    public Book getBookById(Long id) {
        return bookRepository.findById(id).orElse(null);
    }
}
