Return-Path: <linux-ext4+bounces-3550-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4F2942695
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 08:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B55282320
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 06:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C0C16D307;
	Wed, 31 Jul 2024 06:25:32 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25B21BC3F;
	Wed, 31 Jul 2024 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722407132; cv=none; b=Th3yzADopbCAXJqAjmQoq3fgrkszci2jv6Gnvsgy2EkfezZBT7Uj+gzziKle+YZ8ffA6cCmVLsPBK6btxvjttLfqIK5aEz3VtUfw3dWTqzZ2KF+Ce9hHhWWn2awoBkP83ZExZfgDqlPJ985h7YfE6lp2oemxV8tqMcI9oBZsXVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722407132; c=relaxed/simple;
	bh=yOUig+BtTpdLm4KdzpKNDcVLqHFSc+cBH2Vk9hTp5PI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ueOOicpSFfy02/vpCv03CXGjsAjX7RFDglqETfqSvMI+a3llKWBfwA0BL4aTuY4r7TWGO0rk7ZmYvUeHIv5+h0cPCr3cFGeEKbBLxPPDIe3PfhqQrYh7R0dcQEjCvpvt28vL+AUnv0JjqlEDXOqltH096m/A+bdPSIepdXxYixQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WYhsk19l5z4f3jsD;
	Wed, 31 Jul 2024 14:25:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 159771A08FC;
	Wed, 31 Jul 2024 14:25:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3jE7T2KlmaFNcAQ--.8748S9;
	Wed, 31 Jul 2024 14:25:26 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] jbd2: correct comment jbd2_mark_journal_empty
Date: Wed, 31 Jul 2024 14:22:46 +0800
Message-Id: <20240731062247.2380440-8-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240731062247.2380440-1-shikemeng@huaweicloud.com>
References: <20240731062247.2380440-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgA3jE7T2KlmaFNcAQ--.8748S9
X-Coremail-Antispam: 1UD129KBjvdXoWrKF1UtFy7Xr17Ww18KrWkXrb_yoW3Wrb_Xr
	40vrs7ZwsxtanFyw4rCa18Wr1Sqrs7urn5A3WftwsFkr1UJayfGFnrJ345X3srur1kK3y2
	9wn2ga18trZrtjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

After jbd2_mark_journal_empty, journal log is supposed to be empty.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 85273fb1accb..e89d777ded34 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1938,7 +1938,7 @@ static void jbd2_mark_journal_empty(journal_t *journal, blk_opf_t write_flags)
 	if (had_fast_commit)
 		jbd2_set_feature_fast_commit(journal);
 
-	/* Log is no longer empty */
+	/* Log is empty */
 	write_lock(&journal->j_state_lock);
 	journal->j_flags |= JBD2_FLUSHED;
 	write_unlock(&journal->j_state_lock);
-- 
2.30.0


