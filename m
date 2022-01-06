Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CCD485EEA
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jan 2022 03:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344964AbiAFCpq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jan 2022 21:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344936AbiAFCpn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jan 2022 21:45:43 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436F0C061201
        for <linux-ext4@vger.kernel.org>; Wed,  5 Jan 2022 18:45:43 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id j16so1495633pll.10
        for <linux-ext4@vger.kernel.org>; Wed, 05 Jan 2022 18:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mr4s4nuuaCvYTCilFynb0p++Jy6qt5NsbzJkkeE6Tok=;
        b=M4TAkqJVQ9rDDfSXIEgYs/IT84za+xvc43NVzidRcWVDZKI6wsVv6lacZmG2ifuBAE
         EykRtEwmsJ5rdUfmQ2Flvz1K6k/58tOF78Hd7OVp77QDixo1TQqzmmIvJEQ7TN3SXCJz
         ZRz5dIdoIjhWR8TnGcWRGBG6MrYgZ3m95s9vRHeLFbeDJgv2zjiZ4N3AfBR2gS+uNugm
         cAIFCiCPFxZOoUGwER5r9NCpbq6mB6gdeLzcDAbsYvFK9IAhfNr9DgJ/eXEBnw1249oY
         KiqqsHi9q6WcOezgTlDIlaBkN/4+kqIldfZtnLUHmho3QI75V2gxKeoOgsH7Xy32doKC
         faTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mr4s4nuuaCvYTCilFynb0p++Jy6qt5NsbzJkkeE6Tok=;
        b=4NROk2VP+j+mzoRmbGEISVSM0ZCbu6Bhhdun5riS7v6fl8CJVTCybH1d0Vg+8II/up
         ZzQi5hQwqU9QLllppo/TknI2Ss6PUA731pUE1OGS0YKXQYVaUl9ITjsqV0Aptg2pTQkL
         4OUIzDHtpeswEsnRIdntx9CDYOn7xA+DeX/Z7cohLllxzEro6/0aS3kTVkpCpKFpEKOs
         y1XeF7nnwOOJ9QNr9S274wkIXIgeNX67LI/Lgsj78cF0cjRMUGfa8nVgAym92WDBJ5Rp
         9KfjW434p0lrlwl06St+25hbxw2sfAEScMk9IK7tJ0FNXfdWlknQaiQGe3I6whnTaEbr
         S3AQ==
X-Gm-Message-State: AOAM531QRU8cWz6q6pOqy5k36zgC5466b5ebA8PpgoGkw3e4r8zSMuqX
        Qwf7IVF3iP/PpEzQIXRooph8f6A9OSX+Jw==
X-Google-Smtp-Source: ABdhPJx34uGjbIZlUgC88uc5Ej7PFAD+EtASR7A6Sjy4wMXo+eQZ+yW4KKAPqEepMsxRxIp7pNdsPQ==
X-Received: by 2002:a17:90b:4f4a:: with SMTP id pj10mr7561838pjb.112.1641437142813;
        Wed, 05 Jan 2022 18:45:42 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id p12sm414244pfo.95.2022.01.05.18.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 18:45:42 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH 1/2] ext4: prevent used blocks from being allocated during fast commit replay
Date:   Thu,  6 Jan 2022 10:45:17 +0800
Message-Id: <20220106024518.8161-2-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220106024518.8161-1-yinxin.x@bytedance.com>
References: <20220106024518.8161-1-yinxin.x@bytedance.com>
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
 fs/ext4/ext4.h        |  2 ++
 fs/ext4/extents.c     |  4 ++++
 fs/ext4/fast_commit.c | 11 ++++++++---
 3 files changed, 14 insertions(+), 3 deletions(-)

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
index 23d13983a281..f0cd20f5fe5e 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1567,13 +1567,15 @@ static int ext4_fc_replay_create(struct super_block *sb, struct ext4_fc_tl *tl,
  * Record physical disk regions which are in use as per fast commit area. Our
  * simple replay phase allocator excludes these regions from allocation.
  */
-static int ext4_fc_record_regions(struct super_block *sb, int ino,
-		ext4_lblk_t lblk, ext4_fsblk_t pblk, int len)
+int ext4_fc_record_regions(struct super_block *sb, int ino,
+		ext4_lblk_t lblk, ext4_fsblk_t pblk, int len, int replay)
 {
 	struct ext4_fc_replay_state *state;
 	struct ext4_fc_alloc_region *region;
 
 	state = &EXT4_SB(sb)->s_fc_replay_state;
+	if (replay && state->fc_regions_used != state->fc_regions_valid)
+		state->fc_regions_used = state->fc_regions_valid;
 	if (state->fc_regions_used == state->fc_regions_size) {
 		state->fc_regions_size +=
 			EXT4_FC_REPLAY_REALLOC_INCREMENT;
@@ -1591,6 +1593,9 @@ static int ext4_fc_record_regions(struct super_block *sb, int ino,
 	region->pblk = pblk;
 	region->len = len;
 
+	if (replay)
+		state->fc_regions_valid++;
+
 	return 0;
 }
 
@@ -1938,7 +1943,7 @@ static int ext4_fc_replay_scan(journal_t *journal,
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

