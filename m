Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB9A25F7D
	for <lists+linux-ext4@lfdr.de>; Wed, 22 May 2019 10:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbfEVI25 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Wed, 22 May 2019 04:28:57 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25346 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728525AbfEVI25 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 May 2019 04:28:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1558513733; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=QXOxlcyb0xWm5UmWF0fhCvKzfaudTpeVoTtR8UBH/lKL+k8cAm4LU5Zhh/s8vmnwdJrnOqTF/DmZUL4EoVGXh5qszOU/tVMKqlQ+Xc/VjjoeNRyU5GJBP8sxYvZH3LYmM/my6y+FJrv8EOIx4Ssz7g+DiuaD2KYJXsMTgaK27G8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1558513733; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=50yJu5N8UlW2XLpAfHmVboNt2TktCFuZeCLTmoYA/cE=; 
        b=HRnPgI2ua0Cf75qte3eRstCVmDMmIRqafBofrL6ZfrRd8MVGiX0fObemfMy0UdlTsn7NqO53012pM1ylS6cJRGxf7p+vneFckNSXQYqk5/S7tPnajCKOsjMzR1I+TlXxk1hI4LmkSh7uKUI8DBE7DcjXUC0hFRVRZ0BevCfh0fA=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1558513729645173.3668879941324; Wed, 22 May 2019 16:28:49 +0800 (CST)
From:   Chengguang Xu <cgxu519@zoho.com.cn>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@zoho.com.cn>
Message-ID: <20190522082846.22296-1-cgxu519@zoho.com.cn>
Subject: [PATCH] ext2: strengthen value length check in ext2_xattr_set()
Date:   Wed, 22 May 2019 16:28:46 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Actually maximum length of a valid entry value is not
->s_blocksize because header, last entry and entry
name will also occupy some spaces. This patch
strengthens the value length check and return -ERANGE
when the length is larger than allowed maximum length.

Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>
---
 fs/ext2/xattr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index f1f857b83b45..425c8e29d3cb 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -399,7 +399,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 	struct buffer_head *bh = NULL;
 	struct ext2_xattr_header *header = NULL;
 	struct ext2_xattr_entry *here, *last;
-	size_t name_len, free, min_offs = sb->s_blocksize;
+	size_t name_len, free, min_offs = sb->s_blocksize, max_len;
 	int not_found = 1, error;
 	char *end;
 	
@@ -423,7 +423,10 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
 	if (name == NULL)
 		return -EINVAL;
 	name_len = strlen(name);
-	if (name_len > 255 || value_len > sb->s_blocksize)
+	max_len = sb->s_blocksize - sizeof(struct ext2_xattr_header)
+			- sizeof(__u32);
+	if (name_len > 255 ||
+	    EXT2_XATTR_LEN(name_len) + EXT2_XATTR_SIZE(value_len) > max_len)
 		return -ERANGE;
 	down_write(&EXT2_I(inode)->xattr_sem);
 	if (EXT2_I(inode)->i_file_acl) {
-- 
2.20.1



