<#import "parts/common.ftlh" as c>

<@c.page "Каталог">
    <h1 class="mb-3">
        Каталог книг
    </h1>
    <div class="card p-3">
        <form class="d-flex flex-column" role="search" autocomplete="off" action="/catalog" method="get">
            <div class="d-flex flex-row">
                <input name="searchBar" class="form-control me-2" type="search" placeholder="Напишите название книги или автора" aria-label="Search" value="${searchBar}">
                <button class="btn btn-success me-2" type="submit">Поиск</button>
                <button class="btn btn-primary collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFilters" aria-expanded="false" aria-controls="collapseFilters">
                    Фильтры
                </button>
            </div>
            <div class="collapse" id="collapseFilters">
                <div class="mb-3 mt-3">
                    <h3 class="mb-3">
                        Категории
                    </h3>
                    <div class="d-flex flex-row flex-wrap justify-content-center">
                        <#list categoryStringMap as category, checked>
                            <div class="mb-3 form-check" style="margin-right: 1rem; flex-basis: 20%">
                                <input name="${category}" class="form-check-input" type="checkbox" id="${category}" ${checked}>
                                <label class="form-check-label" for="${category}">
                                    ${category.toRussian(category)}
                                </label>
                            </div>
                        </#list>
                    </div>
                </div>
                <div class="mb-3">
                    <h3 class="mb-3">
                        Жанры
                    </h3>
                    <div class="d-flex flex-row flex-wrap justify-content-center">
                        <#list genreStringMap as genre, checked>
                            <div class="mb-3 form-check" style="margin-right: 1rem; flex-basis: 20%">
                                <input name="${genre}" class="form-check-input" type="checkbox" id="${genre}" ${checked}>
                                <label class="form-check-label" for="${genre}">
                                    ${genre.toRussian(genre)}
                                </label>
                            </div>
                        </#list>
                        <div class="mb-3 form-check" style="margin-right: 1rem; flex-basis: 20%"></div>
                    </div>
                </div>
                <div class="mb-3">
                    <h3 class="mb-3">
                        Сортировка
                    </h3>
                    <div class="d-flex flex-row flex-wrap justify-content-start">
                        <div class="mb-3 form-check" style="margin-right: 1rem; flex-basis: 20%">
                            <input name="sorting" class="form-check-input" type="radio" id="sortByYear" ${sortByYear} value="sortByYear">
                            <label class="form-check-label" for="sortByYear">
                                по году издания
                            </label>
                        </div>
                        <div class="mb-3 form-check" style="margin-right: 1rem; flex-basis: 20%">
                            <input name="sorting" class="form-check-input" type="radio" id="sortByPrice" ${sortByPrice} value="sortByPrice">
                            <label class="form-check-label" for="sortByPrice">
                                по цене
                            </label>
                        </div>
                        <div class="mb-3 form-check" style="margin-right: 1rem; flex-basis: 20%">
                            <input name="sorting" class="form-check-input" type="radio" id="sortByRating" ${sortByRating} value="sortByRating">
                            <label class="form-check-label" for="sortByRating">
                                по рейтингу
                            </label>
                        </div>
                        <div class="mb-3 form-check" style="margin-right: 1rem; flex-basis: 20%">
                            <input name="sorting" class="form-check-input" type="radio" id="sortByShuffle" ${sortByShuffle} value="sortByShuffle">
                            <label class="form-check-label" for="sortByShuffle">
                                в перемешку
                            </label>
                        </div>
                    </div>
                </div>
                <div class="mb-3">
                    <div class="d-flex flex-row flex-wrap justify-content-start">
                        <div class="mb-3 form-check" style="margin-right: 1rem; flex-basis: 20%">
                            <input name="sortingType" class="form-check-input" type="radio" id="sortReverse" value="sortReverse" ${sortingType?then("checked", "")}>
                            <label class="form-check-label" for="sortReverse">
                                по убыванию
                            </label>
                        </div>
                        <div class="mb-3 form-check" style="margin-right: 1rem; flex-basis: 20%">
                            <input name="sortingType" class="form-check-input" type="radio" id="sortDefault" value="sortDefault" ${sortingType?then("", "checked")}>
                            <label class="form-check-label" for="sortDefault">
                                по возрастанию
                            </label>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <div class="card p-3 mt-3">
        <div class="row">
            <div class="col">
                <h3>Поиск по запросу: ${searchBar}</h3>
            </div>
            <div class="col">
                <form action="/catalog" method="get">
                    <input type="hidden" name="reset" value="true">
                    <button class="btn btn-outline-primary float-end" type="submit">Сбросить фильтры</button>
                </form>
            </div>
        </div>
        <div class="row">
            <h5>Категории: ${stringActiveCategories}</h5>
        </div>
        <div class="row">
            <h5>Жанры: ${stringActiveGenres}</h5>
        </div>
        <div class="row">
            <#if sortingType>
                <h5>Сортировка: ${sortBy}, по убыванию</h5>
                <#else>
                <h5>Сортировка: ${sortBy}, по возрастанию</h5>
            </#if>
        </div>
    </div>

    <div class="card p-3 mt-3">
        <div class="d-flex flex-row flex-wrap justify-content-center">
            <#list books as book>
                <div class="d-flex align-items-stretch" style="width: 25%">
                    <div class="card m-3 w-100">
                        <img src="/img/${book.image()}" class="card-img-top overflow-hidden object-fit-cover" alt="Image of a book" style="height: 25rem">
                        <div class="card-body d-flex flex-column justify-content-between">
                            <h5 class="card-title mb-4">${book.title()}</h5>
                            <div>
                                <h2 class="font-monospace">${book.finalPrice()} ₽</h2>
                                <div class="d-flex justify-content-between">
                                    <a href="/book/${book.id()}" class="btn btn-primary">Подробнее</a>
                                    <#if userId==-1>
                                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                            Купить
                                        </button>
                                        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h1 class="modal-title fs-5" id="exampleModalLabel">Похоже, вы не авторизованы</h1>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <p>Пожалуйста, авторизуйтесь, чтобы добавить товар в корзину.</p>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Закрыть</button>
                                                        <a href="/sign-in" class="btn btn-primary">Войти</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    <#else>
                                        <form action="/buy" method="post">
                                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                                            <input type="hidden" name="bookId" value="${book.id()}">
                                            <#if book.amount() != 0>
                                                <button id="buy-button" type="submit" class="btn btn-primary">В корзину</button>
                                            <#else >
                                                <button type="button" class="btn btn-danger">Нет в наличии</button>
                                            </#if>
                                        </form>

                                    </#if>

                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            <#else>
                <div class="card w-100">
                    <div class="card-body">
                        По вашему запросу ничего не найдено.
                    </div>
                </div>
            </#list>
        </div>
    </div>
</@c.page>