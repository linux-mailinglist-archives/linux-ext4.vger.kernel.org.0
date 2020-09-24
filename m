Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438E82766AA
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Sep 2020 05:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgIXDDu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Sep 2020 23:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgIXDDt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Sep 2020 23:03:49 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3777DC0613CE
        for <linux-ext4@vger.kernel.org>; Wed, 23 Sep 2020 20:03:49 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y17so874671plb.6
        for <linux-ext4@vger.kernel.org>; Wed, 23 Sep 2020 20:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3hZsytmlQaX9NGZF9BpwiV8ktJMeRFpFu2EsLmiO5AI=;
        b=Zoidp/0YoUROCTF/Vsl1hd7LoJ2bYvHJ7xpyzMeVHnfVrj3uvP/gP8T0dFGtJ7lfkv
         MT9zVBEz+ZOptuLdgkUqXTwc5MTXRfynhNlr1KYBr5erUixybg3AynVK6bVtKWD4Ak+y
         IY6o68LSz9d0F56GqpJT5acDXsVGxefUmlvMMSS+GDm/ulKEDUYE7+DtFem848AtLLH7
         5AMyzdnfIx1mZnAsC7B2+34JWSZWPlX2dmG3Vi+VqgTTxYbvnTCCzAzUvS78XcplqtJo
         wRAHRbLeSuE8hSZ+t5xrvfDcYKEOASigx89BhVyVWfTmstA1Ogo5StVYEEc007yEkjUO
         XQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3hZsytmlQaX9NGZF9BpwiV8ktJMeRFpFu2EsLmiO5AI=;
        b=OIZtDg/irkb3hedZ5Q8WO3kThqpXtZRBMBPfl/u/OiQI+BMj9LjIO2xU716F7V2niD
         QahgCnaHbu9++4wUsMmTSira0/YV/efcc/Y8fTJsSjUKXu8IfT/P5Zce3nqy/71LTezb
         PCluB36S6uB/9CbhqSRcn8sVLiwcPzzv0ruiC0OEVZ4ixI28Ux1eBNCCSww2IpZHGzVv
         8I+r4jvP8zvUBaC96WKaCp69A4sNXrTtNiEUA1KGV2p9iJbbBiqguok2S//n4PX5KHiB
         R5Shn6dkQ36V5GZzZNCPPEaPD3vuB1T/QZbVQhpAeMJbEWLWXlgNhSsUcMA7sLG1Dzrh
         RjFg==
X-Gm-Message-State: AOAM530oD6smW+ef++PRHeNY1YF4TU5nN6dCBeq2zgZ4mBCpd8fsipJN
        hs+EZ/KCvxN1rzqscW9YGRs=
X-Google-Smtp-Source: ABdhPJySXeiBUg2nfiXlpaDY/q/aGpxOQTCe9nUvVUtyL1sgO4ovBOLvq4gzMK4sQkfu3RoEXcRsjg==
X-Received: by 2002:a17:902:7144:b029:d1:e5e7:be22 with SMTP id u4-20020a1709027144b02900d1e5e7be22mr2484772plm.85.1600916628486;
        Wed, 23 Sep 2020 20:03:48 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id 3sm979525pgw.44.2020.09.23.20.03.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 20:03:48 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     adilger@dilger.ca, linux-ext4@vger.kernel.org
Subject: [PATCH v2 RESEND 2/2] ext4: rename system_blks to s_system_blks inside ext4_sb_info
Date:   Thu, 24 Sep 2020 11:03:43 +0800
Message-Id: <1600916623-544-2-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1600916623-544-1-git-send-email-brookxu@tencent.com>
References: <1600916623-544-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Rename system_blks to s_system_blks inside ext4_sb_info, keep
the naming rules consistent with other variables, which is
convenient for code reading and writing.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/block_validity.c | 14 +++++++-------
 fs/ext4/ext4.h           |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 16e9b2f..69240b4 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -138,7 +138,7 @@ static void debug_print_tree(struct ext4_sb_info *sbi)
 
 	printk(KERN_INFO "System zones: ");
 	rcu_read_lock();
-	system_blks = rcu_dereference(sbi->system_blks);
+	system_blks = rcu_dereference(sbi->s_system_blks);
 	node = rb_first(&system_blks->root);
 	while (node) {
 		entry = rb_entry(node, struct ext4_system_zone, node);
@@ -263,11 +263,11 @@ int ext4_setup_system_zone(struct super_block *sb)
 	int ret;
 
 	if (!test_opt(sb, BLOCK_VALIDITY)) {
-		if (sbi->system_blks)
+		if (sbi->s_system_blks)
 			ext4_release_system_zone(sb);
 		return 0;
 	}
-	if (sbi->system_blks)
+	if (sbi->s_system_blks)
 		return 0;
 
 	system_blks = kzalloc(sizeof(*system_blks), GFP_KERNEL);
@@ -308,7 +308,7 @@ int ext4_setup_system_zone(struct super_block *sb)
 	 * with ext4_data_block_valid() accessing the rbtree at the same
 	 * time.
 	 */
-	rcu_assign_pointer(sbi->system_blks, system_blks);
+	rcu_assign_pointer(sbi->s_system_blks, system_blks);
 
 	if (test_opt(sb, DEBUG))
 		debug_print_tree(sbi);
@@ -333,9 +333,9 @@ void ext4_release_system_zone(struct super_block *sb)
 {
 	struct ext4_system_blocks *system_blks;
 
-	system_blks = rcu_dereference_protected(EXT4_SB(sb)->system_blks,
+	system_blks = rcu_dereference_protected(EXT4_SB(sb)->s_system_blks,
 					lockdep_is_held(&sb->s_umount));
-	rcu_assign_pointer(EXT4_SB(sb)->system_blks, NULL);
+	rcu_assign_pointer(EXT4_SB(sb)->s_system_blks, NULL);
 
 	if (system_blks)
 		call_rcu(&system_blks->rcu, ext4_destroy_system_zone);
@@ -353,7 +353,7 @@ int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
 	 * mount option.
 	 */
 	rcu_read_lock();
-	system_blks = rcu_dereference(sbi->system_blks);
+	system_blks = rcu_dereference(sbi->s_system_blks);
 	ret = ext4_data_block_valid_rcu(sbi, system_blks, start_blk,
 					count);
 	rcu_read_unlock();
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 8ca9adf..d60a462 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1470,7 +1470,7 @@ struct ext4_sb_info {
 	int s_jquota_fmt;			/* Format of quota to use */
 #endif
 	unsigned int s_want_extra_isize; /* New inodes should reserve # bytes */
-	struct ext4_system_blocks __rcu *system_blks;
+	struct ext4_system_blocks __rcu *s_system_blks;
 
 #ifdef EXTENTS_STATS
 	/* ext4 extents stats */
-- 
1.8.3.1

