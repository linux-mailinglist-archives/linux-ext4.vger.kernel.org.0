Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6609C61F30E
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiKGM0N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbiKGM0G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:26:06 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FCE1B1C9
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:26:04 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso12688653pjn.0
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vO3jPRC7xmlL2kLSJ6JtsnSnyM9UGaAxq/yG02THUg=;
        b=Dqmm7yxv1BHoOuU66HFITJ4WA5B32+CLnFcyDHNqzQuDfVLqprjPzgOZjzc1wc3WEF
         p8T1wPTGp8YkLsm/R8oOah8rgp+IF98kun/ZSVLudGPdoQbyCA7zMp5HIlEax/xg6n2X
         23sg7cDTj+un4nvMDv1aWm0B7LZp/jvqhds+E+8uF0VSSHJlGP9BjSydlceMMdj4pAQn
         OLf+bV+aLjTz4G4hQajexsBKdApFlnBfd7trY8BFoRkROzj4wbGcrlgi19+l76DmrdSV
         1yqM2EYwTkEti1piO3uMqPivhRQ+GDLYwtu7h1BymefcWl5DxrP8d9Wrks2051O3icmM
         hadA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vO3jPRC7xmlL2kLSJ6JtsnSnyM9UGaAxq/yG02THUg=;
        b=DH0HPHswilq6G2KuA42rmroG/vbqKWIjWuNMUf3JvPm2C/42dP8enOshYkRxRpaX+F
         1Zbd/zT/DIxN230HhwnLGao+vtwAgiElAC+/Gl3CiRMlIxTpVyA2i6onf3ymxSO4P9zd
         G7cKi0URMOfqGvTew/Qgv3iWBQ4YuxABpHYibGZk5NHZSJKiw3HrrtS1lzfTNtICI0YB
         kMOLiyyopAH94hTfhMr8dU+4c6crYLQkE+ViiH+lNYLNaiZgo/j4C0XZBgxNbunWKHuX
         rmFT+15vyvzfnShqDxc1usyQWKHUtbKwCKsAYK1BQik30LOf+YOemW6drOOVTcCu5MQ/
         nV0g==
X-Gm-Message-State: ACrzQf02m16IYm1rC6z3tDE9UdtNUWP5Z6XbIH4e6xDAnA2Zlwxhz0cz
        kqKVWNtMhImpcNMH6MTNZctwBpjKWCU=
X-Google-Smtp-Source: AMsMyM7ldy9tgfl3RdyA0NIqP0FnD2qY+N0BWbbnCJ0QEvS9HsXFzC1LaZ/1kCwUkvq14MhFCSaVbg==
X-Received: by 2002:a17:90a:6c41:b0:212:fdaf:d79c with SMTP id x59-20020a17090a6c4100b00212fdafd79cmr50302729pjj.134.1667823964465;
        Mon, 07 Nov 2022 04:26:04 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b0017bb38e4588sm4861702plk.135.2022.11.07.04.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:26:03 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 36/72] e2fsck: merge icounts after thread finishes
Date:   Mon,  7 Nov 2022 17:51:24 +0530
Message-Id: <b876ffdffefd060b7211687ce2f254f9eadf1cc8.1667822611.git.ritesh.list@gmail.com>
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

Merge inode_count and inode_link_info properly after
threads finish.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 4d98c467..18bf7efd 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2341,6 +2341,41 @@ static void e2fsck_pass1_merge_dir_info(e2fsck_t global_ctx, e2fsck_t thread_ctx
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
 	errcode_t retval = 0;
@@ -2361,6 +2396,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2fs_block_bitmap block_ea_map = global_ctx->block_ea_map;
 	ext2fs_block_bitmap block_metadata_map = global_ctx->block_metadata_map;
 	ext2fs_block_bitmap inodes_to_rebuild = global_ctx->inodes_to_rebuild;
+	ext2_icount_t inode_count = global_ctx->inode_count;
+	ext2_icount_t inode_link_info = global_ctx->inode_link_info;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf old_jmp;
@@ -2385,6 +2422,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->block_metadata_map = block_metadata_map;
 	global_ctx->dir_info = dir_info;
 	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
+	global_ctx->inode_count = inode_count;
+	global_ctx->inode_link_info = inode_link_info;
 
 	/* Keep the global singal flags*/
 	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
@@ -2396,6 +2435,13 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_fs->priv_data = global_ctx;
 	global_ctx->fs = global_fs;
 
+	retval = e2fsck_pass1_merge_icounts(global_ctx, thread_ctx);
+	if (retval) {
+		com_err(global_ctx->program_name, 0,
+			_("while merging icounts\n"));
+		return retval;
+	}
+
 	retval = ext2fs_merge_fs(&(thread_ctx->fs));
 	if (retval) {
 		com_err(global_ctx->program_name, 0, _("while merging fs\n"));
@@ -2478,6 +2524,8 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	e2fsck_pass1_free_bitmap(&thread_ctx->block_ea_map);
 	e2fsck_pass1_free_bitmap(&thread_ctx->block_metadata_map);
 	e2fsck_free_dir_info(thread_ctx);
+	ext2fs_free_icount(thread_ctx->inode_count);
+	ext2fs_free_icount(thread_ctx->inode_link_info);
 
 	if (thread_ctx->logf)
 		fclose(thread_ctx->logf);
-- 
2.37.3

