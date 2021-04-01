Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2CF35184E
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Apr 2021 19:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhDARpj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Apr 2021 13:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbhDARhu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Apr 2021 13:37:50 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F10C0319D2
        for <linux-ext4@vger.kernel.org>; Thu,  1 Apr 2021 10:21:46 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f17so1377994plr.0
        for <linux-ext4@vger.kernel.org>; Thu, 01 Apr 2021 10:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=StY1yBZ9pifiKioURulkv2F1ZBbKhi9Sg1t+jALxITk=;
        b=N6NCbpcfMReEHSI0g2KAy2MhlXyNbP7P3eXR8xBAmE8x7QNwWNwNPO1yGVtCLyUg9T
         YYvPZBgtpx1NzUaKaiGlnqqDbSOy+gqnjXHvxKZc9LvUrR+ddyyn+rxO8TLpxbZs9Wqz
         MpjRVG8awFSOTVig8b5ikdiVvEXHlWtcF/E5wptGNYsdjTp/huAFKYavx0qudfmxOP2Q
         Shs3yOCuBB8sLgTII6gf0fQfsQCDFjY7fyOlN27oKHIu8Yyv09aQyO5WfGaatg4Q60Rg
         aE9n8ABx78bGlQtd7ZfLNoDK/idELelNYYYwbGQ1JQxc6b0CElbWarXo8KUIjvxzdkO1
         O7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=StY1yBZ9pifiKioURulkv2F1ZBbKhi9Sg1t+jALxITk=;
        b=UoDAFxoi8GdreJctokNlegmLtUDeWIcA+jeCFgmGaJQ0/bZZ8Mh4q1iDa6bNVZR/bW
         C9NuVna8IYHZBHVvUEAfmOXXdx3/fbvsc6hqkUD9QHwRtbbm/M5sXpVpVMx6xSld1fSy
         C7rQyg0u+E6+z/dfmyAI/K0tMDrs1gadX/M18/2Yd+sooScWKH46bj1uwjZ39NgLnWQH
         Qy3GUZE1oJndnxPUHIvhm92bNUnSvDu5ute1j9RyTylqCmDIzm0WxbQCUAP/QGcVEE0D
         rexbsg25Joc/Ficj8SAAOdE3nU52+3ROECZKcJtvbE1RY4E4psvAwttMwT29THof6z+Y
         zEbQ==
X-Gm-Message-State: AOAM531zmuTDCAfJcFH2zZn0Ubx0SOVPpQ3GnPp2J3bIa0l1ikHHvwuc
        sUNiqr7iYH2UbCitoBntSYix+L6RrgU=
X-Google-Smtp-Source: ABdhPJzuGlEjZ2rj/xrm8q43Xya9EhzqoXvokw64h2JD+gbJa2aRDM7IFxclNvUVXYKXYArroUY4mg==
X-Received: by 2002:a17:90b:e18:: with SMTP id ge24mr9997260pjb.199.1617297706009;
        Thu, 01 Apr 2021 10:21:46 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:455f:9418:5b00:693])
        by smtp.googlemail.com with ESMTPSA id w26sm5751766pfn.33.2021.04.01.10.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 10:21:45 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 7/7] ext4: make prefetch_block_bitmaps default
Date:   Thu,  1 Apr 2021 10:21:29 -0700
Message-Id: <20210401172129.189766-8-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210401172129.189766-1-harshadshirwadkar@gmail.com>
References: <20210401172129.189766-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Block bitmap prefetching is needed for these allocator optimization
data structures to get populated and provide better group scanning
order. So, turn it on bu default. prefetch_block_bitmaps mount option
is now marked as removed and a new option no_prefetch_block_bitmaps is
added to disable block bitmap prefetching.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h  |  2 +-
 fs/ext4/super.c | 15 ++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9a5afe9d2310..20c757f711e7 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1227,7 +1227,7 @@ struct ext4_inode_info {
 #define EXT4_MOUNT_JOURNAL_CHECKSUM	0x800000 /* Journal checksums */
 #define EXT4_MOUNT_JOURNAL_ASYNC_COMMIT	0x1000000 /* Journal Async Commit */
 #define EXT4_MOUNT_WARN_ON_ERROR	0x2000000 /* Trigger WARN_ON on error */
-#define EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS 0x4000000
+#define EXT4_MOUNT_NO_PREFETCH_BLOCK_BITMAPS 0x4000000
 #define EXT4_MOUNT_DELALLOC		0x8000000 /* Delalloc support */
 #define EXT4_MOUNT_DATA_ERR_ABORT	0x10000000 /* Abort on file data write */
 #define EXT4_MOUNT_BLOCK_VALIDITY	0x20000000 /* Block validity checking */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6116640081c0..cec0fb07916b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1687,7 +1687,7 @@ enum {
 	Opt_dioread_nolock, Opt_dioread_lock,
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
-	Opt_prefetch_block_bitmaps, Opt_mb_optimize_scan,
+	Opt_no_prefetch_block_bitmaps, Opt_mb_optimize_scan,
 #ifdef CONFIG_EXT4_DEBUG
 	Opt_fc_debug_max_replay, Opt_fc_debug_force
 #endif
@@ -1787,7 +1787,8 @@ static const match_table_t tokens = {
 	{Opt_inlinecrypt, "inlinecrypt"},
 	{Opt_nombcache, "nombcache"},
 	{Opt_nombcache, "no_mbcache"},	/* for backward compatibility */
-	{Opt_prefetch_block_bitmaps, "prefetch_block_bitmaps"},
+	{Opt_removed, "prefetch_block_bitmaps"},
+	{Opt_no_prefetch_block_bitmaps, "no_prefetch_block_bitmaps"},
 	{Opt_mb_optimize_scan, "mb_optimize_scan=%d"},
 	{Opt_removed, "check=none"},	/* mount option from ext2/3 */
 	{Opt_removed, "nocheck"},	/* mount option from ext2/3 */
@@ -2009,7 +2010,7 @@ static const struct mount_opts {
 	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
 	{Opt_test_dummy_encryption, 0, MOPT_STRING},
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
-	{Opt_prefetch_block_bitmaps, EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS,
+	{Opt_no_prefetch_block_bitmaps, EXT4_MOUNT_NO_PREFETCH_BLOCK_BITMAPS,
 	 MOPT_SET},
 	{Opt_mb_optimize_scan, EXT4_MOUNT2_MB_OPTIMIZE_SCAN, MOPT_GTE0},
 #ifdef CONFIG_EXT4_DEBUG
@@ -3706,11 +3707,11 @@ static struct ext4_li_request *ext4_li_request_new(struct super_block *sb,
 
 	elr->lr_super = sb;
 	elr->lr_first_not_zeroed = start;
-	if (test_opt(sb, PREFETCH_BLOCK_BITMAPS))
-		elr->lr_mode = EXT4_LI_MODE_PREFETCH_BBITMAP;
-	else {
+	if (test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS)) {
 		elr->lr_mode = EXT4_LI_MODE_ITABLE;
 		elr->lr_next_group = start;
+	} else {
+		elr->lr_mode = EXT4_LI_MODE_PREFETCH_BBITMAP;
 	}
 
 	/*
@@ -3741,7 +3742,7 @@ int ext4_register_li_request(struct super_block *sb,
 		goto out;
 	}
 
-	if (!test_opt(sb, PREFETCH_BLOCK_BITMAPS) &&
+	if (test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS) &&
 	    (first_not_zeroed == ngroups || sb_rdonly(sb) ||
 	     !test_opt(sb, INIT_INODE_TABLE)))
 		goto out;
-- 
2.31.0.291.g576ba9dcdaf-goog

