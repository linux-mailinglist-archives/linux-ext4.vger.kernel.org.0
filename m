Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE87C5B2E97
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Sep 2022 08:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiIIGQi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Sep 2022 02:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIIGQh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Sep 2022 02:16:37 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2430A11779A;
        Thu,  8 Sep 2022 23:16:36 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MP5LP4DRvzHnfh;
        Fri,  9 Sep 2022 14:14:37 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 9 Sep 2022 14:16:34 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 9 Sep
 2022 14:16:33 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <jack@suse.cz>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH] ext4: Fix dir corruption when ext4_dx_add_entry() fails
Date:   Fri, 9 Sep 2022 14:27:36 +0800
Message-ID: <20220909062736.2929221-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Just like make_indexed_dir() does, update dir inode if error occurs.
Fetch a reproducer in [Link].

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216466
CC: stable@vger.kernel.org
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ext4/namei.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 3a31b662f661..f04871fa4ead 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2617,6 +2617,13 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 	 */
 	if (restart && err == 0)
 		goto again;
+	/*
+	 * Even if the dx_add_entry failed, we have to properly write
+	 * out all the changes we did so far. Otherwise we can end up
+	 * with corrupted filesystem.
+	 */
+	if (err)
+		ext4_mark_inode_dirty(handle, dir);
 	return err;
 }
 
-- 
2.31.1

