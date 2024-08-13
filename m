Return-Path: <linux-ext4+bounces-3703-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3C695048A
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Aug 2024 14:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877571F23A97
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Aug 2024 12:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A4C199EAA;
	Tue, 13 Aug 2024 12:10:17 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E48199221;
	Tue, 13 Aug 2024 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723551017; cv=none; b=CUhgejxDyMTPmnzC4hITqmsjWXS7JI7xbOwEy8std/TjEHeLeU07HBtFViAcq4vNamMmiKMmS3Nk9sKNVOXU6mgNonClAIylwdrfDoNqbZTBm3AQL4hWk69rn31lMiu+ApgfUZk4YxRHWzbTNMGFo2isoR2URjSprrNiVLGkXgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723551017; c=relaxed/simple;
	bh=/1BqjdA9iCb1vnVWAoyQTpVuLfh0XLAWYxaz/FJU9+4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DxoNZoEUlIHp2LT/gky4FgyYHPkhyo1T7JGCNT5EC3tzVYSE1cysmGAhpbp9k3TXB+VB7m5JouVjLolp13aaarshM3o2oSOy/UWzb33mc4s+9g7oV+deMqEb+zihvL3vyERCNbQ6N3QevTwFlV4au9La+zr0Rpj48+kV8Rvf5wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WjqvY4QYYz4f3k6P;
	Tue, 13 Aug 2024 20:10:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E35341A058E;
	Tue, 13 Aug 2024 20:10:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgDnl7YhTbtmPh4XBg--.33191S3;
	Tue, 13 Aug 2024 20:10:10 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] ext4: avoid buffer_head leak in ext4_mark_inode_used
Date: Tue, 13 Aug 2024 20:07:06 +0800
Message-Id: <20240813120712.2592310-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240813120712.2592310-1-shikemeng@huaweicloud.com>
References: <20240813120712.2592310-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDnl7YhTbtmPh4XBg--.33191S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtw4UGF4xKr15tFW5XF1UZFb_yoWkJrX_ua
	srJr18J3yrCwn3WF4vvrs8ArWvkay0kF1rWFs5ta43Zw1Ut398uryDArnxArWkuw43Zrn8
	Ar9Fqry3JryFgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbskYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
	8IrcIa0xkI8VCY1x0267AKxVWUXVWUCwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F
	4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
	C0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
	6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73Uj
	IFyTuYvjxUFzV1UUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Release inode_bitmap_bh from ext4_read_inode_bitmap in
ext4_mark_inode_used to avoid buffer_head leak.
By the way, remove unneeded goto for invalid ino when inode_bitmap_bh
is NULL.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/ext4/ialloc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 9dfd768ed9f8..ad7f13976dc6 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -755,10 +755,10 @@ int ext4_mark_inode_used(struct super_block *sb, int ino)
 	struct ext4_group_desc *gdp;
 	ext4_group_t group;
 	int bit;
-	int err = -EFSCORRUPTED;
+	int err;
 
 	if (ino < EXT4_FIRST_INO(sb) || ino > max_ino)
-		goto out;
+		return -EFSCORRUPTED;
 
 	group = (ino - 1) / EXT4_INODES_PER_GROUP(sb);
 	bit = (ino - 1) % EXT4_INODES_PER_GROUP(sb);
@@ -860,6 +860,7 @@ int ext4_mark_inode_used(struct super_block *sb, int ino)
 	err = ext4_handle_dirty_metadata(NULL, NULL, group_desc_bh);
 	sync_dirty_buffer(group_desc_bh);
 out:
+	brelse(inode_bitmap_bh);
 	return err;
 }
 
-- 
2.30.0


