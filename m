Return-Path: <linux-ext4+bounces-3519-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1415E94109E
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 13:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431841C22A7C
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 11:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B258019F46C;
	Tue, 30 Jul 2024 11:36:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87A81991DD;
	Tue, 30 Jul 2024 11:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339378; cv=none; b=YwK6tIgBoQmic4E+zasPjFEdXNgbF0vgPPqVsUWd2oAYc5MbdPfe1G7I0apH0jedMBlAHMwMpD5ISHPbQKcQrcNPYCB3G+CwHsE0PIOH2JzHKdV+r+vSNgBKMBuOzXJkj0vdZzLIOU6NEYLPQeXWZ/DZp0nrf/WDtP0m3PGYci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339378; c=relaxed/simple;
	bh=+K4dQYWGjBUk9cwWtnX6G5B4Oxjq8U7YaemCOosT0cU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tXvdOt6Ch/3zfX/HTkJHVv2TXrSFrue9TEJgQLbcnGjfBleKQsXUQS8yoVJv7knc3GmccjlSsLI0T8SyKIPd997WQ6bP3SdvwfDUk5wdABC0kosYwZLFI1Ox22vOS3ETG5fVi3Xd6w10Y/KmCrxrdwNZq42MZPN/Yakb3JpoCuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WYCpl4N9tz4f3m6s;
	Tue, 30 Jul 2024 19:35:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 7F4FD1A12D1;
	Tue, 30 Jul 2024 19:36:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgCH2kwq0Khmm+QUAQ--.5153S8;
	Tue, 30 Jul 2024 19:36:13 +0800 (CST)
From: Kemeng Shi <shikemeng@huaweicloud.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] jbd2: correct comment jbd2_mark_journal_empty
Date: Tue, 30 Jul 2024 19:33:34 +0800
Message-Id: <20240730113335.2365290-7-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240730113335.2365290-1-shikemeng@huaweicloud.com>
References: <20240730113335.2365290-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCH2kwq0Khmm+QUAQ--.5153S8
X-Coremail-Antispam: 1UD129KBjvdXoWrKF1UtFy7Xr17Ww15Jw1UJrb_yoWxKFX_XF
	40vrs7u39xtrsFyw4rCa18Wrnaqrs7uFn5J3WxtwsFkr1UJFWfGFnrJry5X347uF18K3y2
	9wn2ga48tFZFqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
---
 fs/jbd2/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index f17d05bc61df..dc18b9f7c999 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1939,7 +1939,7 @@ static void jbd2_mark_journal_empty(journal_t *journal, blk_opf_t write_flags)
 	if (had_fast_commit)
 		jbd2_set_feature_fast_commit(journal);
 
-	/* Log is no longer empty */
+	/* Log is empty */
 	write_lock(&journal->j_state_lock);
 	journal->j_flags |= JBD2_FLUSHED;
 	write_unlock(&journal->j_state_lock);
-- 
2.30.0


