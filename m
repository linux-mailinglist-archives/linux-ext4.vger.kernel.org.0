Return-Path: <linux-ext4+bounces-1729-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4D78867B6
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Mar 2024 08:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA40428653F
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Mar 2024 07:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C121A14014;
	Fri, 22 Mar 2024 07:59:08 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C63E134A3;
	Fri, 22 Mar 2024 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711094348; cv=none; b=hnI+aTTZsLX4VeazKbM5po41sRKyOKSkFzqnW0BL4klnMiOnWklKdjixIQVGLyeAoYylCqUEMliDb5jOICV8ru2ROsEGSj2G1JjEvJAVy+/YXvD84xUNsMGA3d3M8ZgVdgJF85spx5oVSxNQ5wcJoavknBpgePrmGMz1qdc/y/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711094348; c=relaxed/simple;
	bh=UzGKJnZTJL1hg3BZWLblMPlF3l/gSCV6CLIGlIgt5UQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oIaxmNf9lue52IgfqES2GoOSBAvp8Xh4E26Gp+rN0LeVwcyVaGS8yd6UFqrarrVRxSmTYXwQWHQeulsWdMpaUxCUD9kLAFqISFIUAfp3xsHT2fOWOXuk/Lz6S+n8rvdTaOtg95WBkMuHisUmKS5J++IfSRJhLPoSxjLlE3etEtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V1F8M0Xjxz4f3k6h;
	Fri, 22 Mar 2024 15:58:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id F33911A0B59;
	Fri, 22 Mar 2024 15:59:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP1 (Coremail) with SMTP id cCh0CgDXpxBFOv1l+23fHg--.60357S2;
	Fri, 22 Mar 2024 15:59:02 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux@roeck-us.net
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: implement filesystem specific alloc_inode in unit test
Date: Sat, 23 Mar 2024 00:55:18 +0800
Message-Id: <20240322165518.8147-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDXpxBFOv1l+23fHg--.60357S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWDXr4UKr1UAr1rXF43Wrg_yoW8Xw1Dpr
	sxCryYkFs8WFZFga1fKry5Zw1fKa1Ig3yUJrWSgw1Sqry3GFy8tFn8tr17AF18JrW8JayF
	vF4qkF47ur4xGaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_
	tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r
	xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
	0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
	80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
	IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0miiDUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

We expect inode with ext4_info_info type as following:
mbt_kunit_init
  mbt_mb_init
    ext4_mb_init
      ext4_mb_init_backend
        sbi->s_buddy_cache = new_inode(sb);
        EXT4_I(sbi->s_buddy_cache)->i_disksize = 0;

Implement alloc_inode ionde with ext4_inode_info type to avoid
out-of-bounds write.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 fs/ext4/mballoc-test.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index 044ca5238f41..49aabcfe6b46 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -30,7 +30,31 @@ struct mbt_ext4_super_block {
 #define MBT_CTX(_sb) (&MBT_SB(_sb)->mbt_ctx)
 #define MBT_GRP_CTX(_sb, _group) (&MBT_CTX(_sb)->grp_ctx[_group])
 
+static struct inode *mbt_alloc_inode(struct super_block *sb)
+{
+	struct ext4_inode_info *ei;
+
+	ei = kmalloc(sizeof(struct ext4_inode_info), GFP_KERNEL);
+	if (!ei)
+		return NULL;
+
+	INIT_LIST_HEAD(&ei->i_orphan);
+	init_rwsem(&ei->xattr_sem);
+	init_rwsem(&ei->i_data_sem);
+	inode_init_once(&ei->vfs_inode);
+	ext4_fc_init_inode(&ei->vfs_inode);
+
+	return &ei->vfs_inode;
+}
+
+static void mbt_free_inode(struct inode *inode)
+{
+	kfree(EXT4_I(inode));
+}
+
 static const struct super_operations mbt_sops = {
+	.alloc_inode	= mbt_alloc_inode,
+	.free_inode	= mbt_free_inode,
 };
 
 static void mbt_kill_sb(struct super_block *sb)
-- 
2.30.0


