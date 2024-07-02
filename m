Return-Path: <linux-ext4+bounces-3091-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6725D923EE1
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jul 2024 15:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 114F21F23A30
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jul 2024 13:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF981B5827;
	Tue,  2 Jul 2024 13:25:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AD21B4C4B;
	Tue,  2 Jul 2024 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926737; cv=none; b=Oc431BDOC+Qhi3upbhUq3whz28CwDF/Y6mvDTJjD67oL1KBA9Lo8ACH2AIfAcwQsfbY6oPGZXl11xl3WT7NTei/0Dy/eJTJu0IToKNb64gQ/93QoP8+MhItO3dF87r5Yhycr3xmu0e/5Ph54ZBOEMYYNHCcB3+UHadeOKOqkOJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926737; c=relaxed/simple;
	bh=ftRkoH2TmPTgozXG+LzlFEoQ/NzP/OPtx7NjHM27y7M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=laNj2zGCm318Z9Pao50Yh5EaC3251ycegpqSAAAES2zeWPgbJBXZYsyhz2f6ODxPzVStxAafikS041cJzlGEW4y/XVupnrIDRT1ylYajeKusQjs9dv5K5vS28p9PMtPM5QscXugcvCggVqZ21hpoO+OQeX/MPsW73UpbO8etCp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WD3Yx4Lh7z4f3kp4;
	Tue,  2 Jul 2024 21:25:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E731D1A0568;
	Tue,  2 Jul 2024 21:25:32 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP2 (Coremail) with SMTP id Syh0CgCXAYfI_4NmaZ_dAw--.32725S6;
	Tue, 02 Jul 2024 21:25:32 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>,
	syzbot+ae688d469e36fb5138d0@syzkaller.appspotmail.com,
	stable@kernel.org
Subject: [PATCH 2/2] ext4: make sure the first directory block is not a hole
Date: Tue,  2 Jul 2024 21:23:49 +0800
Message-Id: <20240702132349.2600605-3-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240702132349.2600605-1-libaokun@huaweicloud.com>
References: <20240702132349.2600605-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXAYfI_4NmaZ_dAw--.32725S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWry7Ar43KF17Kr4kJrW5Wrg_yoW5XF4xpr
	W3tasFkF1FkFW29Fs2y3WUCr1Yga4UWFWUGFWF9w4kWr95Zrn3WFnFqF1UXFW7GF4fX340
	qF4Yq3y5uw4DK37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
	v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87
	Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIF
	yTuYvjfUYNVyUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAMBV1jkHxRXwAAsX

From: Baokun Li <libaokun1@huawei.com>

The syzbot constructs a directory that has no dirblock but is non-inline,
i.e. the first directory block is a hole. And no errors are reported when
creating files in this directory in the following flow.

    ext4_mknod
     ...
      ext4_add_entry
        // Read block 0
        ext4_read_dirblock(dir, block, DIRENT)
          bh = ext4_bread(NULL, inode, block, 0)
          if (!bh && (type == INDEX || type == DIRENT_HTREE))
          // The first directory block is a hole
          // But type == DIRENT, so no error is reported.

After that, we get a directory block without '.' and '..' but with a valid
dentry. This may cause some code that relies on dot or dotdot (such as
make_indexed_dir()) to crash.

Therefore when ext4_read_dirblock() finds that the first directory block
is a hole report that the filesystem is corrupted and return an error to
avoid loading corrupted data from disk causing something bad.

Reported-by: syzbot+ae688d469e36fb5138d0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ae688d469e36fb5138d0
Fixes: 4e19d6b65fb4 ("ext4: allow directory holes")
Cc: stable@kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/namei.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 35881e3dd880..6a95713f9193 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -151,10 +151,11 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 
 		return bh;
 	}
-	if (!bh && (type == INDEX || type == DIRENT_HTREE)) {
+	/* The first directory block must not be a hole. */
+	if (!bh && (type == INDEX || type == DIRENT_HTREE || block == 0)) {
 		ext4_error_inode(inode, func, line, block,
-				 "Directory hole found for htree %s block",
-				 (type == INDEX) ? "index" : "leaf");
+				 "Directory hole found for htree %s block %u",
+				 (type == INDEX) ? "index" : "leaf", block);
 		return ERR_PTR(-EFSCORRUPTED);
 	}
 	if (!bh)
@@ -3084,10 +3085,7 @@ bool ext4_empty_dir(struct inode *inode)
 		EXT4_ERROR_INODE(inode, "invalid size");
 		return false;
 	}
-	/* The first directory block must not be a hole,
-	 * so treat it as DIRENT_HTREE
-	 */
-	bh = ext4_read_dirblock(inode, 0, DIRENT_HTREE);
+	bh = ext4_read_dirblock(inode, 0, EITHER);
 	if (IS_ERR(bh))
 		return false;
 
@@ -3529,10 +3527,7 @@ static struct buffer_head *ext4_get_first_dir_block(handle_t *handle,
 		struct ext4_dir_entry_2 *de;
 		unsigned int offset;
 
-		/* The first directory block must not be a hole, so
-		 * treat it as DIRENT_HTREE
-		 */
-		bh = ext4_read_dirblock(inode, 0, DIRENT_HTREE);
+		bh = ext4_read_dirblock(inode, 0, EITHER);
 		if (IS_ERR(bh)) {
 			*retval = PTR_ERR(bh);
 			return NULL;
-- 
2.39.2


