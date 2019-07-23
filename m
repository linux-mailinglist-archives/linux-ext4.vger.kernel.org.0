Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E27D716DF
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2019 13:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389318AbfGWLWW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 23 Jul 2019 07:22:22 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25363 "EHLO
        sender2-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726709AbfGWLWW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 23 Jul 2019 07:22:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1563880931; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=lu0LElcGejUkU6xUeWMSQexEjqLuwzsaletnFqUbOm0vuW/x35UUQtCjhxCDdRcAFAuzeGQRPumiAD5oDWPOJXFzSU0kKFH3GRarWrixHph2UDdC500D6qQkR6Ng0jNjs2ou3fmjXUhSTXkCAJ6ylzV90OTgKMCf8qFesnMmtcw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1563880931; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=EibNqr3LJK70MILEuH5k7/P6ghQZzaOI2i3nzTk6abo=; 
        b=hE3G+MeJ2gxmUXcvOa2/9Tms3+znM/jSCpb3xmYvZpdaLpJeAG9rY+nuIsRCs0MRs3cJE6eUZpgrOI7TFykmQ+vGeiqSMUd7P+1iNDtg1QUu+MbOYUoqOyGCTB37qEENS3jEY1DdaNhd5xpaHz4jCKc6JYtSV809j8O5LHgJLUc=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1563880930261526.1255951672782; Tue, 23 Jul 2019 19:22:10 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>
Message-ID: <20190723112155.20329-1-cgxu519@zoho.com.cn>
Subject: [PATCH 1/2] ext2: fix block range in ext2_data_block_valid()
Date:   Tue, 23 Jul 2019 19:21:54 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

For block validity we should check the block range
from start_block to start_block + count - 1, so fix
the range in ext2_data_block_valid() and also modify
the count argument properly in calling place.

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
 fs/ext2/balloc.c | 6 +++---
 fs/ext2/xattr.c  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index 547c165299c0..92e9a7489174 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -1203,13 +1203,13 @@ int ext2_data_block_valid(struct ext2_sb_info *sbi, ext2_fsblk_t start_blk,
 			  unsigned int count)
 {
 	if ((start_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
-	    (start_blk + count < start_blk) ||
-	    (start_blk > le32_to_cpu(sbi->s_es->s_blocks_count)))
+	    (start_blk + count - 1 < start_blk) ||
+	    (start_blk + count - 1 >= le32_to_cpu(sbi->s_es->s_blocks_count)))
 		return 0;
 
 	/* Ensure we do not step over superblock */
 	if ((start_blk <= sbi->s_sb_block) &&
-	    (start_blk + count >= sbi->s_sb_block))
+	    (start_blk + count - 1 >= sbi->s_sb_block))
 		return 0;
 
 	return 1;
diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index 79369c13cc55..0456bc990b5e 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -794,7 +794,7 @@ ext2_xattr_delete_inode(struct inode *inode)
 	if (!EXT2_I(inode)->i_file_acl)
 		goto cleanup;
 
-	if (!ext2_data_block_valid(sbi, EXT2_I(inode)->i_file_acl, 0)) {
+	if (!ext2_data_block_valid(sbi, EXT2_I(inode)->i_file_acl, 1)) {
 		ext2_error(inode->i_sb, "ext2_xattr_delete_inode",
 			"inode %ld: xattr block %d is out of data blocks range",
 			inode->i_ino, EXT2_I(inode)->i_file_acl);
-- 
2.20.1



