Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5952A3A69
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Nov 2020 03:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgKCC3F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Nov 2020 21:29:05 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:45787 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbgKCC3F (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Nov 2020 21:29:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UE2tfcu_1604370542;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UE2tfcu_1604370542)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Nov 2020 10:29:02 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Tao Ma <boyu.mt@taobao.com>
Subject: [PATCH] ext4: unlock xattr_sem properly in ext4_inline_data_truncate()
Date:   Tue,  3 Nov 2020 10:29:02 +0800
Message-Id: <1604370542-124630-1-git-send-email-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It takes xattr_sem to check inline data again but without unlock it
in case not have. So unlock it before return.

Fixes: aef1c8513c1f ("ext4: let ext4_truncate handle inline data correctly")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Tao Ma <boyu.mt@taobao.com>
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/ext4/inline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index caa5147..b41512d 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1880,6 +1880,7 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 
 	ext4_write_lock_xattr(inode, &no_expand);
 	if (!ext4_has_inline_data(inode)) {
+		ext4_write_unlock_xattr(inode, &no_expand);
 		*has_inline = 0;
 		ext4_journal_stop(handle);
 		return 0;
-- 
1.8.3.1

