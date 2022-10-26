Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F7560DA1A
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Oct 2022 06:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiJZEB1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Oct 2022 00:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiJZEBY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Oct 2022 00:01:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942F487FA7;
        Tue, 25 Oct 2022 21:01:21 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mxw8g05WJzHvHm;
        Wed, 26 Oct 2022 12:01:07 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 26 Oct
 2022 12:01:19 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v3 3/4] ext4: add EXT4_IGET_BAD flag to prevent unexpected bad inode
Date:   Wed, 26 Oct 2022 12:23:09 +0800
Message-ID: <20221026042310.3839669-4-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221026042310.3839669-1-libaokun1@huawei.com>
References: <20221026042310.3839669-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There are many places that will get unhappy (and crash) when ext4_iget()
returns a bad inode. However, if iget the boot loader inode, allows a bad
inode to be returned, because the inode may not be initialized. This
mechanism can be used to bypass some checks and cause panic. To solve this
problem, we add a special iget flag EXT4_IGET_BAD. Only with this flag
we'd be returning bad inode from ext4_iget(), otherwise we always return
the error code if the inode is bad inode.(suggested by Jan Kara)

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/ext4.h  | 3 ++-
 fs/ext4/inode.c | 8 +++++++-
 fs/ext4/ioctl.c | 3 ++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 8d5453852f98..2b574b143bde 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2964,7 +2964,8 @@ int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 typedef enum {
 	EXT4_IGET_NORMAL =	0,
 	EXT4_IGET_SPECIAL =	0x0001, /* OK to iget a system inode */
-	EXT4_IGET_HANDLE = 	0x0002	/* Inode # is from a handle */
+	EXT4_IGET_HANDLE = 	0x0002,	/* Inode # is from a handle */
+	EXT4_IGET_BAD =		0x0004  /* Allow to iget a bad inode */
 } ext4_iget_flags;
 
 extern struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ae3a836dd9d7..f767340229fd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5043,8 +5043,14 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	if (IS_CASEFOLDED(inode) && !ext4_has_feature_casefold(inode->i_sb))
 		ext4_error_inode(inode, function, line, 0,
 				 "casefold flag without casefold feature");
-	brelse(iloc.bh);
+	if (is_bad_inode(inode) && !(flags & EXT4_IGET_BAD)) {
+		ext4_error_inode(inode, function, line, 0,
+				 "bad inode without EXT4_IGET_BAD flag");
+		ret = -EUCLEAN;
+		goto bad_inode;
+	}
 
+	brelse(iloc.bh);
 	unlock_new_inode(inode);
 	return inode;
 
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index ded535535b27..e0be8026c996 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -375,7 +375,8 @@ static long swap_inode_boot_loader(struct super_block *sb,
 	blkcnt_t blocks;
 	unsigned short bytes;
 
-	inode_bl = ext4_iget(sb, EXT4_BOOT_LOADER_INO, EXT4_IGET_SPECIAL);
+	inode_bl = ext4_iget(sb, EXT4_BOOT_LOADER_INO,
+			EXT4_IGET_SPECIAL | EXT4_IGET_BAD);
 	if (IS_ERR(inode_bl))
 		return PTR_ERR(inode_bl);
 	ei_bl = EXT4_I(inode_bl);
-- 
2.31.1

