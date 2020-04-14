Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9467C1A74A3
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Apr 2020 09:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406598AbgDNH0R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Apr 2020 03:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406586AbgDNH0P (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Apr 2020 03:26:15 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A589C0A3BDC
        for <linux-ext4@vger.kernel.org>; Tue, 14 Apr 2020 00:26:15 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id q73so5733689qvq.2
        for <linux-ext4@vger.kernel.org>; Tue, 14 Apr 2020 00:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vr34bjwiAdcp3VzBjc9EIzXSh6vj+fxfd5u8PnYCrw4=;
        b=DM5xS3c4SWLwQLQ4Lm0/3h0rILPZb/g6Ky+iCQfegt+xnqPlpJTO9aVeaiilkEvfxf
         49tYR2iBkXXMtu4nnX5QxqXv/cKamgLbTL3xKasnUo98a3vzCJ09uV5P9eb+I/4tlGyS
         qVBXPv5B4GJNSIvIgIDBHHk8z4WEsoANXvav8F+rbWfgw27k5OsZrg6hfJrPG6rykKnN
         FBVGTD+JmgldOh87/qBkcYz+qSmHZEMy4z26YA7gjY/k4wYXYX/rxhJolk+TEXc69Zgu
         xgF4hjSHZiaJZtlzfBNcQpaPRcdUYpuLghklVt1ChbFULREhTJyXsy9nX2sO/olho9GI
         yirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vr34bjwiAdcp3VzBjc9EIzXSh6vj+fxfd5u8PnYCrw4=;
        b=nRi3mba/TsEDihJopLh0Pl8tevYjnsblXGQc9BjOgxjYMBYaLOkGjxE60BC171Hf+4
         h/Z0IQpIdhsUfI281cF+NgHhED9eSWVztpPrru7CcK9ZTp7bn6A6ZU9V5vJlQp/AQYAE
         chNizrAWoOoENdPPox7dh5ArS+bhm9r/cU0OrcA9L69GaZ5ONrb6BEJzJKyZIqLRE+cF
         CxWyzQY72/2u49w9gBzRXDUXWDU0e+XKkOHkJth4Ylr6or20Z8v8fXweawPfDq5QXKTN
         jvPwH7Tt7Wx1BO4+UzFxMq3tgcO5KGksoU00bfTbjlw9BBlS2wGYzAqmpeBqb++Sjbc1
         qQJw==
X-Gm-Message-State: AGi0PuauhlYDvNVSW3fvQqmkZ0CpWZRJHiXXuqx4m4f1WIzHB3cBuSly
        4ZeF5Rjcy00n8bZaT+gkO7yUm0YRiaBtIA==
X-Google-Smtp-Source: APiQypI3V4MZfjR/3WV8mrNpbkyI/gHxAbBYxrylRdrEmgWh9S/cefMLURBR47+VqgzDT8I6OGCCFA==
X-Received: by 2002:ad4:446a:: with SMTP id s10mr2259229qvt.31.1586849174510;
        Tue, 14 Apr 2020 00:26:14 -0700 (PDT)
Received: from C02TN4C6HTD6.us.cray.com (seattle-nat.cray.com. [136.162.66.1])
        by smtp.gmail.com with ESMTPSA id x24sm10648818qth.80.2020.04.14.00.26.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 00:26:14 -0700 (PDT)
From:   Artem Blagodarenko <artem.blagodarenko@gmail.com>
X-Google-Original-From: Artem Blagodarenko <artem.blagodarenko@hpe.com>
To:     linux-ext4@vger.kernel.org
Cc:     adilger.kernel@dilger.ca, Alexey Lyashkov <alexey.lyashkov@hpe.com>
Subject: [PATCH] e2image: add option to ignore fs errors
Date:   Tue, 14 Apr 2020 10:26:02 +0300
Message-Id: <20200414072602.53290-1-artem.blagodarenko@hpe.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Alexey Lyashkov <alexey.lyashkov@hpe.com>

While running into RAID corruption issues e2image fails.
The problem is that having an e2image in this instance is really
helpful, no matter if there is an error so having the ability
to skip these errors messages to create an e2image seem warranted.

Add "-i" option to be more tolerant to fs errors while scanning inode
extents.

Signed-off-by: Alexey Lyashkov <alexey.lyashkov@hpe.com>
Signed-off-by: Artem Blagodarenko <artem.blagodarenko@hpe.com>
hpe-bug-id: LUS-1922
Change-Id: Ib79300656726839b1d3b7ee1dd0793c60679d296
---
 misc/e2image.8.in                |  3 +++
 misc/e2image.c                   | 12 +++++++++---
 tests/i_error_tolerance/expect.1 | 23 +++++++++++++++++++++++
 tests/i_error_tolerance/expect.2 |  7 +++++++
 tests/i_error_tolerance/script   | 38 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 80 insertions(+), 3 deletions(-)
 create mode 100644 tests/i_error_tolerance/expect.1
 create mode 100644 tests/i_error_tolerance/expect.2
 create mode 100644 tests/i_error_tolerance/script

diff --git a/misc/e2image.8.in b/misc/e2image.8.in
index ef12486..0ac41d4 100644
--- a/misc/e2image.8.in
+++ b/misc/e2image.8.in
@@ -73,6 +73,9 @@ for the image file to be in a consistent state.  This requirement can be
 overridden using the
 .B \-f
 option, but the resulting image file is very likely not going to be useful.
+If you going to grab an image from a corrupted FS
+.B \-i
+option to ignore fs errors, allows to grab fs image from a corrupted fs.
 .PP
 If
 .I image-file
diff --git a/misc/e2image.c b/misc/e2image.c
index 56183ad..13cc517 100644
--- a/misc/e2image.c
+++ b/misc/e2image.c
@@ -78,6 +78,7 @@ static char move_mode;
 static char show_progress;
 static char *check_buf;
 static int skipped_blocks;
+static int fs_error_tolerant = 0;
 
 static blk64_t align_offset(blk64_t offset, unsigned int n)
 {
@@ -1368,7 +1369,8 @@ static void write_raw_image_file(ext2_filsys fs, int fd, int type, int flags,
 				com_err(program_name, retval,
 					_("while iterating over inode %u"),
 					ino);
-				exit(1);
+				if (fs_error_tolerant == 0)
+					exit(1);
 			}
 		} else {
 			if ((inode.i_flags & EXT4_EXTENTS_FL) ||
@@ -1381,7 +1383,8 @@ static void write_raw_image_file(ext2_filsys fs, int fd, int type, int flags,
 				if (retval) {
 					com_err(program_name, retval,
 					_("while iterating over inode %u"), ino);
-					exit(1);
+					if (fs_error_tolerant == 0)
+						exit(1);
 				}
 			}
 		}
@@ -1507,7 +1510,7 @@ int main (int argc, char ** argv)
 	if (argc && *argv)
 		program_name = *argv;
 	add_error_table(&et_ext2_error_table);
-	while ((c = getopt(argc, argv, "b:B:nrsIQafo:O:pc")) != EOF)
+	while ((c = getopt(argc, argv, "b:B:nrsIQafo:O:pci")) != EOF)
 		switch (c) {
 		case 'b':
 			superblock = strtoull(optarg, NULL, 0);
@@ -1552,6 +1555,9 @@ int main (int argc, char ** argv)
 		case 'c':
 			check = 1;
 			break;
+		case 'i':
+			fs_error_tolerant = 1;
+			break;
 		default:
 			usage();
 		}
diff --git a/tests/i_error_tolerance/expect.1 b/tests/i_error_tolerance/expect.1
new file mode 100644
index 0000000..8d5ffa2
--- /dev/null
+++ b/tests/i_error_tolerance/expect.1
@@ -0,0 +1,23 @@
+Pass 1: Checking inodes, blocks, and sizes
+Inode 12 has illegal block(s).  Clear? yes
+
+Illegal indirect block (1000000) in inode 12.  CLEARED.
+Inode 12, i_blocks is 34, should be 24.  Fix? yes
+
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+Block bitmap differences:  -(31--34) -37
+Fix? yes
+
+Free blocks count wrong for group #0 (62, counted=67).
+Fix? yes
+
+Free blocks count wrong (62, counted=67).
+Fix? yes
+
+
+test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
+test_filesys: 12/16 files (8.3% non-contiguous), 33/100 blocks
+Exit status is 1
diff --git a/tests/i_error_tolerance/expect.2 b/tests/i_error_tolerance/expect.2
new file mode 100644
index 0000000..7fd4231
--- /dev/null
+++ b/tests/i_error_tolerance/expect.2
@@ -0,0 +1,7 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 12/16 files (8.3% non-contiguous), 33/100 blocks
+Exit status is 0
diff --git a/tests/i_error_tolerance/script b/tests/i_error_tolerance/script
new file mode 100644
index 0000000..aeb4581
--- /dev/null
+++ b/tests/i_error_tolerance/script
@@ -0,0 +1,38 @@
+if test -x $E2IMAGE_EXE; then
+if test -x $DEBUGFS_EXE; then
+
+SKIP_GUNZIP="true"
+
+TEST_DATA="$test_name.tmp"
+dd if=/dev/urandom of=$TEST_DATA bs=1k count=16 > /dev/null 2>&1 
+
+dd if=/dev/zero of=$TMPFILE bs=1k count=100 > /dev/null 2>&1
+$MKE2FS -Ft ext4 -O ^extents $TMPFILE > /dev/null 2>&1
+$DEBUGFS -w $TMPFILE << EOF  > /dev/null 2>&1
+write $TEST_DATA testfile
+set_inode_field testfile block[IND] 1000000
+q
+EOF
+
+$E2IMAGE -r $TMPFILE $TMPFILE.back
+
+ls -l $TMPFILE.back
+
+$E2IMAGE -i -r $TMPFILE $TMPFILE.back
+
+ls -l $TMPFILE.back
+
+mv $TMPFILE.back $TMPFILE
+
+. $cmd_dir/run_e2fsck
+
+rm -f $TEST_DATA
+
+unset E2FSCK_TIME TEST_DATA
+
+else #if test -x $DEBUGFS_EXE; then
+	echo "$test_name: $test_description: skipped"
+fi
+else #if test -x $E2IMAGE_EXE; then
+	echo "$test_name: $test_description: skipped"
+fi
-- 
1.8.3.1

