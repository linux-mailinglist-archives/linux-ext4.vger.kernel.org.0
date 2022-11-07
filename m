Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3715461F2FB
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiKGMYj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbiKGMYe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:24:34 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8082E1B9D0
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:24:31 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id io19so10896478plb.8
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfUADwEhy+K71Db3G/GggakC2dWpzFOKZulNS3cjYSw=;
        b=S1RA6xkUdWL02xB65iASd324smkrjde7/wOIjf1MCIExys3qB1lFHJ5NjNcMWZoG66
         +coNBA0zzksK34jlRYKLBlwLejYhKer6bgHNhsYFkYegbQZ71Hq3oprLlTZh0pkG0Aki
         Q1hFOr5SI1EYDhAPJsH2x1pvHHO0DZHpfQ+AWnAalkLylfQ3+mSKHqD6ZwM1vycpGFHE
         smkuLCXmbHivKUNkYiUlw/LDtOGXT6XhnZXMmN4p1etDtGn3q2xUwuAh60k7yeCyj4kg
         cKmI+f6K/2zS4hERr7er12CNIjDo3VQyFSFAO+T6WBbzNazibh/iHjOAe5fSQhE48G86
         s4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CfUADwEhy+K71Db3G/GggakC2dWpzFOKZulNS3cjYSw=;
        b=zXeJOdnh84ZNCLhqXHubtx/vKfVDz7cV17YMNRIIY4Ac2aE6l2JLClghpCVcU6e6q7
         zEeXz2oIs9IOG3Ot9qBgx2qxXqqH1wcA4QPDhssHBCTF6E8LgYff+DgpNPgZrwZX5Uwd
         htSTlZa0lBV2MjTPSTta+bRG3lYP0niKz52/XI1AIFxttm+WPSs1Y8PQrtkJwBBButJF
         itEUvRjuvwzwNomANrlrWTnBP1sZggJa8/GBoIT4uAATQjJqVK8lMUD2+7OuC+iesMHL
         +j2QCoNGq0Pju6nhOcp6omSgSDHpZIVfjIURY7uSHXKQH8CynQTGOjkvd8hnP2Kt0AQy
         F0IQ==
X-Gm-Message-State: ANoB5pmyBPjkSV2ccCWztVFxF9rDRuslcnuwvE9GyMiYldEzrODf4t6G
        2fmhtryrLqSrZbM2rR2bqxI=
X-Google-Smtp-Source: AA0mqf7A8b1uq1V6tYI+0mK7z3DskE74WRWoJrOPEy1HU4udxl1i70iMkWwQ66fliOOblgMqT6fEVw==
X-Received: by 2002:a17:902:9042:b0:188:6fc9:1da with SMTP id w2-20020a170902904200b001886fc901damr13826968plz.162.1667823870910;
        Mon, 07 Nov 2022 04:24:30 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id b6-20020a170903228600b00186b0ac12c5sm4870140plh.172.2022.11.07.04.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:24:30 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 21/72] e2fsck: add -m option for multithread
Date:   Mon,  7 Nov 2022 17:51:09 +0530
Message-Id: <935d3652155338e793325acd5f8b900728a56bd9.1667822611.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667822611.git.ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/e2fsck.h                         |  1 +
 e2fsck/unix.c                           | 31 ++++++++++++++++++++-----
 tests/f_multithread/expect.1            | 23 ++++++++++++++++++
 tests/f_multithread/expect.2            |  7 ++++++
 tests/f_multithread/image.gz            |  1 +
 tests/f_multithread/name                |  1 +
 tests/f_multithread/script              |  4 ++++
 tests/f_multithread_completion/expect.1 |  2 ++
 tests/f_multithread_completion/expect.2 | 23 ++++++++++++++++++
 tests/f_multithread_completion/image.gz |  1 +
 tests/f_multithread_completion/name     |  1 +
 tests/f_multithread_completion/script   |  4 ++++
 tests/f_multithread_no/expect.1         | 24 +++++++++++++++++++
 tests/f_multithread_no/expect.2         | 23 ++++++++++++++++++
 tests/f_multithread_no/image.gz         |  1 +
 tests/f_multithread_no/name             |  1 +
 tests/f_multithread_no/script           |  4 ++++
 tests/f_multithread_preen/expect.1      | 11 +++++++++
 tests/f_multithread_preen/expect.2      | 23 ++++++++++++++++++
 tests/f_multithread_preen/image.gz      |  1 +
 tests/f_multithread_preen/name          |  1 +
 tests/f_multithread_preen/script        |  4 ++++
 tests/f_multithread_yes/expect.1        |  2 ++
 tests/f_multithread_yes/expect.2        | 23 ++++++++++++++++++
 tests/f_multithread_yes/image.gz        |  1 +
 tests/f_multithread_yes/name            |  1 +
 tests/f_multithread_yes/script          |  4 ++++
 27 files changed, 217 insertions(+), 6 deletions(-)
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
index 252a17db..35428717 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -186,6 +186,7 @@ struct resource_track {
 #define E2F_OPT_UNSHARE_BLOCKS  0x40000
 #define E2F_OPT_CLEAR_UNINIT	0x80000 /* Hack to clear the uninit bit */
 #define E2F_OPT_CHECK_ENCODING  0x100000 /* Force verification of encoded filenames */
+#define E2F_OPT_MULTITHREAD	0x200000 /* Use multiple threads to speedup */
 
 /*
  * E2fsck flags
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index e5b672a2..1ee27f6a 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -76,13 +76,14 @@ int journal_enable_debug = -1;
 static void usage(e2fsck_t ctx)
 {
 	fprintf(stderr,
-		_("Usage: %s [-panyrcdfktvDFV] [-b superblock] [-B blocksize]\n"
+		_("Usage: %s [-pamnyrcdfktvDFV] [-b superblock] [-B blocksize]\n"
 		"\t\t[-l|-L bad_blocks_file] [-C fd] [-j external_journal]\n"
 		"\t\t[-E extended-options] [-z undo_file] device\n"),
 		ctx->program_name ? ctx->program_name : "e2fsck");
 
 	fprintf(stderr, "%s", _("\nEmergency help:\n"
 		" -p                   Automatic repair (no questions)\n"
+		" -m                   multiple threads to speedup fsck\n"
 		" -n                   Make no changes to the filesystem\n"
 		" -y                   Assume \"yes\" to all questions\n"
 		" -c                   Check for bad blocks and add them to the badblock list\n"
@@ -854,7 +855,8 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 
 	phys_mem_kb = get_memory_size() / 1024;
 	ctx->readahead_kb = ~0ULL;
-	while ((c = getopt(argc, argv, "panyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) != EOF)
+
+	while ((c = getopt(argc, argv, "pamnyrcC:B:dE:fvtFVM:b:I:j:P:l:L:N:SsDkz:")) != EOF)
 		switch (c) {
 		case 'C':
 			ctx->progress = e2fsck_update_progress;
@@ -895,6 +897,9 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
 			}
 			ctx->options |= E2F_OPT_PREEN;
 			break;
+		case 'm':
+			ctx->options |= E2F_OPT_MULTITHREAD;
+			break;
 		case 'n':
 			if (ctx->options & (E2F_OPT_YES|E2F_OPT_PREEN))
 				goto conflict_opt;
@@ -1014,6 +1019,18 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
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
 
@@ -1120,10 +1137,12 @@ static errcode_t PRS(int argc, char *argv[], e2fsck_t *ret_ctx)
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
2.37.3

