Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BD372DF8E
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jun 2023 12:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbjFMKcS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jun 2023 06:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240051AbjFMKcL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jun 2023 06:32:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B22A1B8
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jun 2023 03:30:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC50A1FD87;
        Tue, 13 Jun 2023 10:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686652216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=viUv/h43Lsbo9vjaRoz+V9wr+lSZ4qAlf96ftg89TUM=;
        b=gsTcsTs3pcFF3GNcFrbJUVWl5N3ndxF5dWHQ1WO5cVA9NRIIsuVr0+nUcGiJCov7MDopNM
        U4n5HXdid0RDQqQcBT5CHUsfNo15CGbM0mDfxcoxVFZNJv/Ns7FYpeb6bJczWOIKUgEA1m
        9R+g6k7SP2Z0TuB8oq1lk8DphKqug2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686652216;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=viUv/h43Lsbo9vjaRoz+V9wr+lSZ4qAlf96ftg89TUM=;
        b=Haht6ukCo1wAhWA9uE4UvpvKBmMSrzePh/iSjzIyh7VDMW6E9TzvAv0UXnd+gWcTQlRuEN
        YkHquTX+gxT1x0DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E051C13483;
        Tue, 13 Jun 2023 10:30:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k4fBNjhFiGREdAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 13 Jun 2023 10:30:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 776DAA0717; Tue, 13 Jun 2023 12:30:16 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot+af5e10f73dbff48f70af@syzkaller.appspotmail.com
Subject: [PATCH] ext2: Drop fragment support
Date:   Tue, 13 Jun 2023 12:30:12 +0200
Message-Id: <20230613103012.22933-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4022; i=jack@suse.cz; h=from:subject; bh=Jc2JKMv3k5dfOiFkgOvyCg04SrWsE99TW9BdhiY9c4o=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkiEUuph2hls1XjcrT/+NbKzM9W8vn/pYH3CMCziqx g46+Pe6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZIhFLgAKCRCcnaoHP2RA2SGrB/ 4gUQt0R83Cw6SPt38FUQAw6SWPFLfowNntuedRpLl6vRWNBE579vO/I8H+3EdsNtLAef0/VqWAmmUg pqdntMNFTRz+rV+S5jbumjbl0pjzGJN3pl5SJligpk0XSnOoxP2f/Pod0fh47SZMTajokJHP9dDo7k 0JmUjq3F3NRVmXuXnO2NX+fTPJRGJ8OrPD8gtYUxZeMjXGuoltG6EbMkrI5Ekxw20S19X+05Us3x04 6kFzDHzbbqshtjtNUUyMWHe1ahjag1Boh435drYK13kNiYb8vtQavQ3lCnLSzQNLgDiAyWanfE0PUU lnOv3ENSiaadc/MlWyHXeDurPocjHc
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ext2 has fields in superblock reserved for subblock allocation support.
However that never landed. Drop the many years dead code.

Reported-by: syzbot+af5e10f73dbff48f70af@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/ext2.h  | 12 ------------
 fs/ext2/super.c | 23 ++++-------------------
 2 files changed, 4 insertions(+), 31 deletions(-)

I plan to merge this patch through my tree.

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 8244366862e4..11572cc60d0e 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -70,10 +70,7 @@ struct mb_cache;
  * second extended-fs super-block data in memory
  */
 struct ext2_sb_info {
-	unsigned long s_frag_size;	/* Size of a fragment in bytes */
-	unsigned long s_frags_per_block;/* Number of fragments per block */
 	unsigned long s_inodes_per_block;/* Number of inodes per block */
-	unsigned long s_frags_per_group;/* Number of fragments in a group */
 	unsigned long s_blocks_per_group;/* Number of blocks in a group */
 	unsigned long s_inodes_per_group;/* Number of inodes in a group */
 	unsigned long s_itb_per_group;	/* Number of inode table blocks per group */
@@ -188,15 +185,6 @@ static inline struct ext2_sb_info *EXT2_SB(struct super_block *sb)
 #define EXT2_INODE_SIZE(s)		(EXT2_SB(s)->s_inode_size)
 #define EXT2_FIRST_INO(s)		(EXT2_SB(s)->s_first_ino)
 
-/*
- * Macro-instructions used to manage fragments
- */
-#define EXT2_MIN_FRAG_SIZE		1024
-#define	EXT2_MAX_FRAG_SIZE		4096
-#define EXT2_MIN_FRAG_LOG_SIZE		  10
-#define EXT2_FRAG_SIZE(s)		(EXT2_SB(s)->s_frag_size)
-#define EXT2_FRAGS_PER_BLOCK(s)		(EXT2_SB(s)->s_frags_per_block)
-
 /*
  * Structure of a blocks group descriptor
  */
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index f342f347a695..2959afc7541c 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -668,10 +668,9 @@ static int ext2_setup_super (struct super_block * sb,
 		es->s_max_mnt_count = cpu_to_le16(EXT2_DFL_MAX_MNT_COUNT);
 	le16_add_cpu(&es->s_mnt_count, 1);
 	if (test_opt (sb, DEBUG))
-		ext2_msg(sb, KERN_INFO, "%s, %s, bs=%lu, fs=%lu, gc=%lu, "
+		ext2_msg(sb, KERN_INFO, "%s, %s, bs=%lu, gc=%lu, "
 			"bpg=%lu, ipg=%lu, mo=%04lx]",
 			EXT2FS_VERSION, EXT2FS_DATE, sb->s_blocksize,
-			sbi->s_frag_size,
 			sbi->s_groups_count,
 			EXT2_BLOCKS_PER_GROUP(sb),
 			EXT2_INODES_PER_GROUP(sb),
@@ -1012,14 +1011,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 		}
 	}
 
-	sbi->s_frag_size = EXT2_MIN_FRAG_SIZE <<
-				   le32_to_cpu(es->s_log_frag_size);
-	if (sbi->s_frag_size == 0)
-		goto cantfind_ext2;
-	sbi->s_frags_per_block = sb->s_blocksize / sbi->s_frag_size;
-
 	sbi->s_blocks_per_group = le32_to_cpu(es->s_blocks_per_group);
-	sbi->s_frags_per_group = le32_to_cpu(es->s_frags_per_group);
 	sbi->s_inodes_per_group = le32_to_cpu(es->s_inodes_per_group);
 
 	sbi->s_inodes_per_block = sb->s_blocksize / EXT2_INODE_SIZE(sb);
@@ -1045,11 +1037,10 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount;
 	}
 
-	if (sb->s_blocksize != sbi->s_frag_size) {
+	if (es->s_log_frag_size != es->s_log_block_size) {
 		ext2_msg(sb, KERN_ERR,
-			"error: fragsize %lu != blocksize %lu"
-			"(not supported yet)",
-			sbi->s_frag_size, sb->s_blocksize);
+			"error: fragsize log %u != blocksize log %u",
+			le32_to_cpu(es->s_log_frag_size), sb->s_blocksize_bits);
 		goto failed_mount;
 	}
 
@@ -1066,12 +1057,6 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 			sbi->s_blocks_per_group, sbi->s_inodes_per_group + 3);
 		goto failed_mount;
 	}
-	if (sbi->s_frags_per_group > sb->s_blocksize * 8) {
-		ext2_msg(sb, KERN_ERR,
-			"error: #fragments per group too big: %lu",
-			sbi->s_frags_per_group);
-		goto failed_mount;
-	}
 	if (sbi->s_inodes_per_group < sbi->s_inodes_per_block ||
 	    sbi->s_inodes_per_group > sb->s_blocksize * 8) {
 		ext2_msg(sb, KERN_ERR,
-- 
2.35.3

