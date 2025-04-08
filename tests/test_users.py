import csv
import pytest
import requests


def get_test_data():
    with open('data/test_data.csv') as f:
        return [row for row in csv.DictReader(f)]


@pytest.mark.parametrize("data", get_test_data())
def test_user_posts(data):
    url = f"https://jsonplaceholder.typicode.com/posts?userId={data['user_id']}"
    response = requests.get(url)
    assert response.status_code == 200
    assert len(response.json()) == int(data["expected_count"])


def test_response_schema():
    response = requests.get("https://jsonplaceholder.typicode.com/posts/1")
    data = response.json()

    assert isinstance(data["id"], int)
    assert isinstance(data["title"], str)
    assert isinstance(data["body"], str)
