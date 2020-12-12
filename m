Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFAC2D85AE
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Dec 2020 11:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438583AbgLLKGo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 12 Dec 2020 05:06:44 -0500
Received: from smtp-out-no.shaw.ca ([64.59.134.9]:56179 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437368AbgLLKGn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 12 Dec 2020 05:06:43 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Dec 2020 05:06:42 EST
Received: from cabot.adilger.int ([70.77.221.9])
        by shaw.ca with ESMTP
        id o1fTkfLK5tdldo1fUkAY05; Sat, 12 Dec 2020 02:58:25 -0700
X-Authority-Analysis: v=2.4 cv=INe8tijG c=1 sm=1 tr=0 ts=5fd49441
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=ySfo2T4IAAAA:8
 a=XHBN5R38jSZPtdUxAFIA:9 a=tMomuHDIUWStJmtT:21 a=FT4KXUcYLKzXBloV:21
 a=ZUkhVnNHqyo2at-WnAgH:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@whamcloud.com>
Subject: [PATCH] misc: replace remaining loff_t with ext2_loff_t
Date:   Sat, 12 Dec 2020 02:58:23 -0700
Message-Id: <20201212095823.35563-1-adilger@dilger.ca>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
X-CMAE-Envelope: MS4xfBNPqHuEeU4vxHayxdW7CUK7uVIGqOP3a5LFPP2CboUKmN/s6DAzJ545tMWVlFc83ZNgJfLVJLGLbm4bPvruiMQh/Xlh2KXi+r/UUBOtCo9TpAPvBwYd
 78/kWNiYkPKUY23ET1Iv+8NUOkGFy66ldYi625bDtUNOKHLxjSlwbSFCarnDRo4Hn+srFQ7WhoCArT1Kw1F/6sFPaFt/tnHtVmUOuqP0gRNNo8dbTIEDG39Q
 QNqX4561hRn9u0ny/0mDlg==
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Andreas Dilger <adilger@whamcloud.com>

Replace the remaining loff_t uses with ext2_loff_t, as
was done in patch 1df6a4555, since loff_t is a GCC'ism
and is not portable.

Signed-off-by: Andreas Dilger <adilger@whamcloud.com>
---
 contrib/fallocate.c |  4 ++--
 misc/e4defrag.c     | 21 +++++++++++----------
 misc/findsuper.c    |  4 ++--
 3 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/contrib/fallocate.c b/contrib/fallocate.c
index d4273d881d1a..16c08ab37e83 100644
--- a/contrib/fallocate.c
+++ b/contrib/fallocate.c
@@ -95,8 +95,8 @@ int main(int argc, char **argv)
 	int	fd;
 	char	*fname;
 	int	opt;
-	loff_t	length = -2LL;
-	loff_t	offset = 0;
+	ext2_loff_t length = -2LL;
+	ext2_loff_t offset = 0;
 	int	falloc_mode = 0;
 	int	error;
 	int	tflag = 0;
diff --git a/misc/e4defrag.c b/misc/e4defrag.c
index c6c6f134cd4f..47be2e03b8d2 100644
--- a/misc/e4defrag.c
+++ b/misc/e4defrag.c
@@ -362,7 +362,7 @@ static int page_in_core(int fd, struct move_extent defrag_data,
 {
 	long	pagesize;
 	void	*page = NULL;
-	loff_t	offset, end_offset, length;
+	ext2_loff_t offset, end_offset, length;
 
 	if (vec == NULL || *vec != NULL)
 		return -1;
@@ -371,8 +371,8 @@ static int page_in_core(int fd, struct move_extent defrag_data,
 	if (pagesize < 0)
 		return -1;
 	/* In mmap, offset should be a multiple of the page size */
-	offset = (loff_t)defrag_data.orig_start * block_size;
-	length = (loff_t)defrag_data.len * block_size;
+	offset = (ext2_loff_t)defrag_data.orig_start * block_size;
+	length = (ext2_loff_t)defrag_data.len * block_size;
 	end_offset = offset + length;
 	/* Round the offset down to the nearest multiple of pagesize */
 	offset = (offset / pagesize) * pagesize;
@@ -418,18 +418,18 @@ static int defrag_fadvise(int fd, struct move_extent defrag_data,
 			    SYNC_FILE_RANGE_WRITE |
 			    SYNC_FILE_RANGE_WAIT_AFTER;
 	unsigned int	i;
-	loff_t	offset;
+	ext2_loff_t	offset;
 
 	if (pagesize < 1)
 		return -1;
 
-	offset = (loff_t)defrag_data.orig_start * block_size;
+	offset = (ext2_loff_t)defrag_data.orig_start * block_size;
 	offset = (offset / pagesize) * pagesize;
 
 #ifdef HAVE_SYNC_FILE_RANGE
 	/* Sync file for fadvise process */
 	if (sync_file_range(fd, offset,
-		(loff_t)pagesize * page_num, sync_flag) < 0)
+		(ext2_loff_t)pagesize * page_num, sync_flag) < 0)
 		return -1;
 #endif
 
@@ -1286,7 +1286,8 @@ out:
  * @start:		logical offset for defrag target file
  * @file_size:		defrag target filesize
  */
-static void print_progress(const char *file, loff_t start, loff_t file_size)
+static void print_progress(const char *file, ext2_loff_t start,
+			   ext2_loff_t file_size)
 {
 	int percent = (start * 100) / file_size;
 	printf("\033[79;0H\033[K[%u/%u]%s:\t%3d%%",
@@ -1308,7 +1309,7 @@ static void print_progress(const char *file, loff_t start, loff_t file_size)
 static int call_defrag(int fd, int donor_fd, const char *file,
 	const struct stat64 *buf, struct fiemap_extent_list *ext_list_head)
 {
-	loff_t	start = 0;
+	ext2_loff_t	start = 0;
 	unsigned int	page_num;
 	unsigned char	*vec = NULL;
 	int	defraged_ret = 0;
@@ -1561,8 +1562,8 @@ static int file_defrag(const char *file, const struct stat64 *buf,
 	orig_group_tmp = orig_group_head;
 	do {
 		ret = fallocate64(donor_fd, 0,
-		  (loff_t)orig_group_tmp->start->data.logical * block_size,
-		  (loff_t)orig_group_tmp->len * block_size);
+		  (ext2_loff_t)orig_group_tmp->start->data.logical * block_size,
+		  (ext2_loff_t)orig_group_tmp->len * block_size);
 		if (ret < 0) {
 			if (mode_flag & DETAIL) {
 				PRINT_FILE_NAME(file);
diff --git a/misc/findsuper.c b/misc/findsuper.c
index 765295c3b4b6..7e78c1fc819a 100644
--- a/misc/findsuper.c
+++ b/misc/findsuper.c
@@ -115,11 +115,11 @@ static void usage(void)
 int main(int argc, char *argv[])
 {
 	int skiprate=512;		/* one sector */
-	loff_t sk=0, skl=0;
+	ext2_loff_t sk=0, skl=0;
 	int fd;
 	char *s;
 	time_t tm, last = time(0);
-	loff_t interval = 1024 * 1024;
+	ext2_loff_t interval = 1024 * 1024;
 	int c, print_jnl_copies = 0;
 	const char * device_name;
 	struct ext2_super_block ext2;
-- 
2.14.3 (Apple Git-98)

