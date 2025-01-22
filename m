Return-Path: <linux-ext4+bounces-6196-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C12F3A19054
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 12:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16EF3A7785
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 11:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C4F211A0A;
	Wed, 22 Jan 2025 11:11:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4370E18AE2;
	Wed, 22 Jan 2025 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737544292; cv=none; b=MynJ8DP8O7ghuSeY1vxMpVIq2gCjxF967hw9zCfbZpHunS4MmP1wtA03vUb8mDVloz768EXn9lsDTNOR6aJxmnj27dhMfu5GJgT0n7LMvVZu3ZfvV0oSzXjJs59FAkDV0H+bP4FBTTVpKo/dlmtBuXpP4nlqhA59Svuz3h/O0/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737544292; c=relaxed/simple;
	bh=X23XqX00vz1DAdtLZouIdcr2MyEus49x1ykdfPct2xY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Id9Q4wrYTsi/R9YruL8ZWT1YAem3UOVYlb4h8CY3TZPUQ51IOjCSzYF4PUlgWC/kFm3romPYoI3aBLUNplwgreH0Uv4OTHvyZedxWodpTTaFhbyQSy0LDe1gJ3uAl+B+6KeprGIvjxu1FvMR+BEVUeJNqlqp1HK6eQw9KZSKtn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YdLwm1CP2z4f3kvR;
	Wed, 22 Jan 2025 19:11:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 12EE41A1331;
	Wed, 22 Jan 2025 19:11:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAni19Z0pBnW0KsBg--.50502S7;
	Wed, 22 Jan 2025 19:11:25 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH v3 3/9] ext4: reject the 'data_err=abort' option in nojournal mode
Date: Wed, 22 Jan 2025 19:05:27 +0800
Message-Id: <20250122110533.4116662-4-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250122110533.4116662-1-libaokun@huaweicloud.com>
References: <20250122110533.4116662-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAni19Z0pBnW0KsBg--.50502S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4xGFWUZrW7AFykJFW3Awb_yoW8WrWfpw
	1Duw1xGry0vF4xuF47Wa1rJa40qw40ka4UGrWI9w1DX39rtw1Sgry8tr1Yqa12qFZ3Xr1f
	XFyjkryxua4Yka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPv14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24lc7CjxV
	Aaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
	vjfUOnmRUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAPBWePVXkU8wAFsu

From: Baokun Li <libaokun1@huawei.com>

data_err=abort aborts the journal on I/O errors. However, this option is
meaningless if journal is disabled, so it is rejected in nojournal mode
to reduce unnecessary checks. Also, this option is ignored upon remount.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a50e5c31b937..34a7b6523f8b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2785,6 +2785,13 @@ static int ext4_check_opt_consistency(struct fs_context *fc,
 	}
 
 	if (is_remount) {
+		if (!sbi->s_journal &&
+		    ctx_test_mount_opt(ctx, EXT4_MOUNT_DATA_ERR_ABORT)) {
+			ext4_msg(NULL, KERN_WARNING,
+				 "Remounting fs w/o journal so ignoring data_err option");
+			ctx_clear_mount_opt(ctx, EXT4_MOUNT_DATA_ERR_ABORT);
+		}
+
 		if (ctx_test_mount_opt(ctx, EXT4_MOUNT_DAX_ALWAYS) &&
 		    (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)) {
 			ext4_msg(NULL, KERN_ERR, "can't mount with "
@@ -5428,6 +5435,11 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 				 "data=, fs mounted w/o journal");
 			goto failed_mount3a;
 		}
+		if (test_opt(sb, DATA_ERR_ABORT)) {
+			ext4_msg(sb, KERN_ERR,
+				 "can't mount with data_err=abort, fs mounted w/o journal");
+			goto failed_mount3a;
+		}
 		sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
 		clear_opt(sb, JOURNAL_CHECKSUM);
 		clear_opt(sb, DATA_FLAGS);
-- 
2.39.2


