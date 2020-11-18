Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512402B80EB
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgKRPlr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgKRPlr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:47 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB50CC0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:46 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w8so2923546ybj.14
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=J+qzfoSyTvz9pOQzjIGTh7s4r8If6jlOq/zMCK5+DV4=;
        b=v4e407f8aGXGpVFY8yg7uJWS0tYiO3NlLuF2kg5i5DGF9uA7OIXOyh4hl9P/y8ZQyz
         2Cr8MI3Mc1STskg8OvPQbRd8lZcJoc6qCsRZ/H5fvp4jBGW0tz9O0GsaaW6wD8nrGhJ0
         fUx0NktDcw6rMaRJKJ0a8wYjMXzIurEhuNWyh5fI6nvXQAyAQzjS5tlL0/cbb4QDaHBk
         u+XOiVx2WiCNTFMNscPPno2t9D0AKJCliKdNcV9IvvbldYLz/UDW12R7819Zk3//DigH
         2gTzEx12A9/kgGuiopNVYThJkq8hzknnOsICOpQi6+yuAqlb8zH3g1h6Zr6iUnGtEj51
         zOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J+qzfoSyTvz9pOQzjIGTh7s4r8If6jlOq/zMCK5+DV4=;
        b=ihby04zrlyQCORsz3zCsRqjYrsbGxMpsiG5B8UvXhA4B0EdH6B7GezOJkn5Uust/bf
         GbWpbly9IBEj2cicAbCQ3iT22lv+ek57+lEV+vqZ40eCHhzafQpM+ymBvwNZg86eXPg9
         m+6zWsH3BjlVL/FAWOrVt7X/93HPi4cZaSxnSvom/K1lw360yrlb64J+alUvspOIIFdy
         ddsmQPi7t2TvoCbm+tRYJIgIJ+M77EjrvaFvpS6LBM9+I5HOGo7EyIA1ruu2XqbTJkP2
         zEZVRquc9BCJm1gIV7NZ5u7D3IneSLu+Fv4gGi20pk74bA9+aQ3MEY/BH6Q4QSAv6h8P
         20qg==
X-Gm-Message-State: AOAM5335nnQHGPAJXn1Z+7fkOnx7l8Cq5o95FGA+kRW6E3RRTaKvXJHY
        bjyRw5WwMRa+yfxJGiuvSvHN+tdOPAMBzoMeIcsw9nnT3Te6A4ka8g7BJ4o0V/4m4+EfiEnZ3bY
        gxnv717l4fw6NiV0u1bb6mS2pqSqPy8aM8/iINQcEyAMzsZqTF1CIyJ0tpSAtCYzTEuHzwrsuUA
        YM4LX5wPo=
X-Google-Smtp-Source: ABdhPJyObyeM+BE15vwDaELPAS1hrxwWEZKVPUXPrm0OlFJt3wf/IfKbmZ5BzKXfpAtu5FBS/xYcdryvJCoUlLC72MI=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a25:b11:: with SMTP id
 17mr7188939ybl.203.1605714106018; Wed, 18 Nov 2020 07:41:46 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:29 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-44-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 43/61] e2fsck: cleanup e2fsck_pass1_thread_join()
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Use e2fsck_reset_context() to free memory to simpify
codes.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 5e62e357..60f70111 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -3079,32 +3079,14 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 		fputs("</problem_log>\n", thread_ctx->problem_logf);
 		fclose(thread_ctx->problem_logf);
 	}
-	e2fsck_pass1_free_bitmap(&thread_ctx->inode_used_map);
-	e2fsck_pass1_free_bitmap(&thread_ctx->inode_bad_map);
-	e2fsck_pass1_free_bitmap(&thread_ctx->inode_dir_map);
-	e2fsck_pass1_free_bitmap(&thread_ctx->inode_bb_map);
-	e2fsck_pass1_free_bitmap(&thread_ctx->inode_imagic_map);
-	e2fsck_pass1_free_bitmap(&thread_ctx->inode_reg_map);
-	e2fsck_pass1_free_bitmap(&thread_ctx->inodes_to_rebuild);
-	e2fsck_pass1_free_bitmap(&thread_ctx->block_found_map);
-	e2fsck_pass1_free_bitmap(&thread_ctx->block_ea_map);
-	if (thread_ctx->refcount)
-		ea_refcount_free(thread_ctx->refcount);
-	if (thread_ctx->refcount_extra)
-		ea_refcount_free(thread_ctx->refcount_extra);
-	if (thread_ctx->ea_inode_refs)
-		ea_refcount_free(thread_ctx->ea_inode_refs);
-	if (thread_ctx->refcount_orig)
-		ea_refcount_free(thread_ctx->refcount_orig);
-	e2fsck_free_dir_info(thread_ctx);
-	ext2fs_free_icount(thread_ctx->inode_count);
-	ext2fs_free_icount(thread_ctx->inode_link_info);
-	if (thread_ctx->dirs_to_hash)
-		ext2fs_badblocks_list_free(thread_ctx->dirs_to_hash);
-	quota_release_context(&thread_ctx->qctx);
-	ext2fs_free_mem(&thread_ctx->invalid_block_bitmap_flag);
-	ext2fs_free_mem(&thread_ctx->invalid_inode_bitmap_flag);
-	ext2fs_free_mem(&thread_ctx->invalid_inode_table_flag);
+
+	/*
+	 * @block_metadata_map and @block_dup_map are
+	 * shared, so we don't free them.
+	 */
+	thread_ctx->block_metadata_map = NULL;
+	thread_ctx->block_dup_map = NULL;
+	e2fsck_reset_context(thread_ctx);
 	ext2fs_free_mem(&thread_ctx);
 
 	return retval;
-- 
2.29.2.299.gdc1121823c-goog

