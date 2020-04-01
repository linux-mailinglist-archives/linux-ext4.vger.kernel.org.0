Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 923F019A653
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Apr 2020 09:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbgDAHfE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Apr 2020 03:35:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12595 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731870AbgDAHfD (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 1 Apr 2020 03:35:03 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 818B5F262207DA92C326;
        Wed,  1 Apr 2020 15:35:00 +0800 (CST)
Received: from localhost (10.173.223.234) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 1 Apr 2020
 15:34:51 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ext4: Fix build error while CONFIG_PRINTK is n
Date:   Wed, 1 Apr 2020 15:30:38 +0800
Message-ID: <20200401073038.33076-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

fs/ext4/balloc.c: In function ‘ext4_wait_block_bitmap’:
fs/ext4/balloc.c:519:3: error: implicit declaration of function ‘ext4_error_err’; did you mean ‘ext4_error’? [-Werror=implicit-function-declaration]
   ext4_error_err(sb, EIO, "Cannot read block bitmap - "
   ^~~~~~~~~~~~~~

Add missing stub helper and fix ext4_abort.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 2ea2fc775321 ("ext4: save all error info in save_error_info() and drop ext4_set_errno()")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/ext4/ext4.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index eacd2f9cc833..aa8466d28787 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2848,6 +2848,11 @@ do {									\
 	no_printk(fmt, ##__VA_ARGS__);					\
 	__ext4_error_inode(inode, "", 0, block, 0, " ");		\
 } while (0)
+#define ext4_error_inode_err(inode, func, line, block, err, fmt, ...)	\
+do {									\
+	no_printk(fmt, ##__VA_ARGS__);					\
+	__ext4_error_inode(inode, "", 0, block, 0, " ");		\
+} while (0)
 #define ext4_error_file(file, func, line, block, fmt, ...)		\
 do {									\
 	no_printk(fmt, ##__VA_ARGS__);					\
@@ -2858,10 +2863,15 @@ do {									\
 	no_printk(fmt, ##__VA_ARGS__);					\
 	__ext4_error(sb, "", 0, 0, 0, " ");				\
 } while (0)
-#define ext4_abort(sb, fmt, ...)					\
+#define ext4_error_err(sb, err, fmt, ...)				\
+do {									\
+	no_printk(fmt, ##__VA_ARGS__);					\
+	__ext4_error((sb), "", 0, 0, 0, " ");				\
+} while (0)
+#define ext4_abort(sb, err, fmt, ...)					\
 do {									\
 	no_printk(fmt, ##__VA_ARGS__);					\
-	__ext4_abort(sb, "", 0, " ");					\
+	__ext4_abort(sb, "", 0, 0, " ");				\
 } while (0)
 #define ext4_warning(sb, fmt, ...)					\
 do {									\
-- 
2.17.1


