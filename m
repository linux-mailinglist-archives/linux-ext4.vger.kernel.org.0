Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E74A32E780
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Mar 2021 12:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhCEL6c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Mar 2021 06:58:32 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13475 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhCEL60 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Mar 2021 06:58:26 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DsR6241fLzjWpT;
        Fri,  5 Mar 2021 19:56:26 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Fri, 5 Mar 2021
 19:58:02 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <yi.zhang@huawei.com>
Subject: [PATCH] ext4: do not try to set xattr into ea_inode if value is empty
Date:   Fri, 5 Mar 2021 20:05:08 +0800
Message-ID: <20210305120508.298465-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Syzbot report a warning that ext4 may create an empty ea_inode if set
an empty extent attribute to a file on the file system which is no free
blocks left.

  WARNING: CPU: 6 PID: 10667 at fs/ext4/xattr.c:1640 ext4_xattr_set_entry+0x10f8/0x1114 fs/ext4/xattr.c:1640
  ...
  Call trace:
   ext4_xattr_set_entry+0x10f8/0x1114 fs/ext4/xattr.c:1640
   ext4_xattr_block_set+0x1d0/0x1b1c fs/ext4/xattr.c:1942
   ext4_xattr_set_handle+0x8a0/0xf1c fs/ext4/xattr.c:2390
   ext4_xattr_set+0x120/0x1f0 fs/ext4/xattr.c:2491
   ext4_xattr_trusted_set+0x48/0x5c fs/ext4/xattr_trusted.c:37
   __vfs_setxattr+0x208/0x23c fs/xattr.c:177
  ...

Now, ext4 try to store extent attribute into an external inode if
ext4_xattr_block_set() return -ENOSPC, but for the case of store an
empty extent attribute, store the extent entry into the extent
attribute block is enough. A simple reproduce below.

  fallocate test.img -l 1M
  mkfs.ext4 -F -b 2048 -O ea_inode test.img
  mount test.img /mnt
  dd if=/dev/zero of=/mnt/foo bs=2048 count=500
  setfattr -n "user.test" /mnt/foo

Reported-by: syzbot+98b881fdd8ebf45ab4ae@syzkaller.appspotmail.com
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 372208500f4e..6aef74f7c9ee 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2400,7 +2400,7 @@ ext4_xattr_set_handle(handle_t *handle, struct inode *inode, int name_index,
 				 * external inode if possible.
 				 */
 				if (ext4_has_feature_ea_inode(inode->i_sb) &&
-				    !i.in_inode) {
+				    i.value_len && !i.in_inode) {
 					i.in_inode = 1;
 					goto retry_inode;
 				}
-- 
2.25.4

