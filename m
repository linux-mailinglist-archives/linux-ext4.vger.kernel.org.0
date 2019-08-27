Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E60E69DB84
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2019 04:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfH0CGR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Aug 2019 22:06:17 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:40163 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728457AbfH0CGQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 26 Aug 2019 22:06:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TaZ3wnw_1566871553;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TaZ3wnw_1566871553)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 27 Aug 2019 10:05:53 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
        Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: [PATCH 2/3] Revert "ext4: fix off-by-one error when writing back pages before dio read"
Date:   Tue, 27 Aug 2019 10:05:51 +0800
Message-Id: <1566871552-60946-3-git-send-email-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1566871552-60946-1-git-send-email-joseph.qi@linux.alibaba.com>
References: <1566871552-60946-1-git-send-email-joseph.qi@linux.alibaba.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This reverts commit e5465795cac4 ("ext4: fix off-by-one error when
writing back pages before dio read").
It is related to the following revert 16c54688592c ("ext4: Allow
parallel DIO reads") which causes significant performance regression in
mixed random read/write scenario.

Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0f505f0..16077ec 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3875,7 +3875,7 @@ static ssize_t ext4_direct_IO_read(struct kiocb *iocb, struct iov_iter *iter)
 	 */
 	inode_lock_shared(inode);
 	ret = filemap_write_and_wait_range(mapping, iocb->ki_pos,
-					   iocb->ki_pos + count - 1);
+					   iocb->ki_pos + count);
 	if (ret)
 		goto out_unlock;
 	ret = __blockdev_direct_IO(iocb, inode, inode->i_sb->s_bdev,
-- 
1.8.3.1

