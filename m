Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B2C3320EC
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Mar 2021 09:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhCIIn0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Mar 2021 03:43:26 -0500
Received: from smtp-out-so.shaw.ca ([64.59.136.139]:42014 "EHLO
        smtp-out-so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhCIInZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Mar 2021 03:43:25 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Mar 2021 03:43:25 EST
Received: from cabot.adilger.int ([70.77.221.9])
        by shaw.ca with ESMTP
        id JXpblguAMnRGtJXpdlGSWi; Tue, 09 Mar 2021 01:35:09 -0700
X-Authority-Analysis: v=2.4 cv=cagXElPM c=1 sm=1 tr=0 ts=6047333e
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=RPJ6JBhKAAAA:8
 a=FP58Ms26AAAA:8 a=azo8WlVMIcuJQSkrYigA:9 a=fa_un-3J20JGBB2Tu-mn:22
 a=BPzZvq435JnGatEyYwdK:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH] e2image: add OPTIONS section to man page
Date:   Tue,  9 Mar 2021 01:35:08 -0700
Message-Id: <20210309083508.30900-1-adilger@dilger.ca>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
X-CMAE-Envelope: MS4xfDZRqEHBehCjxmxy56Xq4qCI14D3Oky+fZCJSFf5k7nHf8jnzk6mQG99IvyhiicBnAFEJhRGsNtELOpQZjKdSlBuwXL5G1i2wHZCTpoK/E35ZHB/JtLz
 vTlIcel08f3tzPQ1ufJYf7KJEMpa7cY2AGt/i9SqGlqvo+jjuxu2zi9p01sBvBfRjGzxIO/ZKH1qhDVZOfLaIesVGnBJ3chHkNx2ZKmHkmTd2pZhx9K8HFTw
 VW4WYdzop15B6783EvSHbA==
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Reorganize the e2image.8 man page so that the command-line options
are listed in a dedicated OPTIONS section, rather than being
interspersed among the text in the DESCRIPTION section.  Otherwise,
it is difficult to determine which options are available, and to
find where each option is described.

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
---
 misc/e2image.8.in | 350 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 184 insertions(+), 166 deletions(-)

diff --git a/misc/e2image.8.in b/misc/e2image.8.in
index ef1248674997..cb176f5dfdd0 100644
--- a/misc/e2image.8.in
+++ b/misc/e2image.8.in
@@ -1,18 +1,14 @@
 .\" -*- nroff -*-
 .\" Copyright 2001 by Theodore Ts'o.  All Rights Reserved.
 .\" This file may be copied under the terms of the GNU Public License.
-.\" 
+.\"
 .TH E2IMAGE 8 "@E2FSPROGS_MONTH@ @E2FSPROGS_YEAR@" "E2fsprogs version @E2FSPROGS_VERSION@"
 .SH NAME
 e2image \- Save critical ext2/ext3/ext4 filesystem metadata to a file
+
 .SH SYNOPSIS
 .B e2image
-[
-.B \-r|\-Q
-]
-[
-.B \-f
-]
+.RB [ \-r | \-Q " [" \-af ]]
 [
 .B \-b
 .I superblock
@@ -21,18 +17,8 @@ e2image \- Save critical ext2/ext3/ext4 filesystem metadata to a file
 .B \-B
 .I blocksize
 ]
-.I device
-.I image-file
-.br
-.B e2image
-.B \-I
-.I device
-.I image-file
-.br
-.B e2image
-.B \-ra
 [
-.B \-cfnp
+.B \-cnps
 ]
 [
 .B \-o
@@ -42,10 +28,14 @@ e2image \- Save critical ext2/ext3/ext4 filesystem metadata to a file
 .B \-O
 .I dest_offset
 ]
-.I src_fs
-[
-.I dest_fs
-]
+.I device
+.I image-file
+.br
+.B e2image
+.B \-I
+.I device
+.I image-file
+
 .SH DESCRIPTION
 The
 .B e2image
@@ -59,40 +49,11 @@ and
 .BR  debugfs ,
 by using the
 .B \-i
-option to those programs.  This can assist an expert in
-recovering catastrophically corrupted filesystems.  In the future,
-e2fsck will be enhanced to be able to use the image file to help
-recover a badly damaged filesystem.
+option to those programs.  This can assist an expert in recovering
+catastrophically corrupted filesystems.
 .PP
-When saving an e2image for debugging purposes, using either the
-.B \-r
-or
-.B \-Q
-options, the filesystem must be unmounted or be mounted read/only, in order
-for the image file to be in a consistent state.  This requirement can be
-overridden using the
-.B \-f
-option, but the resulting image file is very likely not going to be useful.
-.PP
-If
-.I image-file
-is \-, then the output of
-.B e2image
-will be sent to standard output, so that the output can be piped to
-another program, such as
-.BR gzip (1).
-(Note that this is currently only supported when
-creating a raw image file using the
-.B \-r
-option, since the process of creating a normal image file, or QCOW2
-image currently
-requires random access to the file, which cannot be done using a
-pipe.  This restriction will hopefully be lifted in a future version of
-.BR e2image .)
-.PP
-It is a very good idea to create image files for all of
-filesystems on a system and save the partition
-layout (which can be generated using the
+It is a very good idea to create image files for all filesystems on a
+system and save the partition layout (which can be generated using the
 .B fdisk \-l
 command) at regular intervals --- at boot time, and/or every week or so.
 The image file should be stored on some filesystem other than
@@ -101,31 +62,95 @@ accessible in the case where the filesystem has been badly damaged.
 .PP
 To save disk space,
 .B e2image
-creates the image file as a sparse file, or in QCOW2 format.
-Hence, if the sparse image file
-needs to be copied to another location, it should
+creates the image file as a sparse file, or in QCOW2 format.  Hence, if
+the sparse image file needs to be copied to another location, it should
 either be compressed first or copied using the
 .B \-\-sparse=always
 option to the GNU version of
-.BR cp .
+.BR cp (1).
 This does not apply to the QCOW2 image, which is not sparse.
 .PP
 The size of an ext2 image file depends primarily on the size of the
-filesystems and how many inodes are in use.  For a typical 10 gigabyte
-filesystem, with 200,000 inodes in use out of 1.2 million inodes, the
-image file will be approximately 35 megabytes; a 4 gigabyte filesystem with
-15,000 inodes in use out of 550,000 inodes will result in a 3 megabyte
-image file.  Image files tend to be quite
-compressible; an image file taking up 32 megabytes of space on
-disk will generally compress down to 3 or 4 megabytes.
+filesystems and how many inodes are in use.  For a typical 10 Gigabyte
+filesystem, with 200,000 inodes in use out of 1.2 million inodes, the image
+file will be approximately 35 Megabytes; a 4 Gigabyte filesystem with 15,000
+inodes in use out of 550,000 inodes will result in a 3 Megabyte image file.
+Image files tend to be quite compressible; an image file taking up 32 Megabytes
+of space on disk will generally compress down to 3 or 4 Megabytes.
 .PP
-.SH RESTORING FILESYSTEM METADATA USING AN IMAGE FILE
-.PP
-The
+If
+.I image-file
+is
+.BR \- ,
+then the output of
+.B e2image
+will be sent to standard output, so that the output can be piped to
+another program, such as
+.BR gzip (1).
+(Note that this is currently only supported when
+creating a raw image file using the
+.B \-r
+option, since the process of creating a normal image file, or QCOW2
+image currently
+requires random access to the file, which cannot be done using a
+pipe.
+
+.SH OPTIONS
+.TP
+.B \-a
+Include file data in the image file.  Normally
+.B e2image
+only includes fs metadata, not regular file data.  This option will
+produce an image that is suitable to use to clone the entire FS or
+for backup purposes.  Note that this option only works with the
+raw
+.RI ( \-r )
+or QCOW2
+.RI ( \-Q )
+formats.  In conjunction with the
+.B \-r
+option it is possible to clone all and only the used blocks of one
+filesystem to another device/image file.
+.TP
+.BI \-b " superblock"
+Get image from partition with broken primary superblock by using
+the superblock located at filesystem block number
+.IR superblock .
+The partition is copied as-is including broken primary superblock.
+.TP
+.BI \-B " blocksize"
+Set the filesystem blocksize in bytes.  Normally,
+.B e2image
+will search for the superblock at various different block sizes in an
+attempt to find the appropriate blocksize. This search can be fooled in
+some cases.  This option forces e2fsck to only try locating the superblock
+with a particular blocksize. If the superblock is not found, e2image will
+terminate with a fatal error.
+.TP
+.BI \-c
+Compare each block to be copied from the source
+.I device
+to the corresponding block in the target
+.IR image-file .
+If both are already the same, the write will be skipped.  This is
+useful if the file system is being cloned to a flash-based storage device
+(where reads are very fast and where it is desirable to avoid unnecessary
+writes to reduce write wear on the device).
+.TP
+.B \-f
+Override the read-only requirement for the source filesystem when saving
+the image file using the
+.B \-r
+and
+.B \-Q
+options.  Normally, if the source filesystem is in use, the resulting image
+file is very likely not going to be useful. In some cases where the source
+filesystem is in constant use this may be better than no image at all.
+.TP
 .B \-I
-option will cause e2image to install the metadata stored in the image
-file back to the device.  It can be used to restore the filesystem metadata
-back to the device in emergency situations.
+install the metadata stored in the image file back to the device.
+It can be used to restore the filesystem metadata back to the device
+in emergency situations.
 .PP
 .B WARNING!!!!
 The
@@ -134,29 +159,76 @@ option should only be used as a desperation measure when other
 alternatives have failed.  If the filesystem has changed since the image
 file was created, data
 .B will
-be lost.  In general, you should make a full image
-backup of the filesystem first, in case you wish to try other recovery
-strategies afterwards.
-.PP
+be lost.  In general, you should make another full image backup of the
+filesystem first, in case you wish to try other recovery strategies afterward.
+.TP
+.B \-n
+Cause all image writes to be skipped, and instead only print the block
+numbers that would have been written.
+.TP
+.BI \-o " src_offset"
+Specify offset of the image to be read from the start of the source
+.I device
+in bytes.  See
+.B OFFSETS
+for more details.
+.TP
+.BI \-O " tgt_offset"
+Specify offset of the image to be written from the start of the target
+.I image-file
+in bytes.  See
+.B OFFSETS
+for more details.
+.TP
+.B \-p
+Show progress of image-file creation.
+.TP
+.B \-Q
+Create a QCOW2-format image file instead of a normal image file, suitable
+for use by virtual machine images, and other tools that can use the
+.B .qcow
+image format. See
+.B QCOW2 IMAGE FILES
+below for details.
+.TP
+.B \-r
+Create a raw image file instead of a normal image file.  See
+.B RAW IMAGE FILES
+below for details.
+.TP
+.B \-s
+Scramble directory entries and zero out unused portions of the directory
+blocks in the written image file to avoid revealing information about
+the contents of the filesystem.  However, this will prevent analysis of
+problems related to hash-tree indexed directories.
+
 .SH RAW IMAGE FILES
 The
 .B \-r
-option will create a raw image file instead of a normal image file.
-A raw image file differs
+option will create a raw image file, which differs
 from a normal image file in two ways.  First, the filesystem metadata is
-placed in the proper position so that e2fsck, dumpe2fs, debugfs,
-etc.\& can be run directly on the raw image file.  In order to minimize
-the amount of disk space consumed by a raw image file, the file is
+placed in the same relative offset within
+.I image-file
+as it is in the
+.I device
+so that
+.BR debugfs (8),
+.BR dumpe2fs (8),
+.BR e2fsck (8),
+.BR losetup (8),
+etc. and can be run directly on the raw image file.  In order to minimize
+the amount of disk space consumed by the raw image file, it is
 created as a sparse file.  (Beware of copying or
 compressing/decompressing this file with utilities that don't understand
 how to create sparse files; the file will become as large as the
 filesystem itself!)  Secondly, the raw image file also includes indirect
-blocks and directory blocks, which the standard image file does not have,
-although this may change in the future.
+blocks and directory blocks, which the standard image file does not have.
 .PP
 Raw image files are sometimes used when sending filesystems to the maintainer
 as part of bug reports to e2fsprogs.  When used in this capacity, the
-recommended command is as follows (replace hda1 with the appropriate device):
+recommended command is as follows (replace
+.B hda1
+with the appropriate device for your system):
 .PP
 .br
 	\fBe2image \-r /dev/hda1 \- | bzip2 > hda1.e2i.bz2\fR
@@ -166,46 +238,27 @@ However, the filenames in the directory blocks can still reveal
 information about the contents of the filesystem that the bug reporter
 may wish to keep confidential.  To address this concern, the
 .B \-s
-option can be specified.  This will cause
-.B e2image
-to scramble directory entries and zero out any unused portions
-of the directory blocks before writing the image file.  However,
-the
-.B \-s
-option will prevent analysis of problems related to hash-tree indexed
-directories.
+option can be specified to scramble the filenames in the image.
 .PP
-Option
-.B \-b
-.I superblock
-can be used to get image from partition with broken primary superblock.
-The partition is copied as-is including broken primary superblock.
-.PP
-Option
-.B \-B
-.I blocksize
-can be used to set superblock block size. Normally, e2fsck will search
-for the superblock at various different block sizes in an attempt to find
-the appropriate blocksize. This search can be fooled in some cases.  This
-option forces e2fsck to only try locating the superblock at a particular
-blocksize. If the superblock is not found, e2fsck will terminate with a
-fatal error.
-.PP
-Note that this will work even if you substitute "/dev/hda1" for another raw
+Note that this will work even if you substitute
+.B /dev/hda1
+for another raw
 disk image, or QCOW2 image previously created by
 .BR e2image .
-.PP
+
 .SH QCOW2 IMAGE FILES
 The
 .B \-Q
 option will create a QCOW2 image file instead of a normal, or raw image file.
 A QCOW2 image contains all the information the raw image does, however unlike
-the raw image it is not sparse. The QCOW2 image minimize the amount of disk
-space by storing data in special format with pack data closely together, hence
-avoiding holes while still minimizing size.
+the raw image it is not sparse. The QCOW2 image minimize the amount of space
+used by the image by storing it in special format which packs data closely
+together, hence avoiding holes while still minimizing size.
 .PP
 In order to send filesystem to the maintainer as a part of bug report to
-e2fsprogs, use following commands (replace hda1 with the appropriate device):
+e2fsprogs, use following commands (replace
+.B hda1
+with the appropriate device for your system):
 .PP
 .br
 \	\fBe2image \-Q /dev/hda1 hda1.qcow2\fR
@@ -213,66 +266,28 @@ e2fsprogs, use following commands (replace hda1 with the appropriate device):
 \	\fBbzip2 -z hda1.qcow2\fR
 .PP
 This will only send the metadata information, without any data blocks.
-However, the filenames in the directory blocks can still reveal
-information about the contents of the filesystem that the bug reporter
-may wish to keep confidential.  To address this concern, the
+As described for
+.B RAW IMAGE FILES
+the
 .B \-s
-option can be specified.  This will cause
-.B e2image
-to scramble directory entries and zero out any unused portions
-of the directory blocks before writing the image file.  However, the
-.B \-s
-option will prevent analysis of problems related to hash-tree indexed
-directories.
+option can be specified to scramble the filesystem names in the image.
 .PP
-Note that QCOW2 image created by
+Note that the QCOW2 image created by
 .B e2image
-is regular QCOW2 image and can be processed by tools aware of QCOW2 format
+is a regular QCOW2 image and can be processed by tools aware of QCOW2 format
 such as for example
 .BR qemu-img .
 .PP
-You can convert a qcow2 image into a raw image with:
+You can convert a .qcow2 image into a raw image with:
 .PP
 .br
 \	\fBe2image \-r hda1.qcow2 hda1.raw\fR
 .br
 .PP
-This can be useful to write a qcow2 image containing all data to a
+This can be useful to write a QCOW2 image containing all data to a
 sparse image file where it can be loop mounted, or to a disk partition.
-Note that this may not work with qcow2 images not generated by e2image.
-.PP
-Options
-.B \-b
-.I superblock
-and
-.B \-B
-.I blocksize
-can be used same way as for raw images.
-.PP
-.SH INCLUDING DATA
-Normally
-.B e2image
-only includes fs metadata, not regular file data.  The
-.B \-a
-option can be specified to include all data.  This will
-give an image that is suitable to use to clone the entire FS or
-for backup purposes.  Note that this option only works with the
-raw or QCOW2 formats.  The
-.B \-p
-switch may be given to show progress.  If the file system is being
-cloned to a flash-based storage device (where reads are very fast and
-where it is desirable to avoid unnecessary writes to reduce write wear
-on the device), the
-.B \-c
-option which cause e2image to try reading a block from the destination
-to see if it is identical to the block which
-.B e2image
-is about to copy.  If the block is already the same, the write can be
-skipped.  The
-.B \-n
-option will cause all of the writes to be no-ops, and print the blocks
-that would have been written.
-.PP
+Note that this may not work with QCOW2 images not generated by e2image.
+
 .SH OFFSETS
 Normally a filesystem starts at the beginning of a partition, and
 .B e2image
@@ -288,14 +303,14 @@ before writing the filesystem.
 For example, if you have a
 .B dd
 image of a whole hard drive that contains an ext2 fs in a partition
-starting at 1 MiB, you can clone that fs with:
+starting at 1 MiB, you can clone that image to a block device with:
 .PP
 .br
 \	\fBe2image \-aro 1048576 img /dev/sda1\fR
 .br
 .PP
-Or you can clone a fs into an image file, leaving room in the first
-MiB for a partition table with:
+Or you can clone a filesystem from a block device into an image file,
+leaving room in the first MiB for a partition table with:
 .PP
 .br
 \	\fBe2image -arO 1048576 /dev/sda1 img\fR
@@ -304,14 +319,17 @@ MiB for a partition table with:
 If you specify at least one offset, and only one file, an in-place
 move will be performed, allowing you to safely move the filesystem
 from one offset to another.
+
 .SH AUTHOR
 .B e2image
 was written by Theodore Ts'o (tytso@mit.edu).
+
 .SH AVAILABILITY
 .B e2image
 is part of the e2fsprogs package and is available from
 http://e2fsprogs.sourceforge.net.
+
 .SH SEE ALSO
 .BR dumpe2fs (8),
 .BR debugfs (8)
-
+.BR e2fsck (8)
-- 
2.14.3 (Apple Git-98)

