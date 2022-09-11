Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894F45B4BDA
	for <lists+linux-ext4@lfdr.de>; Sun, 11 Sep 2022 06:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiIKElK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Sep 2022 00:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiIKElJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Sep 2022 00:41:09 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8B541D17;
        Sat, 10 Sep 2022 21:41:07 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MQH7G6hG9zHnkn;
        Sun, 11 Sep 2022 12:39:06 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 11 Sep 2022 12:41:05 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sun, 11 Sep
 2022 12:41:04 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <jack@suse.cz>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v2] ext4: Fix dir corruption when ext4_dx_add_entry() fails
Date:   Sun, 11 Sep 2022 12:52:04 +0800
Message-ID: <20220911045204.516460-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Following process may lead to fs corruption:
1. ext4_create(dir/foo)
 ext4_add_nondir
  ext4_add_entry
   ext4_dx_add_entry
     a. add_dirent_to_buf
      ext4_mark_inode_dirty
      ext4_handle_dirty_metadata   // dir inode bh is recorded into journal
     b. ext4_append    // dx_get_count(entries) == dx_get_limit(entries)
       ext4_bread(EXT4_GET_BLOCKS_CREATE)
        ext4_getblk
         ext4_map_blocks
          ext4_ext_map_blocks
            ext4_mb_new_blocks
             dquot_alloc_block
              dquot_alloc_space_nodirty
               inode_add_bytes    // update dir's i_blocks
            ext4_ext_insert_extent
	     ext4_ext_dirty  // record extent bh into journal
              ext4_handle_dirty_metadata(bh)
	      // record new block into journal
       inode->i_size += inode->i_sb->s_blocksize   // new size(in mem)
     c. ext4_handle_dirty_dx_node(bh2)
	// record dir's new block(dx_node) into journal
     d. ext4_handle_dirty_dx_node((frame - 1)->bh)
     e. ext4_handle_dirty_dx_node(frame->bh)
     f. do_split    // ret err!
     g. add_dirent_to_buf
	 ext4_mark_inode_dirty(dir)  // update raw_inode on disk(skipped)
2. fsck -a /dev/sdb
 drop last block(dx_node) which beyonds dir's i_size.
  /dev/sdb: recovering journal
  /dev/sdb contains a file system with errors, check forced.
  /dev/sdb: Inode 12, end of extent exceeds allowed value
	(logical block 128, physical block 3938, len 1)
3. fsck -fn /dev/sdb
 dx_node->entry[i].blk > dir->i_size
  Pass 2: Checking directory structure
  Problem in HTREE directory inode 12 (/dir): bad block number 128.
  Clear HTree index? no
  Problem in HTREE directory inode 12: block #3 has invalid depth (2)
  Problem in HTREE directory inode 12: block #3 has bad max hash
  Problem in HTREE directory inode 12: block #3 not referenced

Fix it by marking inode dirty directly inside ext4_append().
Fetch a reproducer in [Link].

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216466
CC: stable@vger.kernel.org
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 v1->v2: mark inode dirty inside ext4_append().
 fs/ext4/namei.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 3a31b662f661..0d0e41d2dee8 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -85,15 +85,20 @@ static struct buffer_head *ext4_append(handle_t *handle,
 		return bh;
 	inode->i_size += inode->i_sb->s_blocksize;
 	EXT4_I(inode)->i_disksize = inode->i_size;
+	err = ext4_mark_inode_dirty(handle, inode);
+	if (err)
+		goto out;
 	BUFFER_TRACE(bh, "get_write_access");
 	err = ext4_journal_get_write_access(handle, inode->i_sb, bh,
 					    EXT4_JTR_NONE);
-	if (err) {
-		brelse(bh);
-		ext4_std_error(inode->i_sb, err);
-		return ERR_PTR(err);
-	}
+	if (err)
+		goto out;
 	return bh;
+
+out:
+	brelse(bh);
+	ext4_std_error(inode->i_sb, err);
+	return ERR_PTR(err);
 }
 
 static int ext4_dx_csum_verify(struct inode *inode,
-- 
2.31.1

