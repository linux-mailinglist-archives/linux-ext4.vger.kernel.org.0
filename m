Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AE6504890
	for <lists+linux-ext4@lfdr.de>; Sun, 17 Apr 2022 19:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbiDQROk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 17 Apr 2022 13:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiDQROj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 17 Apr 2022 13:14:39 -0400
X-Greylist: delayed 436 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 17 Apr 2022 10:12:02 PDT
Received: from forward300j.mail.yandex.net (forward300j.mail.yandex.net [5.45.198.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304A2646C
        for <linux-ext4@vger.kernel.org>; Sun, 17 Apr 2022 10:12:02 -0700 (PDT)
Received: from sas1-ad1836f4152f.qloud-c.yandex.net (sas1-ad1836f4152f.qloud-c.yandex.net [IPv6:2a02:6b8:c08:793:0:640:ad18:36f4])
        by forward300j.mail.yandex.net (Yandex) with ESMTP id D44377E7132;
        Sun, 17 Apr 2022 20:03:18 +0300 (MSK)
Received: from kernel1.search.yandex.net (kernel1.search.yandex.net [2a02:6b8:c02:550:0:604:9094:6282])
        by sas1-ad1836f4152f.qloud-c.yandex.net (yaback/Yandex) with ESMTP id 8E4vHNekKh-3Ir4assr;
        Sun, 17 Apr 2022 20:03:18 +0300
X-Yandex-Fwd: 1
Authentication-Results: sas1-ad1836f4152f.qloud-c.yandex.net; dkim=pass
Received: by kernel1.search.yandex.net (Postfix, from userid 55271)
        id 2F378560032; Sun, 17 Apr 2022 20:03:18 +0300 (MSK)
From:   Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
To:     linux-ext4@vger.kernel.org
Cc:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: [PATCH] ext4: mark group as trimmed only if it was fully scanned
Date:   Sun, 17 Apr 2022 20:03:15 +0300
Message-Id: <1650214995-860245-1-git-send-email-dmtrmonakhov@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Otherwise nonaligned fstrim calls will works inconveniently for iterative
scanners, for example:

// trim [0,16MB] for group-1, but mark full group as trimmed
fstrim  -o $((1024*1024*128)) -l $((1024*1024*16)) ./m
// handle [16MB,16MB] for group-1, do nothing because group already has the flag.
fstrim  -o $((1024*1024*144)) -l $((1024*1024*16)) ./m

Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 252c168454c7..c7332eb65ccd 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6407,7 +6407,7 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 static ext4_grpblk_t
 ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 		   ext4_grpblk_t start, ext4_grpblk_t max,
-		   ext4_grpblk_t minblocks)
+		   ext4_grpblk_t minblocks, bool may_cache)
 {
 	struct ext4_buddy e4b;
 	int ret;
@@ -6426,7 +6426,7 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 	if (!EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) ||
 	    minblocks < EXT4_SB(sb)->s_last_trim_minblks) {
 		ret = ext4_try_to_trim_range(sb, &e4b, start, max, minblocks);
-		if (ret >= 0)
+		if (ret >= 0 && may_cache)
 			EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
 	} else {
 		ret = 0;
@@ -6463,6 +6463,7 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 	ext4_fsblk_t first_data_blk =
 			le32_to_cpu(EXT4_SB(sb)->s_es->s_first_data_block);
 	ext4_fsblk_t max_blks = ext4_blocks_count(EXT4_SB(sb)->s_es);
+	bool whole_group, eof = false;
 	int ret = 0;
 
 	start = range->start >> sb->s_blocksize_bits;
@@ -6481,8 +6482,10 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 		if (minlen > EXT4_CLUSTERS_PER_GROUP(sb))
 			goto out;
 	}
-	if (end >= max_blks)
+	if (end >= max_blks - 1) {
 		end = max_blks - 1;
+		eof = true;
+	}
 	if (end <= first_data_blk)
 		goto out;
 	if (start < first_data_blk)
@@ -6496,6 +6499,7 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 
 	/* end now represents the last cluster to discard in this group */
 	end = EXT4_CLUSTERS_PER_GROUP(sb) - 1;
+	whole_group = true;
 
 	for (group = first_group; group <= last_group; group++) {
 		grp = ext4_get_group_info(sb, group);
@@ -6512,12 +6516,13 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 		 * change it for the last group, note that last_cluster is
 		 * already computed earlier by ext4_get_group_no_and_offset()
 		 */
-		if (group == last_group)
+		if (group == last_group) {
 			end = last_cluster;
-
+			whole_group = eof ? true : end == EXT4_CLUSTERS_PER_GROUP(sb) - 1;
+		}
 		if (grp->bb_free >= minlen) {
 			cnt = ext4_trim_all_free(sb, group, first_cluster,
-						end, minlen);
+						 end, minlen, whole_group);
 			if (cnt < 0) {
 				ret = cnt;
 				break;
-- 
2.7.4

