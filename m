Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AF45A8E25
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Sep 2022 08:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiIAGP5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Sep 2022 02:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbiIAGPu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Sep 2022 02:15:50 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0E8FE059;
        Wed, 31 Aug 2022 23:15:44 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MJ9g55hYqz1N7bs;
        Thu,  1 Sep 2022 14:12:01 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 14:15:41 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next] ext4: ensure data forced to disk when rename
Date:   Thu, 1 Sep 2022 14:26:57 +0800
Message-ID: <20220901062657.1192732-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There is issue that data lost when rename new file. Reason is dioread_nolock is
enabled default now, which map blocks will mark extent unwritten. But inode
size is changed after submit io. Then read file will return zero if extent is
unwritten.
To solve above isuue, wait all data force to disk before rename when enable
dioread_nolock and enable delay allocate.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/inode.c | 16 ++++++++++++++++
 fs/ext4/namei.c |  2 +-
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 9bca5565547b..111296259b89 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2998,6 +2998,7 @@ extern int ext4_break_layouts(struct inode *);
 extern int ext4_punch_hole(struct file *file, loff_t offset, loff_t length);
 extern void ext4_set_inode_flags(struct inode *, bool init);
 extern int ext4_alloc_da_blocks(struct inode *inode);
+extern void ext4_flush_data(struct inode *inode);
 extern void ext4_set_aops(struct inode *inode);
 extern int ext4_writepage_trans_blocks(struct inode *);
 extern int ext4_chunk_trans_blocks(struct inode *, int nrblocks);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 601214453c3a..4df7ffd3f1b0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3133,6 +3133,22 @@ int ext4_alloc_da_blocks(struct inode *inode)
 	return filemap_flush(inode->i_mapping);
 }
 
+void ext4_flush_data(struct inode *inode)
+{
+	if (!EXT4_I(inode)->i_reserved_data_blocks)
+		return;
+
+	if (filemap_flush(inode->i_mapping))
+		return;
+
+	if (test_opt(inode->i_sb, DELALLOC) &&
+	    ext4_should_dioread_nolock(inode) &&
+	    atomic_read(&EXT4_I(inode)->i_unwritten))
+		filemap_fdatawait(inode->i_mapping);
+
+	return;
+}
+
 /*
  * bmap() is special.  It gets used by applications such as lilo and by
  * the swapper to find the on-disk block of a specific piece of data.
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 3a31b662f661..030402fe3b9f 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3820,7 +3820,7 @@ static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		}
 	}
 	if (new.inode && !test_opt(new.dir->i_sb, NO_AUTO_DA_ALLOC))
-		ext4_alloc_da_blocks(old.inode);
+		ext4_flush_data(old.inode);
 
 	credits = (2 * EXT4_DATA_TRANS_BLOCKS(old.dir->i_sb) +
 		   EXT4_INDEX_EXTRA_TRANS_BLOCKS + 2);
-- 
2.31.1

