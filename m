Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441E31B55A0
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Apr 2020 09:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgDWH1h (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Apr 2020 03:27:37 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:41145 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725562AbgDWH1g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 23 Apr 2020 03:27:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TwPIcx9_1587626854;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0TwPIcx9_1587626854)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 23 Apr 2020 15:27:34 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     tytso@mit.edu, jack@suse.cz
Cc:     linux-ext4@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: [PATCH] ext4: fix error pointer dereference
Date:   Thu, 23 Apr 2020 15:27:34 +0800
Message-Id: <1587626854-73470-1-git-send-email-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Don't pass error pointers to brelse().

commit 7159a986b420 ("ext4: fix some error pointer dereferences") has fixed
some cases, fix the remaining one case.

Once ext4_xattr_block_find()->ext4_sb_bread() failed, error pointer is
stored in @bs->bh, which will be passed to brelse() in the cleanup
routine of ext4_xattr_set_handle(). This will then cause a NULL panic
crash in __brelse().

BUG: unable to handle kernel NULL pointer dereference at 000000000000005b
RIP: 0010:__brelse+0x1b/0x50
Call Trace:
 ext4_xattr_set_handle+0x163/0x5d0
 ext4_xattr_set+0x95/0x110
 __vfs_setxattr+0x6b/0x80
 __vfs_setxattr_noperm+0x68/0x1b0
 vfs_setxattr+0xa0/0xb0
 setxattr+0x12c/0x1a0
 path_setxattr+0x8d/0xc0
 __x64_sys_setxattr+0x27/0x30
 do_syscall_64+0x60/0x250
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

In this case, @bs->bh stores '-EIO' actually.

Fixes: fb265c9cb49e ("ext4: add ext4_sb_bread() to disambiguate ENOMEM cases")
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: stable@kernel.org # 2.6.19
---
 fs/ext4/xattr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 21df43a..c0ebd0f 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1800,8 +1800,10 @@ struct ext4_xattr_block_find {
 	if (EXT4_I(inode)->i_file_acl) {
 		/* The inode already has an extended attribute block. */
 		bs->bh = ext4_sb_bread(sb, EXT4_I(inode)->i_file_acl, REQ_PRIO);
-		if (IS_ERR(bs->bh))
+		if (IS_ERR(bs->bh)) {
+			bs->bh = NULL;
 			return PTR_ERR(bs->bh);
+		}
 		ea_bdebug(bs->bh, "b_count=%d, refcount=%d",
 			atomic_read(&(bs->bh->b_count)),
 			le32_to_cpu(BHDR(bs->bh)->h_refcount));
-- 
1.8.3.1

