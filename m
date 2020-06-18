Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3281FF6E3
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbgFRPaQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731622AbgFRPaI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:30:08 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FA1C0613EF
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:30:06 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b201so2962296pfb.0
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d2YnaOgtbX0ScW7yoDd5TcUP4cnYYDyfxeaqwQkvP1E=;
        b=S6Kp2GRKqoM+e/uMSSenPVLCy1hhVnQemTUCnF3jpxT+InNXyUpkpsImSsfd+J8cnX
         kX5Fdi8Cw98j8g2OOWPmuqrsR2HPdQcf0PBVXkynlP3LexPHhFkXd2TXECmTU3r5Rsc5
         ngyscOe51bpYuxfnmUdbDZzTUw3RKnH43PxK7elPWhUyJ4hVIjbaEJ0JYQl0prNj0AGK
         fB11Ng6uWT6/vH0JoEPubDWaK2Y7GBTLxFtv7ZevDOxWJVA724Rwk1ncfjKD4M3ztszT
         tmEfgZ1kB/gze90maNB+JW1VVENy98xXsELW3188chZHpcAsKVRtfErKXIDFmctY9x3i
         yGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d2YnaOgtbX0ScW7yoDd5TcUP4cnYYDyfxeaqwQkvP1E=;
        b=XgyfnqMCXd3oJV/nT0XSQ1AIcgU5aYnhfwaega2iQPzsLOowg4bewgEIyKsk6R8lVV
         ER+kvcb21y8MAkCierC/fa+4khry4zxfXqthjZDIhE8lnAj5j0CUCPIBOyawkTjmjTQs
         qZcIdhwElIhYsk+E8el7B802Q+0U88RBF9w4qN2FeItKpCFiPY8+oW8wtjnTxxCV/vMl
         a/OLDAZmbGwz3Uovp8KhLqHL9q66s4xD1Lp5FZg6sJSdqYZc7DWU9huPceU0z9q61GOz
         4Tgl3AaO1EIqg/8OOKq/77oAYJ1KBGhYzG9uz1m9HOPrkPUnTRMIEA0vLrt0Q/whJq+6
         +gdg==
X-Gm-Message-State: AOAM530JfP4lrWA+oh5R+WPuC91ht47XZ8OTqC8MKeZgNAjY9bJo65yH
        qA5GIjz/DzH3h3MJ/x7BPisEG6+2/Lg=
X-Google-Smtp-Source: ABdhPJzrAajPPyDoZYXcQSksS9gQQNvtl576msNBacRbSOszv/fBPLWtIKWzCtiQCpO2k3U4uw8x7Q==
X-Received: by 2002:a63:7a56:: with SMTP id j22mr3629848pgn.194.1592494205990;
        Thu, 18 Jun 2020 08:30:05 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.30.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:30:05 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 47/51] e2fsck: only set E2F_FLAG_ALLOC_OK if all threads succeed
Date:   Fri, 19 Jun 2020 00:27:50 +0900
Message-Id: <1592494074-28991-48-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index d56b7128..45e8090b 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -1375,9 +1375,12 @@ static void _e2fsck_pass1_post(e2fsck_t ctx)
 {
 	struct problem_context pctx;
 	ext2_filsys fs = ctx->fs;
+	char *block_buf;
 
-	char *block_buf =
-		(char *)e2fsck_allocate_memory(ctx, ctx->fs->blocksize * 3,
+	if (e2fsck_should_abort(ctx))
+		return;
+
+	block_buf = (char *)e2fsck_allocate_memory(ctx, ctx->fs->blocksize * 3,
 					      "block interate buffer");
 	reserve_block_for_root_repair(ctx);
 	reserve_block_for_lnf_repair(ctx);
@@ -1455,6 +1458,8 @@ static void _e2fsck_pass1_post(e2fsck_t ctx)
 		ext2fs_free_mem(&block_buf);
 		ctx->flags &= ~E2F_FLAG_DUP_BLOCK;
 	}
+
+	ctx->flags |= E2F_FLAG_ALLOC_OK;
 }
 
 
@@ -2309,7 +2314,6 @@ void _e2fsck_pass1(e2fsck_t ctx)
 		goto endit;
 	}
 
-	ctx->flags |= E2F_FLAG_ALLOC_OK;
 endit:
 	e2fsck_use_inode_shortcuts(ctx, 0);
 	ext2fs_free_mem(&inodes_to_process);
-- 
2.25.4

