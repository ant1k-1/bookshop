<#import "parts/common.ftlh" as c>
<@c.page "Регистрация">
    <div class="container mx-auto p-2">
        <!-- Section: Design Block -->
        <section class="text-center">
            <!-- Background image -->
            <div class="p-5 bg-image" style="
        background-image: url('/static/img/a-pleasure-doing-business-my-perfect-dad-43-jayhypnowriter.png');
        height: 300px;
        "></div>
            <!-- Background image -->

            <div class="card shadow-5-strong mx-auto p-2" style="
        margin-top: -10rem;
        background: hsla(0, 0%, 100%, 0.8);
        backdrop-filter: blur(30px);
        width: 50%;
        ">
                <div class="card-body py-5 px-md-5">

                    <div class="row d-flex justify-content-center">
                        <div class="col-lg-8">
                            <h2 class="fw-bold mb-3">Регистрация</h2>
                            <form action="/sign-up" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <!-- Username input -->
                                <div class="form-outline mb-1">
                                    <label class="form-label float-start" for="form3Example1">Логин</label>
                                    <input name="username" type="text" id="form3Example1" class="form-control" aria-describedby="loginHelp"/>
                                    <div id="loginHelp" class="form-text">Придумайте логин</div>
                                </div>

                                <!-- Password input -->
                                <div class="form-outline mb-1">
                                    <label class="form-label float-start" for="form3Example2">Пароль</label>
                                    <input name="password" type="password" id="form3Example2" class="form-control" aria-describedby="passwordHelp"/>
                                    <div id="passwordHelp" class="form-text">Придумайте надежный пароль!</div>
                                </div>

                                <!-- Email input -->
                                <div class="form-outline mb-1">
                                    <label class="form-label float-start" for="form3Example3">Почта</label>
                                    <input name="email" type="email" id="form3Example3" class="form-control" aria-describedby="emailHelp" placeholder="example@mymail.com"/>
                                    <div id="emailHelp" class="form-text">Для связи с вами</div>
                                </div>

                                <!-- Name input -->
                                <div class="form-outline mb-1">
                                    <label class="form-label float-start" for="form3Example4">Имя</label>
                                    <input name="name" type="text" id="form3Example4" class="form-control" aria-describedby="nameHelp"/>
                                    <div id="nameHelp" class="form-text">Как к вам обращаться?</div>
                                </div>

                                <!-- Date input -->
                                <div class="form-outline mb-3">
                                    <label class="form-label float-start" for="form3Example5">Дата рождения</label>
                                    <input name="birthDate" type="date" id="form3Example5" class="form-control" aria-describedby="birthdayHelp"/>
                                    <div id="birthdayHelp" class="form-text">Нужно для фильтрации книг</div>
                                </div>

                                <!-- Submit button -->
                                <button type="submit" class="btn btn-primary btn-block mb-3">
                                    Зарегистрироваться
                                </button>

                                <div>
                                    <p class="mb-0">Уже есть аккаунт? <a href="/sign-in" class="text-blue-50 fw-bold">Войти</a>
                                    </p>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Section: Design Block -->
    </div>
</@c.page>