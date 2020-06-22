Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522642037A4
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jun 2020 15:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgFVNOz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Jun 2020 09:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgFVNOy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Jun 2020 09:14:54 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93287C061573
        for <linux-ext4@vger.kernel.org>; Mon, 22 Jun 2020 06:14:54 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x207so8400914pfc.5
        for <linux-ext4@vger.kernel.org>; Mon, 22 Jun 2020 06:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A8MjK80hHPbdpWiCN4eDD1WmKAq1ju8wZ3baFdZW/kw=;
        b=uMCCCktMPDM+N1tOLRfAif9fHH/4RwksZEsY+/2K2QoGvhRNoirVUkS3LTydcnMf1b
         mAnxeYYmhnI0ItZ071KTSPcXmXaEYt5ACnWlv+seYDqDpRRrvfk0kmJeDELzulFURlvs
         NiAa5faC75uiM54tjQWfp18INx2fVTkBAhM5cLs/79rmq9BTptgMuHsaFmhks2yMFLmQ
         9UfGvuG5+VLAFIwcuGwQllq+xcPq3dc1BJfy9E5TVkbWwhvTy0rSGBOLz0wNow2O6N73
         lqqPxY/+TrwHlR4x6vH0YMZ0kH5tvO3VVdjrKX0ZFd41uQbR4ehbk1m43MC/xYdHR3MW
         0X0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A8MjK80hHPbdpWiCN4eDD1WmKAq1ju8wZ3baFdZW/kw=;
        b=bay6MrjGC7rwaZax+9W9gdb0+pqwbazhZzJawpBbX/+vqKhINFDOyqR5VHcORe2xYU
         Zc0x7XIpcmsEQSjOmmC1HuRmcc48RXkmDLkRB1dYL1hIMOksQAuRbhPzYrPPyA+PFcX/
         VbUT3fh1Nf8BGiyjYUEP/SCkOEDKRigTugfv26NrrEWEeKgX19CXT1e5ur9BPkJLbEja
         T8JL/TpYOTMUqQzZKdoHpPGxoGlxpJJkbm1Bxg5KDGjBTmdZnSEe7XzAy8nHOFaKXlpa
         5x/TzrBUb3loBtw9gInym+vfY2nM24E1iuVIJOulgwuDfOa5kWGy2VXnyTfI1WYbbfx6
         M2UA==
X-Gm-Message-State: AOAM533AJzlNjD8joMVpmhZGHV1PV+KU97spmKrWv/ZdSBXSKi/amxPJ
        9UK69fBFwPKcn6ejiNBPAT29UnrNF+Q=
X-Google-Smtp-Source: ABdhPJzN+n0ypps39wwD4wrRNEQbIUeqRentLddm3MB3lZHelQH0sE+9JLGvFNTw9mwmI3oY4UtPMA==
X-Received: by 2002:a62:1ac7:: with SMTP id a190mr19925991pfa.194.1592831693800;
        Mon, 22 Jun 2020 06:14:53 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id v62sm2652291pfb.119.2020.06.22.06.14.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 06:14:53 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Wang Shilong <wshilong@ddn.com>, Shuichi Ihara <sihara@ddn.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Wang Shilong <wangshilong1991@gmail.com>
Subject: [PATCH 2/2] ext4: avoid trimming block group if only few blocks freed
Date:   Mon, 22 Jun 2020 22:14:37 +0900
Message-Id: <1592831677-13945-2-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592831677-13945-1-git-send-email-wangshilong1991@gmail.com>
References: <1592831677-13945-1-git-send-email-wangshilong1991@gmail.com>
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
 fs/ext4/ext4.h    |  7 +++++++
 fs/ext4/mballoc.c | 17 +++++++++++++++--
 fs/ext4/sysfs.c   |  2 ++
 3 files changed, 24 insertions(+), 2 deletions(-)

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
index 235a316584d0..d33ee1781b2c 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2763,6 +2763,8 @@ int ext4_mb_init(struct super_block *sb)
 			sbi->s_mb_group_prealloc, sbi->s_stripe);
 	}
 
+	sbi->s_min_freed_blocks_to_trim = DEFAULT_MIN_FREED_BLOCKS_TO_TRIM;
+
 	sbi->s_locality_groups = alloc_percpu(struct ext4_locality_group);
 	if (sbi->s_locality_groups == NULL) {
 		ret = -ENOMEM;
@@ -5091,8 +5093,18 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
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
 
@@ -5425,6 +5437,7 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
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

