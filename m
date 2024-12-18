Return-Path: <linux-ext4+bounces-5729-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A89A89F5EF0
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 07:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB04518957AB
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2024 06:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DDC15990C;
	Wed, 18 Dec 2024 06:56:15 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F458156C6F;
	Wed, 18 Dec 2024 06:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734504975; cv=none; b=FYBbXzJ5R2gjJ2yeXsI3TAUXT+Tvz71i8p4SkkYiTwYx0NlrZsAMbgzKuPxXs/bniYuKRLwK95o+skmDKjLby/s+aa6NE/YDpYUmeYPlKvD78i6JmxzvCyjiw65GZilLEx3w1aDUHJzWKNqPsQINpgGptTI3c52J6rRmSJS2KxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734504975; c=relaxed/simple;
	bh=PItxZlU7olmAcAYHmchpso4UkCwjhshfqAG2RB3B4/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DeOmEZwVvu8DVvfTBOAEOJZCypkYUlhTFlEG8q/RiZtZ092el0upH7VLIfPLZ1aV+RE6Briat/GfWqL8TpT9BIczjNKDSKzLuCw1GMXuSWNOb+gT0MW1u50K+15+CSEhoaSTo6W2/hRzXWG4zGYJjQoHDPpm1npwL/hRNuUQCpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YCkwQ5mHwz4f3kFP;
	Wed, 18 Dec 2024 14:55:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4961B1A0196;
	Wed, 18 Dec 2024 14:56:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgCnhMEHcmJnLjMnEw--.53472S5;
	Wed, 18 Dec 2024 14:56:10 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: corbet@lwn.net,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.com
Cc: dennis.lamerice@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v2 3/3] ext4: remove unneeded forward declaration
Date: Wed, 18 Dec 2024 22:54:14 +0800
Message-Id: <20241218145414.1422946-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241218145414.1422946-1-shikemeng@huaweicloud.com>
References: <20241218145414.1422946-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCnhMEHcmJnLjMnEw--.53472S5
X-Coremail-Antispam: 1UD129KBjvdXoW7GF4rAr1xKrWDXw13ZF1rXrb_yoWfCrgE9r
	WxAr4xu343Cw1SkF4F9a13tFnYkrs5Zw48XFZ5t34UuF4jqr4Uu34DZr17Ars8uF4rGay3
	Cr1kJF13KrWkWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbq8YFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r1rM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxV
	WUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
	WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUsoGQ
	DUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove unneeded forward declaration of ext4_destroy_lazyinit_thread().

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8dfda41dabaa..d294cd43d3f2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -79,7 +79,6 @@ static int ext4_unfreeze(struct super_block *sb);
 static int ext4_freeze(struct super_block *sb);
 static inline int ext2_feature_set_ok(struct super_block *sb);
 static inline int ext3_feature_set_ok(struct super_block *sb);
-static void ext4_destroy_lazyinit_thread(void);
 static void ext4_unregister_li_request(struct super_block *sb);
 static void ext4_clear_request_list(void);
 static struct inode *ext4_get_journal_inode(struct super_block *sb,
-- 
2.30.0


