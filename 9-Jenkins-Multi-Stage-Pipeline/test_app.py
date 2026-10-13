import unittest
from app import app

class TestFlaskApp(unittest.TestCase):
    def test_home_route(self):
        client = app.test_client()
        response = client.get("/")
        print(response.data.decode("utf-8"))
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data.decode("utf-8"), "Flask CI/CD Pipeline — Build Successful!")

if __name__ == "__main__":
    unittest.main()
