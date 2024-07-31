Return-Path: <linux-ext4+bounces-3547-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AC594268F
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 08:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335CA1F2389A
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jul 2024 06:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EDA16A92C;
	Wed, 31 Jul 2024 06:25:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C616661FDF;
	Wed, 31 Jul 2024 06:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722407131; cv=none; b=O/lFtKzahLcL1yGFhR7YHdsOncxZNJbmVxAB9WBN53jarrTu50esGETu0sU5d5nu//SNwG0YBrSCOyaX0iFtKd6AyUIgGoKFTTNrGhI2LQHdpA5Iw3a4/j5puBRxH2r/ulYf0tDZFDh+K0L/vQQ3Z2gbAoilqxf4kM7Iiy3XAls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722407131; c=relaxed/simple;
	bh=/HhltXrUnAA1vufTg3Jeu0VYuGj993ceIJ71pFcaIk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OONSt3CC6bI3Ujo5Ps1dv9BgWI+QQO+yZXd7b+u03q6KdBgTQdDyb+kkZthDsM5AALekbWeRUug4cbt0t1PL1CXAJkCDfWYXQ7Bo+Cp24VuV4voGW7a/u6SYgXOmMibBWUeMJJNdyoYBigfuFSH8dVS/VyTZjFOO/d+8v8dddDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WYhsh4GSvz4f3jrw;
	Wed, 31 Jul 2024 14:25:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7CBE11A06D7;
	Wed, 31 Jul 2024 14:25:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgA3jE7T2KlmaFNcAQ--.8748S3;
	Wed, 31 Jul 2024 14:25:25 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/8] jbd2: correctly compare tids with tid_geq function in jbd2_fc_begin_commit
Date: Wed, 31 Jul 2024 14:22:40 +0800
Message-Id: <20240731062247.2380440-2-shikemeng@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgA3jE7T2KlmaFNcAQ--.8748S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XFWUJF1fAFW3AF43JF1rCrg_yoWxtFX_XF
	10yr47Z3yagF15Aw48C3yY9rnaqws7urn5Gw1xtwsFkr4UGF15tFnrt390krn8W3yktrW3
	WayI9a10qF9xJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
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
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU14CJJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

Use tid_geq to compare tids to work over sequence number wraps.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Jan Kara <jack@suse.cz>
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


