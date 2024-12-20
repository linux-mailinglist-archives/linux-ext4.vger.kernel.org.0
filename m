Return-Path: <linux-ext4+bounces-5800-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7872E9F8C73
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 07:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD2918970E3
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 06:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFF31A83F9;
	Fri, 20 Dec 2024 06:11:52 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6651C19D070;
	Fri, 20 Dec 2024 06:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734675112; cv=none; b=ZLOQgqA+ljBHHxp4KjZytVmFQ4tcaK9XMtpjQaew70ey8f9tvd6kHCW6yxl7csKRj0ZL2yNwhnbuHGwGGagidh1jDSojokibUuIvKqTIxMvMR/IWZ7r4sXmqBBf56GWcwOUCiU0tlHNcGwCvNLuJONkN9qpVK/nwXquQRHTkRNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734675112; c=relaxed/simple;
	bh=kYV5+VVWdUm+4WTBKwN+YzStOD/3ZS1El4V9nKsyH7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Md1kAcfp3eC5rw8CWeHA5OPSy1bTmhZJ/D5UBMOcduIfw75FkztHv7UzAAXd71ChOfYNi5XwiTJcWolbzHXN6zPuMQLm4JFE5xD7kNHA5kcz28KYxEW9GN2447seycOCQwTlx23NNTTGQotsbZf4rJFm9YH9zwES1KhTMVoVUK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YDxrF456dz4f3lDG;
	Fri, 20 Dec 2024 14:11:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 307BB1A0197;
	Fri, 20 Dec 2024 14:11:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgA3XoKeCmVn6SRyFA--.26943S7;
	Fri, 20 Dec 2024 14:11:45 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH 3/5] ext4: abort journal on data writeback failure if in data_err=abort mode
Date: Fri, 20 Dec 2024 14:07:55 +0800
Message-Id: <20241220060757.1781418-4-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241220060757.1781418-1-libaokun@huaweicloud.com>
References: <20241220060757.1781418-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3XoKeCmVn6SRyFA--.26943S7
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW8ur4DCw4fJr15Xr47Arb_yoW8CF13pF
	yDCF4kXFW8Wa4j9a1vyFs7JryxKay8KFW7WrW7GFZ0vFWDXr95t3WxtFyFqF1jkayxG3W2
	qF48JF1DuFnrG3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24lc7CjxV
	Aaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
	vjfUOnmRUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQADBWdkCnU2wgABsO

From: Baokun Li <libaokun1@huawei.com>

If we mount an ext4 fs with data_err=abort option, it should abort on
file data write error. But if the extent is unwritten, we won't add a
JI_WAIT_DATA bit to the inode, so jbd2 won't wait for the inode's data
to be written back and check the inode mapping for errors. The data
writeback failures are not sensed unless the log is watched or fsync
is called.

Therefore, when data_err=abort is enabled, the journal is aborted when
an I/O error is detected in ext4_end_io_end() to make users who are
concerned about the contents of the file happy.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/page-io.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 6054ec27fb48..058bf4660d7b 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -175,6 +175,7 @@ static int ext4_end_io_end(ext4_io_end_t *io_end)
 {
 	struct inode *inode = io_end->inode;
 	handle_t *handle = io_end->handle;
+	struct super_block *sb = inode->i_sb;
 	int ret = 0;
 
 	ext4_debug("ext4_end_io_nolock: io_end 0x%p from inode %lu,list->next 0x%p,"
@@ -190,11 +191,15 @@ static int ext4_end_io_end(ext4_io_end_t *io_end)
 		ret = -EIO;
 		if (handle)
 			jbd2_journal_free_reserved(handle);
+		if (test_opt(sb, DATA_ERR_ABORT) &&
+		    !ext4_is_quota_file(inode) &&
+		    ext4_should_order_data(inode))
+			jbd2_journal_abort(EXT4_SB(sb)->s_journal, ret);
 	} else {
 		ret = ext4_convert_unwritten_io_end_vec(handle, io_end);
 	}
-	if (ret < 0 && !ext4_forced_shutdown(inode->i_sb)) {
-		ext4_msg(inode->i_sb, KERN_EMERG,
+	if (ret < 0 && !ext4_forced_shutdown(sb)) {
+		ext4_msg(sb, KERN_EMERG,
 			 "failed to convert unwritten extents to written "
 			 "extents -- potential data loss!  "
 			 "(inode %lu, error %d)", inode->i_ino, ret);
-- 
2.46.1


