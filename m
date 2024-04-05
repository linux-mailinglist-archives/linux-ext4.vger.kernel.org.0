Return-Path: <linux-ext4+bounces-1907-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D470C89A5EE
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Apr 2024 23:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B6761C21070
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Apr 2024 21:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C438174EFB;
	Fri,  5 Apr 2024 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="hpiQA8ev"
X-Original-To: linux-ext4@vger.kernel.org
Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CF0174ECB;
	Fri,  5 Apr 2024 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351307; cv=none; b=HIC2x6LCeqMRV+vbI3ILoMyDLjBZoGG0rE73dr7s23fyvPGIVlWJDGtKgdwFVQA4X7bYtXA0Gt3YAprYrYKYCCc/MPb9tcQ7wBzKWfqveDQdCiRgvATwC3VR4kuHEWbXh8PslBvLmfcaXUkKBxP5NAVInqXG/nl9tf+o02FxKAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351307; c=relaxed/simple;
	bh=BuUaqwqRMooOCayqSdCfqcPUua5XUE2+B4+1D+Bpq+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G32+GWMb62yRDDZgjWZZKOLJiOdyFcqcLTRSI2pBRmzUa3NQRSE6A8kGab/vvJsmBIU+O2dVHGOYAIaP1bq7xQTjXQf5opvzsm8rS/ALXJyB8XyssCHnH/MwPUIRHPBFwGWdoa0k1Ov//l89q4BnUcamZ5bs86ENHTZcYruWo/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=hpiQA8ev; arc=none smtp.client-ip=178.154.239.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:410d:0:640:81ab:0])
	by forward100c.mail.yandex.net (Yandex) with ESMTPS id EAC2B608FF;
	Sat,  6 Apr 2024 00:08:20 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 58dgY40f2mI0-s2z5ewZt;
	Sat, 06 Apr 2024 00:08:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1712351300; bh=ankcvjCnWYEl74QlyFijcb2pcN+AU5nXfIOxKz9HVUs=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=hpiQA8evIJLZ4olpHFL2cQ7I03vbuDXkgHOLLB/mqNk3Wo8SF4TSZiwF+2K0q/Nh6
	 /fVWGp+IFFs1PKipv7/RJfusYMvKU4nU2m0BZmYTYqCHhjWhwTZjka8jR7GNGKVS2f
	 gftU5k1NiwGNjMKMrSCXRJwFMVypvj3iGpjFnMyg=
Authentication-Results: mail-nwsmtp-smtp-production-main-54.iva.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Mikhail Ukhin <mish.uxin2012@yandex.ru>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Mikhail Ukhin <mish.uxin2012@yandex.ru>,
	stable@vger.kernel.org,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michail Ivanov <iwanov-23@bk.ru>,
	Pavel Koshutin <koshutin.pavel@yandex.ru>,
	lvc-project@linuxtesting.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Artem Sadovnikov <ancowi69@gmail.com>
Subject: [PATCH v2] ext4: fix i_data_sem unlock order in ext4_ind_migrate()
Date: Sat,  6 Apr 2024 00:08:03 +0300
Message-Id: <20240405210803.9152-1-mish.uxin2012@yandex.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fuzzing reports a possible deadlock in jbd2_log_wait_commit.

The problem occurs in ext4_ind_migrate due to an incorrect order of
unlocking of the journal and write semaphores - the order of unlocking
must be the reverse of the order of locking.

Found by Linux Verification Center (linuxtesting.org) with syzkaller.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>
Signed-off-by: Mikhail Ukhin <mish.uxin2012@yandex.ru>
---
 v2: New addresses have been added and Ritesh Harjani has been noted as a
 reviewer.
 fs/ext4/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index b0ea646454ac..59290356aa5b 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -663,8 +663,8 @@ int ext4_ind_migrate(struct inode *inode)
 	if (unlikely(ret2 && !ret))
 		ret = ret2;
 errout:
-	ext4_journal_stop(handle);
 	up_write(&EXT4_I(inode)->i_data_sem);
+	ext4_journal_stop(handle);
 out_unlock:
 	percpu_up_write(&sbi->s_writepages_rwsem);
 	return ret;
-- 
2.25.1


