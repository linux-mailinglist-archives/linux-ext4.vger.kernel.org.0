Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141A75B8C31
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Sep 2022 17:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiINPrg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Sep 2022 11:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiINPrb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Sep 2022 11:47:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E8F7F275
        for <linux-ext4@vger.kernel.org>; Wed, 14 Sep 2022 08:47:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD90033AD7;
        Wed, 14 Sep 2022 15:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1663170448; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DSopkM9PArl3suiAm2VAyhBauIKueQBuBrU83vydfKs=;
        b=N7mTsc4HkusGWmZ9XvwfY0XedpOMIL4FAnYz/VKVRPKRyntWX6YzeHVuXjzQzjX0tUuZNz
        UmrqCOTMix6ToptOoOgCuTqMIj6bDdVq69k6s7WVqD7U7NYCpNCKfPZoaTRIRcq5dUhvIB
        Z7aSa+wdoOC7qPokRcFU/qJVigbh0S8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1663170448;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DSopkM9PArl3suiAm2VAyhBauIKueQBuBrU83vydfKs=;
        b=fMcaUYDIaK5VvnxJtvvgv2aTI1qZ5yLvNcofB4XQmtw3VCN0Ercc6f+csbqNfHlId4SknM
        Dl6Lz2OxRhxsl9CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD59113494;
        Wed, 14 Sep 2022 15:47:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IBM5LpD3IWOjVQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 14 Sep 2022 15:47:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3D12AA0682; Wed, 14 Sep 2022 17:47:28 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot+0f2f7e65a3007d39539f@syzkaller.appspotmail.com
Subject: [PATCH 1/2] ext2: Add sanity checks for group and filesystem size
Date:   Wed, 14 Sep 2022 17:47:22 +0200
Message-Id: <20220914154728.20280-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220914154450.26562-1-jack@suse.cz>
References: <20220914154450.26562-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1855; h=from:subject; bh=sHQiIytQKH1D0kdp+MB7bWI389+MwXAulcnNsVT8xxw=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGJIVv3f+UWQT9P+bJ7CDWepfjfehZS65l78dkmi7F8ux/5v9 0vzITkZjFgZGDgZZMUWW1ZEXta/NM+raGqohAzOIlQlkCgMXpwBM5LoIB8NslvArshm8IV/2WRbcUs wr659w6MrGqJKps/8cUfRvOlW+/d/Oi+4979z7PMyiJAznzlveauJsF9GxcINRxl+7bcaJ3WvCxLQu +Rx/z5wSWGUuwnWTab22wJ5nza91z3eHfpH+Wx/92Urhi1RtYf2OJ/aH2i0YrH+8N9mSqiDJ58JcLS mnqNY0rzp3Xm+hdGuNO792qr5sdPkppkD3bTcmP1zle6pDLTkvTOhtUvnTuGWl7AaXDlsd7q2d7rl/ wtZPGXzpJr5rzNaq5D04zx34O+Rd2FP7K9f6tRyLT3Of/nTj2JacWU85O+u1Tnn2cdqH7vs0b47MIY 3rbSwbph1qD/+75fVOOeGajbITAA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add sanity check that filesystem size does not exceed the underlying
device size and that group size is big enough so that metadata can fit
into it. This avoid trying to mount some crafted filesystems with
extremely large group counts.

Reported-by: syzbot+0f2f7e65a3007d39539f@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/super.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 252c742379cf..c94955b6701c 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -1052,6 +1052,13 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 			sbi->s_blocks_per_group);
 		goto failed_mount;
 	}
+	/* At least inode table, bitmaps, and sb have to fit in one group */
+	if (sbi->s_blocks_per_group <= sbi->s_inodes_per_group + 3) {
+		ext2_msg(sb, KERN_ERR,
+			"error: #blocks per group smaller than metadata size: %lu <= %lu",
+			sbi->s_blocks_per_group, sbi->s_inodes_per_group + 3);
+		goto failed_mount;
+	}
 	if (sbi->s_frags_per_group > sb->s_blocksize * 8) {
 		ext2_msg(sb, KERN_ERR,
 			"error: #fragments per group too big: %lu",
@@ -1065,9 +1072,14 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 			sbi->s_inodes_per_group);
 		goto failed_mount;
 	}
+	if (sb_bdev_nr_blocks(sb) < le32_to_cpu(es->s_blocks_count)) {
+		ext2_msg(sb, KERN_ERR,
+			 "bad geometry: block count %u exceeds size of device (%u blocks)",
+			 le32_to_cpu(es->s_blocks_count),
+			 (unsigned)sb_bdev_nr_blocks(sb));
+		goto failed_mount;
+	}
 
-	if (EXT2_BLOCKS_PER_GROUP(sb) == 0)
-		goto cantfind_ext2;
 	sbi->s_groups_count = ((le32_to_cpu(es->s_blocks_count) -
 				le32_to_cpu(es->s_first_data_block) - 1)
 					/ EXT2_BLOCKS_PER_GROUP(sb)) + 1;
-- 
2.35.3

