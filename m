Return-Path: <linux-ext4+bounces-1491-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BCA86FAFA
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 08:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 126471C21348
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 07:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D20168BA;
	Mon,  4 Mar 2024 07:39:12 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDDA13FFD;
	Mon,  4 Mar 2024 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537952; cv=none; b=j53Wl5Vr7UP3tfZOhcycPr5n0cr3wJAQTAbm3YugLZ679zH9BFT4Mgsrt8nnofTyuIa814JZNyfpfNd1Z5JhYa670F2AFNSNZ2PekEdhB+Llw71N6mmB2nK8xFKZ94sN1tPk8kcwHrOHsX9qttHwDZFGtin9Sot2aMf+q569b7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537952; c=relaxed/simple;
	bh=/LhgKrGSOiaYrC11cugO+xFYJU1yWEdd+eAWZriHGQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YjUhijaR+7UAFf9AF4QUeTHCH8bNJsLCWPY6McwC5uS6H1zyhUnSwHnJ/2zw6bfStPYgTaLc4Jo3qAPE8iOk5JyOBnW+G/QBnx9XdMY5tcgzluFrmJaPOaFBshQGX49G7R8EF5HjeuBwDzjhNSTjagj7wDdHCk0uAMsr2itXlWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tp9Yb6VSzz4f3mHK;
	Mon,  4 Mar 2024 15:38:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5C8DF1A04BC;
	Mon,  4 Mar 2024 15:39:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgDXKGuXeuVlWUH1Fw--.2277S3;
	Mon, 04 Mar 2024 15:39:07 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	naresh.kamboju@linaro.org,
	daniel.diaz@linaro.org,
	linux@roeck-us.net,
	brauner@kernel.org
Subject: [PATCH v4 1/3] ext4: alloc test super block from sget
Date: Tue,  5 Mar 2024 00:35:41 +0800
Message-Id: <20240304163543.6700-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240304163543.6700-1-shikemeng@huaweicloud.com>
References: <20240304163543.6700-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXKGuXeuVlWUH1Fw--.2277S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1rGw1DCr18uw1fJF47Jwb_yoWrWFyrpa
	43AFyFkr48uF4q9an7JFykXr1S9a109ryDGrWI9w15JayYgry8GFWvyF1jyrWFqrWxGFZ3
	ZF1UKrWUCr4UGa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsWrWDUUUU
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


