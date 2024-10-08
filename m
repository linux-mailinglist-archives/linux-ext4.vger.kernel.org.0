Return-Path: <linux-ext4+bounces-4528-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFF3994888
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Oct 2024 14:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C431F27B08
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Oct 2024 12:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32CE1DE4DC;
	Tue,  8 Oct 2024 12:13:49 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA291DE3C1;
	Tue,  8 Oct 2024 12:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389629; cv=none; b=T7jT0FIAUa1pS3moGx/HWirEsdZX3c2644kzLwskGuvSVtsXfxc8resrps3d3W/EkXZFtOx5O5x6pDWQFqwwjby239IcFkgFuadLU2hqmSS/QEuxY6r853mcv6wbZcn5akE09tKFq8fmCSCLvhutY8kybdCxV0BwN532iuICoLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389629; c=relaxed/simple;
	bh=wEbV/QzaN2bQIxKJnfGzPG4juvL36fx0LANBaOI3IZw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DfU/jM89HwJN8M25lD7HfyeO4idVYwTJO1u+07SQNo+mdmeK9b1aXacQ6v64SgpWtpFFBJXb22/xdUCARKXZax212Eu/S9iZ3C39O6KqW7LJ/Ma+UTTcjrtuqGMHFY/Miwx0N4dZh8XT4EfV3OzVwdFPglvJtxImLXwylYbtAgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XNFKk5SPvz4f3k6W;
	Tue,  8 Oct 2024 20:13:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 78B3F1A0568;
	Tue,  8 Oct 2024 20:13:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgDH+8fzIQVnSZoUDg--.44667S4;
	Tue, 08 Oct 2024 20:13:41 +0800 (CST)
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
Subject: [PATCH] ext4: WARN if a full dir leaf block has only one dentry
Date: Tue,  8 Oct 2024 20:11:52 +0800
Message-Id: <20241008121152.3771906-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDH+8fzIQVnSZoUDg--.44667S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrykKr17KF43Aw4fCF4rKrg_yoW8ZFWfpF
	4aqwn0yr42qFs09FnrCa4YvrnIk39xuF1DWrZxW34jvryqqr1SqFZrKr1FvF1rtrW8W3Z5
	XF12gr90k3yIy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
	MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7VU1oUDtUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAKBWcE7QQQOwAAsv

From: Baokun Li <libaokun1@huawei.com>

The maximum length of a filename is 255 and the minimum block size is 1024,
so it is always guaranteed that the number of entries is greater than or
equal to 2 when do_split() is called. So unless ext4_dx_add_entry() and
make_indexed_dir() or some other functions are buggy, 'split == 0' will
not occur.

Setting 'continued' to 0 in this case masks the problem that the file
system has become corrupted, even though it prevents possible out-of-bounds
access. Hence WARN_ON_ONCE() is used to check if 'split' is 0, and if it is
then warns and returns an error to abort split.

Suggested-by: Theodore Ts'o <tytso@mit.edu>
Link: https://lore.kernel.org/r/20240823160518.GA424729@mit.edu
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/namei.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 790db7eac6c2..08d15cd2b594 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2000,8 +2000,17 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 	else
 		split = count/2;
 
+	if (WARN_ON_ONCE(split == 0)) {
+		/* Should never happen, but avoid out-of-bounds access below */
+		ext4_error_inode_block(dir, (*bh)->b_blocknr, 0,
+			"bad indexed directory? hash=%08x:%08x count=%d move=%u",
+			hinfo->hash, hinfo->minor_hash, count, move);
+		err = -EFSCORRUPTED;
+		goto out;
+	}
+
 	hash2 = map[split].hash;
-	continued = split > 0 ? hash2 == map[split - 1].hash : 0;
+	continued = hash2 == map[split - 1].hash;
 	dxtrace(printk(KERN_INFO "Split block %lu at %x, %i/%i\n",
 			(unsigned long)dx_get_block(frame->at),
 					hash2, split, count-split));
@@ -2043,10 +2052,11 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 	return de;
 
 journal_error:
+	ext4_std_error(dir->i_sb, err);
+out:
 	brelse(*bh);
 	brelse(bh2);
 	*bh = NULL;
-	ext4_std_error(dir->i_sb, err);
 	return ERR_PTR(err);
 }
 
-- 
2.46.1


