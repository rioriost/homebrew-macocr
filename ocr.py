#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import argparse
from ocrmac import ocrmac
import os
import glob
import magic
import math
from pillow_heif import register_heif_opener

register_heif_opener()


def format_annotations(annotations: list = []) -> str:
    SPACE = 1.0
    avg_font_width = sum([ann[2][2] for ann in annotations]) / len(annotations) * SPACE
    avg_font_height = sum([ann[2][3] for ann in annotations]) / len(annotations) * SPACE
    lines = []
    sv_x = 0
    sv_y = 0
    for ann in annotations:
        if (abs(ann[2][0] - sv_x) > avg_font_width) and (
            abs(ann[2][1] - sv_y) > avg_font_height
        ):
            lines.append(ann[0])
        else:
            spaces = math.floor(
                max(
                    abs(ann[2][0] - sv_x) / avg_font_width * 0.5,
                    abs(ann[2][1] - sv_y) / avg_font_height * 0.5,
                )
            )
            try:
                lines[len(lines) - 1] += " " * spaces + ann[0]
            except IndexError:
                lines.append(" " * spaces + ann[0])
        sv_x = ann[2][0]
        sv_y = ann[2][1]

    return "\n".join(lines)


def main() -> None:
    # Parse arguments
    parser = argparse.ArgumentParser()
    parser.add_argument("image_dir", help="Directory containing images to OCR")
    parser.add_argument("output_dir", help="Directory to output OCR results")
    args = parser.parse_args()

    # Get all images in the directory
    images = [
        f
        for f in glob.glob(os.path.join(os.path.realpath(args.image_dir), "*"))
        if magic.from_file(f, mime=True) in ["image/jpeg", "image/png", "image/heic"]
    ]
    for image in images:
        print(f"Processing {image}")
        annotations = ocrmac.OCR(
            image, framework="livetext", language_preference=["ja-JP"]
        ).recognize()
        if not annotations:
            print(f"Failed to OCR {image}")
            continue
        bn_no_ext = os.path.splitext(os.path.basename(image))[0]
        with open(
            os.path.join(os.path.realpath(args.output_dir), f"{bn_no_ext}.txt"), "w"
        ) as f:
            f.write(format_annotations(annotations))


if __name__ == "__main__":
    main()
