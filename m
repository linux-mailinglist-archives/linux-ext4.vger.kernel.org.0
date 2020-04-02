Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E8B19BAC0
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Apr 2020 05:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733283AbgDBDtj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Apr 2020 23:49:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12668 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732439AbgDBDtj (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 1 Apr 2020 23:49:39 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 45DDD2E4A07293643E83;
        Thu,  2 Apr 2020 11:49:32 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Apr 2020
 11:49:23 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH -next] ext4: remove set but not used variable 'es' in ext4_jbd2.c
Date:   Thu, 2 Apr 2020 11:47:59 +0800
Message-ID: <20200402034759.29957-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fix the following gcc warning:

fs/ext4/ext4_jbd2.c:341:30: warning: variable 'es' set but not used [-Wunused-but-set-variable]
     struct ext4_super_block *es;
                              ^~

Fixes: 2ea2fc775321 ("ext4: save all error info in save_error_info() and drop ext4_set_errno()")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/ext4/ext4_jbd2.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 7f16e1af8d5c..0c76cdd44d90 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -338,9 +338,6 @@ int __ext4_handle_dirty_metadata(const char *where, unsigned int line,
 		if (inode && inode_needs_sync(inode)) {
 			sync_dirty_buffer(bh);
 			if (buffer_req(bh) && !buffer_uptodate(bh)) {
-				struct ext4_super_block *es;
-
-				es = EXT4_SB(inode->i_sb)->s_es;
 				ext4_error_inode_err(inode, where, line,
 						     bh->b_blocknr, EIO,
 					"IO error syncing itable block");
-- 
2.17.2

