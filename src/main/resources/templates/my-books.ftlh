<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Мои книги</h1>
    <hr>
    <a class="btn btn-dark mt-3 mb-3" style="text-align: center; width: 100%"
       data-toggle="collapse" href="#collapseExample" role="button"
       aria-expanded="true" aria-controls="collapseExample">
        Добавить новую книгу
    </a>
    <div class="collapse mb-3" id="collapseExample" style="">
        <form action="/book/create" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="bookName">Название книги</label>
                <input type="text" required class="form-control"
                       id="bookName" name="title">
            </div>
            <div class="form-group">
                <label for="description">Описание книги</label>
                <textarea required class="form-control" id="description" name="description"></textarea>
            </div>

            <div class="form-group">
                <label for="price">Цена книги</label>
                <div class="input-group mb-3">
                    <input type="number" required class="form-control" id="price" name="price">
                    <div class="input-group-append">
                        <span class="input-group-text">₽</span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="num_pag">Количество страниц</label>
                <div class="input-group mb-3">
                    <input type="number" required class="form-control" id="num_pag" name="num_pag">
                    <div class="input-group-append">
                        <span class="input-group-text"></span>
                    </div>
                </div>
            </div>


            <div class="form-group">
                <div class="custom-file">
                    <input required type="file" name="file1" id="file1">
                    <label class="custom-file-label" for="file1">Первая фотография книги</label>
                </div>
            </div>
            <div class="form-group">
                <div class="custom-file">
                    <input type="file" name="file2" id="file2">
                    <label class="custom-file-label" for="file2">Вторая фотография книги</label>
                </div>
            </div>

            <input type="hidden" name="_csrf" value="${_csrf.token}"/>

            <button type="submit" style="width: 100%" class="btn btn-dark">Добавить</button>
        </form>
    </div>
    <div class="card-columns">
        <#list books as book>
            <a href="/book/${book.id}" class="book-link">
                <div class="card text-white bg-dark my-3 book">
                    <div class="card-top">
                        <form action="/book/delete/${book.id}" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                            <button type="submit" class="btn btn-danger m-3">
                                Удалить
                            </button>
                        </form>
                    </div>
                    <img src="/images/${book.previewImageId}"
                         class="card-img-top">
                    <div class="card-body">
                        <h5 class="card-title">${book.title}</h5>
                        <p class="card-text">${book.price} ₽</p>
                    </div>
                    <div class="card-footer">
                        ${book.num_pag} стр.
                    </div>
                </div>
            </a>
        <#else>

        </#list>
    </div>
</@t.template>