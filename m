Return-Path: <linux-ext4+bounces-5680-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D719F4186
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Dec 2024 05:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47DF016C7E9
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Dec 2024 04:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F0C14A0A3;
	Tue, 17 Dec 2024 04:05:54 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55530142E9F;
	Tue, 17 Dec 2024 04:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734408354; cv=none; b=UvvIvgpFna3Y/Sp/oUs/C71LYX7OhjXw5NO4S+2NJqFc4zDynrl69+CcdW+7wX0YYWqDyKlNZj9Z6+BQrc4u5+G7hyk6WjLXVgNIYrKa1JLMLTd8rlRtWY8Ac0GdrkMf2NenV2NKqBYw8NdjMCRvPP+aN+4WwBQtCJimflV6PBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734408354; c=relaxed/simple;
	bh=t66BcyMmOEw+GUAnoH4lSY8564FR6+4dW93Jl80MkDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m4mD5TyuwoWMbh1HGgb1TF4GNMDzX0q2eGYAQ+Nj8yBz3ZksIun+rTy6hiUK6kb+CDV6rTXzy6K8gmhP0u0cvMeCiCYGUCFHBlmog9wB4Ddc9ARyG5kHaZrCjBTzSweK6K0EPy5XF93MqX2A9AKSlwHLK2biMxE/ZOrPLEzjmtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YC3BK3H9Jz4f3jsG;
	Tue, 17 Dec 2024 12:05:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id DEAF71A0196;
	Tue, 17 Dec 2024 12:05:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgB3VsOb+GBnwxC_Eg--.2804S5;
	Tue, 17 Dec 2024 12:05:48 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.com
Cc: dennis.lamerice@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 3/3] ext4: remove unneeded forward declaration
Date: Tue, 17 Dec 2024 20:03:56 +0800
Message-Id: <20241217120356.1399443-4-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241217120356.1399443-1-shikemeng@huaweicloud.com>
References: <20241217120356.1399443-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3VsOb+GBnwxC_Eg--.2804S5
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw13WF45Ar1xGw15Cr4fuFg_yoWfGrg_Wr
	W7Ar4xC343Cw1SkF4jga13tFnY9rs5Zw48XFs5t34UuF1jvr4Uu34DZr17Ars8uF4rJay3
	Cr1kJF1fKrW8WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbDAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l87I20VAvwVAaII0Ic2I_JFv_Gryl82
	xGYIkIc2x26280x7IE14v26r1rM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxV
	WUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j4uWLU
	UUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Remove unneeded forward declaration of ext4_destroy_lazyinit_thread().

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
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


