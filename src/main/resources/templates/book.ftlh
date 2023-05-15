<#import "parts/common.ftlh" as c>
<#assign
    known = SPRING_SECURITY_CONTEXT??
>
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
        <div class="row card m-3 p-3">
            <div class="">
                <h3 class="">Описание</h3>
                <p class="lh-base fst-normal p-1">${book.description}</p>
            </div>
        </div>
        <div class="m-3 row justify-content-between">
            <div class="col d-flex align-items-end">
                <div class="d-flex flex-column align-items-start">
                    <p>В закладки:</p>
                    <#if known>
                        <form action="/book/${book.id}/bookmark" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <#if user.isBookmarked(book.id)>
                                <button type="submit" class="btn btn-danger">Убрать</button>
                                <#else>
                                <button type="submit" class="btn btn-primary">Добавить</button>
                            </#if>
                        </form>
                        <#else>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#goLogin">
                                Добавить
                            </button>
                            <div class="modal fade" id="goLogin" tabindex="-1" aria-labelledby="goLoginModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="goLoginModalLabel">Похоже, вы не авторизованы</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <p>Пожалуйста, авторизуйтесь, чтобы добавить товар в закладки.</p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Закрыть</button>
                                            <a href="/sign-in" class="btn btn-primary">Войти</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </#if>
                </div>

            </div>
            <div class="col">
                <div class="d-flex flex-column align-items-end">
                    <#if book.sale!=0 >
                        <h3 class="font-monospace text-decoration-line-through">
                            ${book.price} ₽
                        </h3>
                        <h3 id="sale" class="font-monospace text-danger">
                            ${book.finalPrice} ₽
                        </h3>
                        <div style="position: absolute; margin-top: -1rem" id="saleHelp" class="form-text text-danger">Скидка ${book.sale}%</div>
                    <#else>
                        <h3 class="font-monospace">
                            ${book.price} ₽
                        </h3>
                    </#if>
                    <#if known>
                        <form action="/book/${book.id}/buy" method="post">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <#if user.isCarted(book.id)>
                                <a class="btn btn-success" href="/cart">Оформить</a>
                                <#else>
                                    <#if book.amount != 0>
                                    <button type="submit" class="btn btn-primary">В корзину</button>
                                        <#else >
                                            <button type="button" class="btn btn-danger">Нет в наличии</button>
                                    </#if>
                            </#if>
                        </form>
                        <#else>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#goLogin">
                                Купить
                            </button>
                    </#if>

                </div>
            </div>
        </div>
    </div>

    <div class="card p-3 my-5">
        <h3 class="m-3">Отзывы</h3>
         <#if known>
             <button class="btn btn-primary collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                 Написать отзыв
             </button>
         </#if>
        <div class="col p-3 mt-3">
            <#if known>
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
                                        <div class="form-check d-flex flex-row">
                                            <label class="form-check-label">1</label>
                                            <input name="rating" class="form-check-input" type="radio" id="star1" value="1" style="margin-left: .5rem;">
                                        </div>
                                        <div class="form-check d-flex flex-row">
                                            <label class="form-check-label" for="star2">2</label>
                                            <input name="rating" class="form-check-input" type="radio" id="star2" value="2" style="margin-left: .5rem">
                                        </div>
                                        <div class="form-check d-flex flex-row">
                                            <label class="form-check-label" for="star3">3</label>
                                            <input name="rating" class="form-check-input" type="radio" id="star3" value="3" style="margin-left: .5rem">
                                        </div>
                                        <div class="form-check d-flex flex-row">
                                            <label class="form-check-label" for="star4">4</label>
                                            <input name="rating" class="form-check-input" type="radio" id="star4" value="4" style="margin-left: .5rem">
                                        </div>
                                        <div class="form-check d-flex flex-row">
                                            <label class="form-check-label" for="star5">5</label>
                                            <input name="rating" class="form-check-input" type="radio" id="star5" value="5" style="margin-left: .5rem">
                                        </div>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary">Добавить</button>
                            </div>
                        </form>
                    </#if>
                </div>
            </#if>
            <#list book.comments as comment>
                <#if comment.isModerated>
                    <div class="card p-3 mb-3">
                        <div class="row justify-content-between">
                            <div class="col-4">
                                <div class="mb-3">
                                    <p><b>${comment.user.username}</b>, дата: ${comment.formatDate()}</p>
                                </div>
                            </div>

                            <div class="col-4">
                                <form class="d-flex justify-content-end" action="/book/${book.id}/comment/${comment.id}" method="post">
                                    <#if known>
                                        <#if comment.user.id == user.id! || user.isAdmin() || user.isModerator()>
                                            <button type="button" class="btn btn-close" data-bs-toggle="modal" data-bs-target="#exampleModal"></button>
                                        </#if>
                                    </#if>

                                    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h1 class="modal-title fs-5" id="exampleModalLabel">Удаление комментария</h1>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    <p>Вы действительно хотите удалить комментарий?</p>
                                                </div>
                                                <div class="modal-footer">
                                                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                                                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Нет</button>
                                                    <button type="submit" class="btn btn-danger" data-bs-dismiss="modal">Да</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <div class="mb-3">
                            <h4>${comment.title}</h4>
                        </div>
                        <div class="mb-3">
                            <p>${comment.text}</p>
                        </div>
                        <div class="mb-3">
                            <strong>Оценка: ${comment.rate}</strong>
                        </div>
                    </div>
                </#if>
                <#else>
                <h4 class="mb-3">Отзывов пока нет. Будьте первым и напишите отзыв!</h4>
            </#list>
        </div>
    </div>
</@c.page>