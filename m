Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BED21131FC4
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2020 07:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgAGGYQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jan 2020 01:24:16 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45888 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbgAGGYQ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 7 Jan 2020 01:24:16 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3215F9CF0DF543897293;
        Tue,  7 Jan 2020 14:24:12 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Tue, 7 Jan 2020
 14:24:03 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <agruenba@redhat.com>,
        <darrick.wong@oracle.com>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ext4: remove unused variable 'mapping'
Date:   Tue, 7 Jan 2020 14:23:55 +0800
Message-ID: <20200107062355.40624-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

fs/ext4/inode.c: In function 'ext4_page_mkwrite':
fs/ext4/inode.c:5910:24: warning: unused variable 'mapping' [-Wunused-variable]

commit 4a58d8158f6d ("fs: Fix page_mkwrite off-by-one errors")
left behind this unused variable.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/ext4/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9a3e8d0..d0049fd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5907,7 +5907,6 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	vm_fault_t ret;
 	struct file *file = vma->vm_file;
 	struct inode *inode = file_inode(file);
-	struct address_space *mapping = inode->i_mapping;
 	handle_t *handle;
 	get_block_t *get_block;
 	int retries = 0;
-- 
2.7.4


