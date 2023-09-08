Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCB279908B
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Sep 2023 21:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243860AbjIHTtC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Sep 2023 15:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243168AbjIHTtB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Sep 2023 15:49:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2604171F;
        Fri,  8 Sep 2023 12:48:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6CFC4163D;
        Fri,  8 Sep 2023 19:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201808;
        bh=mUzN3FyyNu3FLKa9WhO4+TX4mzylTF0rizk8q87A1T8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHOQb/NpqHuCSQDlJwmAShUkgB9EjEgTU6+UbxN6BQttcvU0P/um/2ddCIP3Sues9
         PGGT9LD3Wn+/gUgWrp23gclwIxNBu/NgzRQYaiTFFeMpVKbBomO/blXXn69HkgGIea
         z42I9ISiI5Aw+vjrdmdFHE4i2nLwrKdR0X1EX+8U08OBMXbe6nfKny48dkFjHYGUUT
         lR03/PS6UxUMvSHpTiBjkw21p7CymCs/uoiEVisVp5ZDOBl+SIORjvsZyswcUyGIFT
         DzmwkBX5rwMTZZzFOBUnRn2KrWIwurW/+EtC3xCX7GddwBnPVxMbYFp4lqI2c/Zh66
         veY2QAQ1NlwQw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Georg Ottinger <g.ottinger@gmx.at>, Jan Kara <jack@suse.cz>,
        Sasha Levin <sashal@kernel.org>, jack@suse.com,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 4/4] ext2: fix datatype of block number in ext2_xattr_set2()
Date:   Fri,  8 Sep 2023 15:36:40 -0400
Message-Id: <20230908193641.3463943-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908193641.3463943-1-sashal@kernel.org>
References: <20230908193641.3463943-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.256
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Georg Ottinger <g.ottinger@gmx.at>

[ Upstream commit e88076348425b7d0491c8c98d8732a7df8de7aa3 ]

I run a small server that uses external hard drives for backups. The
backup software I use uses ext2 filesystems with 4KiB block size and
the server is running SELinux and therefore relies on xattr. I recently
upgraded the hard drives from 4TB to 12TB models. I noticed that after
transferring some TBs I got a filesystem error "Freeing blocks not in
datazone - block = 18446744071529317386, count = 1" and the backup
process stopped. Trying to fix the fs with e2fsck resulted in a
completely corrupted fs. The error probably came from ext2_free_blocks(),
and because of the large number 18e19 this problem immediately looked
like some kind of integer overflow. Whereas the 4TB fs was about 1e9
blocks, the new 12TB is about 3e9 blocks. So, searching the ext2 code,
I came across the line in fs/ext2/xattr.c:745 where ext2_new_block()
is called and the resulting block number is stored in the variable block
as an int datatype. If a block with a block number greater than
INT32_MAX is returned, this variable overflows and the call to
sb_getblk() at line fs/ext2/xattr.c:750 fails, then the call to
ext2_free_blocks() produces the error.

Signed-off-by: Georg Ottinger <g.ottinger@gmx.at>
Signed-off-by: Jan Kara <jack@suse.cz>
Message-Id: <20230815100340.22121-1-g.ottinger@gmx.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext2/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 62acbe27d8bf4..ca7ff31a1f194 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -690,10 +690,10 @@ ext2_xattr_set2(struct inode *inode, struct buffer_head *old_bh,
 			/* We need to allocate a new block */
 			ext2_fsblk_t goal = ext2_group_first_block_no(sb,
 						EXT2_I(inode)->i_block_group);
-			int block = ext2_new_block(inode, goal, &error);
+			ext2_fsblk_t block = ext2_new_block(inode, goal, &error);
 			if (error)
 				goto cleanup;
-			ea_idebug(inode, "creating block %d", block);
+			ea_idebug(inode, "creating block %lu", block);
 
 			new_bh = sb_getblk(sb, block);
 			if (unlikely(!new_bh)) {
-- 
2.40.1

