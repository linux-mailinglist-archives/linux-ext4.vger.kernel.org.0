Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1440A3E014E
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Aug 2021 14:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238157AbhHDMkK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 08:40:10 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7921 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbhHDMkK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 08:40:10 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gfrnc2rvNz83vF;
        Wed,  4 Aug 2021 20:36:04 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 4 Aug 2021 20:39:54 +0800
Received: from localhost.localdomain (10.175.127.227) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 4 Aug 2021 20:39:53 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH] ext4: stop return ENOSPC from ext4_issue_zeroout
Date:   Wed, 4 Aug 2021 20:50:44 +0800
Message-ID: <20210804125044.2480435-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Our testcase(briefly described as fsstress on dm thin-provisioning which
ext4 see volume size with 100G but actual size 10G) trigger a hungtask
bug since ext4_writepages fall into a infinite loop:

static int ext4_writepages(xxx)
{
    ...
   while (!done && mpd.first_page <= mpd.last_page) {
       ...
       ret = mpage_prepare_extent_to_map(&mpd);
       if (!ret) {
           ...
           ret = mpage_map_and_submit_extent(handle,
&mpd,&give_up_on_write);
           <----- will return -ENOSPC
           ...
       }
       ...
       if (ret == -ENOSPC && sbi->s_journal) {
           <------ we cannot break since we will get ENOSPC forever
           jbd2_journal_force_commit_nested(sbi->s_journal);
           ret = 0;
           continue;
       }
       ...
   }
}

Got ENOSPC with follow stack:
...
ext4_ext_map_blocks
  ext4_ext_convert_to_initialized
    ext4_ext_zeroout
      ext4_issue_zeroout
        ...
        submit_bio_wait <-- bio to thinpool will return ENOSPC

'df22291ff0fd ("ext4: Retry block allocation if we have free blocks
left")' add the logic to retry block allcate since we may get free block
after we commit a transaction. But the ENOSPC from thin-provisioning
will confuse ext4, and lead the upper infinite loop. Fix it by convert
the err to EIO.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/ext4/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 038aebd7eb2f..d9ded699a88c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -428,6 +428,9 @@ int ext4_issue_zeroout(struct inode *inode, ext4_lblk_t lblk, ext4_fsblk_t pblk,
 	if (ret > 0)
 		ret = 0;
 
+	if (ret == -ENOSPC)
+		ret = -EIO;
+
 	return ret;
 }
 
-- 
2.31.1

