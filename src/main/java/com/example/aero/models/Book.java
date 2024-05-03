package com.example.aero.models;

import lombok.Data;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "books")
@Data
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String title; // название книги
    private String description; // описание книги
    private Integer price; // цена книги
    private Integer num_pag; // количество страниц
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY,
    mappedBy = "book")
    private List<Image> images = new ArrayList<>();
    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    @JoinColumn
    private User user;
    private Long previewImageId; // id превьюшки
    private LocalDateTime dateOfCreated; // дата выгрузки на портал

    // инициализация даты выгрузки сегодняшним днём
    @PrePersist
    private void onCreate() { dateOfCreated = LocalDateTime.now(); }

    // добавление фото к книге
    public void addImageToBook(Image image) {
        image.setBook(this);
        images.add(image);
    }
}
