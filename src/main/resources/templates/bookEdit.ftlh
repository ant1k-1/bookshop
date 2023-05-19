<#import "parts/common.ftlh" as c>
<@c.page "Редактирование книги">
    <div class="d-flex justify-content-center mb-3">
        <a href="/admin/add-book" class="btn btn-primary mb-3 me-2" style="width: 10rem">Добавить книгу</a>
        <a href="/admin/books" class="btn btn-primary mb-3 me-2" style="width: 10rem">Все книги</a>
        <a href="/admin/users" class="btn btn-primary mb-3 me-2" style="width: 10rem">Все пользователи</a>
    </div>

    <div class="card p-3 mb-3">
        <form action="/admin/books/${book.id}" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <div class="mb-3">
                <label for="title" class="form-label">Название</label>
                <input autocomplete="off" name="title" type="text" class="form-control" id="title" value="${book.title}" required>
            </div>
            <div class="mb-3">
                <label for="author" class="form-label">Автор</label>
                <input autocomplete="off" name="author" type="text" class="form-control" id="author" value="${book.author}" required>
            </div>
            <div class="mb-3">
                <label for="year" class="form-label">Год</label>
                <input autocomplete="off" name="year" type="text" class="form-control" id="year" value="${book.year}" required>
            </div>
            <div class="mb-3">
                <label for="publisher" class="form-label">Издательство</label>
                <input autocomplete="off" name="publisher" type="text" class="form-control" id="publisher" value="${book.publisher}" required>
            </div>
            <div class="mb-3">
                <label for="ISBN" class="form-label">ISBN</label>
                <input autocomplete="off" name="ISBN" type="text" class="form-control" id="ISBN" value="${book.ISBN}" required>
            </div>
            <div class="mb-3">
                <label for="price" class="form-label">Цена</label>
                <input autocomplete="off" name="price" type="text" class="form-control" id="price" value="${book.price}" required>
            </div>
            <div class="mb-3">
                <label for="sale" class="form-label">Скидка %</label>
                <input autocomplete="off" name="sale" type="text" class="form-control" id="sale" value="${book.sale}" required>
            </div>
            <div class="mb-3">
                <label for="amount" class="form-label">Количество</label>
                <input autocomplete="off" name="amount" type="text" class="form-control" id="amount" value="${book.amount}" required>
            </div>
            <div class="mb-3">
                <label for="ageRestriction" class="form-label">Возрастное ограничение</label>
                <input autocomplete="off" name="ageRestriction" type="text" class="form-control" id="ageRestriction" value="${book.ageRestriction}" required>
            </div>
            <div class="mb-3">
                <label for="description" class="form-label">Описание</label>
                <textarea name="description" class="form-control" id="description" rows="10">${book.description}</textarea>
            </div>
            <div class="mb-3">
                <p>Категория:</p>
            </div>
            <#list categories as category>
                <div class="mb-3 form-check">
                    <input name="${category}" class="form-check-input" type="radio" id="category" ${(category == book.category)?string("checked", "")}>
                    <label class="form-check-label" for="category">
                        ${category.toRussian()}
                    </label>
                </div>
            </#list>

            <div class="mb-3">
                <p>Жанры:</p>
            </div>
            <#list genres as genre>
                <div class="mb-3 form-check">
                    <input name="${genre}" class="form-check-input" type="checkbox" id="${genre}" ${book.genres?seq_contains(genre)?string("checked", "")}>
                    <label class="form-check-label" for="${genre}">
                        ${genre.toRussian()}
                    </label>
                </div>
            </#list>
            <button type="submit" class="btn btn-primary">Обновить</button>
        </form>
    </div>
</@c.page>