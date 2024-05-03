<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Электронная библиотека</h1><hr>
    <form method="get" action="/">
        <div class="form-row">
            <div class="form-group col-md-10">
                <label for="searchWord">Поиск по названию</label>
                <input type="text" name="searchWord" <#if searchWord??>value="${searchWord}"</#if> class="form-control"
                       id="searchWord">
            </div>
            <button style="width: 100%" type="submit" class="btn btn-dark">Поиск</button>
        </div>
    </form>
    <hr>
    <div class="card-columns">
        <#list books as book>
            <a href="/book/${book.id}" class="book-link">
                <div class="card text-white bg-dark my-3 book">

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
            <h2 style="text-align: center;">Книг не найдено</h2>
        </#list>
    </div>
</@t.template>