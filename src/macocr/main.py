#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import argparse
import os
import glob
import magic
import math
from pillow_heif import register_heif_opener  # type: ignore
from ocrmac import ocrmac  # type: ignore

register_heif_opener()


class OCRProcessor:
    def __init__(self, image_dir: str, output_dir: str):
        # Convert provided directories to absolute paths
        self.image_dir = os.path.realpath(image_dir)
        self.output_dir = os.path.realpath(output_dir)

    def run(self) -> None:
        """Main method to process all images from the input directory."""
        for image in self.get_images():
            print(f"Processing {image}")
            annotations = self.process_image(image)
            if not annotations:
                print(f"Failed to OCR {image}")
                continue
            self.save_annotations(image, annotations)

    def get_images(self) -> list:
        """
        Retrieves image paths from the input directory.
        Only includes images with MIME types 'image/jpeg', 'image/png', or 'image/heic'.
        """
        pattern = os.path.join(self.image_dir, "*")
        images = [
            f
            for f in glob.glob(pattern)
            if magic.from_file(f, mime=True)
            in ["image/jpeg", "image/png", "image/heic"]
        ]
        return images

    def process_image(self, image_path: str) -> list:
        """
        Uses the ocrmac.OCR class to perform OCR on the image.
        The "livetext" framework is used with language preference set to Japanese.
        """
        ocr_instance = ocrmac.OCR(
            image_path, framework="livetext", language_preference=["ja-JP"]
        )
        return ocr_instance.recognize()

    def save_annotations(self, image_path: str, annotations: list) -> None:
        """
        Formats the OCR annotations and writes them to a text file.
        The filename is based on the original image filename without extension.
        """
        bn_no_ext = os.path.splitext(os.path.basename(image_path))[0]
        output_file = os.path.join(self.output_dir, f"{bn_no_ext}.txt")
        with open(output_file, "w", encoding="utf-8") as f:
            f.write(self.format_annotations(annotations))

    def format_annotations(self, annotations: list) -> str:
        """
        Formats OCR annotations into a string, attempting to replicate the original layout.
        Uses average character width and height from the annotations to determine spacing.
        """
        SPACE = 1.0
        avg_font_width = (
            sum(ann[2][2] for ann in annotations) / len(annotations) * SPACE
        )
        avg_font_height = (
            sum(ann[2][3] for ann in annotations) / len(annotations) * SPACE
        )

        lines = []
        sv_x, sv_y = 0, 0

        for ann in annotations:
            x, y, width, height = ann[2]
            # If the current annotation's position is offset enough from the previous annotation,
            # treat it as a new line
            if (abs(x - sv_x) > avg_font_width) and (abs(y - sv_y) > avg_font_height):
                lines.append(ann[0])
            else:
                # Calculate the number of spaces based on the position differences
                spaces = math.floor(
                    max(
                        abs(x - sv_x) / avg_font_width * 0.5,
                        abs(y - sv_y) / avg_font_height * 0.5,
                    )
                )
                if lines:
                    lines[-1] += " " * spaces + ann[0]
                else:
                    lines.append(" " * spaces + ann[0])
            sv_x, sv_y = x, y

        return "\n".join(lines)


def main() -> None:
    # Parse command-line arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("image_dir", help="Directory containing images to OCR")
    parser.add_argument("output_dir", help="Directory to output OCR results")
    args = parser.parse_args()

    # Create an OCRProcessor instance and run the OCR processing
    processor = OCRProcessor(args.image_dir, args.output_dir)
    processor.run()


if __name__ == "__main__":
    main()
