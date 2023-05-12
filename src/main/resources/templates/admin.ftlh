<#import "parts/common.ftlh" as c>
<@c.page "Книги">
    <div class="card p-3">
        <div><h3>Добавить новую книгу</h3></div>
        <form action="admin/books" method="post" enctype="multipart/form-data">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <div class="mb-3">
                <label for="title1" class="form-label">Название</label>
                <input name="title" type="text" class="form-control" id="title1">
            </div>
            <div class="mb-3">
                <label for="authorName1" class="form-label">Автор</label>
                <input name="author_name" type="text" class="form-control" id="authorName1">
            </div>
            <div class="mb-3">
                <label for="year1" class="form-label">Год</label>
                <input name="year" type="number" class="form-control" id="year1">
            </div>
            <div class="mb-3">
                <label for="publisher1" class="form-label">Издательство</label>
                <input name="publisher" type="text" class="form-control" id="publisher1">
            </div>
            <div class="mb-3">
                <label for="ISBN1" class="form-label">ISBN</label>
                <input name="ISBN" type="text" class="form-control" id="ISBN1">
            </div>
            <div class="mb-3">
                <label for="price1" class="form-label">Цена</label>
                <input name="price" type="number" class="form-control" id="price1">
            </div>
            <div class="mb-3">
                <label for="sale1" class="form-label">Скидка %</label>
                <input name="sale" type="number" class="form-control" id="sale">
            </div>
            <div class="mb-3">
                <label for="amount1" class="form-label">Количество</label>
                <input name="amount" type="number" class="form-control" id="amount1">
            </div>
            <div class="mb-3">
                <label for="age1" class="form-label">Возрастное ограничение</label>
                <input name="age" type="number" class="form-control" id="age1">
            </div>
            <div class="mb-3">
                <label for="description1" class="form-label">Описание</label>
                <textarea name="description" class="form-control" id="description1" rows="10"></textarea>
            </div>
            <div class="mb-3">
                <label for="file1" class="form-label">Обложка</label>
                <input name="file" type="file" class="form-control" id="file1">
            </div>
            <div class="mb-3">
                <p>Категория:</p>
            </div>
            <#list categories! as category>
                <div class="mb-3 form-check">
                    <input name="${category}" class="form-check-input" type="radio" id="${category}">
                    <label class="form-check-label" for="${category}">
                        ${category.toRussian(category)}
                    </label>
                </div>
            </#list>

            <div class="mb-3">
                <p>Жанры:</p>
            </div>
            <#list genres as genre>
                <div class="mb-3 form-check">
                    <input name="${genre}" class="form-check-input" type="checkbox" id="${genre}">
                    <label class="form-check-label" for="${genre}">
                        ${genre.toRussian(genre)}
                    </label>
                </div>
            </#list>
            <button type="submit" class="btn btn-primary">Добавить</button>
        </form>
    </div>
</@c.page>