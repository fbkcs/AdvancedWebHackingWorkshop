from django.shortcuts import render, render_to_response
from hashlib import *
import datetime
from django.views.decorators.cache import cache_page
from django.core.cache import cache
import random
import string


def generate_cookie():
    phrase = ''.join(random.choice(string.ascii_uppercase + string.digits) for _ in range(6))
    phrase = phrase.encode('utf-8')
    hashed = md5(phrase).hexdigest()
    return hashed


def auth2(request):
    context = {}
    if request.method == 'POST':
        cookie = generate_cookie()
        username = request.POST['username']
        context.update({'username': username})
        cache.set(cookie, username)
        response = render(request, 'inbox/auth.html', context)
        response.set_cookie('ID', cookie)
        return response
    if request.method == 'GET':
        cookie = request.COOKIES['ID']
        username = cache.get(cookie)
        context.update({'cookie': cookie, 'username': cache.get(cookie)})
        return render(request, 'inbox/auth.html', context)


@cache_page(10*10)
def cookie2(request):
    context = {}
    try:
        ID = request.COOKIES['ID']
        context.update({'cookie': ID, 'username': cache.get(ID)})
    except:
        ID = "UNKNOWN"
        context.update({'cookie': ID, 'username': ID})
    response = render(request, 'inbox/cookie.html', context)
    return response


def index(request):
    return render(request, 'inbox/index.html')


def clear(request):
    response = render(request, 'inbox/clear.html')
    response.set_cookie('ID', '0')
    return response
