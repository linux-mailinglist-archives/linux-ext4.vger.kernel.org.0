Return-Path: <linux-ext4+bounces-3802-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595CE9588B8
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 16:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8873B21154
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 14:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC871922E5;
	Tue, 20 Aug 2024 14:11:51 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD31F1917CB
	for <linux-ext4@vger.kernel.org>; Tue, 20 Aug 2024 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724163111; cv=none; b=iJvZEcXFg2YWoFgQkDJI3BOAK12oThurM5KMVjh8y1RbRh3i6DRUPGnLuANYFS5sgRGO9FFj+MnaOoswG4uNCuGp6bYczCbM3XvtFLeO3lZCVcid7IPLWp3uWQm0Mg0XmG/qYW6oKjw5tPUQZsS9fGwT1wL63Pn32sPl3dWSvOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724163111; c=relaxed/simple;
	bh=oyFJwQ6CJco6l2jvEpleg1wYg1Sp8qMEpYz3tF60jyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q96m/Sp5SUk92+KTMp5RWaM7ntPe3fO2I/OLIn6Kmu2uSpCEahQ14fM6SactN2VZFpFmGWdieABAUnWnMAyPzr49hFYcp6bmMOglQi7+V5dFn3/P0gRGDJRWrZM6olNB4bsk/btEsRLclvWiYOcWhIDDuK2eidJUT1TQ8eMzO/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WpBGS5Jmlz4f3jdL
	for <linux-ext4@vger.kernel.org>; Tue, 20 Aug 2024 22:11:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D7CBA1A14F8
	for <linux-ext4@vger.kernel.org>; Tue, 20 Aug 2024 22:11:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCXv4UTpMRmyr3nCA--.45152S4;
	Tue, 20 Aug 2024 22:11:38 +0800 (CST)
From: yangerkun <yangerkun@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz
Cc: linux-ext4@vger.kernel.org,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com,
	chengzhihao1@huawei.com
Subject: [PATCH 1/2] ext4: dax: Fix overflowing extents beyond inode size when partially writing
Date: Tue, 20 Aug 2024 22:06:56 +0800
Message-Id: <20240820140657.3685287-1-yangerkun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXv4UTpMRmyr3nCA--.45152S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAF4ftr1UZF18Cry8Jry8AFb_yoW5Wr1xpr
	9xKFyY9rWvqasFgay8tF4DZw4jk3W7GrWUCF1UKwn0vF9rZryfKF1jyF4FvF15JrWkuF17
	XrsYyry8u3W2y3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

From: Zhihao Cheng <chengzhihao1@huawei.com>

The dax_iomap_rw() does two things in each iteration: map written blocks
and copy user data to blocks. If the process is killed by user(See signal
handling in dax_iomap_iter()), the copied data will be returned and added
on inode size, which means that the length of written extents may exceed
the inode size, then fsck will fail. An example is given as:

dd if=/dev/urandom of=file bs=4M count=1
 dax_iomap_rw
  iomap_iter // round 1
   ext4_iomap_begin
    ext4_iomap_alloc // allocate 0~2M extents(written flag)
  dax_iomap_iter // copy 2M data
  iomap_iter // round 2
   iomap_iter_advance
    iter->pos += iter->processed // iter->pos = 2M
   ext4_iomap_begin
    ext4_iomap_alloc // allocate 2~4M extents(written flag)
  dax_iomap_iter
   fatal_signal_pending
  done = iter->pos - iocb->ki_pos // done = 2M
 ext4_handle_inode_extension
  ext4_update_inode_size // inode size = 2M

fsck reports: Inode 13, i_size is 2097152, should be 4194304.  Fix?

Fix the problem by truncating extents if the written length is smaller
than expected.

Fixes: 776722e85d3b ("ext4: DAX iomap write support")
CC: stable@vger.kernel.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=219136
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index c89e434db6b7..be061bb64067 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -334,10 +334,10 @@ static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
  * Clean up the inode after DIO or DAX extending write has completed and the
  * inode size has been updated using ext4_handle_inode_extension().
  */
-static void ext4_inode_extension_cleanup(struct inode *inode, ssize_t count)
+static void ext4_inode_extension_cleanup(struct inode *inode, bool need_trunc)
 {
 	lockdep_assert_held_write(&inode->i_rwsem);
-	if (count < 0) {
+	if (need_trunc) {
 		ext4_truncate_failed_write(inode);
 		/*
 		 * If the truncate operation failed early, then the inode may
@@ -586,7 +586,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		 * writeback of delalloc blocks.
 		 */
 		WARN_ON_ONCE(ret == -EIOCBQUEUED);
-		ext4_inode_extension_cleanup(inode, ret);
+		ext4_inode_extension_cleanup(inode, ret < 0);
 	}
 
 out:
@@ -670,7 +670,7 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (extend) {
 		ret = ext4_handle_inode_extension(inode, offset, ret);
-		ext4_inode_extension_cleanup(inode, ret);
+		ext4_inode_extension_cleanup(inode, ret < (ssize_t)count);
 	}
 out:
 	inode_unlock(inode);
-- 
2.39.2


