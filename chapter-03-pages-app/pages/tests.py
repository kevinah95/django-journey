from django.test import SimpleTestCase
from django.urls import reverse  # new

# Create your tests here.


class HomepageTests(SimpleTestCase):
    def test_url_exists_at_correct_location(self):
        # Arrange Act
        response = self.client.get("/")
        # Assert
        self.assertEqual(response.status_code, 200)

    def test_url_available_by_name(self):  # new
        # Arrange Act
        response = self.client.get(reverse("home"))
        # Assert
        self.assertEqual(response.status_code, 200)

    def test_template_name_correct(self):  # new
        response = self.client.get(reverse("home"))
        self.assertTemplateUsed(response, "home.html")

    def test_template_content(self):  # new
        response = self.client.get(reverse("home"))
        self.assertContains(response, "<h1>Homepage</h1>")


class AboutpageTests(SimpleTestCase):
    def test_url_exists_at_correct_location(self):
        # Arrange Act
        response = self.client.get("/about/")
        # Asert
        self.assertEqual(response.status_code, 200)

    def test_url_available_by_name(self):  # new
        # Arrange Act
        response = self.client.get(reverse("about"))
        # Assert
        self.assertEqual(response.status_code, 200)

    def test_template_name_correct(self):  # new
        response = self.client.get(reverse("about"))
        self.assertTemplateUsed(response, "about.html")

    def test_template_content(self):  # new
        response = self.client.get(reverse("about"))
        self.assertContains(response, "<h1>About page</h1>")
