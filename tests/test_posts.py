import requests


def test_get_all_posts():
    url = "https://jsonplaceholder.typicode.com/posts"
    response = requests.get(url)
    assert response.status_code == 200
    assert len(response.json()) > 0  # Verify non-empty response


def test_create_post():
    url = "https://jsonplaceholder.typicode.com/posts"
    payload = {
        "title": "Test Post",
        "body": "This is a test post",
        "userId": 1
    }
    response = requests.post(url, json=payload)
    assert response.status_code == 201
    assert response.json()["id"] == 101  # Mock server returns 101 for new posts


def test_update_post():
    url = "https://jsonplaceholder.typicode.com/posts/1"
    payload = {"title": "Updated Title"}
    response = requests.patch(url, json=payload)
    assert response.status_code == 200
    assert response.json()["title"] == "Updated Title"
