Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D54488F10
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Jan 2022 04:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbiAJDwM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 9 Jan 2022 22:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238413AbiAJDwH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 9 Jan 2022 22:52:07 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B341EC06173F
        for <linux-ext4@vger.kernel.org>; Sun,  9 Jan 2022 19:52:07 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id z3so10800605plg.8
        for <linux-ext4@vger.kernel.org>; Sun, 09 Jan 2022 19:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7te4fBQgwRS2Iw5emYEKUEH67E4Lg1hDqrgyyrBzcMA=;
        b=3mRoslvnjf/54OKUc1rIZ35RScGfEtoKuqW6f94mpsSk42iDIA7elb2eqdvXqTqSDl
         gLx49Wwx7Gabq+toavSghkIvR5J/mE54PVtsWS1TuQptsB+VLF5u+ozv/VUlqZr7VbWv
         OpYT0Epaow/ZGvGIx6CX1pHpckBUhzQNnKyE9h/RFRW2XfxKAbo48DLzAwW8psl224tN
         PS96+e5mjXrGpnXYYwuQ9ncmzMtGhyOry9U1LAx3BawFZbzcyfQGQ7aT0JlTPZA/nkz3
         tCn6ZcuwfIOvXmv0Y5BtmhD9BYdswDWI49NJ01ylJyyRZHjeQU4MYpp6Xyhs6BdUNUnj
         szeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7te4fBQgwRS2Iw5emYEKUEH67E4Lg1hDqrgyyrBzcMA=;
        b=3FHhlAKca3QCMDKuTurs4j71jc8Ny87r17UVzze/OuL11/pt/EqxPzhsDe0aWHSD6S
         kheqwdZpQ6yUaI40KavKs20rMdZIVegAh1HQaWi86hwBUG9GcoLSH0CyriccEhujD1An
         S3uwMeBTmdzsnkcFS8LZMWE9/3rJVZtEjGLY34eMDkHBmhDLHCXgqlHQrIwOrVtZPvcH
         DuXZNk5zP6mrbZ8ncd5zUarabUq4lpC+/BDhaVqJqI80Eo/FXXBBhKuvNeVRQy2/J+KO
         oc4P/olINmcr5t97RrSB6iew3AJDOzIH/t4Uj+yCg5ugjzv2LA6oOYil/7HtRgvcF39N
         gzzw==
X-Gm-Message-State: AOAM530Tmuqo2CvfXSxhq+yqu9EwdmA8+NKqGs0AOI1JOoNdhGwm66Bd
        9aZKJwOgpZzDiU6l88dsliyVkA==
X-Google-Smtp-Source: ABdhPJxCme/Hhfy90yO06PBqyoQoQGTgOgxEY3e/rDP2CF2kz/hnaG2Mo1J9IBACQ6/mLdKaTcFCOA==
X-Received: by 2002:a17:90b:3e87:: with SMTP id rj7mr28312761pjb.88.1641786727295;
        Sun, 09 Jan 2022 19:52:07 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id h3sm6772748pjk.48.2022.01.09.19.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 19:52:07 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH v2 1/2] ext4: prevent used blocks from being allocated during fast commit replay
Date:   Mon, 10 Jan 2022 11:51:40 +0800
Message-Id: <20220110035141.1980-2-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220110035141.1980-1-yinxin.x@bytedance.com>
References: <20220110035141.1980-1-yinxin.x@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

during fast commit replay procedure, we clear inode blocks bitmap in
ext4_ext_clear_bb(), this may cause ext4_mb_new_blocks_simple() allocate
blocks still in use.

make ext4_fc_record_regions() also record physical disk regions used by
inodes during replay procedure. Then ext4_mb_new_blocks_simple() can
excludes these blocks in use.

Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
v2: add comments for behavior change of ext4_fc_record_regions().
---
 fs/ext4/ext4.h        |  2 ++
 fs/ext4/extents.c     |  4 ++++
 fs/ext4/fast_commit.c | 20 +++++++++++++++-----
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 82fa51d6f145..7b0686758691 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2932,6 +2932,8 @@ bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t block);
 void ext4_fc_replay_cleanup(struct super_block *sb);
 int ext4_fc_commit(journal_t *journal, tid_t commit_tid);
 int __init ext4_fc_init_dentry_cache(void);
+int ext4_fc_record_regions(struct super_block *sb, int ino,
+		     ext4_lblk_t lblk, ext4_fsblk_t pblk, int len, int replay);
 
 /* mballoc.c */
 extern const struct seq_operations ext4_mb_seq_groups_ops;
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c3e76a5de661..9b6c76629c93 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -6096,11 +6096,15 @@ int ext4_ext_clear_bb(struct inode *inode)
 
 					ext4_mb_mark_bb(inode->i_sb,
 							path[j].p_block, 1, 0);
+					ext4_fc_record_regions(inode->i_sb, inode->i_ino,
+							0, path[j].p_block, 1, 1);
 				}
 				ext4_ext_drop_refs(path);
 				kfree(path);
 			}
 			ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
+			ext4_fc_record_regions(inode->i_sb, inode->i_ino,
+					map.m_lblk, map.m_pblk, map.m_len, 1);
 		}
 		cur = cur + map.m_len;
 	}
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 23d13983a281..0812438d10cc 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1564,16 +1564,23 @@ static int ext4_fc_replay_create(struct super_block *sb, struct ext4_fc_tl *tl,
 }
 
 /*
- * Record physical disk regions which are in use as per fast commit area. Our
- * simple replay phase allocator excludes these regions from allocation.
+ * Record physical disk regions which are in use as per fast commit area,
+ * and used by inodes during replay phase. Our simple replay phase
+ * allocator excludes these regions from allocation.
  */
-static int ext4_fc_record_regions(struct super_block *sb, int ino,
-		ext4_lblk_t lblk, ext4_fsblk_t pblk, int len)
+int ext4_fc_record_regions(struct super_block *sb, int ino,
+		ext4_lblk_t lblk, ext4_fsblk_t pblk, int len, int replay)
 {
 	struct ext4_fc_replay_state *state;
 	struct ext4_fc_alloc_region *region;
 
 	state = &EXT4_SB(sb)->s_fc_replay_state;
+	/*
+	 * during replay phase, the fc_regions_valid may not same as
+	 * fc_regions_used, update it when do new additions.
+	 */
+	if (replay && state->fc_regions_used != state->fc_regions_valid)
+		state->fc_regions_used = state->fc_regions_valid;
 	if (state->fc_regions_used == state->fc_regions_size) {
 		state->fc_regions_size +=
 			EXT4_FC_REPLAY_REALLOC_INCREMENT;
@@ -1591,6 +1598,9 @@ static int ext4_fc_record_regions(struct super_block *sb, int ino,
 	region->pblk = pblk;
 	region->len = len;
 
+	if (replay)
+		state->fc_regions_valid++;
+
 	return 0;
 }
 
@@ -1938,7 +1948,7 @@ static int ext4_fc_replay_scan(journal_t *journal,
 			ret = ext4_fc_record_regions(sb,
 				le32_to_cpu(ext.fc_ino),
 				le32_to_cpu(ex->ee_block), ext4_ext_pblock(ex),
-				ext4_ext_get_actual_len(ex));
+				ext4_ext_get_actual_len(ex), 0);
 			if (ret < 0)
 				break;
 			ret = JBD2_FC_REPLAY_CONTINUE;
-- 
2.20.1

