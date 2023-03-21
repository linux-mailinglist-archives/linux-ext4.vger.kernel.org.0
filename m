Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394FF6C2782
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Mar 2023 02:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjCUBiW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Mar 2023 21:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjCUBiV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Mar 2023 21:38:21 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0A1BB94;
        Mon, 20 Mar 2023 18:38:18 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PgZ443Zc8z9thY;
        Tue, 21 Mar 2023 09:37:56 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 21 Mar
 2023 09:38:16 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.com>,
        <tudor.ambarus@linaro.org>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v2] ext4: Fix i_disksize exceeding i_size problem in paritally written case
Date:   Tue, 21 Mar 2023 09:37:21 +0800
Message-ID: <20230321013721.89818-1-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Following process makes i_disksize exceed i_size:

generic_perform_write
 copied = iov_iter_copy_from_user_atomic(len) // copied < len
 ext4_da_write_end
 | ext4_update_i_disksize
 |  new_i_size = pos + copied;
 |  WRITE_ONCE(EXT4_I(inode)->i_disksize, newsize) // update i_disksize
 | generic_write_end
 |  copied = block_write_end(copied, len) // copied = 0
 |   if (unlikely(copied < len))
 |    if (!PageUptodate(page))
 |     copied = 0;
 |  if (pos + copied > inode->i_size) // return false
 if (unlikely(copied == 0))
  goto again;
 if (unlikely(iov_iter_fault_in_readable(i, bytes))) {
  status = -EFAULT;
  break;
 }

We get i_disksize greater than i_size here, which could trigger WARNING
check 'i_size_read(inode) < EXT4_I(inode)->i_disksize' while doing dio:

ext4_dio_write_iter
 iomap_dio_rw
  __iomap_dio_rw // return err, length is not aligned to 512
 ext4_handle_inode_extension
  WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize) // Oops

 WARNING: CPU: 2 PID: 2609 at fs/ext4/file.c:319
 CPU: 2 PID: 2609 Comm: aa Not tainted 6.3.0-rc2
 RIP: 0010:ext4_file_write_iter+0xbc7
 Call Trace:
  vfs_write+0x3b1
  ksys_write+0x77
  do_syscall_64+0x39

Fix it by updating 'copied' value before updating i_disksize just like
ext4_write_inline_data_end() does.

Fetch a reproducer in [Link].

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217209
Fixes: 64769240bd07 ("ext4: Add delayed allocation support in data=writeback mode")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 v1->v2: Check and update 'copied' value before updating i_disksize rather
	 than opencoding generic_write_end().
 fs/ext4/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bf0b7dea4900..41ba1c432844 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3148,6 +3148,9 @@ static int ext4_da_write_end(struct file *file,
 	    ext4_has_inline_data(inode))
 		return ext4_write_inline_data_end(inode, pos, len, copied, page);
 
+	if (unlikely(copied < len) && !PageUptodate(page))
+		copied = 0;
+
 	start = pos & (PAGE_SIZE - 1);
 	end = start + copied - 1;
 
-- 
2.31.1

