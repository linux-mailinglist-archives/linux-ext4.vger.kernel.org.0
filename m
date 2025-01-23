Return-Path: <linux-ext4+bounces-6225-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D45F6A19FD2
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 09:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A45F188E468
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2025 08:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B61020C472;
	Thu, 23 Jan 2025 08:23:46 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF4520C01E;
	Thu, 23 Jan 2025 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737620626; cv=none; b=hzwu2v19iCBMX2UecemkjXxutTeyOnaGsoWupR3FRTCsK7c31yqzNycDfzh4t4jqYhbQ2bdn+i+kI3keA8nB7dQG8euLEk+EBWP9FoUsKlSlN6EwwcNQhHB4c2EXA89SJJ/8lWpEuXkD5ngtg5nS47Ob6dbwwNutj4fo8MhIyD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737620626; c=relaxed/simple;
	bh=6I/D6FfPnEvEfKs2R4SW6zvONpTUPw9Kzrx2lTpXUI4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bk7Ks6yIIsiGSdANTEqxf6fNsZDWmFMoAFKsky+Vnb3iMtfbpwXja0WNuWP9pBJQnDnh98OFTQXtSlYVJntZFQ3pRHFo+kljHIZRn1EVgDU7/p09jSlF8sq0KygWGWm7UBDYm8KaAB0sR/w8W/k6WCb01JovA+zJV557HbNhfiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ydv8t149tz4f3jt8;
	Thu, 23 Jan 2025 16:23:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9BD381A121F;
	Thu, 23 Jan 2025 16:23:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCH7GCL_JFnxur_Bg--.47357S5;
	Thu, 23 Jan 2025 16:23:41 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	ojaswin@linux.ibm.com,
	yi.zhang@huaweicloud.com
Cc: akpm@osdl.org,
	shaggy@austin.ibm.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ext4: remove unused input "inode" in ext4_find_dest_de
Date: Fri, 24 Jan 2025 00:20:50 +0800
Message-Id: <20250123162050.2114499-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250123162050.2114499-1-shikemeng@huaweicloud.com>
References: <20250123162050.2114499-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH7GCL_JFnxur_Bg--.47357S5
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1xKw1kuF1ktF1DZF45trb_yoW8tw15pr
	Z8J3WDCr4UWF4q9a1xua1UZr1aq3ZrGr47WrWfG34rKrW7XwnYgF13tF10yF15KrWrZ3W2
	vFZ8K348Gw13KrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JrWl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2
	z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0V
	AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1l
	Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErc
	IFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AK
	xVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRGXHiUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove unused input "inode" in ext4_find_dest_de.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
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
index c3a80df51328..9a6331179f27 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2030,8 +2030,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 	return ERR_PTR(err);
 }
 
-int ext4_find_dest_de(struct inode *dir, struct inode *inode,
-		      struct buffer_head *bh,
+int ext4_find_dest_de(struct inode *dir, struct buffer_head *bh,
 		      void *buf, int buf_size,
 		      struct ext4_filename *fname,
 		      struct ext4_dir_entry_2 **dest_de)
@@ -2117,7 +2116,7 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 		csum_size = sizeof(struct ext4_dir_entry_tail);
 
 	if (!de) {
-		err = ext4_find_dest_de(dir, inode, bh, bh->b_data,
+		err = ext4_find_dest_de(dir, bh, bh->b_data,
 					blocksize - csum_size, fname, &de);
 		if (err)
 			return err;
-- 
2.30.0


