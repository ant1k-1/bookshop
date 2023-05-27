<#import "parts/common.ftlh" as c>
<@c.page "Книги">
    <div class="d-flex justify-content-center mb-3">
        <a href="/admin/add-book" class="btn btn-primary mb-3 me-2" style="width: 10rem">Добавить книгу</a>
        <a href="/admin/books" class="btn btn-primary mb-3 me-2" style="width: 10rem">Все книги</a>
        <a href="/admin/users" class="btn btn-primary mb-3 me-2" style="width: 10rem">Все пользователи</a>
    </div>
    <#if userShow>
        <div class="card p-3 mb-3">
            <div class="d-flex flex-row">
                <form class="col" action="/admin/findUserById" method="get">
                    <div class="d-flex flex-row">
                        <input autocomplete="off" name="id" class="form-control me-2" type="search" placeholder="Введите id пользователя" aria-label="Search">
                        <button class="btn btn-success me-2" type="submit">Перейти</button>
                    </div>
                </form>
                <form class="col" action="/admin/findUserByUsername" method="get">
                    <div class="d-flex flex-row">
                        <input autocomplete="off" name="username" class="form-control me-2" type="search" placeholder="Введите username пользователя" aria-label="Search">
                        <button class="btn btn-success me-2" type="submit">Перейти</button>
                    </div>
                </form>
            </div>

        </div>
        <div class="card p-3 mb-3">
            <#list users as user>
                <div class="card p-3 mb-3">
                    <div class="d-flex justify-content-between">
                        <h5 class="mb-3">id:${user.id}. Пользователь ${user.username}</h5>
                        <a href="/admin/users/${user.id}" class="btn btn-primary"> Редактировать</a>
                    </div>
                </div>
            </#list>
        </div>
    </#if>

    <#if bookShow>
        <div class="card p-3 mb-3">
            <form action="/admin/findBookById" method="get">
                <div class="d-flex flex-row w-50">
                    <input autocomplete="off" name="id" class="form-control me-2" type="search" placeholder="Введите id книги" aria-label="Search">
                    <button class="btn btn-success me-2" type="submit">Перейти</button>
                </div>
            </form>
        </div>

        <div class="card p-3 mb-3">
            <#list books as book>
                <div class="card p-3 mb-3">
                    <div class="d-flex justify-content-between">
                        <h5 class="mb-3">id:${book.id}. ${book.title}</h5>
                        <a href="/admin/books/${book.id}" class="btn btn-primary"> Редактировать</a>
                    </div>
                </div>
            </#list>
        </div>
    </#if>

    <#if addBook>
        <div class="card p-3 mb-3">
            <div><h3>Добавить новую книгу</h3></div>
            <form action="admin/add-book" method="post" enctype="multipart/form-data">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <div class="mb-3">
                    <label for="title1" class="form-label">Название</label>
                    <input autocomplete="off" name="title" type="text" class="form-control" id="title1" required>
                </div>
                <div class="mb-3">
                    <label for="authorName1" class="form-label">Автор</label>
                    <input autocomplete="off" name="author_name" type="text" class="form-control" id="authorName1" required>
                </div>
                <div class="mb-3">
                    <label for="year1" class="form-label">Год</label>
                    <input autocomplete="off" name="year" type="number" class="form-control" id="year1" required>
                </div>
                <div class="mb-3">
                    <label for="publisher1" class="form-label">Издательство</label>
                    <input autocomplete="off" name="publisher" type="text" class="form-control" id="publisher1" required>
                </div>
                <div class="mb-3">
                    <label for="ISBN1" class="form-label">ISBN</label>
                    <input autocomplete="off" name="ISBN" type="text" class="form-control" id="ISBN1" required>
                </div>
                <div class="mb-3">
                    <label for="price1" class="form-label">Цена</label>
                    <input autocomplete="off" name="price" type="number" class="form-control" id="price1" required>
                </div>
                <div class="mb-3">
                    <label for="sale1" class="form-label">Скидка %</label>
                    <input autocomplete="off" name="sale" type="number" class="form-control" id="sale" required>
                </div>
                <div class="mb-3">
                    <label for="amount1" class="form-label">Количество</label>
                    <input autocomplete="off" name="amount" type="number" class="form-control" id="amount1" required>
                </div>
                <div class="mb-3">
                    <label for="age1" class="form-label">Возрастное ограничение</label>
                    <input autocomplete="off" name="age" type="number" class="form-control" id="age1" required>
                </div>
                <div class="mb-3">
                    <label for="description1" class="form-label">Описание</label>
                    <textarea required name="description" class="form-control" id="description1" rows="10"></textarea>
                </div>
                <div class="mb-3">
                    <label for="file1" class="form-label">Обложка</label>
                    <input name="file" type="file" class="form-control" id="file1" required>
                </div>
                <div class="mb-3">
                    <p>Категория:</p>
                </div>
                <#list categories! as category>
                    <div class="mb-3 form-check">
                        <input name="category" class="form-check-input" type="radio" id="${category}" value="${category}">
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
    </#if>

</@c.page>