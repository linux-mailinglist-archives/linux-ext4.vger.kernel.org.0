Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B466319BAB4
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Apr 2020 05:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387440AbgDBDlS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Apr 2020 23:41:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12667 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726205AbgDBDlS (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 1 Apr 2020 23:41:18 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B2384CA398F61C171289;
        Thu,  2 Apr 2020 11:41:10 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Apr 2020
 11:41:02 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH -next] ext4: remove set but not used variable 'es'
Date:   Thu, 2 Apr 2020 11:39:39 +0800
Message-ID: <20200402033939.25303-1-yanaijie@huawei.com>
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

fs/ext4/super.c:599:27: warning: variable 'es' set but not used [-Wunused-but-set-variable]
  struct ext4_super_block *es;
                           ^~
Fixes: 2ea2fc775321 ("ext4: save all error info in save_error_info() and drop ext4_set_errno()")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/ext4/super.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9728e7b0e84f..0725cb120b77 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -596,7 +596,6 @@ void __ext4_error_file(struct file *file, const char *function,
 {
 	va_list args;
 	struct va_format vaf;
-	struct ext4_super_block *es;
 	struct inode *inode = file_inode(file);
 	char pathname[80], *path;
 
@@ -604,7 +603,6 @@ void __ext4_error_file(struct file *file, const char *function,
 		return;
 
 	trace_ext4_error(inode->i_sb, function, line);
-	es = EXT4_SB(inode->i_sb)->s_es;
 	if (ext4_error_ratelimit(inode->i_sb)) {
 		path = file_path(file, pathname, sizeof(pathname));
 		if (IS_ERR(path))
-- 
2.17.2

