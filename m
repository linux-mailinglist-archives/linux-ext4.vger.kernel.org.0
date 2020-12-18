Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D202DE366
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Dec 2020 14:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgLRNqJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Dec 2020 08:46:09 -0500
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17133 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbgLRNqJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 18 Dec 2020 08:46:09 -0500
X-Greylist: delayed 1004 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Dec 2020 08:46:03 EST
ARC-Seal: i=1; a=rsa-sha256; t=1608298110; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=PJI7BSydzTDGXQv6doml7CFfNUR21WMLzEVJPFm+l28KUGHdaiabDlEfo5gpMwgDyY4+bArGrCbwkpp3OvyUergcnH+YIsBn8nPjih8jQbKbWYzezcRPzl9+/g+6e3Y7xo2VGqxIZ1ikY4xXVdVFnlVUO1qovt/4M0Q4yFqPPb0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1608298110; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=awXflIhmEnSwwuTtk1iHfgGZL5MVwlaN1kgEGSNkTpc=; 
        b=qz077Y75qUZOfx5oVKsANHnZ422weEAdjJnb7PjpkcBkwfc5xdeDTbAHzH+sHJ+xubbNmDE3lgNGpgh5TRDo5ij7v4+R1jTj5E1UNamrNmGBoboDCmncpEH5Qqe8MVFCjviJHGGIRCAOhICNYl9sho8FL/5s0hrV6wZqiJ2nHAQ=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1608298110;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=awXflIhmEnSwwuTtk1iHfgGZL5MVwlaN1kgEGSNkTpc=;
        b=JerxTB0+0t4gqLPZMPA8LHkSj3wlzDo7aCiQlapj3h5+Cyogs3wvNMh9oURQT0XX
        aa4m7UU/CdFVuQvQw6yKhpjWJYKbb8bJr/Nte+ayS1t4JPXWw/dJjRgH7S2HmP2gUsJ
        aIxJLmWtpaZxXsqgDIuAr2p4jkKdX69vnUCAHGuE=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 1608298107117568.1965624674809; Fri, 18 Dec 2020 21:28:27 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Subject: [PATCH] ext2: implement ->page_mkwrite
Date:   Fri, 18 Dec 2020 21:27:57 +0800
Message-Id: <20201218132757.279685-1-cgxu519@mykernel.net>
X-Mailer: git-send-email 2.18.4
X-ZohoCNMailClient: External
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently ext2 uses generic mmap operations for non DAX file and
filemap_page_mkwrite() does not check the block allocation for
shared writable mmapped area on pagefault. In some cases like
disk space exhaustion or disk quota limitation, it will cause silent
data loss. This patch tries to check and do block preallocation on
pagefault if necessary and explicitly return error to user when
allocation failure.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/ext2/file.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 96044f5dbc0e..a34119415ef1 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -25,10 +25,34 @@
 #include <linux/quotaops.h>
 #include <linux/iomap.h>
 #include <linux/uio.h>
+#include <linux/buffer_head.h>
 #include "ext2.h"
 #include "xattr.h"
 #include "acl.h"
 
+vm_fault_t ext2_page_mkwrite(struct vm_fault *vmf)
+{
+	struct vm_area_struct *vma = vmf->vma;
+	struct inode *inode = file_inode(vma->vm_file);
+	int err;
+
+	if (unlikely(IS_IMMUTABLE(inode)))
+		return VM_FAULT_SIGBUS;
+
+	sb_start_pagefault(inode->i_sb);
+	file_update_time(vma->vm_file);
+	err = block_page_mkwrite(vma, vmf, ext2_get_block);
+	sb_end_pagefault(inode->i_sb);
+
+	return block_page_mkwrite_return(err);
+}
+
+const struct vm_operations_struct ext2_vm_ops = {
+	.fault		= filemap_fault,
+	.map_pages	= filemap_map_pages,
+	.page_mkwrite	= ext2_page_mkwrite,
+};
+
 #ifdef CONFIG_FS_DAX
 static ssize_t ext2_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
@@ -123,15 +147,23 @@ static const struct vm_operations_struct ext2_dax_vm_ops = {
 
 static int ext2_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	file_accessed(file);
 	if (!IS_DAX(file_inode(file)))
-		return generic_file_mmap(file, vma);
+		vma->vm_ops = &ext2_vm_ops;
+	else
+		vma->vm_ops = &ext2_dax_vm_ops;
 
-	file_accessed(file);
-	vma->vm_ops = &ext2_dax_vm_ops;
 	return 0;
 }
+
 #else
-#define ext2_file_mmap	generic_file_mmap
+static int ext2_file_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	file_accessed(file);
+	vma->vm_ops = &ext2_vm_ops;
+	return 0;
+}
+
 #endif
 
 /*
-- 
2.18.4

