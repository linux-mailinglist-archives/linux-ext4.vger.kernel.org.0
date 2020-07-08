Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BF7218B64
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jul 2020 17:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbgGHPfW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jul 2020 11:35:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:54670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730237AbgGHPfW (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 8 Jul 2020 11:35:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6526EABE2;
        Wed,  8 Jul 2020 15:35:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C0D951E12BF; Wed,  8 Jul 2020 17:35:20 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: Do not block RWF_NOWAIT dio write on unallocated space
Date:   Wed,  8 Jul 2020 17:35:16 +0200
Message-Id: <20200708153516.9507-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since commit 378f32bab371 ("ext4: introduce direct I/O write using iomap
infrastructure") we don't properly bail out of RWF_NOWAIT direct IO
write if underlying blocks are not allocated. Also
ext4_dio_write_checks() does not honor RWF_NOWAIT when re-acquiring
i_rwsem. Fix both issues.

Fixes: 378f32bab371 ("ext4: introduce direct I/O write using iomap infrastructure")
Reported-by: Filipe Manana <fdmanana@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 2a01e31a032c..8f742b53f1d4 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -428,6 +428,10 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 	 */
 	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
 	     !ext4_overwrite_io(inode, offset, count))) {
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			ret = -EAGAIN;
+			goto out;
+		}
 		inode_unlock_shared(inode);
 		*ilock_shared = false;
 		inode_lock(inode);
-- 
2.16.4

