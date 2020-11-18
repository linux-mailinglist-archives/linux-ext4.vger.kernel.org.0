Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E922B80F2
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgKRPmB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbgKRPmA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:42:00 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820EFC0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:42:00 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u37so2943100ybi.15
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=uaDW3e45uHJQl6bXyNwdqfI0txtMN4R0imzv8FDVqaE=;
        b=SZ3nQjcFUO1GhfYRA8oGh7U5oXDMKJLyQLT+8/KawAuY0VhJ0vkfBiN8U5ZxsM/6nP
         3WgkzPmSVmpOQ2LhD9HeOracNyKrCGgzE/JxswH8DTUv1ahuPt/pUEtN7IOsx3PeyCR3
         KAkDIdG1tOHNZ4WFfpEtV7bIC2hfkB0B/u+ITtCmKIQVAdbgwlRvenKZy/sjVDCMwzss
         82AfWyqdNnOm3tT8oZo1tKyJlStL06MbdslxV8h0/JKMOPyN28QPsnz5slTWs4JxkTUx
         EpFNDbdFNN4hcd/eaU7okWaUeyV2t+IxjTZ4bDW+3TRWydnUo9deEQMN2ZUuCyojs+BK
         pESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uaDW3e45uHJQl6bXyNwdqfI0txtMN4R0imzv8FDVqaE=;
        b=UDZuOKh3wwEcASxp8Zl8AiIYJe5nfY4HE+FqK8CPYG1PM1hycgdgq4CKUlIXH5XBrY
         /5Z7NcrpIal688aR2wRgLbtPluwYh+fbm7YmzpwzqzCJuaJd9Y5jbuCVEeGfyAdpo+Ei
         pqh4puraQvIlKaeCMhTmM8lL+nyY8uMtIwTvM1EquCYgzBUq6ZO7ss864df+QelQH2h1
         7GHJ3tDOChrgBdi5JVrDKCcWu2lDR9KSz/hiEHFyloMc6MRdKObOhgH/h2D0MmaDsTxe
         PvLf9C4ry6ek4kJMXbVK3ab26V/AQbYjqyjZEYW6xIa3qng58aUKgyljHlP66xINWw9H
         42qw==
X-Gm-Message-State: AOAM533Y0v1lP5LS17IzVH0BDR6a1ph7Igfq8ed4q0R+jTp7Ge/Oe1Ds
        1J7q6CJsD9iaZm16q3fl8Z3erB1hE8kKuxrcWZWy1rPBl4VV9Walj6NhNkbt6zcbguTgYX7rOBm
        ZzsfwEo1Pm/gkat4Qq+2qsSkZ23LrWoxYk9V1OgGOm344GcqUCF2Yae/m25DM3yW22F6/+htvUO
        AB0BYi+II=
X-Google-Smtp-Source: ABdhPJwtPYtoiaKg8sXW5PpaR8nXR5vaHcQYN5kD044RhlguA8A9T/g+7WCnmO/PkYb+ZqgECsnjB65E/bbQG7Pr11I=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a25:2e0d:: with SMTP id
 u13mr7449724ybu.247.1605714119662; Wed, 18 Nov 2020 07:41:59 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:36 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-51-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 50/61] e2fsck: move ext2fs_get_avg_group to rw_bitmaps.c
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        jenkins <devops@whamcloud.com>, Maloo <maloo@whamcloud.com>,
        Andreas Dilger <adilger@whamcloud.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

A bounch of ext2fs_get_avg_group() unused warning messages are
annoying, move it to rw_bitmaps.c to make gcc happy.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Change-Id: Ia7d372b7b5aadcbf5d94916f6f67363a2a9f0bfa
Reviewed-on: https://review.whamcloud.com/40060
Tested-by: jenkins <devops@whamcloud.com>
Tested-by: Maloo <maloo@whamcloud.com>
Reviewed-by: Andreas Dilger <adilger@whamcloud.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 lib/ext2fs/ext2fs.h     | 29 +----------------------------
 lib/ext2fs/rw_bitmaps.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 83f2af07..616c9412 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -2122,34 +2122,7 @@ ext2fs_const_inode(const struct ext2_inode_large * large_inode)
 	return (const struct ext2_inode *) large_inode;
 }
 
-static dgrp_t ext2fs_get_avg_group(ext2_filsys fs)
-{
-#ifdef CONFIG_PFSCK
-	dgrp_t average_group;
-	unsigned flexbg_size;
-
-	if (fs->fs_num_threads <= 1)
-		return fs->group_desc_count;
-
-	average_group = fs->group_desc_count / fs->fs_num_threads;
-	if (average_group <= 1)
-		return 1;
-
-	if (ext2fs_has_feature_flex_bg(fs->super)) {
-		int times = 1;
-
-		flexbg_size = 1 << fs->super->s_log_groups_per_flex;
-		if (average_group % flexbg_size) {
-			times = average_group / flexbg_size;
-			average_group = times * flexbg_size;
-		}
-	}
-
-	return average_group;
-#else
-	return fs->group_desc_count;
-#endif
-}
+dgrp_t ext2fs_get_avg_group(ext2_filsys fs);
 
 #undef _INLINE_
 #endif
diff --git a/lib/ext2fs/rw_bitmaps.c b/lib/ext2fs/rw_bitmaps.c
index 960a6913..95de9b1c 100644
--- a/lib/ext2fs/rw_bitmaps.c
+++ b/lib/ext2fs/rw_bitmaps.c
@@ -515,6 +515,31 @@ struct read_bitmaps_thread_info {
 	io_channel      rbt_io;
 };
 
+dgrp_t ext2fs_get_avg_group(ext2_filsys fs)
+{
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
+}
+
 static void* read_bitmaps_thread(void *data)
 {
 	struct read_bitmaps_thread_info *rbt = data;
-- 
2.29.2.299.gdc1121823c-goog

