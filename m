Return-Path: <linux-ext4+bounces-2324-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D16FC8BCFF3
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 16:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558F11F234EC
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 14:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AE513DB92;
	Mon,  6 May 2024 14:18:31 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611E013CF80;
	Mon,  6 May 2024 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005111; cv=none; b=qyvI32ZucHpC+nKl2Ez01oE+v3d9B4so4ZIJ1CE5MSCO7uJu6tUcfBazSP2tR4LgibpXa2E8wUldYurMuh/TmWq0zrOhElKp/RtKmsqUQZMTJL5S44jK2PalK1dAyKaMqQCdbpuS8AD5O9O0biyQZOjSddN+nmJhd50StafRqI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005111; c=relaxed/simple;
	bh=cWuhVqAP6v8J0U9SKkA4Mal2e/kDt5ywT7XvdMIQYYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c/B5S56PEjzbS6/sY9SLT9BCj9Zx74oof1laHn+wEfzur9tj1BWLYzgn9PDSsy3d8BAhxYhMfWCb6OANFqnDKJpmqswCimkI2AbWK87Mb98VsD5lxIwkBVrEKb2Z/4L6ig5OQX+EbR1tsel+orVte6ctQFBlBNUwdXqtEO0o3lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VY3RJ6n9Fz4f3k6H;
	Mon,  6 May 2024 22:18:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 371A71A08D3;
	Mon,  6 May 2024 22:18:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgAH2RGu5jhmGgSzLw--.22965S10;
	Mon, 06 May 2024 22:18:26 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] jbd2: remove dead check of JBD2_UNMOUNT in kjournald2
Date: Mon,  6 May 2024 22:18:00 +0800
Message-Id: <20240506141801.1165315-9-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
References: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAH2RGu5jhmGgSzLw--.22965S10
X-Coremail-Antispam: 1UD129KBjvdXoWrZF15WF4DJFy8Ar48Xr4UXFb_yoW3KrX_Xr
	WxArnrZ39xKr45JFWxGw45Wr1Fqrs7ur1kAw1Iq39Fkw1UJ3W7ZF1kXry5Zry5ua1vq3y5
	u3Z7Ka18Kr9agjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26F4UJVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7IU13l1DUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/

We always set JBD2_UNMOUNT with j_state_lock held in journal_kill_thread.
In kjournald2, we check JBD2_UNMOUNT flag two times under the same
j_state_lock. Then the second check is unnecessary.
Also see comment in struct journal_s about lock rule of j_flags.

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
---
 fs/jbd2/journal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index e8f592fbd6e1..ce9004f40ffb 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -228,8 +228,6 @@ static int kjournald2(void *arg)
 		if (transaction && time_after_eq(jiffies,
 						transaction->t_expires))
 			should_sleep = 0;
-		if (journal->j_flags & JBD2_UNMOUNT)
-			should_sleep = 0;
 		if (should_sleep) {
 			write_unlock(&journal->j_state_lock);
 			schedule();
-- 
2.30.0


