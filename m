Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6E26F752D
	for <lists+linux-ext4@lfdr.de>; Thu,  4 May 2023 21:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjEDT4h (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 May 2023 15:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjEDTzU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 May 2023 15:55:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3A01C0C2;
        Thu,  4 May 2023 12:48:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA6EC637EA;
        Thu,  4 May 2023 19:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0DDC433A0;
        Thu,  4 May 2023 19:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229715;
        bh=F3Fg4ykSRNJLZjUFr+7CCg9HoRNT2L/SxItHFFNZQpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D8otLOT7QRLKafTVy2zxus26pjUL2ZSx5tFwCDzAfTc8d9zcJZdK7W8s922IEYoIm
         v+OKa90SYR3CT1aeT5kXf/P7f2Eh/8G4pjhIvglB+4QRRr6xQ0RWDK5mIu5xZ/Qsfq
         0eDjLrqHzVvWDXNG2hHSjzsFBiQm5QGxzVtjf7i4MC7s4u9O1/zfnvi638gxsLheL7
         wR2LR3FQ2ny21bdgcm+x2zAeiW8qM50V5PsAfFdit49Pi01w8ku4qugsDLlBahBz/j
         z2mS1SbpTEi1dXd2mJ2NFlaYCncKFxqtNKS3VwKQ+/ApMIRDyqKYr1xyVJiMmM5wNp
         Pi+scPRrn1eQQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        syzbot+4fec412f59eba8c01b77@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, jack@suse.com,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 04/30] ext2: Check block size validity during mount
Date:   Thu,  4 May 2023 15:47:57 -0400
Message-Id: <20230504194824.3808028-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194824.3808028-1-sashal@kernel.org>
References: <20230504194824.3808028-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Jan Kara <jack@suse.cz>

[ Upstream commit 62aeb94433fcec80241754b70d0d1836d5926b0a ]

Check that log of block size stored in the superblock has sensible
value. Otherwise the shift computing the block size can overflow leading
to undefined behavior.

Reported-by: syzbot+4fec412f59eba8c01b77@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext2/ext2.h  | 1 +
 fs/ext2/super.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 3be9dd6412b78..a610c096f3a9d 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -179,6 +179,7 @@ static inline struct ext2_sb_info *EXT2_SB(struct super_block *sb)
 #define EXT2_MIN_BLOCK_SIZE		1024
 #define	EXT2_MAX_BLOCK_SIZE		4096
 #define EXT2_MIN_BLOCK_LOG_SIZE		  10
+#define EXT2_MAX_BLOCK_LOG_SIZE		  16
 #define EXT2_BLOCK_SIZE(s)		((s)->s_blocksize)
 #define	EXT2_ADDR_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (__u32))
 #define EXT2_BLOCK_SIZE_BITS(s)		((s)->s_blocksize_bits)
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 02d82f8fe85d9..486a43e347950 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -947,6 +947,13 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed_mount;
 	}
 
+	if (le32_to_cpu(es->s_log_block_size) >
+	    (EXT2_MAX_BLOCK_LOG_SIZE - BLOCK_SIZE_BITS)) {
+		ext2_msg(sb, KERN_ERR,
+			 "Invalid log block size: %u",
+			 le32_to_cpu(es->s_log_block_size));
+		goto failed_mount;
+	}
 	blocksize = BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
 
 	if (test_opt(sb, DAX)) {
-- 
2.39.2

