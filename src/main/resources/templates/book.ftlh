<#import "parts/common.ftlh" as c>
<@c.page "Главная">
    <div class="card p-3">
        <div class="m-3 row">
            <h1 class="mb-3">${book.title}</h1>
            <div class="col">
                <img src="/img/${book.image}" class="rounded" style="
                width: 90%;
                height: auto"
                alt="">
            </div>

            <div class="col card p-3">
                <div class="m-3 row d-flex justify-content-between">
                    <div class="col">
                        <p>ID:</p>
                    </div>
                    <div class="col">${book.id}</div>
                </div>

                <div class="m-3 row d-flex justify-content-between">
                    <div class="col">
                        <p>Автор:</p>
                    </div>
                    <div class="col">${book.author}</div>
                </div>

                <div class="m-3 row d-flex justify-content-between">
                    <div class="col">
                        <p>Издательство:</p>
                    </div>
                    <div class="col">${book.publisher}</div>
                </div>

                <div class="m-3 row d-flex justify-content-between">
                    <div class="col">
                        <p>Год издания:</p>
                    </div>
                    <div class="col">${book.year}</div>
                </div>

                <div class="m-3 row d-flex justify-content-between">
                    <div class="col">
                        <p>ISBN:</p>
                    </div>
                    <div class="col">${book.ISBN}</div>
                </div>

                <div class="m-3 row d-flex justify-content-between">
                    <div class="col">
                        <p>Категория:</p>
                    </div>
                    <div class="col">${book.category.toRussian(book.category)}</div>
                </div>

                <div class="m-3 row d-flex justify-content-between">
                    <div class="col">
                        <p>Жанры:</p>
                    </div>
                    <div class="col">${book.toStringGenres()}</div>
                </div>

                <div class="m-3 row d-flex justify-content-between">
                    <div class="col">
                        <p>Возрастное ограничение:</p>
                    </div>
                    <div class="col">${book.ageRestriction}+</div>
                </div>

                <div class="m-3 row d-flex justify-content-between">
                    <div class="col">
                        <p>В наличии:</p>
                    </div>
                    <div class="col">${book.amount} шт</div>
                </div>

                <div class="m-3 row d-flex justify-content-between">
                    <div class="col">
                        <p>Рейтинг:</p>
                    </div>
                    <div class="col">
                        <#if book.rating == -1>
                            Нет рейтинга
                            <#else>
                            ${book.rating}
                        </#if>
                    </div>
                </div>
            </div>
        </div>
        <div class="m-3 row">
            <div class="m-3"><h4>Описание</h4></div>
            <div class="m-3">${book.description}</div>
        </div>
        <div class="m-3 row">
            <div class="col">
                <p>Цена:</p>
            </div>
            <div class="col">${book.price}</div>
        </div>
    </div>

    <div class="card p-3 my-5">
        <h3 class="m-3">Отзывы</h3>
        <button class="btn btn-primary collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
            Написать отзыв
        </button>
        <div class="col p-3 mt-3">
            <div class="collapse" id="collapseExample">
                <div><h4>Оставьте свой отзыв!</h4></div>
                <#if user.isCommented(book.id)>
                <div class="card p-3 mb-3">
                    <h5>Вы уже оставили отзыв на эту книгу</h5>
                </div>
                <#else>
                <form action="/book/${book.id}/comment" name="comment" method="post">
                    <div class="card p-3">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <div class="mb-3">
                            <label for="title1" class="form-label">Заголовок</label>
                            <input name="title" type="text" class="form-control" id="title1">
                        </div>
                        <div class="mb-3">
                            <label for="description1" class="form-label">Отзыв</label>
                            <textarea name="description" class="form-control" id="description1" rows="10"></textarea>
                        </div>
                        <div class="mb-1">
                            <p>Оценка:</p>
                        </div>
                        <div class="col">
                            <div class="star-rating d-flex flex-column ">
                                <#--                            fix labels margin-->
                                <div class="form-check d-flex flex-row">
                                    <label class="form-check-label">1</label>
                                    <input name="rating" class="form-check-input" type="radio" id="star1" value="1">
                                </div>
                                <div class="form-check d-flex flex-row">
                                    <label class="form-check-label" for="star2">2</label>
                                    <input name="rating" class="form-check-input" type="radio" id="star2" value="2">
                                </div>
                                <div class="form-check d-flex flex-row">
                                    <label class="form-check-label" for="star3">3</label>
                                    <input name="rating" class="form-check-input" type="radio" id="star3" value="3">
                                </div>
                                <div class="form-check d-flex flex-row">
                                    <label class="form-check-label" for="star4">4</label>
                                    <input name="rating" class="form-check-input" type="radio" id="star4" value="4">
                                </div>
                                <div class="form-check d-flex flex-row">
                                    <label class="form-check-label" for="star5">5</label>
                                    <input name="rating" class="form-check-input" type="radio" id="star5" value="5">
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">Добавить</button>
                    </div>
                </form>
                </#if>
            </div>
            <#list book.comments as comment>
                <#if comment.isModerated>
                    <div class="card p-3">
                        <div class="mb-3">
                            <p>${comment.user.username}, дата: ${comment.formatDate()}</p>
                        </div>
                        <div class="mb-3">
                            <p>${comment.title}</p>
                        </div>
                        <div class="mb-3">
                            <p>${comment.text}</p>
                        </div>
                        <div class="mb-3">
                            <p>Оценка: ${comment.rate}</p>
                        </div>
                        <div class="mb-3 row">
                            <div class="col">
                                Лайк:${comment.likes}
                            </div>
                            <div class="col">
                                Дизлайк:${comment.likes}
                            </div>
                        </div>
                    </div>
                </#if>
                <#else>
                <h4 class="mb-3">Отзывов пока нет. Будьте первым и напишите отзыв!</h4>
            </#list>
        </div>
    </div>
</@c.page>