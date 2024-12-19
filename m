Return-Path: <linux-ext4+bounces-5763-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DCC9F731C
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 04:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EEF716B694
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2024 03:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEAE1632FB;
	Thu, 19 Dec 2024 03:02:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202DC40BE0;
	Thu, 19 Dec 2024 03:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734577350; cv=none; b=VHFVE2THK6QXysPjnEBeyXve4/6k1RKTud8UtlwdKCsIKW3XEXfRuNPVX5V+WgikRsbDUSbKjOLq3s7+eHDukOaCIsmEiyUAYobwssjvIBDqgkfRt3Ryr84VE25IcJkEilpdI6BdQslhcl+PnHklUYCpcUS37AYG13JkwJvRV7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734577350; c=relaxed/simple;
	bh=bRgG7RBPMdd0JDNJacgTScno2ctOnq2j+mW2PpWJVJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g4O0adP46CieXdjdvsB4r+ACAzquoQ38LVka0yNhqOqTqmihOFvRpjxJUAdMTQvVzst3BaCako8gjNIZmGA51OYnq+8wzESpOB63BHP6LOBd0Su7CyTje3qXjlDnMQJijfhgxa8lm6Z4954slLBc5zLnwikXOj6ic6idUqtOEdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YDFhD33zDz4f3kFL;
	Thu, 19 Dec 2024 11:02:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id EC60D1A07B6;
	Thu, 19 Dec 2024 11:02:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgDHpMG9jGNnctd0Ew--.54838S7;
	Thu, 19 Dec 2024 11:02:23 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] ext4: remove unused input "inode" in ext4_find_dest_de
Date: Thu, 19 Dec 2024 19:00:26 +0800
Message-Id: <20241219110027.1440876-6-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241219110027.1440876-1-shikemeng@huaweicloud.com>
References: <20241219110027.1440876-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDHpMG9jGNnctd0Ew--.54838S7
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1xKw1kuF1ktF1DZF45trb_yoW8tF15pr
	Z8JF1DCr47WFWq9a1xuF4UZw1avwnrGrW7WrWfG34rKrW2qwnYqF15tF10yF15KrWrZw12
	vFs8K348Jw1agrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3w
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU3XTQUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove unused input "inode" in ext4_find_dest_de.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/ext4.h   | 3 +--
 fs/ext4/inline.c | 2 +-
 fs/ext4/namei.c  | 5 ++---
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bbffb76d9a90..f7cec0de2790 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2821,8 +2821,7 @@ extern int ext4_htree_store_dirent(struct file *dir_file, __u32 hash,
 				struct ext4_dir_entry_2 *dirent,
 				struct fscrypt_str *ent_name);
 extern void ext4_htree_free_dir_info(struct dir_private_info *p);
-extern int ext4_find_dest_de(struct inode *dir, struct inode *inode,
-			     struct buffer_head *bh,
+extern int ext4_find_dest_de(struct inode *dir, struct buffer_head *bh,
 			     void *buf, int buf_size,
 			     struct ext4_filename *fname,
 			     struct ext4_dir_entry_2 **dest_de);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3536ca7e4fcc..29081a04aef5 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1012,7 +1012,7 @@ static int ext4_add_dirent_to_inline(handle_t *handle,
 	int		err;
 	struct ext4_dir_entry_2 *de;
 
-	err = ext4_find_dest_de(dir, inode, iloc->bh, inline_start,
+	err = ext4_find_dest_de(dir, iloc->bh, inline_start,
 				inline_size, fname, &de);
 	if (err)
 		return err;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 07a1bb570deb..aee1858e6482 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2024,8 +2024,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 	return ERR_PTR(err);
 }
 
-int ext4_find_dest_de(struct inode *dir, struct inode *inode,
-		      struct buffer_head *bh,
+int ext4_find_dest_de(struct inode *dir, struct buffer_head *bh,
 		      void *buf, int buf_size,
 		      struct ext4_filename *fname,
 		      struct ext4_dir_entry_2 **dest_de)
@@ -2111,7 +2110,7 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 		csum_size = sizeof(struct ext4_dir_entry_tail);
 
 	if (!de) {
-		err = ext4_find_dest_de(dir, inode, bh, bh->b_data,
+		err = ext4_find_dest_de(dir, bh, bh->b_data,
 					blocksize - csum_size, fname, &de);
 		if (err)
 			return err;
-- 
2.30.0


