Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A237D61F314
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiKGM0n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiKGM0m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:26:42 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFB863D5
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:26:42 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id e129so10303432pgc.9
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djX6kG4sb5dSN1Jo9voKc/t70N6XAj7Y4LtlOcTTGEI=;
        b=JUhJRCd5DAjnwvACzAeMR1dtwzdkXflnrkpW0fMdisLYmtuZkezcnQyBt3CF1j5PjO
         B2N6pcwKH6/MfMNgzVt40q7oImNYyQb5B37k2raftfpD42Xi+H+FFV95Xqhjz8Xzrsp8
         73Oz5542gfL3K+qOFcBiw45rThLoqEYTOQwVrrExh7ZvN+EfN3ZqZnk8Iw4C7xbD/MWA
         ShBsy4ug5HOOGS/Kg8CsF8o7yAl90YqUSDyQCyIbJPTNfsV02HZYTRLnIM9Uj5NTXQDE
         S7Pvtj4BsQCNwk/MXKI2efaVjE1kWiwIzmUP70rllBCa/4Xoil7WZQC07b4e4VIcUEoV
         lxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djX6kG4sb5dSN1Jo9voKc/t70N6XAj7Y4LtlOcTTGEI=;
        b=nhyKec9cR/dEbTAcd/rpIeutE8O3Kuo5rdwooHmtPMMM6gZz09NEnax3eHx2eIi3N3
         MKO7wtnXqrVrIBJNwScc/DHf2phDkWHqWracEnqINIxI7GfBnEWUfsenkv/wWI7BeB09
         OvYn6h683QaYv3UW8ua7ULHcE3gEjcVIU/FT271eQfJURdVteJWskiJXrSrBw4VqfoRb
         5JJ2uVzYR1QSigJMuCyPX0Ban1u+HX+t8EkQsSc56FdUrNJjAn6zYXBR9a9fSGQHNwaQ
         J65rK4qvobHkeFnUp63Du5e/Hz1hb/UEowIFVA/BjjZaJyWyZa3xsZD9tMMby0iZZ3a2
         bsvA==
X-Gm-Message-State: ACrzQf0dM691NYYLzVHNCF9Qm05Z0IAz1h8XR7MrbdUzqzPRjWOzvWP2
        SN2frM+CqobWwGLeDC/aHb8=
X-Google-Smtp-Source: AMsMyM4g6es8Govex4KSfeE1vzCpofC57TUWx2HAIkCgq10jmLHUuvApxHaiwSAf7ihsaf74Qw0Y4Q==
X-Received: by 2002:a62:ea09:0:b0:562:a86f:63af with SMTP id t9-20020a62ea09000000b00562a86f63afmr51018117pfh.71.1667824001646;
        Mon, 07 Nov 2022 04:26:41 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id p1-20020a170902ebc100b00179c9219195sm4881685plg.16.2022.11.07.04.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:26:40 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 42/72] e2fsck: merge quota context after threads finish
Date:   Mon,  7 Nov 2022 17:51:30 +0530
Message-Id: <31672b4c6e497a62c5f4fe0650cf0acde6c0b607.1667822611.git.ritesh.list@gmail.com>
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

From: Wang Shilong <wshilong@ddn.com>

Every threads calculate its own quota accounting,
merge them after threads finish.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/pass1.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 7e167189..213c1a51 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2317,6 +2317,12 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 	if (thread_context->options & E2F_OPT_MULTITHREAD)
 		log_out(thread_context, _("Scan group range [%d, %d)\n"),
 			tinfo->et_group_start, tinfo->et_group_end);
+	retval = quota_init_context(&thread_context->qctx, thread_fs, 0);
+	if (retval) {
+		com_err(global_ctx->program_name, retval,
+			"while init quota context");
+		goto out_fs;
+	}
 	*thread_ctx = thread_context;
 	return 0;
 out_fs:
@@ -2454,6 +2460,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2_ino_t dx_dir_info_size = global_ctx->dx_dir_info_size;
 	ext2_ino_t dx_dir_info_count = global_ctx->dx_dir_info_count;
 	ext2_u32_list dirs_to_hash = global_ctx->dirs_to_hash;
+	quota_ctx_t qctx = global_ctx->qctx;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf old_jmp;
@@ -2530,6 +2537,12 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 		return retval;
 	}
 
+	global_ctx->qctx = qctx;
+	retval = quota_merge_and_update_usage(global_ctx->qctx,
+					      thread_ctx->qctx);
+	if (retval)
+		return retval;
+
 	retval = e2fsck_pass1_merge_bitmap(global_fs,
 				&thread_ctx->inode_used_map,
 				&global_ctx->inode_used_map);
@@ -2611,6 +2624,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	ext2fs_free_icount(thread_ctx->inode_link_info);
 	if (thread_ctx->dirs_to_hash)
 		ext2fs_badblocks_list_free(thread_ctx->dirs_to_hash);
+	quota_release_context(&thread_ctx->qctx);
 
 	if (thread_ctx->logf)
 		fclose(thread_ctx->logf);
-- 
2.37.3

