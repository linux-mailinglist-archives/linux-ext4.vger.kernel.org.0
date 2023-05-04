Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB9E6F7626
	for <lists+linux-ext4@lfdr.de>; Thu,  4 May 2023 22:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjEDUGB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 May 2023 16:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjEDUFg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 May 2023 16:05:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9B919915;
        Thu,  4 May 2023 12:53:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD50F6389F;
        Thu,  4 May 2023 19:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B381C43442;
        Thu,  4 May 2023 19:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229937;
        bh=NWcAK2jZaWIg8oh2/zqFwf5x7GS/Tjlh3ak4HK9Z0bY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFPw6eX7HVcqwQFTqQEXU2JcK40iQSn0R2hpDu1he2q2KHz5VQNeSCbTkNCqdS+Ts
         IPks8aQlxc7IElRx0L3dQ1jWYGxewHd36Uz26/SaJbE17ElBJklWV4JNrh+mzy/El7
         CdgKmUUsNsXb5nN9Xo0PIA+16DDmQ9ek1c9ufRAo9Bohu92Epqz6Dn/BYvwVFynWkM
         rJHbIhiTBCuG/0jjVbzWkraZv1pBhzdaIKrTIhJxMLuuBvq+ON6slLoiffr6QSjZyE
         BHI4iepyGtcngwyp8jqjNfsWpx8LiOBS2+t0mmprDpl3gcmgFXUudt/kXXHLNw1PRn
         iXwszCT4fdhKQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        syzbot+4fec412f59eba8c01b77@syzkaller.appspotmail.com,
        Sasha Levin <sashal@kernel.org>, jack@suse.com,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 03/13] ext2: Check block size validity during mount
Date:   Thu,  4 May 2023 15:51:55 -0400
Message-Id: <20230504195207.3809116-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504195207.3809116-1-sashal@kernel.org>
References: <20230504195207.3809116-1-sashal@kernel.org>
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
index 032295e1d3865..b500fed96a692 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -177,6 +177,7 @@ static inline struct ext2_sb_info *EXT2_SB(struct super_block *sb)
 #define EXT2_MIN_BLOCK_SIZE		1024
 #define	EXT2_MAX_BLOCK_SIZE		4096
 #define EXT2_MIN_BLOCK_LOG_SIZE		  10
+#define EXT2_MAX_BLOCK_LOG_SIZE		  16
 #define EXT2_BLOCK_SIZE(s)		((s)->s_blocksize)
 #define	EXT2_ADDR_PER_BLOCK(s)		(EXT2_BLOCK_SIZE(s) / sizeof (__u32))
 #define EXT2_BLOCK_SIZE_BITS(s)		((s)->s_blocksize_bits)
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 5f7079b65426c..7ca9fb0bfc324 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -965,6 +965,13 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
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
 
 	if (sbi->s_mount_opt & EXT2_MOUNT_DAX) {
-- 
2.39.2

