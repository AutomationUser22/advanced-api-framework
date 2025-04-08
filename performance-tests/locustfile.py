from locust import HttpUser, task


class ApiUser(HttpUser):
    @task
    def get_post(self):
        self.client.get("/posts/1")
