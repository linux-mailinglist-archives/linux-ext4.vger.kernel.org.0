Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFE12CF960
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Dec 2020 06:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgLEE74 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Dec 2020 23:59:56 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50368 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727046AbgLEE7z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Dec 2020 23:59:55 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B54x0dH002025
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Dec 2020 23:59:01 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9280F4202E5; Fri,  4 Dec 2020 23:58:58 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Saranya Muruganandam <saranyamohan@google.com>,
        Wang Shilong <wshilong@ddn.com>, adilger.kernel@dilger.ca,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH RFC 5/5] Enable threaded support for e2fsprogs' applications.
Date:   Fri,  4 Dec 2020 23:58:56 -0500
Message-Id: <20201205045856.895342-6-tytso@mit.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201205045856.895342-1-tytso@mit.edu>
References: <20201205045856.895342-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

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
index 78e557792..132c5f9d9 100644
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
index 1cb516721..dbeaeef5a 100644
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
index d295ba4d4..82fb4e630 100644
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
index 9c23fadce..a9d16fc41 100644
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
index 685cdbe29..1ace1df5a 100644
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
index 892c5371e..e5e475653 100644
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
index 4005894d3..c59572129 100644
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
index f942c698a..e5186fe0c 100644
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
index cb0bf6a0d..72a703f6a 100644
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
2.28.0

