Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B494479EC10
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Sep 2023 17:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbjIMPFM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Sep 2023 11:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjIMPFL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Sep 2023 11:05:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0237C1
        for <linux-ext4@vger.kernel.org>; Wed, 13 Sep 2023 08:05:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7BC041F385;
        Wed, 13 Sep 2023 15:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694617505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GwLIS2G1YAxJjV8hOVKZNXogc2hFp6dFP8S9Axv1vsg=;
        b=1Rb40n3P/7XLve8PPgMToy1WpuNpXktZ+sz8PXg/kZUv8zrU7knXLQPwjBv7+9/w7fmbcB
        tC7ZhykivrMaMcht0aLqGZ4oiwhKp/Okce5TxoRxyWPfdMSXFHZrcDoIa3r2WzFQe67UYJ
        3P/bvTcXdaoqAhgiLcQCHr0lxZx6nsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694617505;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GwLIS2G1YAxJjV8hOVKZNXogc2hFp6dFP8S9Axv1vsg=;
        b=OYSgWfl4pch2XTK+mPGqacYdbdWeM905vPdbe32VyZhQGz5K/GVg6jU13rZJZIyOBUiFA4
        gcw6LbLGxH/clpBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C32713A34;
        Wed, 13 Sep 2023 15:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AD1mGqHPAWUIdQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 13 Sep 2023 15:05:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DE608A07C3; Wed, 13 Sep 2023 17:05:04 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, todd.e.brandt@intel.com,
        lenb@kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] ext4: Move setting of trimmed bit into ext4_try_to_trim_range()
Date:   Wed, 13 Sep 2023 17:04:54 +0200
Message-Id: <20230913150504.9054-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230913145649.3595-1-jack@suse.cz>
References: <20230913145649.3595-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5356; i=jack@suse.cz; h=from:subject; bh=LUYm7Zew/b2aDDTAylta/pxzaocIY3BpxyPd1C1D960=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlAc+V0Bl5QmYh0cQe7PSvZHRV6w+5t/8j9LwfynoN yxbSvXOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZQHPlQAKCRCcnaoHP2RA2ZRUCA DDDmbKMGwGnv/K6AwijDR+iUh1pgXPWruiWtnhH8IRQS/SJuyhCV24A2no+/KCB/fYYsjj+ouIA3pN n5uE5BeCIFm45xmg/j1Z+8tCAof5Ew5+q3uChCIZUWptGJwYke6RTJ1R3wdTHaZvHAZJ2hKzJhRart n0ETOGacx71+bugwh/MGYCr6sgJWrK2KVUKRgcgXKYNRPmc7oAGVZddnmMepIpYlzrfvOnCdnDRhW4 KzTjTWdxmE6Qn/puJ+NzVxG+seBJSk09IibPcsBQqxUn4tk15ICmmUcpmANRqTwsSs7q+TiPdr6T+k I7Yg6P82Vq5nlfH23tZyHykgF/AeDz
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently we set the group's trimmed bit in ext4_trim_all_free() based
on return value of ext4_try_to_trim_range(). However when we will want
to abort trimming because of suspend attempt, we want to return success
from ext4_try_to_trim_range() but not set the trimmed bit. Instead
implementing awkward propagation of this information, just move setting
of trimmed bit into ext4_try_to_trim_range() when the whole group is
trimmed.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c91db9f57524..09091adfde64 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6906,6 +6906,16 @@ __acquires(bitlock)
 	return ret;
 }
 
+static ext4_grpblk_t ext4_last_grp_cluster(struct super_block *sb,
+					   ext4_group_t grp)
+{
+	if (grp < ext4_get_groups_count(sb))
+		return EXT4_CLUSTERS_PER_GROUP(sb) - 1;
+	return (ext4_blocks_count(EXT4_SB(sb)->s_es) -
+		ext4_group_first_block_no(sb, grp) - 1) >>
+					EXT4_CLUSTER_BITS(sb);
+}
+
 static int ext4_try_to_trim_range(struct super_block *sb,
 		struct ext4_buddy *e4b, ext4_grpblk_t start,
 		ext4_grpblk_t max, ext4_grpblk_t minblocks)
@@ -6913,9 +6923,12 @@ __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
 __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 {
 	ext4_grpblk_t next, count, free_count;
+	bool set_trimmed = false;
 	void *bitmap;
 
 	bitmap = e4b->bd_bitmap;
+	if (start == 0 && max >= ext4_last_grp_cluster(sb, e4b->bd_group))
+		set_trimmed = true;
 	start = max(e4b->bd_info->bb_first_free, start);
 	count = 0;
 	free_count = 0;
@@ -6930,16 +6943,14 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 			int ret = ext4_trim_extent(sb, start, next - start, e4b);
 
 			if (ret && ret != -EOPNOTSUPP)
-				break;
+				return count;
 			count += next - start;
 		}
 		free_count += next - start;
 		start = next + 1;
 
-		if (fatal_signal_pending(current)) {
-			count = -ERESTARTSYS;
-			break;
-		}
+		if (fatal_signal_pending(current))
+			return -ERESTARTSYS;
 
 		if (need_resched()) {
 			ext4_unlock_group(sb, e4b->bd_group);
@@ -6951,6 +6962,9 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 			break;
 	}
 
+	if (set_trimmed)
+		EXT4_MB_GRP_SET_TRIMMED(e4b->bd_info);
+
 	return count;
 }
 
@@ -6961,7 +6975,6 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
  * @start:		first group block to examine
  * @max:		last group block to examine
  * @minblocks:		minimum extent block count
- * @set_trimmed:	set the trimmed flag if at least one block is trimmed
  *
  * ext4_trim_all_free walks through group's block bitmap searching for free
  * extents. When the free extent is found, mark it as used in group buddy
@@ -6971,7 +6984,7 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 static ext4_grpblk_t
 ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 		   ext4_grpblk_t start, ext4_grpblk_t max,
-		   ext4_grpblk_t minblocks, bool set_trimmed)
+		   ext4_grpblk_t minblocks)
 {
 	struct ext4_buddy e4b;
 	int ret;
@@ -6988,13 +7001,10 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 	ext4_lock_group(sb, group);
 
 	if (!EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) ||
-	    minblocks < EXT4_SB(sb)->s_last_trim_minblks) {
+	    minblocks < EXT4_SB(sb)->s_last_trim_minblks)
 		ret = ext4_try_to_trim_range(sb, &e4b, start, max, minblocks);
-		if (ret >= 0 && set_trimmed)
-			EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
-	} else {
+	else
 		ret = 0;
-	}
 
 	ext4_unlock_group(sb, group);
 	ext4_mb_unload_buddy(&e4b);
@@ -7027,7 +7037,6 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 	ext4_fsblk_t first_data_blk =
 			le32_to_cpu(EXT4_SB(sb)->s_es->s_first_data_block);
 	ext4_fsblk_t max_blks = ext4_blocks_count(EXT4_SB(sb)->s_es);
-	bool whole_group, eof = false;
 	int ret = 0;
 
 	start = range->start >> sb->s_blocksize_bits;
@@ -7046,10 +7055,8 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 		if (minlen > EXT4_CLUSTERS_PER_GROUP(sb))
 			goto out;
 	}
-	if (end >= max_blks - 1) {
+	if (end >= max_blks - 1)
 		end = max_blks - 1;
-		eof = true;
-	}
 	if (end <= first_data_blk)
 		goto out;
 	if (start < first_data_blk)
@@ -7063,7 +7070,6 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 
 	/* end now represents the last cluster to discard in this group */
 	end = EXT4_CLUSTERS_PER_GROUP(sb) - 1;
-	whole_group = true;
 
 	for (group = first_group; group <= last_group; group++) {
 		grp = ext4_get_group_info(sb, group);
@@ -7082,13 +7088,11 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 		 * change it for the last group, note that last_cluster is
 		 * already computed earlier by ext4_get_group_no_and_offset()
 		 */
-		if (group == last_group) {
+		if (group == last_group)
 			end = last_cluster;
-			whole_group = eof ? true : end == EXT4_CLUSTERS_PER_GROUP(sb) - 1;
-		}
 		if (grp->bb_free >= minlen) {
 			cnt = ext4_trim_all_free(sb, group, first_cluster,
-						 end, minlen, whole_group);
+						 end, minlen);
 			if (cnt < 0) {
 				ret = cnt;
 				break;
-- 
2.35.3

