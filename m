Return-Path: <linux-ext4+bounces-3583-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C329440C4
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 04:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16EC41F24803
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Aug 2024 02:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29B41AD9D2;
	Thu,  1 Aug 2024 01:41:01 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6B61A7210;
	Thu,  1 Aug 2024 01:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722476461; cv=none; b=OvJOenD5nKBsDt/mAFOjB1+PQZUuV7HuUMWCpQrPBfPiF+UIp5oUGRRJON8t88seOsCQPAS2GR/iAkRRQ+Ej2cVOui5Fgn81mRyQ1sMLXM2j6+A7i+Zh3kiO4AuuE2aUQgEdD/ZajjPGGaAMTR7lccEZLUOvuAW61sYmT6HFTeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722476461; c=relaxed/simple;
	bh=jv9mL8bTYHP2MRryq0Gtvp3IB6pLJqrsD0knMVMr34w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=phCbSYSe5AaZpvpPBY92J110OVS1G3Qa8ibAERC9cwkgMkmwzfQ//WkXaRhpAtCjvdPkrsNZQsj/1fBz2yRzF8i6poc50wIV5trF83THVeq/Sqluf0SgzREZSEghX/bFBVyAuX3y1UlNAwwG9kwiJ+gnGoi/nUviHe6LQaoSb6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WZBW22P3Kz4f3jYh;
	Thu,  1 Aug 2024 09:40:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0BF261A0FA3;
	Thu,  1 Aug 2024 09:40:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP2 (Coremail) with SMTP id Syh0CgBnnr2l56pmr3OyAQ--.24249S3;
	Thu, 01 Aug 2024 09:40:54 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/8] jbd2: correctly compare tids with tid_geq function in jbd2_fc_begin_commit
Date: Thu,  1 Aug 2024 09:38:08 +0800
Message-Id: <20240801013815.2393869-2-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240801013815.2393869-1-shikemeng@huaweicloud.com>
References: <20240801013815.2393869-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnnr2l56pmr3OyAQ--.24249S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZryDJr1rtry7GF45Zry5Jwb_yoW3XFX_XF
	10yr47Z3yagF1rA3yrCayY9rnaqws7urn5Ww1xtw12kr4UGF18tFnrt398Kr1DW3yktrW5
	WFZ29a10qr9xJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbV8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r18M2
	8IrcIa0xkI8VCY1x0267AKxVWUXVWUCwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07UAEfrUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Use tid_geq to compare tids to work over sequence number wraps.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 1ebf2393bfb7..da5a56d700f1 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -710,7 +710,7 @@ int jbd2_fc_begin_commit(journal_t *journal, tid_t tid)
 		return -EINVAL;
 
 	write_lock(&journal->j_state_lock);
-	if (tid <= journal->j_commit_sequence) {
+	if (tid_geq(journal->j_commit_sequence, tid)) {
 		write_unlock(&journal->j_state_lock);
 		return -EALREADY;
 	}
-- 
2.30.0


