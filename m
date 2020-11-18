Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCE72B80E7
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgKRPlj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727453AbgKRPlj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:39 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12761C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:39 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k7so2893301ybm.13
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=N9eDhLjAK0lXjDIxv8fRi1NvR4Rb1NkH/1Lwpae+OkM=;
        b=knMVGkzn9iDTAsLdt0JTlH5fJS9NgYczDqyP3bpCRHh+18z1sMryFYkxLGvpEm+ZwK
         Iff6ShNzDCQCrJcUW/v5Y1+65PZV272znx2N8hnaRhoeGB+Vfkp2u0qiNsgyLPPAA4O6
         6lNIZ7EXhPZhfUqtLfYLudHx1i0ZIq6ROA6OlOspw1UtfTSGQXIwDDfz8Ocgh/rfk+Hf
         y7AAEUHXovmjjyE9l/sOxT9d+lTOUyxW7S/eess7il8+Sp+kcFB/CAMD6ywmaTJoo7qU
         fm2x/BgBM/lEquywaGm+gK1ND1MJdW5LwVq2P3Uugrct6sjCUYe76hw9Xnm1e+KcAmXS
         obBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N9eDhLjAK0lXjDIxv8fRi1NvR4Rb1NkH/1Lwpae+OkM=;
        b=NqIcysE8qPgCFYVlg4apPYco9t+YEErMRoTV2wbGUXvTRFBlIqIzEAz6SEoNgPvVGr
         JdzIuul+wl1YirUGgdOlJqVDuFbfnTSvLjHXplY0bEUtd7zFjtmRk6v9sN1irz+jt0KE
         Dj+UeYoko/iL8ax+ULiooiD2hKTBlhsQSQBlQDfWoiYn17gpIWYEwH/HxZdD8E3Ro+7T
         DVMD6hyoWnl9bLXJP9FppE6w3wQGLAUfJ8fqiVDYlX73oPeejHnkwonHBDKefswT/ECk
         XTxPTsX/FRCr89NPM6RXk2qp/9OdTvI7BvHL2ybJnlUyZFructcio1ol1mudH6oVtTWh
         uQuQ==
X-Gm-Message-State: AOAM530MGQfZk1RLOiVwHIcgG1Ufx3+CngRTWt78y4J97Z67q1BBB/Mb
        HAynASffTCzK3aefftBl4dfqXu2aETer/iLe56MNO0r91+sRjhzVhJHISzJO/rgdEhzQJH0yFhf
        /6rXkU9O9TUcLqw6+GEyWGdaR0gWv2uDc5+UJ7oBVJMP0ZsNIVrprrVaNm8QttQJJVHtPh8P/je
        vPUTpkvh8=
X-Google-Smtp-Source: ABdhPJxfUhGyBptjYbSLizRSJb7QxlYRXnCBoa28RoW6Pper4W1PFd5HlQCJJTYOeDPHU6PvNPjW4YyHx+XyGStGDE8=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a5b:850:: with SMTP id
 v16mr5558343ybq.4.1605714098192; Wed, 18 Nov 2020 07:41:38 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:25 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-40-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 39/61] e2fsck: merge extent depth count after threads finish
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

tests covered by f_extent_htree.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 09bfef44..0a872028 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2935,8 +2935,11 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2_refcount_t ea_inode_refs = global_ctx->ea_inode_refs;
 	ext2fs_block_bitmap  block_found_map = global_ctx->block_found_map;
 	ext2fs_block_bitmap  block_dup_map = global_ctx->block_dup_map;
-	int options = global_ctx->options;
+	int options = global_ctx->options, i;
+	__u32 extent_depth_count[MAX_EXTENT_DEPTH_COUNT];
 
+	memcpy(extent_depth_count, global_ctx->extent_depth_count,
+	       sizeof(extent_depth_count));
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
 
@@ -2996,6 +2999,12 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	 * later passes will recalculate it if necessary
 	 */
 	global_ctx->lost_and_found = 0;
+	memcpy(global_ctx->extent_depth_count, extent_depth_count,
+	       sizeof(extent_depth_count));
+	/* merge extent depth count */
+	for (i = 0; i < MAX_EXTENT_DEPTH_COUNT; i++)
+		global_ctx->extent_depth_count[i] +=
+			thread_ctx->extent_depth_count[i];
 
 	retval = e2fsck_pass1_merge_fs(global_fs, thread_fs);
 	if (retval) {
-- 
2.29.2.299.gdc1121823c-goog

