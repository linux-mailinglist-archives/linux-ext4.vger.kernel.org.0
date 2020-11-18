Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268482B80D3
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgKRPlE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgKRPlD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:03 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BF2C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:03 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id v10so1398401pjg.5
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=bMbtktrsgt2BKEt9MFrYvx/sw2jOEdjl21VAcL40JPE=;
        b=TWWNVsMu73wQwMedlAkK59gJe4RWuHBF95OJrD4Xw9HKEwxyjAiEVqXFJv63vh6Ogh
         2OvZGoGBS9tfh66PP+3HOMvAF7unL6DQhz3h2Th1LCC5Br4XPHq20RJved4oJ+dfA6c0
         PXr2TeCXns34pTzMRHEoT9MAgxuUu6ch+a/g2N/eKA6NZayOD5B+/g4iqYWLIshh+YTk
         AbSsqtTIRRhmHhsWBWO8A136a40Ngeb1WaHpNJ719gv/slAYRS/8LavvvER0UuCMO17O
         sgLr78a/HM8G6SM+PgwWSo0/fnlKKPLaK96x1VL4KUFrcPvVBe4mcTQvvgkMW+cCQrEv
         MTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bMbtktrsgt2BKEt9MFrYvx/sw2jOEdjl21VAcL40JPE=;
        b=gR4t89V20q4ImL/ExSpaExZ1rHfk4ndII3AfStEOUMP8/k//Bx89MT6NQyb+2X8ZHW
         LmrrRehhbhaz/viEUbmmOTZEUtBC/XDp4XC9o9zbHJUUhB6b7WrfDtEuPu8g5PszcMrS
         fSv6uR1FdDo7O6WILNYuiUD7C/4H4S8IHmtqSimtHCE01u3hv2dmXVTRtezaHzkOcEld
         5dzsqm+XhxWS4INPRdud58T607WFmeOCUBNrB8F5oCiEU3jvUgBUcRMEUKNt5DWNLoaW
         gzjcbZfnu3PXzyeBikkwzc+32h1jic6gmn2NhlEVrGlqHV8tNYhpNUyiTrZxVcl+xAmE
         7QpQ==
X-Gm-Message-State: AOAM531ectjig5Gp6naWY9om0Bexs6ksHOBNjX03pC+RdFjIQhEnGiXE
        2aM/1UDEeTcvAV46mI0K02jRh5SydH/R3JXcyHpGlpE9X/ti2foVEwBRC5EftSfZFzDiKHeWFWN
        HX4BXSmGJf1OTBb6g4/sd3603pNvldbjRPmGGuQDHH+oVO8HzAs6iEiAwriHSOoT4mhRo5ySikx
        mxnPls2Kg=
X-Google-Smtp-Source: ABdhPJycJwOOV6dxxuR/pspcZBKIBnhPb/PtjLTMP94fhVyrgguq3Q1butzKj/l5NLsiIAn6j8Masv2B4Ve+2UYMWG8=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a62:2cc1:0:b029:18c:85f5:864b with
 SMTP id s184-20020a622cc10000b029018c85f5864bmr4818724pfs.29.1605714063126;
 Wed, 18 Nov 2020 07:41:03 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:06 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-21-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 20/61] e2fsck: merge icounts after thread finishes
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Li Xi <lixi@ddn.com>,
        Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

Merge inode_count and inode_link_info properly after
threads finish.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c      |  47 ++++++++++++++++++++
 lib/ext2fs/ext2fs.h |   1 +
 lib/ext2fs/icount.c | 103 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index da42323d..cdecd7c2 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2388,6 +2388,41 @@ static void e2fsck_pass1_merge_dir_info(e2fsck_t global_ctx, e2fsck_t thread_ctx
 			      global_ctx->dir_info);
 }
 
+static inline errcode_t
+e2fsck_pass1_merge_icount(ext2_icount_t *dest_icount,
+			  ext2_icount_t *src_icount)
+{
+	if (*src_icount) {
+		if (*dest_icount == NULL) {
+			*dest_icount = *src_icount;
+			*src_icount = NULL;
+		} else {
+			errcode_t ret;
+
+			ret = ext2fs_icount_merge(*src_icount,
+						  *dest_icount);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static errcode_t e2fsck_pass1_merge_icounts(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+{
+	errcode_t ret;
+
+	ret = e2fsck_pass1_merge_icount(&global_ctx->inode_count,
+					&thread_ctx->inode_count);
+	if (ret)
+		return ret;
+	ret = e2fsck_pass1_merge_icount(&global_ctx->inode_link_info,
+					&thread_ctx->inode_link_info);
+
+	return ret;
+}
+
 static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
 	errcode_t	 retval;
@@ -2408,6 +2443,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2fs_block_bitmap block_ea_map = global_ctx->block_ea_map;
 	ext2fs_block_bitmap block_metadata_map = global_ctx->block_metadata_map;
 	ext2fs_block_bitmap inodes_to_rebuild = global_ctx->inodes_to_rebuild;
+	ext2_icount_t inode_count = global_ctx->inode_count;
+	ext2_icount_t inode_link_info = global_ctx->inode_link_info;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
@@ -2432,6 +2469,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->block_metadata_map = block_metadata_map;
 	global_ctx->dir_info = dir_info;
 	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
+	global_ctx->inode_count = inode_count;
+	global_ctx->inode_link_info = inode_link_info;
 
 	/* Keep the global singal flags*/
 	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
@@ -2447,6 +2486,12 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->logf = global_logf;
 	global_ctx->problem_logf = global_problem_logf;
 	global_ctx->global_ctx = NULL;
+	retval = e2fsck_pass1_merge_icounts(global_ctx, thread_ctx);
+	if (retval) {
+		com_err(global_ctx->program_name, 0,
+			_("while merging icounts\n"));
+		return retval;
+	}
 
 	retval = e2fsck_pass1_merge_bitmap(global_fs,
 				&thread_ctx->inode_used_map,
@@ -2532,6 +2577,8 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	e2fsck_pass1_free_bitmap(&thread_ctx->block_ea_map);
 	e2fsck_pass1_free_bitmap(&thread_ctx->block_metadata_map);
 	e2fsck_free_dir_info(thread_ctx);
+	ext2fs_free_icount(thread_ctx->inode_count);
+	ext2fs_free_icount(thread_ctx->inode_link_info);
 	ext2fs_free_mem(&thread_ctx);
 
 	return retval;
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index ac548311..28662d44 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1513,6 +1513,7 @@ extern errcode_t ext2fs_icount_decrement(ext2_icount_t icount, ext2_ino_t ino,
 					 __u16 *ret);
 extern errcode_t ext2fs_icount_store(ext2_icount_t icount, ext2_ino_t ino,
 				     __u16 count);
+extern errcode_t ext2fs_icount_merge(ext2_icount_t src, ext2_icount_t dest);
 extern ext2_ino_t ext2fs_get_icount_size(ext2_icount_t icount);
 errcode_t ext2fs_icount_validate(ext2_icount_t icount, FILE *);
 
diff --git a/lib/ext2fs/icount.c b/lib/ext2fs/icount.c
index 888a90b2..766eccca 100644
--- a/lib/ext2fs/icount.c
+++ b/lib/ext2fs/icount.c
@@ -13,6 +13,7 @@
 #if HAVE_UNISTD_H
 #include <unistd.h>
 #endif
+#include <assert.h>
 #include <string.h>
 #include <stdio.h>
 #include <sys/stat.h>
@@ -701,6 +702,108 @@ errcode_t ext2fs_icount_store(ext2_icount_t icount, ext2_ino_t ino,
 	return 0;
 }
 
+errcode_t ext2fs_icount_merge_full_map(ext2_icount_t src, ext2_icount_t dest)
+{
+	/* TODO: add the support for full map */
+	return EOPNOTSUPP;
+}
+
+errcode_t ext2fs_icount_merge_el(ext2_icount_t src, ext2_icount_t dest)
+{
+	int			 src_count = src->count;
+	int			 dest_count = dest->count;
+	int			 size = src_count + dest_count;
+	int			 size_entry = sizeof(struct ext2_icount_el);
+	struct ext2_icount_el	*array;
+	struct ext2_icount_el	*array_ptr;
+	struct ext2_icount_el	*src_array = src->list;
+	struct ext2_icount_el	*dest_array = dest->list;
+	int			 src_index = 0;
+	int			 dest_index = 0;
+	errcode_t		 retval;
+
+	if (src_count == 0)
+		return 0;
+
+	retval = ext2fs_get_array(size, size_entry, &array);
+	if (retval)
+		return retval;
+
+	array_ptr = array;
+	/*
+	 * This can be improved by binary search and memcpy, but codes
+	 * would be more complex. And if number of bad blocks is small,
+	 * the optimization won't improve performance a lot.
+	 */
+	while (src_index < src_count || dest_index < dest_count) {
+		if (src_index >= src_count) {
+			memcpy(array_ptr, &dest_array[dest_index],
+			       (dest_count - dest_index) * size_entry);
+			break;
+		}
+		if (dest_index >= dest_count) {
+			memcpy(array_ptr, &src_array[src_index],
+			       (src_count - src_index) * size_entry);
+			break;
+		}
+		if (src_array[src_index].ino < dest_array[dest_index].ino) {
+			*array_ptr = src_array[src_index];
+			src_index++;
+		} else {
+			assert(src_array[src_index].ino >
+			       dest_array[dest_index].ino);
+			*array_ptr = dest_array[dest_index];
+			dest_index++;
+		}
+		array_ptr++;
+	}
+
+	ext2fs_free_mem(&dest->list);
+	dest->list = array;
+	dest->count = src_count + dest_count;
+	dest->size = size;
+	dest->last_lookup = NULL;
+	return 0;
+}
+
+errcode_t ext2fs_icount_merge(ext2_icount_t src, ext2_icount_t dest)
+{
+	errcode_t	retval;
+
+	if (src->fullmap && !dest->fullmap)
+		return EINVAL;
+
+	if (!src->fullmap && dest->fullmap)
+		return EINVAL;
+
+	if (src->multiple && !dest->multiple)
+		return EINVAL;
+
+	if (!src->multiple && dest->multiple)
+		return EINVAL;
+
+	if (src->fullmap)
+		return ext2fs_icount_merge_full_map(src, dest);
+
+	retval = ext2fs_merge_bitmap(src->single, dest->single, NULL,
+				     NULL);
+	if (retval)
+		return retval;
+
+	if (src->multiple) {
+		retval = ext2fs_merge_bitmap(src->multiple, dest->multiple,
+					     NULL, NULL);
+		if (retval)
+			return retval;
+	}
+
+	retval = ext2fs_icount_merge_el(src, dest);
+	if (retval)
+		return retval;
+
+	return 0;
+}
+
 ext2_ino_t ext2fs_get_icount_size(ext2_icount_t icount)
 {
 	if (!icount || icount->magic != EXT2_ET_MAGIC_ICOUNT)
-- 
2.29.2.299.gdc1121823c-goog

