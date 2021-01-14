Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244322F5599
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jan 2021 01:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbhANAaW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Jan 2021 19:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729876AbhANA2u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Jan 2021 19:28:50 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA059C0617A9
        for <linux-ext4@vger.kernel.org>; Wed, 13 Jan 2021 16:28:07 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id y187so2998128qke.20
        for <linux-ext4@vger.kernel.org>; Wed, 13 Jan 2021 16:28:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=igzmCwjg5atHiUFdbQ2u8LPL/muJ3sFGxPj3xEyM1Uw=;
        b=Rbe/HUm+JYB/aMTlScFTUuziOCRqxHmuYyanxXC/I/68FXOHLEGW2k/gSGclv8d3OK
         A/xbC//i7eIdrlqDpKqSeZk2Otr3nBpx7iQPEHGrL3rb3ahDrM82ZHLRkrI4ouqnrKBM
         YCI5U4sr0SabSm5b+3onIZRCTy9fnsDk/Ddc0GjwOEj+4LBSYCDceTfYie7U6KSP/Wcu
         XaNMahqVkPKUUHnTk4iAIn3CDNlZ160omwn2Sr7bHQc3DPeRrGrnZTCXb7vSXRUwXgtP
         jz7Jo9OXMqo7h0NpLO4/LRFfnBtE3zd49BE1NHYrNzjGcCy5UwfydMbiC5APx5oaSJ8E
         OjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=igzmCwjg5atHiUFdbQ2u8LPL/muJ3sFGxPj3xEyM1Uw=;
        b=QB8v6utfJNCPuNlzhbfw+DzNaMSaq+Ws/tvtJ1mxDuzOYRUDBTzDyb6STgogzPsoYM
         gqurcbOsu+2EmEmnk0y0YO7+d8NB++TbhdqY9yzpLgDpOEHYogfUIaNW7wSKGdnANxhw
         S4wCnBvnpNwt4UrdgvxlpMxY/eabKiJjhoTh/aMhqw4E+NvT7ry0y4x74hp0I4Jd6hFY
         ltM8PaO5UBzl9IQyEQdDeHRk7NYFYSWDmcW/gGO1qI0Em5njHef8EBVWOccdtQPelH2D
         cy3CEvJ0y3F5ZLQsnmTmuMre/N4FfAYcNARJ+qtJUqjVOflUGYZFUfIKB02E255Fcxra
         r2yg==
X-Gm-Message-State: AOAM532CvPaOdZe/0P7EYPi00eu00MG4icapg2rU7sPwKZAieiStFP2C
        6Q1XSg94ELVfAawh1+pYzUIe2t3DAoLIQ7TvhebDnLgXFgRIJnImOmNmWDBkBBzUopr40l/Jhp7
        /mPJkIgvgPN2xgojhmpetT+QpPq2v+4mhwqRn68PqaRUdgcfoxwEBUPti3fLKme5k2CrVMeKJVv
        KSwfLcBpw=
X-Google-Smtp-Source: ABdhPJzeIkC4rCPdr1bQP/+iQ/p2Nol9pHaCMHLleTx39t+psIq972/3HQglc27DFq3/pTjj2uPvy0rWOGPfW7eq3EA=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef5:75ee])
 (user=saranyamohan job=sendgmr) by 2002:a05:6214:1227:: with SMTP id
 p7mr4779726qvv.31.1610584086644; Wed, 13 Jan 2021 16:28:06 -0800 (PST)
Date:   Wed, 13 Jan 2021 16:27:23 -0800
In-Reply-To: <20210114002723.643589-1-saranyamohan@google.com>
Message-Id: <20210114002723.643589-6-saranyamohan@google.com>
Mime-Version: 1.0
References: <20210114002723.643589-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [RFC PATCH v1 5/5] Enable threaded support for e2fsprogs' applications.
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 debugfs/debugfs.c | 6 ++++--
 e2fsck/unix.c     | 2 +-
 misc/dumpe2fs.c   | 2 +-
 misc/e2freefrag.c | 2 +-
 misc/e2fuzz.c     | 4 ++--
 misc/e2image.c    | 3 ++-
 misc/fuse2fs.c    | 3 ++-
 misc/tune2fs.c    | 3 ++-
 resize/main.c     | 2 +-
 9 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/debugfs/debugfs.c b/debugfs/debugfs.c
index 78e55779..132c5f9d 100644
--- a/debugfs/debugfs.c
+++ b/debugfs/debugfs.c
@@ -231,7 +231,8 @@ void do_open_filesys(int argc, char **argv, int sci_idx EXT2FS_ATTR((unused)),
 	int	catastrophic = 0;
 	blk64_t	superblock = 0;
 	blk64_t	blocksize = 0;
-	int	open_flags = EXT2_FLAG_SOFTSUPP_FEATURES | EXT2_FLAG_64BITS; 
+	int	open_flags = EXT2_FLAG_SOFTSUPP_FEATURES | EXT2_FLAG_64BITS |
+		EXT2_FLAG_THREADS;
 	char	*data_filename = 0;
 	char	*undo_file = NULL;
 
@@ -2532,7 +2533,8 @@ int main(int argc, char **argv)
 #endif
 		"[-c]] [device]";
 	int		c;
-	int		open_flags = EXT2_FLAG_SOFTSUPP_FEATURES | EXT2_FLAG_64BITS;
+	int		open_flags = EXT2_FLAG_SOFTSUPP_FEATURES |
+				EXT2_FLAG_64BITS | EXT2_FLAG_THREADS;
 	char		*request = 0;
 	int		exit_status = 0;
 	char		*cmd_file = 0;
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index 1cb51672..dbeaeef5 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -1474,7 +1474,7 @@ int main (int argc, char *argv[])
 	}
 	ctx->superblock = ctx->use_superblock;
 
-	flags = EXT2_FLAG_SKIP_MMP;
+	flags = EXT2_FLAG_SKIP_MMP | EXT2_FLAG_THREADS;
 restart:
 #ifdef CONFIG_TESTIO_DEBUG
 	if (getenv("TEST_IO_FLAGS") || getenv("TEST_IO_BLOCK")) {
diff --git a/misc/dumpe2fs.c b/misc/dumpe2fs.c
index d295ba4d..82fb4e63 100644
--- a/misc/dumpe2fs.c
+++ b/misc/dumpe2fs.c
@@ -665,7 +665,7 @@ int main (int argc, char ** argv)
 
 	device_name = argv[optind++];
 	flags = EXT2_FLAG_JOURNAL_DEV_OK | EXT2_FLAG_SOFTSUPP_FEATURES |
-		EXT2_FLAG_64BITS;
+		EXT2_FLAG_64BITS | EXT2_FLAG_THREADS;
 	if (force)
 		flags |= EXT2_FLAG_FORCE;
 	if (image_dump)
diff --git a/misc/e2freefrag.c b/misc/e2freefrag.c
index 9c23fadc..a9d16fc4 100644
--- a/misc/e2freefrag.c
+++ b/misc/e2freefrag.c
@@ -363,7 +363,7 @@ static void collect_info(ext2_filsys fs, struct chunk_info *chunk_info, FILE *f)
 static void open_device(char *device_name, ext2_filsys *fs)
 {
 	int retval;
-	int flag = EXT2_FLAG_FORCE | EXT2_FLAG_64BITS;
+	int flag = EXT2_FLAG_FORCE | EXT2_FLAG_64BITS | EXT2_FLAG_THREADS;
 
 	retval = ext2fs_open(device_name, flag, 0, 0, unix_io_manager, fs);
 	if (retval) {
diff --git a/misc/e2fuzz.c b/misc/e2fuzz.c
index 685cdbe2..1ace1df5 100644
--- a/misc/e2fuzz.c
+++ b/misc/e2fuzz.c
@@ -201,8 +201,8 @@ static int process_fs(const char *fsname)
 	}
 
 	/* Ensure the fs is clean and does not have errors */
-	ret = ext2fs_open(fsname, EXT2_FLAG_64BITS, 0, 0, unix_io_manager,
-			  &fs);
+	ret = ext2fs_open(fsname, EXT2_FLAG_64BITS | EXT2_FLAG_THREADS,
+			  0, 0, unix_io_manager, &fs);
 	if (ret) {
 		fprintf(stderr, "%s: failed to open filesystem.\n",
 			fsname);
diff --git a/misc/e2image.c b/misc/e2image.c
index 892c5371..e5e47565 100644
--- a/misc/e2image.c
+++ b/misc/e2image.c
@@ -1482,7 +1482,8 @@ int main (int argc, char ** argv)
 	ext2_filsys fs;
 	char *image_fn, offset_opt[64];
 	struct ext2_qcow2_hdr *header = NULL;
-	int open_flag = EXT2_FLAG_64BITS | EXT2_FLAG_IGNORE_CSUM_ERRORS;
+	int open_flag = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS |
+		EXT2_FLAG_IGNORE_CSUM_ERRORS;
 	int img_type = 0;
 	int flags = 0;
 	int mount_flags = 0;
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 4005894d..c5957212 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3727,7 +3727,8 @@ int main(int argc, char *argv[])
 	errcode_t err;
 	char *logfile;
 	char extra_args[BUFSIZ];
-	int ret = 0, flags = EXT2_FLAG_64BITS | EXT2_FLAG_EXCLUSIVE;
+	int ret = 0;
+	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | EXT2_FLAG_EXCLUSIVE;
 
 	memset(&fctx, 0, sizeof(fctx));
 	fctx.magic = FUSE2FS_MAGIC;
diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index f942c698..e5186fe0 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -2950,7 +2950,8 @@ retry_open:
 	if ((open_flag & EXT2_FLAG_RW) == 0 || f_flag)
 		open_flag |= EXT2_FLAG_SKIP_MMP;
 
-	open_flag |= EXT2_FLAG_64BITS | EXT2_FLAG_JOURNAL_DEV_OK;
+	open_flag |= EXT2_FLAG_64BITS | EXT2_FLAG_THREADS |
+		EXT2_FLAG_JOURNAL_DEV_OK;
 
 	/* keep the filesystem struct around to dump MMP data */
 	open_flag |= EXT2_FLAG_NOFREE_ON_ERROR;
diff --git a/resize/main.c b/resize/main.c
index cb0bf6a0..72a703f6 100644
--- a/resize/main.c
+++ b/resize/main.c
@@ -402,7 +402,7 @@ int main (int argc, char ** argv)
 	if (!(mount_flags & EXT2_MF_MOUNTED))
 		io_flags = EXT2_FLAG_RW | EXT2_FLAG_EXCLUSIVE;
 
-	io_flags |= EXT2_FLAG_64BITS;
+	io_flags |= EXT2_FLAG_64BITS | EXT2_FLAG_THREADS;
 	if (undo_file) {
 		retval = resize2fs_setup_tdb(device_name, undo_file, &io_ptr);
 		if (retval)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

