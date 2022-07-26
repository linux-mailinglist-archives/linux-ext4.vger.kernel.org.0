Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8A75811D9
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Jul 2022 13:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbiGZLXe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Jul 2022 07:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiGZLXd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Jul 2022 07:23:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58FF659B
        for <linux-ext4@vger.kernel.org>; Tue, 26 Jul 2022 04:23:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6B4563510D;
        Tue, 26 Jul 2022 11:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658834611; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8ltFS8MKPvZkRUUS6T5i4fusyR7Iq/Le1xnQXgC+FrI=;
        b=k6Ky7q1gUSLcQZxDj1aoqRLqzMJIsCt5lTmnHTnN6qjnJm1bWERusBNVLDP/JR2L3EYX8N
        hdiiab/phGsgLUtIRBDg3NdwXgq1k3JWFICyHYkhLosaQqlt27345TtiksHPV0iMYNqHj0
        M2vnQ1S/gknBZII/UYiiAR9+YAAPwR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658834611;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8ltFS8MKPvZkRUUS6T5i4fusyR7Iq/Le1xnQXgC+FrI=;
        b=vyZtAddrcPz4qXBLBJixq7+WuEoU/ftEwkQhMVU7sGaNFDAMA39vRhsnxkrwbmZq21jsRg
        cGbXlJGdC3NgD+DQ==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 52C742C15D;
        Tue, 26 Jul 2022 11:23:31 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F01C3A0664; Tue, 26 Jul 2022 13:23:29 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot+d273f7d7f58afd93be48@syzkaller.appspotmail.com
Subject: [PATCH] ext2: Add more validity checks for inode counts
Date:   Tue, 26 Jul 2022 13:23:23 +0200
Message-Id: <20220726112323.32325-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1911; h=from:subject; bh=GYQCBcLW7wH/F3SEC5OUVt+DMLCPh3ZHcR6fCOkxdlc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBi386a0s6AS6Tn6jFl0RSi+Imfujv76/lzC9GtIVsN 2olsAfmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYt/OmgAKCRCcnaoHP2RA2RclB/ 98lDsfFQIX/HLfEvFYDRUoa1aMQOAJyF6rnPrPe1R4QW8cmAmO2raOUYO45e6A2DGdbEDNCxCcM58q UCpWQqRC3dIopCcmzCqINZH0vlK1dbJ1jwcrk727u0TYYnse3ZYcRAwQFDRo8LP1Cq0s4Yt7VdoiKs QZfyXslXYJeLx6HLRRCXq0131Nuzv3wLxk2M9xKVjj6rHg9HBrq7u8STY5qFui8j+xHG0x1Hqx8VCS 6hOlRYwae5QV0+r3b+wkcS5hRwoUuYTGANdz8WOeviFQUyO2WC0zZRKg/wwWEsThlW4IF3kh/FSV2e 4HGoQXdUCt4QnujO1emwpGW2yj37FE
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add checks verifying number of inodes stored in the superblock matches
the number computed from number of inodes per group. Also verify we have
at least one block worth of inodes per group. This prevents crashes on
corrupted filesystems.

Reported-by: syzbot+d273f7d7f58afd93be48@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/super.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

I plan to send this patch to Linus for the coming merge window. It mirrors
the checks already done in ext4.

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index f6a19f6d9f6d..cdffa2a041af 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1059,9 +1059,10 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 			sbi->s_frags_per_group);
 		goto failed_mount;
 	}
-	if (sbi->s_inodes_per_group > sb->s_blocksize * 8) {
+	if (sbi->s_inodes_per_group < sbi->s_inodes_per_block ||
+	    sbi->s_inodes_per_group > sb->s_blocksize * 8) {
 		ext2_msg(sb, KERN_ERR,
-			"error: #inodes per group too big: %lu",
+			"error: invalid #inodes per group: %lu",
 			sbi->s_inodes_per_group);
 		goto failed_mount;
 	}
@@ -1071,6 +1072,13 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->s_groups_count = ((le32_to_cpu(es->s_blocks_count) -
 				le32_to_cpu(es->s_first_data_block) - 1)
 					/ EXT2_BLOCKS_PER_GROUP(sb)) + 1;
+	if ((u64)sbi->s_groups_count * sbi->s_inodes_per_group !=
+	    le32_to_cpu(es->s_inodes_count)) {
+		ext2_msg(sb, KERN_ERR, "error: invalid #inodes: %u vs computed %llu",
+			 le32_to_cpu(es->s_inodes_count),
+			 (u64)sbi->s_groups_count * sbi->s_inodes_per_group);
+		goto failed_mount;
+	}
 	db_count = (sbi->s_groups_count + EXT2_DESC_PER_BLOCK(sb) - 1) /
 		   EXT2_DESC_PER_BLOCK(sb);
 	sbi->s_group_desc = kmalloc_array(db_count,
-- 
2.35.3

