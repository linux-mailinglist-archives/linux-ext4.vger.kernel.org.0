Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FABA2B80EF
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgKRPl4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgKRPly (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:54 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDC1C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:54 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id i6so1514951pgg.10
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=GjJeR3HmrSAYgbKKIohYNzytTHCLPFhyiKxa4ICxu0I=;
        b=FHWYN3OWgUJiszB8swLc52iCR910jAwz6e23BtVOWyZdVt9Qe++6yMOlUkzDepEz7X
         TJ9GaUm6pkaKLgozHBJhlhVhJ3mmxIcSUfoKrq/LC7f3AWT9rcxOoelaJ3Yfn+jyDrO3
         1Jh7UrOev9o6HRr5/N8kst/I5TCHywlDq8CmHANJMTf5egkN3sShG6BIlnChqr/EkoNJ
         C8GB7eEq/Pt8/cMO/gYGqXt7lpOFtFY3tDfUdJSIDOuOf9ITHmQ1ZRteav/CGl46Y1oA
         1pHpyrD+6oliOsWbixPKe+/uj2g7lctdskwGGPLKlyjPWJeoh5UrfldGkWzSpS2fhRDu
         s65A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GjJeR3HmrSAYgbKKIohYNzytTHCLPFhyiKxa4ICxu0I=;
        b=VnkURGYIB0dp6I3avHfhrk/Isd0anIC+4kZFmqqqNVNY8WQqLfjvfDgm7LLCDx/chA
         s1dN0fzWTNpM5LNGgo6VnzuE81979HRmtXwZ5/cL7YQutvEX5vtyobEdU1CcQgwPqPYs
         BtvjyK0WCYIdOdOTDV1DZ5zwnVC3aKpfIFzw1T3mLsu7jeIuu2JfMyauVITqc7cgiDHJ
         9g8rBv6onKqiWRgQ56i5ECv3ktcA8LN9vP5z5q3AKyM+8hsA27IkQCWbcaVTzS5OpGlP
         5FdRfKbAHP9q9IunfppJL7NJoX6er4XEYax/yETpYSmoS06jo9xeAZR8scG/tT5GGF8x
         CA7Q==
X-Gm-Message-State: AOAM533V6lvYQpS7ZvE5CPSCHfYXa/DrfaPbAeaTr7A2pdfnOI9N50ts
        XAKQLY1fYjiDpTdOgaWfPnemqpomAYKxUhLEBxSkQ7hkfvPebN6ZIVjNhbo6S81IyNN5L8ycxCR
        TgKjrUl5WgAMvo7cKf1aj3/zlbmeFsijOE+YbNmy+yvA2TCRY9Cp1ZyqjAS4P5udpdz2xNCwOFW
        yq9lmda7U=
X-Google-Smtp-Source: ABdhPJyKMCxL4ddnwWmP9DD5L5/iA35fwH0BsmhJbkqLXKnUW6+CBox2u3+LpOLRFtNZ5SO995DwtTpZzS8tDj62YHA=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a17:90b:e04:: with SMTP id
 ge4mr46486pjb.0.1605714113740; Wed, 18 Nov 2020 07:41:53 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:33 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-48-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 47/61] e2fsck: update mmp block in one thread
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

For multiple threads, different threads will try to
update mmp block at the same time, only allow one
thread to update it.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/e2fsck.h |  1 +
 e2fsck/pass1.c  | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index a66772c1..1469c3e1 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -451,6 +451,7 @@ struct e2fsck_struct {
 	char *undo_file;
 #ifdef CONFIG_PFSCK
 	__u32			 fs_num_threads;
+	__u32			 mmp_update_thread;
 	int			 fs_need_locking;
 	/* serialize fix operation for multiple threads */
 	pthread_rwlock_t	 fs_fix_rwlock;
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 60f70111..e98cda9f 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1497,7 +1497,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 	dgrp_t		ra_group = 0;
 	struct ea_quota	ea_ibody_quota;
 	struct process_inode_block *inodes_to_process;
-	int		process_inode_count;
+	int		process_inode_count, check_mmp;
 
 	init_resource_track(&rtrack, ctx->fs->io);
 	clear_problem_context(&pctx);
@@ -1646,8 +1646,33 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 #endif
 
 	while (1) {
+		check_mmp = 0;
 		e2fsck_pass1_check_lock(ctx);
-		if (ino % (fs->super->s_inodes_per_group * 4) == 1) {
+#ifdef	CONFIG_PFSCK
+		if (!ctx->mmp_update_thread) {
+			e2fsck_pass1_block_map_w_lock(ctx);
+			if (!ctx->mmp_update_thread) {
+				if (ctx->global_ctx)
+					ctx->mmp_update_thread =
+						ctx->thread_info.et_thread_index + 1;
+				else
+					ctx->mmp_update_thread = 1;
+				check_mmp = 1;
+			}
+			e2fsck_pass1_block_map_w_unlock(ctx);
+		}
+
+		/* only one active thread could update mmp block. */
+		e2fsck_pass1_block_map_r_lock(ctx);
+		if (!ctx->global_ctx || ctx->mmp_update_thread ==
+			(ctx->thread_info.et_thread_index + 1))
+			check_mmp = 1;
+		e2fsck_pass1_block_map_r_unlock(ctx);
+#else
+		check_mmp = 1;
+#endif
+
+		if (check_mmp && (ino % (fs->super->s_inodes_per_group * 4) == 1)) {
 			if (e2fsck_mmp_update(fs))
 				fatal_error(ctx, 0);
 		}
@@ -2365,6 +2390,13 @@ endit:
 		print_resource_track(ctx, _("Pass 1"), &rtrack, ctx->fs->io);
 	else
 		ctx->invalid_bitmaps++;
+#ifdef	CONFIG_PFSCK
+	/* reset update_thread after this thread exit */
+	e2fsck_pass1_block_map_w_lock(ctx);
+	if (ctx->mmp_update_thread)
+		ctx->mmp_update_thread = 0;
+	e2fsck_pass1_block_map_w_unlock(ctx);
+#endif
 }
 
 #ifdef CONFIG_PFSCK
-- 
2.29.2.299.gdc1121823c-goog

