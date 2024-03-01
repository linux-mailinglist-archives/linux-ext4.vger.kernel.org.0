Return-Path: <linux-ext4+bounces-1447-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223EA86D9F1
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Mar 2024 04:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA0172846F7
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Mar 2024 03:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9FF4122C;
	Fri,  1 Mar 2024 03:11:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CE8405CB;
	Fri,  1 Mar 2024 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709262696; cv=none; b=afak2klYvQquUYCU5QQoEBWcNatjNl0/Rm2T79etWkX+o5PIHPtR23AM61ekwHl+Ky4qUMRFcBXtq5sMr0N0HWEvYUmrSLxRcT6YTSmjjtd1c7FvQAPCM50emBP1EGpQ+MD0rv5q5Hygzz6GyE6FUGVdpgCvPXUt2IZfKU7ovCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709262696; c=relaxed/simple;
	bh=WUwDqW735WBIpBsVa8/8CiRZzuogbV8BNEvaplkzE2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HunqmmQz/qwkRmsRusaIBC0Zf27+JMG53U0vQSnkqZb6969f5w4xDXUyFhpYptodNVfULXLcUn3T3Yd/gSI0Jl2RLqaMGD1Ayl/d7RBPNLCeOmlroDGvVadDMogzXgLblHQhaPFOgj95LNAWhSFpfT9xq4m8uoQi7V6Vz91f2m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TmCmB2bZvz4f3m7P;
	Fri,  1 Mar 2024 11:11:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B611D1A0838;
	Fri,  1 Mar 2024 11:11:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgD3SGtfR+FlBJ6mFg--.42023S3;
	Fri, 01 Mar 2024 11:11:29 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	naresh.kamboju@linaro.org,
	daniel.diaz@linaro.org,
	linux@roeck-us.net,
	brauner@kernel.org
Subject: [PATCH 1/2] ext4: alloc test super block from sget
Date: Fri,  1 Mar 2024 20:08:15 +0800
Message-Id: <20240301120816.22581-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240301120816.22581-1-shikemeng@huaweicloud.com>
References: <20240301120816.22581-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3SGtfR+FlBJ6mFg--.42023S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1rGw1DCr18uw1fJF47Jwb_yoWrXry7pa
	43AFyrCr47uF4q9an7JFykXr1S9a1xuryDGrWI9w15Ja4Ygry8JFWvyF10yrW0qrZ7GFZ3
	ZF1UKrWUCr4UGa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jsIDcUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

This fix the oops in ext4 unit test which is cuased by NULL sb.s_user_ns
as following:
<4>[ 14.344565] map_id_range_down (kernel/user_namespace.c:318)
<4>[ 14.345378] make_kuid (kernel/user_namespace.c:415)
<4>[ 14.345998] inode_init_always (include/linux/fs.h:1375 fs/inode.c:174)
<4>[ 14.346696] alloc_inode (fs/inode.c:268)
<4>[ 14.347353] new_inode_pseudo (fs/inode.c:1007)
<4>[ 14.348016] new_inode (fs/inode.c:1033)
<4>[ 14.348644] ext4_mb_init (fs/ext4/mballoc.c:3404 fs/ext4/mballoc.c:3719)
<4>[ 14.349312] mbt_kunit_init (fs/ext4/mballoc-test.c:57
fs/ext4/mballoc-test.c:314)
<4>[ 14.349983] kunit_try_run_case (lib/kunit/test.c:388 lib/kunit/test.c:443)
<4>[ 14.350696] kunit_generic_run_threadfn_adapter (lib/kunit/try-catch.c:30)
<4>[ 14.351530] kthread (kernel/kthread.c:388)
<4>[ 14.352168] ret_from_fork (arch/arm64/kernel/entry.S:861)
<0>[ 14.353385] Code: 52808004 b8236ae7 72be5e44 b90004c4 (38e368a1)

Alloc test super block from sget to properly initialize test super block
to fix the issue.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 fs/ext4/mballoc-test.c | 46 ++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index 12d0b22cabe1..1da52bbf4599 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -21,16 +21,27 @@ struct mbt_ctx {
 };
 
 struct mbt_ext4_super_block {
-	struct super_block sb;
+	struct ext4_super_block es;
+	struct ext4_sb_info sbi;
 	struct mbt_ctx mbt_ctx;
 };
 
-#define MBT_CTX(_sb) (&(container_of((_sb), struct mbt_ext4_super_block, sb)->mbt_ctx))
+#define MBT_SB(_sb) (container_of((_sb)->s_fs_info, struct mbt_ext4_super_block, sbi))
+#define MBT_CTX(_sb) (&MBT_SB(_sb)->mbt_ctx)
 #define MBT_GRP_CTX(_sb, _group) (&MBT_CTX(_sb)->grp_ctx[_group])
 
 static const struct super_operations mbt_sops = {
 };
 
+static void mbt_kill_sb(struct super_block *sb)
+{
+}
+
+static struct file_system_type mbt_fs_type = {
+	.name			= "mballoc test",
+	.kill_sb		= mbt_kill_sb,
+};
+
 static int mbt_mb_init(struct super_block *sb)
 {
 	int ret;
@@ -72,43 +83,48 @@ static void mbt_mb_release(struct super_block *sb)
 	kfree(sb->s_bdev);
 }
 
+static int mbt_set(struct super_block *sb, void *data)
+{
+	return 0;
+}
+
 static struct super_block *mbt_ext4_alloc_super_block(void)
 {
-	struct ext4_super_block *es = kzalloc(sizeof(*es), GFP_KERNEL);
-	struct ext4_sb_info *sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	struct mbt_ext4_super_block *fsb = kzalloc(sizeof(*fsb), GFP_KERNEL);
+	struct super_block *sb = sget(&mbt_fs_type, NULL, mbt_set, 0, NULL);
+	struct ext4_sb_info *sbi;
 
-	if (fsb == NULL || sbi == NULL || es == NULL)
+	if (fsb == NULL || sb == NULL)
 		goto out;
 
+	sbi = &fsb->sbi;
+
 	sbi->s_blockgroup_lock =
 		kzalloc(sizeof(struct blockgroup_lock), GFP_KERNEL);
 	if (!sbi->s_blockgroup_lock)
-		goto out;
+		goto out_deactivate;
 
 	bgl_lock_init(sbi->s_blockgroup_lock);
 
-	sbi->s_es = es;
-	fsb->sb.s_fs_info = sbi;
+	sbi->s_es = &fsb->es;
+	sb->s_fs_info = sbi;
 
-	return &fsb->sb;
+	return sb;
 
+out_deactivate:
+	deactivate_locked_super(sb);
 out:
 	kfree(fsb);
-	kfree(sbi);
-	kfree(es);
 	return NULL;
 }
 
 static void mbt_ext4_free_super_block(struct super_block *sb)
 {
-	struct mbt_ext4_super_block *fsb =
-		container_of(sb, struct mbt_ext4_super_block, sb);
+	struct mbt_ext4_super_block *fsb = MBT_SB(sb);
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
 	kfree(sbi->s_blockgroup_lock);
-	kfree(sbi->s_es);
-	kfree(sbi);
+	deactivate_locked_super(sb);
 	kfree(fsb);
 }
 
-- 
2.30.0


