Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A9D641601
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Dec 2022 11:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiLCKk0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 3 Dec 2022 05:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiLCKkZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 3 Dec 2022 05:40:25 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239623E0BF
        for <linux-ext4@vger.kernel.org>; Sat,  3 Dec 2022 02:40:22 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NPRCh6Tvqz4f3pG1
        for <linux-ext4@vger.kernel.org>; Sat,  3 Dec 2022 18:40:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgDXSNZ9J4tjGg1SBg--.27102S4;
        Sat, 03 Dec 2022 18:40:19 +0800 (CST)
From:   Zhang Yi <yi.zhang@huawei.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [RFC PATCH] ext4: dio take shared inode lock when overwriting preallocated blocks
Date:   Sat,  3 Dec 2022 18:39:56 +0800
Message-Id: <20221203103956.3691847-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDXSNZ9J4tjGg1SBg--.27102S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWUZry5tw15Zw43ArWfuFg_yoWrKr43pF
        y3KF13XrZFgryxWrZ5ta4Ivw1Ygws5ArWxArW3Gw15ZryUWryxtFyUXF1Yya4rJ3yxJ3W2
        qFs0k34DWF1UtrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0aVACjI8F5VA0II8E6IAqYI8I648v4I1l
        42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07x20xyl4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x07UAnYwUUUUU=
Sender: yi.zhang@huaweicloud.com
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In the dio write path, we only take shared inode lock for the case of
aligned overwriting initialized blocks inside EOF. But for overwriting
preallocated blocks, it may only need to split unwritten extents, this
procedure has been protected under i_data_sem lock, it's safe to
release the exclusive inode lock and take shared inode lock.

This could give a significant speed up for multi-threaded writes. Test
on Intel Xeon Gold 6140 and nvme SSD with below fio parameters.

 direct=1
 ioengine=libaio
 iodepth=10
 numjobs=10
 runtime=60
 rw=randwrite
 size=100G

And the test result are:
Before:
 bs=4k       IOPS=11.1k, BW=43.2MiB/s
 bs=16k      IOPS=11.1k, BW=173MiB/s
 bs=64k      IOPS=11.2k, BW=697MiB/s

After:
 bs=4k       IOPS=41.4k, BW=162MiB/s
 bs=16k      IOPS=41.3k, BW=646MiB/s
 bs=64k      IOPS=13.5k, BW=843MiB/s

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 It passed xfstests auto mode with 1k and 4k blocksize.

 fs/ext4/file.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index a7a597c727e6..7edac94025ac 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -202,8 +202,9 @@ ext4_extending_io(struct inode *inode, loff_t offset, size_t len)
 	return false;
 }
 
-/* Is IO overwriting allocated and initialized blocks? */
-static bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len)
+/* Is IO overwriting allocated or initialized blocks? */
+static bool ext4_overwrite_io(struct inode *inode,
+			      loff_t pos, loff_t len, bool *inited)
 {
 	struct ext4_map_blocks map;
 	unsigned int blkbits = inode->i_blkbits;
@@ -217,12 +218,15 @@ static bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len)
 	blklen = map.m_len;
 
 	err = ext4_map_blocks(NULL, inode, &map, 0);
+	if (err != blklen)
+		return false;
 	/*
 	 * 'err==len' means that all of the blocks have been preallocated,
-	 * regardless of whether they have been initialized or not. To exclude
-	 * unwritten extents, we need to check m_flags.
+	 * regardless of whether they have been initialized or not. We need to
+	 * check m_flags to distinguish the unwritten extents.
 	 */
-	return err == blklen && (map.m_flags & EXT4_MAP_MAPPED);
+	*inited = !!(map.m_flags & EXT4_MAP_MAPPED);
+	return true;
 }
 
 static ssize_t ext4_generic_write_checks(struct kiocb *iocb,
@@ -431,11 +435,16 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
  * - For extending writes case we don't take the shared lock, since it requires
  *   updating inode i_disksize and/or orphan handling with exclusive lock.
  *
- * - shared locking will only be true mostly with overwrites. Otherwise we will
- *   switch to exclusive i_rwsem lock.
+ * - shared locking will only be true mostly with overwrites, include
+ *   initialized blocks and unwritten blocks. For overwrite unwritten blocks
+ *   we protects splitting extents by i_data_sem in ext4_inode_info, so we can
+ *   also release exclusive i_rwsem lock.
+ *
+ * - Otherwise we will switch to exclusive i_rwsem lock.
  */
 static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
-				     bool *ilock_shared, bool *extend)
+				     bool *ilock_shared, bool *extend,
+				     bool *overwrite)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
@@ -459,7 +468,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 	 * in file_modified().
 	 */
 	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
-	     !ext4_overwrite_io(inode, offset, count))) {
+	     !ext4_overwrite_io(inode, offset, count, overwrite))) {
 		if (iocb->ki_flags & IOCB_NOWAIT) {
 			ret = -EAGAIN;
 			goto out;
@@ -491,7 +500,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	loff_t offset = iocb->ki_pos;
 	size_t count = iov_iter_count(from);
 	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
-	bool extend = false, unaligned_io = false;
+	bool extend = false, unaligned_io = false, overwrite = false;
 	bool ilock_shared = true;
 
 	/*
@@ -534,7 +543,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		return ext4_buffered_write_iter(iocb, from);
 	}
 
-	ret = ext4_dio_write_checks(iocb, from, &ilock_shared, &extend);
+	ret = ext4_dio_write_checks(iocb, from,
+				    &ilock_shared, &extend, &overwrite);
 	if (ret <= 0)
 		return ret;
 
@@ -582,7 +592,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		ext4_journal_stop(handle);
 	}
 
-	if (ilock_shared)
+	if (overwrite)
 		iomap_ops = &ext4_iomap_overwrite_ops;
 	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
 			   (unaligned_io || extend) ? IOMAP_DIO_FORCE_WAIT : 0,
-- 
2.31.1

