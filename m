Return-Path: <linux-ext4+bounces-1851-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9B7898472
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 11:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4235B21B03
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 09:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6265574E10;
	Thu,  4 Apr 2024 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="cOU24V9/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from forward203b.mail.yandex.net (forward203b.mail.yandex.net [178.154.239.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9E01803D;
	Thu,  4 Apr 2024 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712224572; cv=none; b=AbXGHfFsXz8HcLMGUqU7lv/U2qB7Ok63M08hXNcfwlwP1jNUj33GBic/a/LT0ss4UGCgCuy5jTDeBlSiRFKe8AFXLeKv3k98pTkf04LqmG1Zs7ED5LwM6AD2qlX/vHJTy7dHzhCh2ceIst4XPyjRYV4lJUBXcTs/TgMQ3ghtoiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712224572; c=relaxed/simple;
	bh=pJMDg1eg6ejbUQsB/VhRS6kuW8PWYItofZ8I/HU16ok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t9Mj/o0DFRKCDn2KTL1RPebGC1oHcMu8akYBZVjWRxtopS4J2iIGX29vHPfKpVAl5dbLQOtdO5SxdN0n4csv/k68Fj+lLy33A2MHpAabnA1Olum9NOn8tAeB8+PJl65mfhxSnd88vlyPt4q9Uw/p3FoVTwoGFyHE0an8DytaH9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=cOU24V9/; arc=none smtp.client-ip=178.154.239.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103c.mail.yandex.net (forward103c.mail.yandex.net [IPv6:2a02:6b8:c03:500:1:45:d181:d103])
	by forward203b.mail.yandex.net (Yandex) with ESMTPS id 6A73E64DBD;
	Thu,  4 Apr 2024 12:50:24 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net [IPv6:2a02:6b8:c37:629:0:640:2d57:0])
	by forward103c.mail.yandex.net (Yandex) with ESMTPS id D805E60900;
	Thu,  4 Apr 2024 12:50:15 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 4oQ8Ed9k3Gk0-wDcBHWCM;
	Thu, 04 Apr 2024 12:50:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1712224215; bh=agUHuLc6sWYp/vb7zT9L+aoPJ6k5EpklUa4uldWqnX4=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=cOU24V9/52/2sBbYoPY9HHCSSLmC9Q5l+oux3S+YL7k1HU2kGwudWbgTYjMCCzzEU
	 E4Rgr/Roz5HUFpl8Zd9dx4/6Gd1UHdO+ShAW6f797XO8XYdrGtTGQ0r++ojSUwEA9N
	 vv30KOk92C2EUSqNRMSQSEBfcdkAxsKeHXgF4ybM=
Authentication-Results: mail-nwsmtp-smtp-production-main-36.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Mikhail Ukhin <mish.uxin2012@yandex.ru>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Mikhail Ukhin <mish.uxin2012@yandex.ru>,
	stable@vger.kernel.org,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michail Ivanov <iwanov-23@bk.ru>,
	Pavel Koshutin <koshutin.pavel@yandex.ru>,
	Artem Sadovnikov <ancowi69@gmail.com>
Subject: [PATCH] ext4: fix i_data_sem unlock order in ext4_ind_migrate()
Date: Thu,  4 Apr 2024 12:50:00 +0300
Message-Id: <20240404095000.5872-1-mish.uxin2012@yandex.ru>
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

Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>
---
 fs/ext4/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index d98ac2af8199..a5e1492bbaaa 100644
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
 	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
 	return ret;
-- 
2.25.1


