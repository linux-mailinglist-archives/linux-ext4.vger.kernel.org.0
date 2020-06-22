Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1672038E8
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jun 2020 16:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgFVORM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Jun 2020 10:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728328AbgFVORL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Jun 2020 10:17:11 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78E9C061573
        for <linux-ext4@vger.kernel.org>; Mon, 22 Jun 2020 07:17:11 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id b5so8200496pgm.8
        for <linux-ext4@vger.kernel.org>; Mon, 22 Jun 2020 07:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S5nvfnVVW3icFlX7ze3NlAy4/LTMUqs0sSK3iwANFEw=;
        b=CzirAu6QnnOd88c/cZrQ5xYmxM1chEavirRDGcBkPmqgyT8od/lrKrGO4aKVGh3hax
         yycsquRECDR5xGPScYiIbT/ejnmSAblkU6CFVjHvJNin5yAJZ66KOgWN5m8IxgIXejwn
         Iy5ejANxZM7LlUdO7H88LfqChXEtVeli6oKVtNc9UYBnAJ6BPz6lYiofuzEuoLVhPvFU
         8HPkbyWv1bn7PLVJIs2UnFvn1NMCjB3qWjoaIejDSlBDQyLG5U6z3K56AP2DS9I+dNrK
         377RsrtVQbW4NWtF8E9vtLNG8Ff7d8eyWjilLMBIU6Z54DDI8R/X8Ux66wxiOClXf5Tl
         u4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S5nvfnVVW3icFlX7ze3NlAy4/LTMUqs0sSK3iwANFEw=;
        b=GpCQg3vWntf14VDO/cVAw1dRB3GjaRn7Is10A5obncfojPiy3ybIAl+zLqLDH3E5SY
         BVX6/VuIEjyv+T/+SxlufQHhQMBpbgi8U0SysbgBxpMT6aOFkBnWovmxwgVR/pclfnVs
         fNwEbkzqYCK45y7kUoA8mjcfYvF8DiCQu9ERrdcDynThgV40AF5J/r1yswgqB0IZAasE
         tIOhH5sTfHz5HCKHiudkNVUQKgAu55MmRKftqA/ALiS+472JjcFobVKfaxVK3m2+FhEc
         QYJGRrvRNWKMzyEV1U444AE1FCriD6MWE9PCfqSdR9mGvQfPu/SBQVofYC1ssEYDfsGo
         3wXg==
X-Gm-Message-State: AOAM531PCxu4PPBDKQAl/shw7CCxXmXWH2vxm9QQp/0GlLwuLJ9mQmmh
        TmR9PymAlSEoE4hXmkqahg95ia4XFLk=
X-Google-Smtp-Source: ABdhPJwk4K2lrIz6ofuDjcKKsKc7lZblmO8sfekCU3mlvmMLzZcvQKiAZV/nlgnQSBUGwwiHV1qvsw==
X-Received: by 2002:aa7:9acc:: with SMTP id x12mr20505176pfp.24.1592835430759;
        Mon, 22 Jun 2020 07:17:10 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id v8sm13778933pfn.217.2020.06.22.07.17.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 07:17:09 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Wang Shilong <wshilong@ddn.com>, Shuichi Ihara <sihara@ddn.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Wang Shilong <wangshilong1991@gmail.com>
Subject: [PATCH v2 2/2] ext4: avoid trimming block group if only few blocks freed
Date:   Mon, 22 Jun 2020 23:16:59 +0900
Message-Id: <1592835419-7841-1-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592831677-13945-2-git-send-email-wangshilong1991@gmail.com>
References: <1592831677-13945-2-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Now WAS_TRIMMED flag will be cleared if there are any blocks
freed in this block group, this might be not good idea if there
are only few blocks freed, since most of freed blocks have been
issued discard before.

So this patch tries to introduce another counter which record
how many blocks freed since last time trimmed, WAS_TRIMMED flag
will be only cleared if there are enough free blocks(default 128).

Also expose a new sys interface min_freed_blocks_to_trim to tune
default behavior.

Cc: Shuichi Ihara <sihara@ddn.com>
Cc: Andreas Dilger <adilger@dilger.ca>
Cc: Wang Shilong <wangshilong1991@gmail.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
changelog v1->v2:
init bb_freed_last_trimmed to be zero during setup
---
 fs/ext4/ext4.h    |  7 +++++++
 fs/ext4/mballoc.c | 18 ++++++++++++++++--
 fs/ext4/sysfs.c   |  2 ++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 252754da2f1b..2da86d1ebe3f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1240,6 +1240,9 @@ extern void ext4_set_bits(void *bm, int cur, int len);
 /* Metadata checksum algorithm codes */
 #define EXT4_CRC32C_CHKSUM		1
 
+/* Default min freed blocks which we could clear TRIMMED flags */
+#define DEFAULT_MIN_FREED_BLOCKS_TO_TRIM	128
+
 /*
  * Structure of the super block
  */
@@ -1533,6 +1536,9 @@ struct ext4_sb_info {
 	/* the size of zero-out chunk */
 	unsigned int s_extent_max_zeroout_kb;
 
+	/* Min freed blocks per group that we could run trim on it*/
+	unsigned long s_min_freed_blocks_to_trim;
+
 	unsigned int s_log_groups_per_flex;
 	struct flex_groups * __rcu *s_flex_groups;
 	ext4_group_t s_flex_groups_allocated;
@@ -3125,6 +3131,7 @@ struct ext4_group_info {
 	struct rb_root  bb_free_root;
 	ext4_grpblk_t	bb_first_free;	/* first free block */
 	ext4_grpblk_t	bb_free;	/* total free blocks */
+	ext4_grpblk_t	bb_freed_last_trimmed; /* total free blocks since last trimmed*/
 	ext4_grpblk_t	bb_fragments;	/* nr of freespace fragments */
 	ext4_grpblk_t	bb_largest_free_order;/* order of largest frag in BG */
 	struct          list_head bb_prealloc_list;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 235a316584d0..52ab9ac5be86 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2558,6 +2558,7 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
 	init_rwsem(&meta_group_info[i]->alloc_sem);
 	meta_group_info[i]->bb_free_root = RB_ROOT;
 	meta_group_info[i]->bb_largest_free_order = -1;  /* uninit */
+	meta_group_info[i]->bb_freed_last_trimmed = 0;
 
 	mb_group_bb_bitmap_alloc(sb, meta_group_info[i], group);
 	return 0;
@@ -2763,6 +2764,8 @@ int ext4_mb_init(struct super_block *sb)
 			sbi->s_mb_group_prealloc, sbi->s_stripe);
 	}
 
+	sbi->s_min_freed_blocks_to_trim = DEFAULT_MIN_FREED_BLOCKS_TO_TRIM;
+
 	sbi->s_locality_groups = alloc_percpu(struct ext4_locality_group);
 	if (sbi->s_locality_groups == NULL) {
 		ret = -ENOMEM;
@@ -5091,8 +5094,18 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 	 * If the volume is mounted with -o discard, online discard
 	 * is supported and the free blocks will be trimmed online.
 	 */
-	if (!test_opt(sb, DISCARD))
-		EXT4_MB_GDP_CLEAR_TRIMMED(gdp);
+	if (!test_opt(sb, DISCARD)) {
+		e4b.bd_info->bb_freed_last_trimmed += count;
+		/*
+		 * Only clear the WAS_TRIMMED flag if there are
+		 * several blocks freed, or if the group becomes
+		 * totally 'empty'(free < num_itable_blocks + 2).
+		 */
+		if (e4b.bd_info->bb_freed_last_trimmed >=
+		    sbi->s_min_freed_blocks_to_trim ||
+		    e4b.bd_info->bb_free < (sbi->s_itb_per_group + 2))
+			EXT4_MB_GDP_CLEAR_TRIMMED(gdp);
+	}
 	ext4_group_desc_csum_set(sb, block_group, gdp);
 	ext4_unlock_group(sb, block_group);
 
@@ -5425,6 +5438,7 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 		}
 		ext4_lock_group(sb, group);
 		EXT4_MB_GDP_SET_TRIMMED(gdp);
+		e4b.bd_info->bb_freed_last_trimmed = 0;
 		ext4_group_desc_csum_set(sb, group, gdp);
 		ext4_unlock_group(sb, group);
 		err = ext4_handle_dirty_metadata(handle, NULL, gdp_bh);
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 6c9fc9e21c13..8ee4e7e3f125 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -216,6 +216,7 @@ EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
 EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
 EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
 EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
+EXT4_RW_ATTR_SBI_UI(min_freed_blocks_to_trim, s_min_freed_blocks_to_trim);
 EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
 EXT4_RW_ATTR_SBI_UI(err_ratelimit_interval_ms, s_err_ratelimit_state.interval);
 EXT4_RW_ATTR_SBI_UI(err_ratelimit_burst, s_err_ratelimit_state.burst);
@@ -259,6 +260,7 @@ static struct attribute *ext4_attrs[] = {
 	ATTR_LIST(mb_group_prealloc),
 	ATTR_LIST(max_writeback_mb_bump),
 	ATTR_LIST(extent_max_zeroout_kb),
+	ATTR_LIST(min_freed_blocks_to_trim),
 	ATTR_LIST(trigger_fs_error),
 	ATTR_LIST(err_ratelimit_interval_ms),
 	ATTR_LIST(err_ratelimit_burst),
-- 
2.25.4

