<#import "parts/common.ftlh" as c>
<@c.page "Редактирование пользователя">
    <div class="d-flex justify-content-center mb-3">
        <a href="/admin/add-book" class="btn btn-primary mb-3 me-2" style="width: 10rem">Добавить книгу</a>
        <a href="/admin/books" class="btn btn-primary mb-3 me-2" style="width: 10rem">Все книги</a>
        <a href="/admin/users" class="btn btn-primary mb-3 me-2" style="width: 10rem">Все пользователи</a>
    </div>
    <div class="card p-3 mb-3">
        <form action="/admin/users/${user.id}" method="post">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <div class="mb-3">
                <label for="username" class="form-label">Имя пользователя</label>
                <input autocomplete="off" name="username" type="text" class="form-control" id="username" value="${user.username}">
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Новый пароль</label>
                <input autocomplete="off" name="password" type="password" class="form-control" id="password" placeholder="Введите новый пароль, отличный от старого">
            </div>
            <div class="form-check form-switch">
                <input name="activeStatus" class="form-check-input" type="checkbox" role="switch" id="flexSwitchCheckDefault" ${(!user.isActiveStatus)?then("checked", "")} ${user.isAdmin()?then("disabled", "")}>
                <label class="form-check-label" for="flexSwitchCheckDefault">Забанен</label>
            </div>
            <div class="form-check form-switch">
                <input name="commentsAllowed" class="form-check-input" type="checkbox" role="switch" id="commentsAllowed" ${(!user.isCommentsAllowed)?then("checked", "")}>
                <label class="form-check-label" for="commentsAllowed">Комментирование</label>
            </div>
            <div class="form-check form-switch">
                <input name="isCustomer" class="form-check-input" type="checkbox" role="switch" id="isCustomer" checked disabled>
                <label class="form-check-label" for="isCustomer">Пользователь</label>
            </div>
            <div class="form-check form-switch">
                <input name="isModer" class="form-check-input" type="checkbox" role="switch" id="isModer" ${user.isModer()?then("checked", "")}>
                <label class="form-check-label" for="isModer">Модератор</label>
            </div>
            <div class="form-check form-switch">
                <input name="isAdmin" class="form-check-input" type="checkbox" role="switch" id="isAdmin" ${user.isAdmin()?then("checked", "")} ${user.isAdmin()?then("disabled", "")}>
                <label class="form-check-label" for="isAdmin">Админ</label>
            </div>
            <button type="submit" class="btn btn-primary mt-3">Обновить</button>
        </form>
    </div>
</@c.page>