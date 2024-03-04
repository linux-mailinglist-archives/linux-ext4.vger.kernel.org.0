Return-Path: <linux-ext4+bounces-1493-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6E986FAFE
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 08:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6F41F21F72
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 07:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA2C1756B;
	Mon,  4 Mar 2024 07:39:14 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE89A156DD;
	Mon,  4 Mar 2024 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709537953; cv=none; b=cy9PQ/DfEm59i8GAD4MEf9gs3NlyKqn2tEfC3UxFqXEvHqKLecFECRFBwokSGRcn8ABX2lHeGWDg3f8L1IBZZXQpArO0ZYv/OzwhWZuuUb5E/oHcK11lp/MIuTUGskOjcI1Rl0AZ2LnXdE/wkxyxYnptCyHeYQoLGfisOmzGZxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709537953; c=relaxed/simple;
	bh=VLjUG5/RbFyaBqGFUGG8p3fEzuef3DpGiYiEehefCEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s670lqZuw6yx3tbH91JBDsq6yA7SImgFrlNj3TQUy+1W2XoIWXmB4AhInMqfYcD94vOXlY9PaM2R8mjh9SKasfxddCRuyg23db2uNmsktMyOiKR367N2Lnq2x6qigHU+KI3IWj0yP49wX5UrE4c2CpUexHSo92zzuTprnVX5Jog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Tp9Yh4sJTz4f3kkH;
	Mon,  4 Mar 2024 15:39:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 264F41A0172;
	Mon,  4 Mar 2024 15:39:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.101.6])
	by APP4 (Coremail) with SMTP id gCh0CgDXKGuXeuVlWUH1Fw--.2277S5;
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
Subject: [PATCH v4 3/3] ext4: initialize sbi->s_freeclusters_counter and sbi->s_dirtyclusters_counter before use in kunit test
Date: Tue,  5 Mar 2024 00:35:43 +0800
Message-Id: <20240304163543.6700-4-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgDXKGuXeuVlWUH1Fw--.2277S5
X-Coremail-Antispam: 1UD129KBjvJXoW7AFW3Jry5tFWxZw18XrWkJFb_yoW8Kr1xpF
	Wjkr10kF48CrZ7WrsxJr98X3WYgw4v9a4fK34xuryrAFWayryrAF1kKF15Cr4vgrW8XFnY
	vF1qg34UuF4rC37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIq2MUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Fix that sbi->s_freeclusters_counter and sbi->s_dirtyclusters_counter are
used before initialization.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
---
 fs/ext4/mballoc-test.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index 4d9eb4807c98..19d74ebf5d83 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -45,6 +45,7 @@ static struct file_system_type mbt_fs_type = {
 
 static int mbt_mb_init(struct super_block *sb)
 {
+	ext4_fsblk_t block;
 	int ret;
 
 	/* needed by ext4_mb_init->bdev_nonrot(sb->s_bdev) */
@@ -69,8 +70,23 @@ static int mbt_mb_init(struct super_block *sb)
 	if (ret != 0)
 		goto err_out;
 
+	block = ext4_count_free_clusters(sb);
+	ret = percpu_counter_init(&EXT4_SB(sb)->s_freeclusters_counter, block,
+				  GFP_KERNEL);
+	if (ret != 0)
+		goto err_mb_release;
+
+	ret = percpu_counter_init(&EXT4_SB(sb)->s_dirtyclusters_counter, 0,
+				  GFP_KERNEL);
+	if (ret != 0)
+		goto err_freeclusters;
+
 	return 0;
 
+err_freeclusters:
+	percpu_counter_destroy(&EXT4_SB(sb)->s_freeclusters_counter);
+err_mb_release:
+	ext4_mb_release(sb);
 err_out:
 	kfree(sb->s_bdev->bd_queue);
 	kfree(sb->s_bdev);
@@ -79,6 +95,8 @@ static int mbt_mb_init(struct super_block *sb)
 
 static void mbt_mb_release(struct super_block *sb)
 {
+	percpu_counter_destroy(&EXT4_SB(sb)->s_dirtyclusters_counter);
+	percpu_counter_destroy(&EXT4_SB(sb)->s_freeclusters_counter);
 	ext4_mb_release(sb);
 	kfree(sb->s_bdev->bd_queue);
 	kfree(sb->s_bdev);
@@ -333,7 +351,7 @@ static int mbt_kunit_init(struct kunit *test)
 				   ext4_mb_mark_context,
 				   ext4_mb_mark_context_stub);
 
-	/* stub function will be called in mt_mb_init->ext4_mb_init */
+	/* stub function will be called in mbt_mb_init->ext4_mb_init */
 	if (mbt_mb_init(sb) != 0) {
 		mbt_ctx_release(sb);
 		mbt_ext4_free_super_block(sb);
@@ -534,6 +552,7 @@ static void test_mark_diskspace_used(struct kunit *test)
 	struct test_range ranges[TEST_RANGE_COUNT];
 	int i;
 
+
 	mbt_generate_test_ranges(sb, ranges, TEST_RANGE_COUNT);
 
 	ac.ac_status = AC_STATUS_FOUND;
-- 
2.30.0


