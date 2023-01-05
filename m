Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE6065E5EA
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Jan 2023 08:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjAEHRT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Jan 2023 02:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjAEHRL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Jan 2023 02:17:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D40053728;
        Wed,  4 Jan 2023 23:17:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 333E061903;
        Thu,  5 Jan 2023 07:17:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B65C433EF;
        Thu,  5 Jan 2023 07:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672903030;
        bh=9SnhtoHqnzahPc1L+MI68IB+5P1DoaZ3R0h7wpifSMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cd2Jn7FM4HExgAtbcimeHQ9W9rEChEISlhk7FscJitEx84b0Tr9hjMW/TZFB9rR8C
         oOyaqbOBI2W0TLTnr6a8Cw+DTNlhfZ1Fl1mtNeCd/eDhDi17X/0U3x37tgxM7FZC+W
         CYxCkva6qJTQfBEhou69FdDTr3kQSeOYbr/l1gL+u4rnhvM5mb8a/KdOABk5ptjA3b
         hfunuQMaLXMZJsW9gRR8txGyYGvtqbt2Gc9nazaxUqZz99jesNiElb/p9llgWggSXg
         XIgAFKNKP/bv6ESKCmQOMW7D3IHFPii2esjO1g4FP+fHREcdEIa+lcLPMUwg0MjKy/
         tQFfYAuqprvQQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     stable@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 5.15 08/10] ext4: add missing validation of fast-commit record lengths
Date:   Wed,  4 Jan 2023 23:13:57 -0800
Message-Id: <20230105071359.257952-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105071359.257952-1-ebiggers@kernel.org>
References: <20230105071359.257952-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 64b4a25c3de81a69724e888ec2db3533b43816e2 upstream.

Validate the inode and filename lengths in fast-commit journal records
so that a malicious fast-commit journal cannot cause a crash by having
invalid values for these.  Also validate EXT4_FC_TAG_DEL_RANGE.

Fixes: aa75f4d3daae ("ext4: main fast-commit commit path")
Cc: <stable@vger.kernel.org> # v5.10+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Link: https://lore.kernel.org/r/20221106224841.279231-5-ebiggers@kernel.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/fast_commit.c | 38 +++++++++++++++++++-------------------
 fs/ext4/fast_commit.h |  2 +-
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 0caa03805f0df..f92eb89a8a2b2 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1916,32 +1916,31 @@ void ext4_fc_replay_cleanup(struct super_block *sb)
 	kfree(sbi->s_fc_replay_state.fc_modified_inodes);
 }
 
-static inline bool ext4_fc_tag_len_isvalid(struct ext4_fc_tl *tl,
-					   u8 *val, u8 *end)
+static bool ext4_fc_value_len_isvalid(struct ext4_sb_info *sbi,
+				      int tag, int len)
 {
-	if (val + tl->fc_len > end)
-		return false;
-
-	/* Here only check ADD_RANGE/TAIL/HEAD which will read data when do
-	 * journal rescan before do CRC check. Other tags length check will
-	 * rely on CRC check.
-	 */
-	switch (tl->fc_tag) {
+	switch (tag) {
 	case EXT4_FC_TAG_ADD_RANGE:
-		return (sizeof(struct ext4_fc_add_range) == tl->fc_len);
-	case EXT4_FC_TAG_TAIL:
-		return (sizeof(struct ext4_fc_tail) <= tl->fc_len);
-	case EXT4_FC_TAG_HEAD:
-		return (sizeof(struct ext4_fc_head) == tl->fc_len);
+		return len == sizeof(struct ext4_fc_add_range);
 	case EXT4_FC_TAG_DEL_RANGE:
+		return len == sizeof(struct ext4_fc_del_range);
+	case EXT4_FC_TAG_CREAT:
 	case EXT4_FC_TAG_LINK:
 	case EXT4_FC_TAG_UNLINK:
-	case EXT4_FC_TAG_CREAT:
+		len -= sizeof(struct ext4_fc_dentry_info);
+		return len >= 1 && len <= EXT4_NAME_LEN;
 	case EXT4_FC_TAG_INODE:
+		len -= sizeof(struct ext4_fc_inode);
+		return len >= EXT4_GOOD_OLD_INODE_SIZE &&
+			len <= sbi->s_inode_size;
 	case EXT4_FC_TAG_PAD:
-	default:
-		return true;
+		return true; /* padding can have any length */
+	case EXT4_FC_TAG_TAIL:
+		return len >= sizeof(struct ext4_fc_tail);
+	case EXT4_FC_TAG_HEAD:
+		return len == sizeof(struct ext4_fc_head);
 	}
+	return false;
 }
 
 /*
@@ -2004,7 +2003,8 @@ static int ext4_fc_replay_scan(journal_t *journal,
 	     cur = cur + EXT4_FC_TAG_BASE_LEN + tl.fc_len) {
 		ext4_fc_get_tl(&tl, cur);
 		val = cur + EXT4_FC_TAG_BASE_LEN;
-		if (!ext4_fc_tag_len_isvalid(&tl, val, end)) {
+		if (tl.fc_len > end - val ||
+		    !ext4_fc_value_len_isvalid(sbi, tl.fc_tag, tl.fc_len)) {
 			ret = state->fc_replay_num_tags ?
 				JBD2_FC_REPLAY_STOP : -ECANCELED;
 			goto out_err;
diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
index edbeb5697cebc..2cbd317eda26b 100644
--- a/fs/ext4/fast_commit.h
+++ b/fs/ext4/fast_commit.h
@@ -58,7 +58,7 @@ struct ext4_fc_dentry_info {
 	__u8 fc_dname[0];
 };
 
-/* Value structure for EXT4_FC_TAG_INODE and EXT4_FC_TAG_INODE_PARTIAL. */
+/* Value structure for EXT4_FC_TAG_INODE. */
 struct ext4_fc_inode {
 	__le32 fc_ino;
 	__u8 fc_raw_inode[0];
-- 
2.39.0

