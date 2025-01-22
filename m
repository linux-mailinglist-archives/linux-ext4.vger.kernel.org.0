Return-Path: <linux-ext4+bounces-6207-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C286A190DB
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 12:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14511667D9
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 11:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B335212B25;
	Wed, 22 Jan 2025 11:47:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9F421148F;
	Wed, 22 Jan 2025 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737546447; cv=none; b=osmJb4BnURVWHzgNNLXFyDshIDEFAMdqWMSQksJbj5lZvA/4GM95YbmLG9FEBn8/ymDtbeQlMPUbkLbHbydrdY6rUuvOrh+NDG38h2BAE6ytT2whwCJs0E54stVdlXCNK6fQ1ikMAFe8cosTDXyd9yEf69+uFoRc0QemUYpSMcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737546447; c=relaxed/simple;
	bh=aC7NhqVR69URa85LCzfWpHN8P8hxrKwqEoQe595K5NM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=itCnoHlCjLgyWRznpF6o4EM8atnx+9DAHHf+KJ7cXF5jVgzlFybq89gbyGO68URHV55lx0Qi8wldzdTrU07A+dVUUK+Gn/OggWjrXi8xJQD4efMFInKp1jVFqcYIEXiOvzKYs7TWTY1/zjZIOwAr/EKsoAQUcB1PEzlYI727nWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YdMkG085hz4f3jdK;
	Wed, 22 Jan 2025 19:47:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A074C1A0D8A;
	Wed, 22 Jan 2025 19:47:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl_F2pBn0KiuBg--.48765S10;
	Wed, 22 Jan 2025 19:47:22 +0800 (CST)
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
Subject: [PATCH v2 6/7] ext4: show 'emergency_ro' when EXT4_FLAGS_EMERGENCY_RO is set
Date: Wed, 22 Jan 2025 19:41:29 +0800
Message-Id: <20250122114130.229709-7-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250122114130.229709-1-libaokun@huaweicloud.com>
References: <20250122114130.229709-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3Wl_F2pBn0KiuBg--.48765S10
X-Coremail-Antispam: 1UD129KBjvJXoW7uF15Cryxur48Xw15JrW5ZFb_yoW8Jw48p3
	ZYkwn7Gr9YvF18Ca17GayxZ34Fgw1SkayUWrWS9w45Kry5X34v9r12kryFgFW8urZ0g3s0
	qF1I9ry7Zry5A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24lc7
	CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l
	x2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14
	v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IY
	x2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU
	0xZFpf9x0JU9Aw3UUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAQBWeQpvkOygAAs7

From: Baokun Li <libaokun1@huawei.com>

After commit d3476f3dad4a ("ext4: don't set SB_RDONLY after filesystem
errors") in v6.12-rc1, the 'errors=remount-ro' mode no longer sets
SB_RDONLY on errors, which results in us seeing the filesystem is still
in rw state after errors.

Therefore, after setting EXT4_FLAGS_EMERGENCY_RO, display the emergency_ro
option so that users can query whether the current file system has become
emergency read-only due to errors through commands such as 'mount' or
'cat /proc/fs/ext4/sdx/options'.

Fixes: d3476f3dad4a ("ext4: don't set SB_RDONLY after filesystem errors")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 098e62727aec..06633d23d8b2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3044,6 +3044,9 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 	if (nodefs && !test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS))
 		SEQ_OPTS_PUTS("prefetch_block_bitmaps");
 
+	if (ext4_emergency_ro(sb))
+		SEQ_OPTS_PUTS("emergency_ro");
+
 	ext4_show_quota_options(seq, sb);
 	return 0;
 }
-- 
2.39.2


