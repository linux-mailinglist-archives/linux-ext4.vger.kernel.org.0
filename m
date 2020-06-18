Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D031FF6A1
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731451AbgFRP2W (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731187AbgFRP2V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:28:21 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83350C06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:21 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d8so2561578plo.12
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iM2smD7juCAtTlTGNgMCl4KrTWadI4aJ3J2HlxQBwZM=;
        b=SGtLAFscKkzDV91TaKDafE7/RT1b5gyA1N9fPVtfaCjXXgzsEWPwz8aIgMd/VtuIJo
         0n2QDGVcU1gO8/qo3Md3Umu8c9rCPgE48Rpa5J32uxq04oHa6GqEPXPaPS5S69vik64z
         VXDd+jLP1a159LdAX3ch+/fRlR+Qok0ENLBUO5e3SAkfV4uJu74ZS3BmB75oayRg0izp
         BTNCVDuQw7LgCztJo6WPXRQbb/b4bkRSG94SEn19jKIcaNoK3g31Y1xqa8+Mo8tq9L5m
         RRBUusIeYwByZ+CyUPRQT3Ewz9d2lrxs9agJBFWmqDaSCGFCtrCokzqOZhEMF8uTYJ9P
         rrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iM2smD7juCAtTlTGNgMCl4KrTWadI4aJ3J2HlxQBwZM=;
        b=VTjR9Hbur+UfOFWXEzmd5Pw+FxW2J4xRusnzkFjjTz8O+momyv2JzAPFztadgL7P62
         UNt75PJoMWZzPdxl8lj8j/iEipI7YNOLP4Y0IvAB3xmtwyuufADCCF+niGbe+dVJZgTe
         ZwHg7MnULPAicoSQi7vgdc+uzoGbRwCm1LlEEOJCdn6DXuiMm6VrdVnN23WQUTSEX0Sq
         5VHfLPwSr9O4xIyddLMQgM0vWq+4UXF75Cg+OnMxtqDgl2PP5+VKWeREYoEpEW4LkETZ
         Wt1DWFI+jItb2xP9muD5q8q7m+UzUvD6e3vCOgB5EfPWmIMlZigD5KQ7wQku8ve74/CD
         xTPA==
X-Gm-Message-State: AOAM530lEkCTAv6AIEKg40GAiJc0WckuoDPq3rQ3OPHzprvHQjXVDtqP
        kEOr6PYj8kW6w+2Fc1fmPtI3AzYUd6w=
X-Google-Smtp-Source: ABdhPJy4CJkdTHTO5A96+Qlj494fhec3tMohWSUA0IMi/u0IClkNHrK11298Yo4srzT5K6fJ9tEtCA==
X-Received: by 2002:a17:902:10e:: with SMTP id 14mr4216995plb.12.1592494100241;
        Thu, 18 Jun 2020 08:28:20 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.28.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:28:19 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 03/51] e2fsck: add -m option for multithread
Date:   Fri, 19 Jun 2020 00:27:06 +0900
Message-Id: <1592494074-28991-4-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

-m option is added but no actual functionality is added. This
patch only adds the logic that when -m is specified, one of
-p/-y/-n options should be specified. And when -m is specified,
-C shouldn't be specified and the completion progress report won't
be triggered by sending SIGUSR1/SIGUSR2 signals. This simplifies
the implementation of multi-thread fsck in the future.

Completion progress support with multi-thread fsck will be added
back after multi-thread fsck implementation is finished. Right
now, disable it to simplify the implementation of multi-thread fsck.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/e2fsck.h                         |  1 +
 e2fsck/unix.c                           | 30 ++++++++++++++++++++-----
 tests/f_multithread/expect.1            | 23 +++++++++++++++++++
 tests/f_multithread/expect.2            |  7 ++++++
 tests/f_multithread/image.gz            |  1 +
 tests/f_multithread/name                |  1 +
 tests/f_multithread/script              |  4 ++++
 tests/f_multithread_completion/expect.1 |  2 ++
 tests/f_multithread_completion/expect.2 | 23 +++++++++++++++++++
 tests/f_multithread_completion/image.gz |  1 +
 tests/f_multithread_completion/name     |  1 +
 tests/f_multithread_completion/script   |  4 ++++
 tests/f_multithread_no/expect.1         | 24 ++++++++++++++++++++
 tests/f_multithread_no/expect.2         | 23 +++++++++++++++++++
 tests/f_multithread_no/image.gz         |  1 +
 tests/f_multithread_no/name             |  1 +
 tests/f_multithread_no/script           |  4 ++++
 tests/f_multithread_preen/expect.1      | 11 +++++++++
 tests/f_multithread_preen/expect.2      | 23 +++++++++++++++++++
 tests/f_multithread_preen/image.gz      |  1 +
 tests/f_multithread_preen/name          |  1 +
 tests/f_multithread_preen/script        |  4 ++++
 tests/f_multithread_yes/expect.1        |  2 ++
 tests/f_multithread_yes/expect.2        | 23 +++++++++++++++++++
 tests/f_multithread_yes/image.gz        |  1 +
 tests/f_multithread_yes/name            |  1 +
 tests/f_multithread_yes/script          |  4 ++++
 27 files changed, 216 insertions(+), 6 deletions(-)
 create mode 100644 tests/f_multithread/expect.1
 create mode 100644 tests/f_multithread/expect.2
 create mode 120000 tests/f_multithread/image.gz
 create mode 100644 tests/f_multithread/name
 create mode 100644 tests/f_multithread/script
 create mode 100644 tests/f_multithread_completion/expect.1
 create mode 100644 tests/f_multithread_completion/expect.2
 create mode 120000 tests/f_multithread_completion/image.gz
 create mode 100644 tests/f_multithread_completion/name
 create mode 100644 tests/f_multithread_completion/script
 create mode 100644 tests/f_multithread_no/expect.1
 create mode 100644 tests/f_multithread_no/expect.2
 create mode 120000 tests/f_multithread_no/image.gz
 create mode 100644 tests/f_multithread_no/name
 create mode 100644 tests/f_multithread_no/script
 create mode 100644 tests/f_multithread_preen/expect.1
 create mode 100644 tests/f_multithread_preen/expect.2
 create mode 120000 tests/f_multithread_preen/image.gz
 create mode 100644 tests/f_multithread_preen/name
 create mode 100644 tests/f_multithread_preen/script
 create mode 100644 tests/f_multithread_yes/expect.1
 create mode 100644 tests/f_multithread_yes/expect.2
 create mode 120000 tests/f_multithread_yes/image.gz
 create mode 100644 tests/f_multithread_yes/name
 create mode 100644 tests/f_multithread_yes/script

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index b9e2f06e..8b7e1276 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -177,6 +177,7 @@ struct resource_track {
 #define E2F_OPT_ICOUNT_FULLMAP	0x20000 /* use an array for inode counts */
 #define E2F_OPT_UNSHARE_BLOCKS  0x40000
 #define E2F_OPT_CLEAR_UNINIT	0x80000 /* Hack to clear the uninit bit */
+#define E2F_OPT_MULTITHREAD	0x100000 /* Use multiple threads to speedup */
 
 /*
  * E2fsck flags
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index 1cb51672..0a027be6 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -75,13 +75,14 @@ int journal_enable_debug = -1;
 static void usage(e2fsck_t ctx)
 {
 	fprintf(stderr,
-		_("Usage: %s [-panyrcdfktvDFV] [-b superblock] [-B blocksize]\n"
+		_("Usage: %s [-pamnyrcdfktvDFV] [-b superblock] [-B blocksize]\n"
 		"\t\t[-l|-L bad_blocks_file] [-C fd] [-j external_journal]\n"
 		"\t\t[-E extended-options] [-z undo_file] device\n"),
 		ctx->program_name);
 
 	fprintf(stderr, "%s", _("\nEmergency help:\n"
 		" -p                   Automatic repair (no questions)\n"
+		" -m                   multiple threads to speedup fsck\n"
 		" -n                   Make no changes to the filesystem\n"
 		" -y                   Assume \"yes\" to all questions\n"
 		" -c                   Check for bad blocks and add them to the badblock list\n"
@@ -847,7 +848,7 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 
 	phys_mem_kb = get_memory_size() / 1024;
 	ctx->readahead_kb = ~0ULL;
-	while ((c = getopt(argc, argv, "panyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) != EOF)
+	while ((c = getopt(argc, argv, "pamnyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) != EOF)
 		switch (c) {
 		case 'C':
 			ctx->progress = e2fsck_update_progress;
@@ -888,6 +889,9 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 			}
 			ctx->options |= E2F_OPT_PREEN;
 			break;
+		case 'm':
+			ctx->options |= E2F_OPT_MULTITHREAD;
+			break;
 		case 'n':
 			if (ctx->options & (E2F_OPT_YES|E2F_OPT_PREEN))
 				goto conflict_opt;
@@ -1006,6 +1010,18 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 			_("The -n and -l/-L options are incompatible."));
 		fatal_error(ctx, 0);
 	}
+	if (ctx->options & E2F_OPT_MULTITHREAD) {
+		if ((ctx->options & (E2F_OPT_YES|E2F_OPT_NO|E2F_OPT_PREEN)) == 0) {
+			com_err(ctx->program_name, 0, "%s",
+				_("The -m option should be used together with one of -p/-y/-n options."));
+			fatal_error(ctx, 0);
+		}
+		if (ctx->progress) {
+			com_err(ctx->program_name, 0, "%s",
+				_("Only one of the options -C or -m may be specified."));
+			fatal_error(ctx, 0);
+		}
+	}
 	if (ctx->options & E2F_OPT_NO)
 		ctx->options |= E2F_OPT_READONLY;
 
@@ -1112,10 +1128,12 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 #ifdef SA_RESTART
 	sa.sa_flags = SA_RESTART;
 #endif
-	sa.sa_handler = signal_progress_on;
-	sigaction(SIGUSR1, &sa, 0);
-	sa.sa_handler = signal_progress_off;
-	sigaction(SIGUSR2, &sa, 0);
+	if ((ctx->options & E2F_OPT_MULTITHREAD) == 0) {
+		sa.sa_handler = signal_progress_on;
+		sigaction(SIGUSR1, &sa, 0);
+		sa.sa_handler = signal_progress_off;
+		sigaction(SIGUSR2, &sa, 0);
+	}
 #endif
 
 	/* Update our PATH to include /sbin if we need to run badblocks  */
diff --git a/tests/f_multithread/expect.1 b/tests/f_multithread/expect.1
new file mode 100644
index 00000000..e2b954d0
--- /dev/null
+++ b/tests/f_multithread/expect.1
@@ -0,0 +1,23 @@
+ext2fs_open2: Bad magic number in super-block
+../e2fsck/e2fsck: Superblock invalid, trying backup blocks...
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+Free blocks count wrong for group #0 (7987, counted=7982).
+Fix? yes
+
+Free blocks count wrong (11602, counted=11597).
+Fix? yes
+
+Free inodes count wrong for group #0 (1493, counted=1488).
+Fix? yes
+
+Free inodes count wrong (2997, counted=2992).
+Fix? yes
+
+
+test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
+test_filesys: 16/3008 files (0.0% non-contiguous), 403/12000 blocks
+Exit status is 1
diff --git a/tests/f_multithread/expect.2 b/tests/f_multithread/expect.2
new file mode 100644
index 00000000..a833aefc
--- /dev/null
+++ b/tests/f_multithread/expect.2
@@ -0,0 +1,7 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 16/3008 files (0.0% non-contiguous), 403/12000 blocks
+Exit status is 0
diff --git a/tests/f_multithread/image.gz b/tests/f_multithread/image.gz
new file mode 120000
index 00000000..0fd40018
--- /dev/null
+++ b/tests/f_multithread/image.gz
@@ -0,0 +1 @@
+../f_zero_super/image.gz
\ No newline at end of file
diff --git a/tests/f_multithread/name b/tests/f_multithread/name
new file mode 100644
index 00000000..df838ea6
--- /dev/null
+++ b/tests/f_multithread/name
@@ -0,0 +1 @@
+test "e2fsck -m" option
\ No newline at end of file
diff --git a/tests/f_multithread/script b/tests/f_multithread/script
new file mode 100644
index 00000000..0fe96cd0
--- /dev/null
+++ b/tests/f_multithread/script
@@ -0,0 +1,4 @@
+FSCK_OPT="-fy -m"
+SECOND_FSCK_OPT=-yf
+
+. $cmd_dir/run_e2fsck
diff --git a/tests/f_multithread_completion/expect.1 b/tests/f_multithread_completion/expect.1
new file mode 100644
index 00000000..61cac9bb
--- /dev/null
+++ b/tests/f_multithread_completion/expect.1
@@ -0,0 +1,2 @@
+../e2fsck/e2fsck: Only one of the options -C or -m may be specified.
+Exit status is 8
diff --git a/tests/f_multithread_completion/expect.2 b/tests/f_multithread_completion/expect.2
new file mode 100644
index 00000000..e2b954d0
--- /dev/null
+++ b/tests/f_multithread_completion/expect.2
@@ -0,0 +1,23 @@
+ext2fs_open2: Bad magic number in super-block
+../e2fsck/e2fsck: Superblock invalid, trying backup blocks...
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+Free blocks count wrong for group #0 (7987, counted=7982).
+Fix? yes
+
+Free blocks count wrong (11602, counted=11597).
+Fix? yes
+
+Free inodes count wrong for group #0 (1493, counted=1488).
+Fix? yes
+
+Free inodes count wrong (2997, counted=2992).
+Fix? yes
+
+
+test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
+test_filesys: 16/3008 files (0.0% non-contiguous), 403/12000 blocks
+Exit status is 1
diff --git a/tests/f_multithread_completion/image.gz b/tests/f_multithread_completion/image.gz
new file mode 120000
index 00000000..0fd40018
--- /dev/null
+++ b/tests/f_multithread_completion/image.gz
@@ -0,0 +1 @@
+../f_zero_super/image.gz
\ No newline at end of file
diff --git a/tests/f_multithread_completion/name b/tests/f_multithread_completion/name
new file mode 100644
index 00000000..a959045d
--- /dev/null
+++ b/tests/f_multithread_completion/name
@@ -0,0 +1 @@
+test "e2fsck -m" option conflicts with "-C"
\ No newline at end of file
diff --git a/tests/f_multithread_completion/script b/tests/f_multithread_completion/script
new file mode 100644
index 00000000..bf23cd61
--- /dev/null
+++ b/tests/f_multithread_completion/script
@@ -0,0 +1,4 @@
+FSCK_OPT="-fy -m -C 1"
+SECOND_FSCK_OPT=-yf
+
+. $cmd_dir/run_e2fsck
diff --git a/tests/f_multithread_no/expect.1 b/tests/f_multithread_no/expect.1
new file mode 100644
index 00000000..d14c4083
--- /dev/null
+++ b/tests/f_multithread_no/expect.1
@@ -0,0 +1,24 @@
+ext2fs_open2: Bad magic number in super-block
+../e2fsck/e2fsck: Superblock invalid, trying backup blocks...
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+Free blocks count wrong for group #0 (7987, counted=7982).
+Fix? no
+
+Free blocks count wrong (11602, counted=11597).
+Fix? no
+
+Free inodes count wrong for group #0 (1493, counted=1488).
+Fix? no
+
+Free inodes count wrong (2997, counted=2992).
+Fix? no
+
+
+test_filesys: ********** WARNING: Filesystem still has errors **********
+
+test_filesys: 11/3008 files (0.0% non-contiguous), 398/12000 blocks
+Exit status is 4
diff --git a/tests/f_multithread_no/expect.2 b/tests/f_multithread_no/expect.2
new file mode 100644
index 00000000..e2b954d0
--- /dev/null
+++ b/tests/f_multithread_no/expect.2
@@ -0,0 +1,23 @@
+ext2fs_open2: Bad magic number in super-block
+../e2fsck/e2fsck: Superblock invalid, trying backup blocks...
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+Free blocks count wrong for group #0 (7987, counted=7982).
+Fix? yes
+
+Free blocks count wrong (11602, counted=11597).
+Fix? yes
+
+Free inodes count wrong for group #0 (1493, counted=1488).
+Fix? yes
+
+Free inodes count wrong (2997, counted=2992).
+Fix? yes
+
+
+test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
+test_filesys: 16/3008 files (0.0% non-contiguous), 403/12000 blocks
+Exit status is 1
diff --git a/tests/f_multithread_no/image.gz b/tests/f_multithread_no/image.gz
new file mode 120000
index 00000000..0fd40018
--- /dev/null
+++ b/tests/f_multithread_no/image.gz
@@ -0,0 +1 @@
+../f_zero_super/image.gz
\ No newline at end of file
diff --git a/tests/f_multithread_no/name b/tests/f_multithread_no/name
new file mode 100644
index 00000000..fa49692e
--- /dev/null
+++ b/tests/f_multithread_no/name
@@ -0,0 +1 @@
+test "e2fsck -m" option works with "-n"
\ No newline at end of file
diff --git a/tests/f_multithread_no/script b/tests/f_multithread_no/script
new file mode 100644
index 00000000..b93deb3a
--- /dev/null
+++ b/tests/f_multithread_no/script
@@ -0,0 +1,4 @@
+FSCK_OPT="-fn -m"
+SECOND_FSCK_OPT=-yf
+
+. $cmd_dir/run_e2fsck
diff --git a/tests/f_multithread_preen/expect.1 b/tests/f_multithread_preen/expect.1
new file mode 100644
index 00000000..b4b0cd9a
--- /dev/null
+++ b/tests/f_multithread_preen/expect.1
@@ -0,0 +1,11 @@
+../e2fsck/e2fsck: Bad magic number in super-block while trying to open test.img
+test_filesys: 
+The superblock could not be read or does not describe a valid ext2/ext3/ext4
+filesystem.  If the device is valid and it really contains an ext2/ext3/ext4
+filesystem (and not swap or ufs or something else), then the superblock
+is corrupt, and you might try running e2fsck with an alternate superblock:
+    e2fsck -b 8193 <device>
+ or
+    e2fsck -b 32768 <device>
+
+Exit status is 8
diff --git a/tests/f_multithread_preen/expect.2 b/tests/f_multithread_preen/expect.2
new file mode 100644
index 00000000..e2b954d0
--- /dev/null
+++ b/tests/f_multithread_preen/expect.2
@@ -0,0 +1,23 @@
+ext2fs_open2: Bad magic number in super-block
+../e2fsck/e2fsck: Superblock invalid, trying backup blocks...
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+Free blocks count wrong for group #0 (7987, counted=7982).
+Fix? yes
+
+Free blocks count wrong (11602, counted=11597).
+Fix? yes
+
+Free inodes count wrong for group #0 (1493, counted=1488).
+Fix? yes
+
+Free inodes count wrong (2997, counted=2992).
+Fix? yes
+
+
+test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
+test_filesys: 16/3008 files (0.0% non-contiguous), 403/12000 blocks
+Exit status is 1
diff --git a/tests/f_multithread_preen/image.gz b/tests/f_multithread_preen/image.gz
new file mode 120000
index 00000000..0fd40018
--- /dev/null
+++ b/tests/f_multithread_preen/image.gz
@@ -0,0 +1 @@
+../f_zero_super/image.gz
\ No newline at end of file
diff --git a/tests/f_multithread_preen/name b/tests/f_multithread_preen/name
new file mode 100644
index 00000000..90d199df
--- /dev/null
+++ b/tests/f_multithread_preen/name
@@ -0,0 +1 @@
+test "e2fsck -m" option works with "-p"
\ No newline at end of file
diff --git a/tests/f_multithread_preen/script b/tests/f_multithread_preen/script
new file mode 100644
index 00000000..ecb79cd6
--- /dev/null
+++ b/tests/f_multithread_preen/script
@@ -0,0 +1,4 @@
+FSCK_OPT="-fp -m"
+SECOND_FSCK_OPT=-yf
+
+. $cmd_dir/run_e2fsck
diff --git a/tests/f_multithread_yes/expect.1 b/tests/f_multithread_yes/expect.1
new file mode 100644
index 00000000..8b780ecf
--- /dev/null
+++ b/tests/f_multithread_yes/expect.1
@@ -0,0 +1,2 @@
+../e2fsck/e2fsck: The -m option should be used together with one of -p/-y/-n options.
+Exit status is 8
diff --git a/tests/f_multithread_yes/expect.2 b/tests/f_multithread_yes/expect.2
new file mode 100644
index 00000000..e2b954d0
--- /dev/null
+++ b/tests/f_multithread_yes/expect.2
@@ -0,0 +1,23 @@
+ext2fs_open2: Bad magic number in super-block
+../e2fsck/e2fsck: Superblock invalid, trying backup blocks...
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+Free blocks count wrong for group #0 (7987, counted=7982).
+Fix? yes
+
+Free blocks count wrong (11602, counted=11597).
+Fix? yes
+
+Free inodes count wrong for group #0 (1493, counted=1488).
+Fix? yes
+
+Free inodes count wrong (2997, counted=2992).
+Fix? yes
+
+
+test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
+test_filesys: 16/3008 files (0.0% non-contiguous), 403/12000 blocks
+Exit status is 1
diff --git a/tests/f_multithread_yes/image.gz b/tests/f_multithread_yes/image.gz
new file mode 120000
index 00000000..0fd40018
--- /dev/null
+++ b/tests/f_multithread_yes/image.gz
@@ -0,0 +1 @@
+../f_zero_super/image.gz
\ No newline at end of file
diff --git a/tests/f_multithread_yes/name b/tests/f_multithread_yes/name
new file mode 100644
index 00000000..3a703195
--- /dev/null
+++ b/tests/f_multithread_yes/name
@@ -0,0 +1 @@
+test "e2fsck -m" option works with "-y"
\ No newline at end of file
diff --git a/tests/f_multithread_yes/script b/tests/f_multithread_yes/script
new file mode 100644
index 00000000..38891f6a
--- /dev/null
+++ b/tests/f_multithread_yes/script
@@ -0,0 +1,4 @@
+FSCK_OPT="-f -m"
+SECOND_FSCK_OPT=-yf
+
+. $cmd_dir/run_e2fsck
-- 
2.25.4

