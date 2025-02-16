#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import sys
import tempfile
import shutil
import unittest
from unittest.mock import patch

# Insert the src directory (which contains the macocr package) into sys.path.
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "src"))

# Import the main module from the macocr package.
import macocr.main as main_module


# A fake OCR class for testing.
class FakeOCR:
    def __init__(self, image):
        self.image = image

    def recognize(self):
        # If the image filename includes 'file1', return a dummy annotation list.
        # Otherwise (e.g. for file2.jpg) return an empty list.
        if "file1.jpg" in self.image:
            # A dummy annotation: tuple (text, ignored, [x, y, width, height])
            # The values below were chosen such that format_annotations returns "hello".
            return [("hello", None, [0, 0, 5, 5])]
        else:
            return []


def fake_ocr_constructor(image, framework, language_preference):
    return FakeOCR(image)


class TestMacocrMain(unittest.TestCase):
    def setUp(self):
        # Create temporary directories for the input images and output results.
        self.temp_input_dir = tempfile.mkdtemp(prefix="macocr_input_")
        self.temp_output_dir = tempfile.mkdtemp(prefix="macocr_output_")
        # Create two dummy image files in the input directory.
        # Their content is irrelevant because we patch magic.from_file.
        self.image_file1 = os.path.join(self.temp_input_dir, "file1.jpg")
        self.image_file2 = os.path.join(self.temp_input_dir, "file2.jpg")
        with open(self.image_file1, "w") as f:
            f.write("dummy content")
        with open(self.image_file2, "w") as f:
            f.write("dummy content")

    def tearDown(self):
        # Remove temporary directories and their contents.
        shutil.rmtree(self.temp_input_dir)
        shutil.rmtree(self.temp_output_dir)

    @patch("macocr.main.magic.from_file", return_value="image/jpeg")
    @patch("macocr.main.ocrmac.OCR", side_effect=fake_ocr_constructor)
    def test_main(self, mock_ocr, mock_magic):
        # Patch sys.argv so that main() sees our temporary directories.
        test_argv = [
            "macocr.py",  # dummy name of the script
            self.temp_input_dir,
            self.temp_output_dir,
        ]
        with patch.object(sys, "argv", test_argv):
            # Run the main function from macocr.main.
            main_module.main()

        # Check that file1.jpg produced an output text file since its annotation is non-empty.
        expected_output_file1 = os.path.join(self.temp_output_dir, "file1.txt")
        self.assertTrue(
            os.path.exists(expected_output_file1),
            f"Expected output file {expected_output_file1} does not exist.",
        )
        with open(expected_output_file1, "r", encoding="utf-8") as f:
            content = f.read()
        # Given our dummy annotation and logic in format_annotations, the output should be "hello".
        self.assertEqual(content, "hello")

        # Check that file2.jpg did not generate an output file, as its OCR recognized no text.
        expected_output_file2 = os.path.join(self.temp_output_dir, "file2.txt")
        self.assertFalse(
            os.path.exists(expected_output_file2),
            f"Output file {expected_output_file2} should not exist.",
        )

    @patch("macocr.main.magic.from_file", return_value="image/jpeg")
    @patch("macocr.main.ocrmac.OCR", side_effect=fake_ocr_constructor)
    def test_format_annotations_multiple_entries(self, mock_ocr, mock_magic):
        """
        Test the format_annotations method with multiple annotations.
        This covers the branch in format_annotations where space calculation is performed.
        """
        # Create dummy annotations with two entries having positions that trigger a new line.
        annotations = [
            ("Hello", None, [0, 0, 5, 5]),
            ("World", None, [20, 20, 5, 5]),
        ]
        # Instead of needing an instance, call the method on the class:
        output = main_module.OCRProcessor.format_annotations(
            main_module.OCRProcessor, annotations
        )
        expected = "Hello\nWorld"
        self.assertEqual(output, expected)

    @patch("macocr.main.magic.from_file", return_value="image/jpeg")
    @patch("macocr.main.ocrmac.OCR", side_effect=fake_ocr_constructor)
    def test_format_annotations_same_line(self, mock_ocr, mock_magic):
        """
        Test the format_annotations method when annotations are close enough that they are on the same line.
        """
        # Create dummy annotations that are side by side.
        annotations = [
            ("Hello", None, [0, 0, 5, 5]),
            ("World", None, [3, 0, 5, 5]),  # small horizontal difference
        ]
        output = main_module.OCRProcessor.format_annotations(
            main_module.OCRProcessor, annotations
        )
        # Depending on spacing calculation, "World" should be concatenated directly to "Hello".
        expected = "HelloWorld"
        self.assertEqual(output, expected)


if __name__ == "__main__":
    unittest.main()
