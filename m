Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF076F766B
	for <lists+linux-ext4@lfdr.de>; Thu,  4 May 2023 22:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjEDUHC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 May 2023 16:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjEDUF6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 May 2023 16:05:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEC914E55;
        Thu,  4 May 2023 12:53:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25DD16376D;
        Thu,  4 May 2023 19:44:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A40C433A1;
        Thu,  4 May 2023 19:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229479;
        bh=MabVeKf67bdGxQWhug9guqP+n3QAIhouqhZ8bmwGJic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kjv3HidjIs8fe7N+JFtjAGLU6KIrbPb+wssFjDorbhwPRzSZt74utlhpOoxqUt0rL
         eao3Z5dQDHqnpqv0WN+CklY0JFMaZeO42RH5HQ3jW1p8HVuUX/t8lgC/gbm+TvZefe
         dU7DvJLUw0waxJ3y/Gf+iVHeFKlZloIi97GDCtQu9NVYrZfvylvNPG+pvpbv0XON9O
         qr6uSQA4ylUOtoFrVegCobbxh36Heq3XPNcVaUMoZbIePTYEuMvJBtUyvg/CYwfdnq
         pcBishQ1YUhgTR0ti4owYcUmITmutEwQGyh8rURbDPnIFUeS+fPwNucWviTz7yfubP
         CsSGGwLvAsdFA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        syzbot+4fec412f59eba8c01b77@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, jack@suse.com,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 07/53] ext2: Check block size validity during mount
Date:   Thu,  4 May 2023 15:43:27 -0400
Message-Id: <20230504194413.3806354-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194413.3806354-1-sashal@kernel.org>
References: <20230504194413.3806354-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
index 28de11a22e5f6..dc5dcb78bc27f 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -180,6 +180,7 @@ static inline struct ext2_sb_info *EXT2_SB(struct super_block *sb)
 #define EXT2_MIN_BLOCK_SIZE		1024
 #define	EXT2_MAX_BLOCK_SIZE		4096
 #define EXT2_MIN_BLOCK_LOG_SIZE		  10
+#define EXT2_MAX_BLOCK_LOG_SIZE		  16
 #define EXT2_BLOCK_SIZE(s)		((s)->s_blocksize)
 #define	EXT2_ADDR_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (__u32))
 #define EXT2_BLOCK_SIZE_BITS(s)		((s)->s_blocksize_bits)
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 69c88facfe90e..f342f347a695f 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -945,6 +945,13 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
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

