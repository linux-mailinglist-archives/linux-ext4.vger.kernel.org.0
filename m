Return-Path: <linux-ext4+bounces-1476-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688F086EFC2
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Mar 2024 10:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A18471C21321
	for <lists+linux-ext4@lfdr.de>; Sat,  2 Mar 2024 09:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2348F1428E;
	Sat,  2 Mar 2024 09:21:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3763134AB;
	Sat,  2 Mar 2024 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709371283; cv=none; b=QwqgPo3ZwV0Bpve1qOn1bIc/Vd3T/pkhaIP0MVmCigejxPn0LfOSKEwY627erwY2C1zOpRGeTEn2//SxhgNByh663ta1Zdekw03YkKwMXhZZycuE7JoiJpMUwIHsHTm15vt5Hpl0kw2yEjgoqIINJfGEb7K+60HFaIKbC58SUKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709371283; c=relaxed/simple;
	bh=yuDnORTLBMtabOdEUTJzo3+JPFXKoysV58A6NG+lOyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=brX9kxKvkZ1qLz00tHRdnJ2BdGwj18QJmIvcDZL4xvs/d3UlGMDRTB9yA+tEP1xJBMml+06U5gfn6F0n9/djcPWmij3Tu3gtHyn1YZ3NI3J5MJQohjhn/pGVG3c5lxUDFOKO7W57Gkit/X7Y/A3y5K7anfxpU3AqIRB/LB3a2Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TmzwP54xXz4f3k69;
	Sat,  2 Mar 2024 17:21:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2562E1A0BDF;
	Sat,  2 Mar 2024 17:21:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgA3imyE7+Jld1cqFw--.52350S5;
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
Subject: [PATCH v3 3/3] ext4: initialize sbi->s_freeclusters_counter before use in kunit test
Date: Sun,  3 Mar 2024 02:17:55 +0800
Message-Id: <20240302181755.9192-4-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgA3imyE7+Jld1cqFw--.52350S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1xZr1xGw1fJry8KrW3ZFb_yoW8CFW7pF
	yjkF10kr48Crs7WanrJrZ8Xw12gw4v9ryfKryxuryrAFW3Jry8AF1kKF1Ykr4FgrW8XFn5
	ZF1qgryUWr4rC37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07js0edUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Fix warnning that sbi->s_freeclusters_counter is used before
initialization.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/mballoc-test.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index 4d9eb4807c98..00fc0f8b3809 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -45,6 +45,7 @@ static struct file_system_type mbt_fs_type = {
 
 static int mbt_mb_init(struct super_block *sb)
 {
+	ext4_fsblk_t block;
 	int ret;
 
 	/* needed by ext4_mb_init->bdev_nonrot(sb->s_bdev) */
@@ -69,8 +70,16 @@ static int mbt_mb_init(struct super_block *sb)
 	if (ret != 0)
 		goto err_out;
 
+	block = ext4_count_free_clusters(sb);
+	ret = percpu_counter_init(&EXT4_SB(sb)->s_freeclusters_counter, block,
+				  GFP_KERNEL);
+	if (ret != 0)
+		goto err_mb_release;
+
 	return 0;
 
+err_mb_release:
+	ext4_mb_release(sb);
 err_out:
 	kfree(sb->s_bdev->bd_queue);
 	kfree(sb->s_bdev);
@@ -79,6 +88,7 @@ static int mbt_mb_init(struct super_block *sb)
 
 static void mbt_mb_release(struct super_block *sb)
 {
+	percpu_counter_destroy(&EXT4_SB(sb)->s_freeclusters_counter);
 	ext4_mb_release(sb);
 	kfree(sb->s_bdev->bd_queue);
 	kfree(sb->s_bdev);
@@ -333,7 +343,7 @@ static int mbt_kunit_init(struct kunit *test)
 				   ext4_mb_mark_context,
 				   ext4_mb_mark_context_stub);
 
-	/* stub function will be called in mt_mb_init->ext4_mb_init */
+	/* stub function will be called in mbt_mb_init->ext4_mb_init */
 	if (mbt_mb_init(sb) != 0) {
 		mbt_ctx_release(sb);
 		mbt_ext4_free_super_block(sb);
@@ -534,6 +544,7 @@ static void test_mark_diskspace_used(struct kunit *test)
 	struct test_range ranges[TEST_RANGE_COUNT];
 	int i;
 
+
 	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
 
 	ac.ac_status = AC_STATUS_FOUND;
-- 
2.30.0


