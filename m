Return-Path: <linux-ext4+bounces-1477-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E8886EFC6
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Mar 2024 10:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AD9CB2510A
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Mar 2024 09:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE22168A8;
	Sat,  2 Mar 2024 09:21:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2A412E48;
	Sat,  2 Mar 2024 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709371284; cv=none; b=Z7rwgjTqC7UMHBLutnkLHzLQoRcn0e1KHJUj6YCbWfUlEO2xOWi7S4dBHFyWx2QrkYPY0azej674QklWRir8wkvSPTmUgFGvrhT+9XPD5UIUQ+G8N+ogZxit1yJei78bC5sb8NYDDCPDiYhr3dpPBhhM/ejF6MKKvnxj9fE0bHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709371284; c=relaxed/simple;
	bh=/LhgKrGSOiaYrC11cugO+xFYJU1yWEdd+eAWZriHGQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HBwLW9WcsIcxgcTITS+FszO1wale/3e8QZg3YCDQ8KQorT1hqMqpLpnjvLjNTbZVLZWda9kCpoc1kLhNSeyBWtkHbHE3MDIgw+wWKpPKSwVLAw1WndbMDiRKJo/7Xh9+YRY+axll+QSfD/XJdt27UchzGxpbZqLD9KaEKfYKzFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TmzwM0Zfrz4f3jct;
	Sat,  2 Mar 2024 17:21:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 63EAB1A0BDF;
	Sat,  2 Mar 2024 17:21:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgA3imyE7+Jld1cqFw--.52350S3;
	Sat, 02 Mar 2024 17:21:12 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	naresh.kamboju@linaro.org,
	daniel.diaz@linaro.org,
	linux@roeck-us.net,
	brauner@kernel.org
Subject: [PATCH v3 1/3] ext4: alloc test super block from sget
Date: Sun,  3 Mar 2024 02:17:53 +0800
Message-Id: <20240302181755.9192-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240302181755.9192-1-shikemeng@huaweicloud.com>
References: <20240302181755.9192-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3imyE7+Jld1cqFw--.52350S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1rGw1DCr18uw1fJF47Jwb_yoWrWFyrpa
	43AFyFkr48uF4q9an7JFykXr1S9a109ryDGrWI9w15JayYgry8GFWvyF1jyrWFqrWxGFZ3
	ZF1UKrWUCr4UGa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jTrWwUUUUU=
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
 fs/ext4/mballoc-test.c | 55 ++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index 12d0b22cabe1..9d061f80f150 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -21,16 +21,28 @@ struct mbt_ctx {
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
+	generic_shutdown_super(sb);
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
@@ -72,43 +84,54 @@ static void mbt_mb_release(struct super_block *sb)
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
-	struct mbt_ext4_super_block *fsb = kzalloc(sizeof(*fsb), GFP_KERNEL);
+	struct mbt_ext4_super_block *fsb;
+	struct super_block *sb;
+	struct ext4_sb_info *sbi;
 
-	if (fsb == NULL || sbi == NULL || es == NULL)
+	fsb = kzalloc(sizeof(*fsb), GFP_KERNEL);
+	if (fsb == NULL)
+		return NULL;
+
+	sb = sget(&mbt_fs_type, NULL, mbt_set, 0, NULL);
+	if (IS_ERR(sb))
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
+	up_write(&sb->s_umount);
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
+	deactivate_super(sb);
 	kfree(fsb);
 }
 
-- 
2.30.0


