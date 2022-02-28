Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC584C611E
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Feb 2022 03:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbiB1Cd1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 27 Feb 2022 21:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiB1Cd0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 27 Feb 2022 21:33:26 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCA538DB3;
        Sun, 27 Feb 2022 18:32:46 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4K6PTN3yk6z9sMq;
        Mon, 28 Feb 2022 10:29:12 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 28 Feb
 2022 10:32:43 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <jack@suse.cz>,
        <lczerner@redhat.com>, Ye Bin <yebin10@huawei.com>
Subject: [PATCH v3] ext4:fix file system corrupted when rmdir non empty directory with IO error
Date:   Mon, 28 Feb 2022 10:48:15 +0800
Message-ID: <20220228024815.3952506-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We inject IO error when rmdir non empty direcory, then got issue as follows:
step1: mkfs.ext4 -F /dev/sda
step2: mount /dev/sda  test
step3: cd test
step4: mkdir -p 1/2
step5: rmdir 1
	[  110.920551] ext4_empty_dir: inject fault
	[  110.921926] EXT4-fs warning (device sda): ext4_rmdir:3113: inode #12:
	comm rmdir: empty directory '1' has too many links (3)
step6: cd ..
step7: umount test
step8: fsck.ext4 -f /dev/sda
	e2fsck 1.42.9 (28-Dec-2013)
	Pass 1: Checking inodes, blocks, and sizes
	Pass 2: Checking directory structure
	Entry '..' in .../??? (13) has deleted/unused inode 12.  Clear<y>? yes
	Pass 3: Checking directory connectivity
	Unconnected directory inode 13 (...)
	Connect to /lost+found<y>? yes
	Pass 4: Checking reference counts
	Inode 13 ref count is 3, should be 2.  Fix<y>? yes
	Pass 5: Checking group summary information

	/dev/sda: ***** FILE SYSTEM WAS MODIFIED *****
	/dev/sda: 12/131072 files (0.0% non-contiguous), 26157/524288 blocks

ext4_rmdir
	if (!ext4_empty_dir(inode))
		goto end_rmdir;
ext4_empty_dir
	bh = ext4_read_dirblock(inode, 0, DIRENT_HTREE);
	if (IS_ERR(bh))
		return true;
Now if read directory block failed, 'ext4_empty_dir' will return true, assume
directory is empty. Obviously, it will lead to above issue.
To solve this issue, if read directory block failed 'ext4_empty_dir' just
return false. To avoid making things worse when file system is already
corrupted, 'ext4_empty_dir' also return false.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/inline.c |  9 ++++-----
 fs/ext4/namei.c  | 10 +++++-----
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index e42941803605..9c076262770d 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1783,19 +1783,20 @@ bool empty_inline_dir(struct inode *dir, int *has_inline_data)
 	void *inline_pos;
 	unsigned int offset;
 	struct ext4_dir_entry_2 *de;
-	bool ret = true;
+	bool ret = false;
 
 	err = ext4_get_inode_loc(dir, &iloc);
 	if (err) {
 		EXT4_ERROR_INODE_ERR(dir, -err,
 				     "error %d getting inode %lu block",
 				     err, dir->i_ino);
-		return true;
+		return false;
 	}
 
 	down_read(&EXT4_I(dir)->xattr_sem);
 	if (!ext4_has_inline_data(dir)) {
 		*has_inline_data = 0;
+		ret = true;
 		goto out;
 	}
 
@@ -1804,7 +1805,6 @@ bool empty_inline_dir(struct inode *dir, int *has_inline_data)
 		ext4_warning(dir->i_sb,
 			     "bad inline directory (dir #%lu) - no `..'",
 			     dir->i_ino);
-		ret = true;
 		goto out;
 	}
 
@@ -1823,16 +1823,15 @@ bool empty_inline_dir(struct inode *dir, int *has_inline_data)
 				     dir->i_ino, le32_to_cpu(de->inode),
 				     le16_to_cpu(de->rec_len), de->name_len,
 				     inline_size);
-			ret = true;
 			goto out;
 		}
 		if (le32_to_cpu(de->inode)) {
-			ret = false;
 			goto out;
 		}
 		offset += ext4_rec_len_from_disk(de->rec_len, inline_size);
 	}
 
+	ret = true;
 out:
 	up_read(&EXT4_I(dir)->xattr_sem);
 	brelse(iloc.bh);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 8cf0a924a49b..39e223f7bf64 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2997,14 +2997,14 @@ bool ext4_empty_dir(struct inode *inode)
 	if (inode->i_size < ext4_dir_rec_len(1, NULL) +
 					ext4_dir_rec_len(2, NULL)) {
 		EXT4_ERROR_INODE(inode, "invalid size");
-		return true;
+		return false;
 	}
 	/* The first directory block must not be a hole,
 	 * so treat it as DIRENT_HTREE
 	 */
 	bh = ext4_read_dirblock(inode, 0, DIRENT_HTREE);
 	if (IS_ERR(bh))
-		return true;
+		return false;
 
 	de = (struct ext4_dir_entry_2 *) bh->b_data;
 	if (ext4_check_dir_entry(inode, NULL, de, bh, bh->b_data, bh->b_size,
@@ -3012,7 +3012,7 @@ bool ext4_empty_dir(struct inode *inode)
 	    le32_to_cpu(de->inode) != inode->i_ino || strcmp(".", de->name)) {
 		ext4_warning_inode(inode, "directory missing '.'");
 		brelse(bh);
-		return true;
+		return false;
 	}
 	offset = ext4_rec_len_from_disk(de->rec_len, sb->s_blocksize);
 	de = ext4_next_entry(de, sb->s_blocksize);
@@ -3021,7 +3021,7 @@ bool ext4_empty_dir(struct inode *inode)
 	    le32_to_cpu(de->inode) == 0 || strcmp("..", de->name)) {
 		ext4_warning_inode(inode, "directory missing '..'");
 		brelse(bh);
-		return true;
+		return false;
 	}
 	offset += ext4_rec_len_from_disk(de->rec_len, sb->s_blocksize);
 	while (offset < inode->i_size) {
@@ -3035,7 +3035,7 @@ bool ext4_empty_dir(struct inode *inode)
 				continue;
 			}
 			if (IS_ERR(bh))
-				return true;
+				return false;
 		}
 		de = (struct ext4_dir_entry_2 *) (bh->b_data +
 					(offset & (sb->s_blocksize - 1)));
-- 
2.31.1

