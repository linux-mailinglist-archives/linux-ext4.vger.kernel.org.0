Return-Path: <linux-ext4+bounces-3801-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F789588B7
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 16:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC9D1C224DA
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 14:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596B21922DE;
	Tue, 20 Aug 2024 14:11:51 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CA01922DD
	for <linux-ext4@vger.kernel.org>; Tue, 20 Aug 2024 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724163111; cv=none; b=dOlPdc+Gr3UkWFrqWbixapVzNY0M7y1v9HfVy//rVfLl7EwmwfSnBbHBJ2KhqC1rFUgei1EMddAh+35aMcvQeoLecH9XdSQ5Ekpg8VYYLXjdntXyUvCcyEtHC8xAPaNqfK1c3pbbhoyuIB1LNcSUWO/dxEmktUJTDpeGeRnVWiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724163111; c=relaxed/simple;
	bh=WMlpuClqocTi5icpTNJeg+M1maJ2QHVqkXStiElvm8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OZJ0cBYqoVzd+GyR9/+8ZtQ+drDaXjECpf89HZdujH9vcP+CHtjn+aDPD0sTNICKBudV+G53IDRtkC2RvYdSP8nt90PMDkYqIEXcoDlVk/dLoam7wWAxmyvtmJKGDupmMLfG8BO4qIhsVUkvGBssuHb/JSI5dx39h/t1tiZXfDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WpBGY4MG9z4f3l8Q
	for <linux-ext4@vger.kernel.org>; Tue, 20 Aug 2024 22:11:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3C44E1A0359
	for <linux-ext4@vger.kernel.org>; Tue, 20 Aug 2024 22:11:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCXv4UTpMRmyr3nCA--.45152S5;
	Tue, 20 Aug 2024 22:11:43 +0800 (CST)
From: yangerkun <yangerkun@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz
Cc: linux-ext4@vger.kernel.org,
	yangerkun@huawei.com,
	yangerkun@huaweicloud.com,
	chengzhihao1@huawei.com
Subject: [PATCH 2/2] ext4: dax: keep orphan list before truncate overflow allocated blocks
Date: Tue, 20 Aug 2024 22:06:57 +0800
Message-Id: <20240820140657.3685287-2-yangerkun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240820140657.3685287-1-yangerkun@huaweicloud.com>
References: <20240820140657.3685287-1-yangerkun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXv4UTpMRmyr3nCA--.45152S5
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4fKF4xCryfCF43ZF13Arb_yoW5Gr1xpF
	y3GF15Wr1kZas2grZ3KF4UZ34Fka1xC3yUWFWxWw1fZr9xXr1SqF1UtFyrtF45trW8W3WY
	gF4qyryDu3WUJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjX18JUUUUU==
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

From: yangerkun <yangerkun@huawei.com>

Any extended write for ext4 requires the inode to be placed on the
orphan list before the actual write. In addition, the inode can be
actually removed from the orphan list only after all writes are
completed. Otherwise, those overcommitted blocks (If the allocated
blocks are not written due to certain reasons, the inode size does not
exceed the offset of these blocks) The leak status is always retained,
and fsck reports an alarm for this scenario.

Currently, the dio and buffer IO comply with this logic. However, the
dax write will removed the inode from orphan list since
ext4_handle_inode_extension is unconditionally called during extend
write. Fix it with this patch. We open the code from
ext4_handle_inode_extension since we want to keep the blocks valid
has been allocated and write success.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/ext4/file.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index be061bb64067..fd8597eef75e 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -628,11 +628,12 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 static ssize_t
 ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	ssize_t ret;
+	ssize_t ret, written;
 	size_t count;
 	loff_t offset;
 	handle_t *handle;
 	bool extend = false;
+	bool need_trunc = true;
 	struct inode *inode = file_inode(iocb->ki_filp);
 
 	if (iocb->ki_flags & IOCB_NOWAIT) {
@@ -668,10 +669,36 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
 
-	if (extend) {
-		ret = ext4_handle_inode_extension(inode, offset, ret);
-		ext4_inode_extension_cleanup(inode, ret < (ssize_t)count);
+	if (!extend)
+		goto out;
+
+	if (ret <= 0)
+		goto err_trunc;
+
+	written = ret;
+	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
+	if (IS_ERR(handle)) {
+		ret = PTR_ERR(handle);
+		goto err_trunc;
 	}
+
+	if (ext4_update_inode_size(inode, offset + written)) {
+		ret = ext4_mark_inode_dirty(handle, inode);
+		if (unlikely(ret)) {
+			ext4_journal_stop(handle);
+			goto err_trunc;
+		}
+	}
+
+	if (written == count)
+		need_trunc = false;
+
+	if (inode->i_nlink)
+		ext4_orphan_del(handle, inode);
+	ext4_journal_stop(handle);
+	ret = written;
+err_trunc:
+	ext4_inode_extension_cleanup(inode, need_trunc);
 out:
 	inode_unlock(inode);
 	if (ret > 0)
-- 
2.39.2


