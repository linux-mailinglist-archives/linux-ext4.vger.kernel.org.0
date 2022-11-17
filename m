Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EDE62D089
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Nov 2022 02:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbiKQBVa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Nov 2022 20:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238678AbiKQBV3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Nov 2022 20:21:29 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9AD21BD;
        Wed, 16 Nov 2022 17:21:27 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NCMZB0Jh5z4f3mSK;
        Thu, 17 Nov 2022 09:21:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgAnmdaSjHVj0gCfAg--.26536S5;
        Thu, 17 Nov 2022 09:21:25 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>,
        syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
Subject: [PATCH 1/3] ext4: fix incorrect calculate 'reserved' in '__es_remove_extent' when enable bigalloc feature
Date:   Thu, 17 Nov 2022 09:42:44 +0800
Message-Id: <20221117014246.610202-2-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221117014246.610202-1-yebin@huaweicloud.com>
References: <20221117014246.610202-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnmdaSjHVj0gCfAg--.26536S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1UXr1rXF4UJF45CryrCrg_yoW8Kr48p3
        y8Ar4UWryfuw1UW3yftw1j9Fn29a4UCrW7WFs3t343uFy5A34Sgr10yFs0vFWYqrWIqw4U
        XF4rKw1jq3WUXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvmb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W0oVCq3wA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
        oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
        C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
        6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7IU1M7K7UUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

Syzbot report issue as follows:
EXT4-fs error (device loop0): ext4_validate_block_bitmap:398: comm rep: bg 0: block 5: invalid block bitmap
EXT4-fs (loop0): Delayed block allocation failed for inode 18 at logical offset 0 with max blocks 32 with error 28
EXT4-fs (loop0): This should not happen!! Data will be lost

EXT4-fs (loop0): Total free blocks count 0
EXT4-fs (loop0): Free/Dirty block details
EXT4-fs (loop0): free_blocks=0
EXT4-fs (loop0): dirty_blocks=32
EXT4-fs (loop0): Block reservation details
EXT4-fs (loop0): i_reserved_data_blocks=2
EXT4-fs (loop0): Inode 18 (00000000845cd634): i_reserved_data_blocks (1) not cleared!

Above issue happens as follows:
Assume:
sbi->s_cluster_ratio = 16
Step1: Insert delay block [0, 31] -> ei->i_reserved_data_blocks=2
Step2:
ext4_writepages
  mpage_map_and_submit_extent -> return failed
  mpage_release_unused_pages -> to release [0, 30]
    ext4_es_remove_extent -> remove lblk=0 end=30
      __es_remove_extent -> len1=0 len2=31-30=1
 __es_remove_extent:
 ...
 if (len2 > 0) {
  ...
	  if (len1 > 0) {
		  ...
	  } else {
		es->es_lblk = end + 1;
		es->es_len = len2;
		...
	  }
  	if (count_reserved)
		count_rsvd(inode, lblk, orig_es.es_len - len1 - len2, &orig_es, &rc);
	goto out; -> will return but didn't calculate 'reserved'
 ...
Step3: ext4_destroy_inode -> trigger "i_reserved_data_blocks (1) not cleared!"

To solve above issue if 'len2>0' call 'get_rsvd()' before goto out.

Reported-by: syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/extents_status.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index cd0a861853e3..4684eaea9471 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1371,7 +1371,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 		if (count_reserved)
 			count_rsvd(inode, lblk, orig_es.es_len - len1 - len2,
 				   &orig_es, &rc);
-		goto out;
+		goto count;
 	}
 
 	if (len1 > 0) {
@@ -1413,6 +1413,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 		}
 	}
 
+count:
 	if (count_reserved)
 		*reserved = get_rsvd(inode, end, es, &rc);
 out:
-- 
2.31.1

