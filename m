Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B5C2B80E4
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgKRPlc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbgKRPlc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:32 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F06CC0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:32 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e19so2957233ybc.5
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=qZZIcbpfoZ3m5j0ryKxAM+L6rfSrz5CTtp6iMM9vl70=;
        b=DxT3gGsBvZEs769Ey0GfpQtNGqdljKoJULyNGPSJB3IE9VrS7G82EUZaIxorwDCk4a
         U4SPsI1JhTrSrpUCUhKmkLdZgPinaU6xdQMom56QFvm6WoDlke49tzgApQrlnK1EnNP9
         wmDZ0eR0CoMYn92qQmcdn9D7AymZP0TTrBfVQwuW+q9UC0bmIlm/C/OG3gG1z300bARI
         UOrpHioKr/f5O8kU71n0fbMJp+hp871lN0mcQ9yg/CdPqs5C7DvpdqZh9CIQamXYgbGQ
         iHl4ooH468qENUsIgpNPJWw+KR/qBcXI+ytVxngW6zVeAv8RQaBLgeuOberoVFk9ehac
         Rqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qZZIcbpfoZ3m5j0ryKxAM+L6rfSrz5CTtp6iMM9vl70=;
        b=RiG/fy5itkAlnwkxe/OLrngqwVVOeDmlBt7hzVXEquvlqKLKODYQw+hrc8T6v1M739
         NJM3iOdGOch2GT6wDfSsacibwIDvAblM6cwg58uOfe4aBFOdmfkVVYTvs/QA7EOgcvTi
         SBHIrobXqJrtA6BTt9fpX7Aj8IDm7CBtgm5BOg79mH81NaCfwHpX/toffIhhG4dHpr/G
         a3unToxM8WHXmKDqnfj/c+L8DrW57drYmJAPXypR1zXy0dWbOVC7c7Pw4YRgGDtjZGmH
         5RBlcGEhejCgCtcVUXgi/nD1dtPIYe/+sEdXjNt805RoFdCpICXxdB2dPPACue6r0HEA
         2EZA==
X-Gm-Message-State: AOAM530zHqHspkun3xRpOXQaUlFSc3YfawWkH3XUt/p/r8IQ64nhhs1f
        n/X32+EomwgSplYcmcJ1T415BH0kaKrk6ubRgS0y5XIa23NmNfIrsi4DQB222DFxjp269HNStyv
        ErzJMHiGq61X8RBwvm1cUhpNDblQXBKeEIm8RPZcqIjprZGk5e8Tn2NKftj75Gr5OoEvlBNmcgm
        KmoSGC/38=
X-Google-Smtp-Source: ABdhPJwcES15BGXpsJ8tcVUQHaeD3YWagyiSa84tvARagFp8FnCwMSC2fQwp4ON8INJzAkFP7aZfZw1c8pCfsnyyD9Y=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a25:d981:: with SMTP id
 q123mr8607734ybg.50.1605714091166; Wed, 18 Nov 2020 07:41:31 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:21 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-36-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 35/61] e2fsck: adjust number of threads
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

number of threads should not exceed flex bg numbers,
and output messages if we adjust threads number.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c      | 32 +++++++++++++++-----------------
 lib/ext2fs/ext2fs.h | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 30365d23..e2387fe3 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1282,6 +1282,7 @@ static void e2fsck_pass1_set_thread_num(e2fsck_t ctx)
 	}
 out:
 	ctx->fs_num_threads = num_threads;
+	ctx->fs->fs_num_threads = num_threads;
 }
 #endif
 
@@ -2551,14 +2552,14 @@ static void e2fsck_pass1_merge_invalid_bitmaps(e2fsck_t global_ctx,
 }
 
 static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx,
-					     int thread_index, int num_threads)
+					     int thread_index, int num_threads,
+					     dgrp_t average_group)
 {
 	errcode_t		retval;
 	e2fsck_t		thread_context;
 	ext2_filsys		thread_fs;
 	ext2_filsys		global_fs = global_ctx->fs;
 	struct e2fsck_thread	*tinfo;
-	dgrp_t			average_group;
 
 	assert(global_ctx->inode_used_map == NULL);
 	assert(global_ctx->inode_dir_map == NULL);
@@ -2605,16 +2606,9 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 	thread_context->thread_info.et_thread_index = thread_index;
 	set_up_logging(thread_context);
 
-	/*
-	 * Distribute work to multiple threads:
-	 * Each thread work on fs->group_desc_count / nthread groups.
-	 */
 	tinfo = &thread_context->thread_info;
-	average_group = thread_fs->group_desc_count / num_threads;
-	if (average_group == 0)
-		average_group = 1;
 	tinfo->et_group_start = average_group * thread_index;
-	if (thread_index == num_threads - 1)
+	if (thread_index == global_fs->fs_num_threads - 1)
 		tinfo->et_group_end = thread_fs->group_desc_count;
 	else
 		tinfo->et_group_end = average_group * (thread_index + 1);
@@ -3130,12 +3124,13 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 }
 
 static int e2fsck_pass1_threads_join(struct e2fsck_thread_info *infos,
-				      int num_threads, e2fsck_t global_ctx)
+				     e2fsck_t global_ctx)
 {
 	errcode_t			 rc;
 	errcode_t			 ret = 0;
 	int				 i;
 	struct e2fsck_thread_info	*pinfo;
+	int				 num_threads = global_ctx->fs_num_threads;
 
 	/* merge invalid bitmaps will recalculate it */
 	global_ctx->invalid_bitmaps = 0;
@@ -3217,7 +3212,7 @@ out:
 }
 
 static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
-				      int num_threads, e2fsck_t global_ctx)
+				      e2fsck_t global_ctx)
 {
 	struct e2fsck_thread_info	*infos;
 	pthread_attr_t			 attr;
@@ -3226,6 +3221,8 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 	struct e2fsck_thread_info	*tmp_pinfo;
 	int				 i;
 	e2fsck_t			 thread_ctx;
+	dgrp_t				 average_group;
+	int				 num_threads = global_ctx->fs_num_threads;
 #ifdef DEBUG_THREADS
 	struct e2fsck_thread_debug	 thread_debug =
 		{PTHREAD_MUTEX_INITIALIZER, PTHREAD_COND_INITIALIZER, 0};
@@ -3249,6 +3246,7 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 		return retval;
 	}
 
+	average_group = ext2fs_get_avg_group(global_ctx->fs);
 	for (i = 0; i < num_threads; i++) {
 		tmp_pinfo = &infos[i];
 		tmp_pinfo->eti_thread_index = i;
@@ -3256,7 +3254,8 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 		tmp_pinfo->eti_debug = &thread_debug;
 #endif
 		retval = e2fsck_pass1_thread_prepare(global_ctx, &thread_ctx,
-						     i, num_threads);
+						     i, num_threads,
+						     average_group);
 		if (retval) {
 			com_err(global_ctx->program_name, retval,
 				_("while preparing pass1 thread\n"));
@@ -3286,7 +3285,7 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 	}
 
 	if (retval) {
-		e2fsck_pass1_threads_join(infos, num_threads, global_ctx);
+		e2fsck_pass1_threads_join(infos, global_ctx);
 		return retval;
 	}
 	*pinfo = infos;
@@ -3296,17 +3295,16 @@ static int e2fsck_pass1_threads_start(struct e2fsck_thread_info **pinfo,
 static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 {
 	struct e2fsck_thread_info *infos = NULL;
-	int num_threads = global_ctx->fs_num_threads;
 	errcode_t retval;
 
-	retval = e2fsck_pass1_threads_start(&infos, num_threads, global_ctx);
+	retval = e2fsck_pass1_threads_start(&infos, global_ctx);
 	if (retval) {
 		com_err(global_ctx->program_name, retval,
 			_("while starting pass1 threads\n"));
 		goto out_abort;
 	}
 
-	retval = e2fsck_pass1_threads_join(infos, num_threads, global_ctx);
+	retval = e2fsck_pass1_threads_join(infos, global_ctx);
 	if (retval) {
 		com_err(global_ctx->program_name, retval,
 			_("while joining pass1 threads\n"));
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 0fa0e22f..83f2af07 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -255,10 +255,11 @@ struct struct_ext2_filsys {
 	int				cluster_ratio_bits;
 	__u16				default_bitmap_type;
 	__u16				pad;
+	__u32				fs_num_threads;
 	/*
 	 * Reserved for future expansion
 	 */
-	__u32				reserved[5];
+	__u32				reserved[4];
 
 	/*
 	 * Reserved for the use of the calling application.
@@ -2121,6 +2122,35 @@ ext2fs_const_inode(const struct ext2_inode_large * large_inode)
 	return (const struct ext2_inode *) large_inode;
 }
 
+static dgrp_t ext2fs_get_avg_group(ext2_filsys fs)
+{
+#ifdef CONFIG_PFSCK
+	dgrp_t average_group;
+	unsigned flexbg_size;
+
+	if (fs->fs_num_threads <= 1)
+		return fs->group_desc_count;
+
+	average_group = fs->group_desc_count / fs->fs_num_threads;
+	if (average_group <= 1)
+		return 1;
+
+	if (ext2fs_has_feature_flex_bg(fs->super)) {
+		int times = 1;
+
+		flexbg_size = 1 << fs->super->s_log_groups_per_flex;
+		if (average_group % flexbg_size) {
+			times = average_group / flexbg_size;
+			average_group = times * flexbg_size;
+		}
+	}
+
+	return average_group;
+#else
+	return fs->group_desc_count;
+#endif
+}
+
 #undef _INLINE_
 #endif
 
-- 
2.29.2.299.gdc1121823c-goog

