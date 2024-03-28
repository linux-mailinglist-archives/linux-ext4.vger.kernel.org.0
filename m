Return-Path: <linux-ext4+bounces-1764-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB30E89020D
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Mar 2024 15:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D877C28D6CC
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Mar 2024 14:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDC884D31;
	Thu, 28 Mar 2024 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Zfp/zxg8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from forward206c.mail.yandex.net (forward206c.mail.yandex.net [178.154.239.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EDA80BF0;
	Thu, 28 Mar 2024 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636746; cv=none; b=L6aPE0fMumudfk3j8pFWFYOMWkiwEMcnqen+1Bc6zv39C54zL0Tk23KKrvWz2QyeTKMyTdugIdD1R917Q2Nbje2wjE4HggLFaoDoR2lTbX0Qvo3IrhWqfy+ngMV619hA6VYcQLopDaa2bP76XtQrPaqSoe/GezCIqOixS136RTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636746; c=relaxed/simple;
	bh=pJMDg1eg6ejbUQsB/VhRS6kuW8PWYItofZ8I/HU16ok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AKQ+9GMSfPnNj1vaGS8LGzBs+o37+WM8N7yAMICg2dzxk/uy/gG4aTVtGZHnzC4zSNHU9dYF+J3/FuYB0BdFumCh2kG/GN+6jpSIlQg9RNWOhTsz46Oo8cvUrNkEKqg+kbFMSDqVZ9yGdmvW18/y1Xpr9C3xWpvKn94oaRx3RP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Zfp/zxg8; arc=none smtp.client-ip=178.154.239.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
	by forward206c.mail.yandex.net (Yandex) with ESMTPS id C89A2677E3;
	Thu, 28 Mar 2024 17:33:32 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:530c:0:640:30f1:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 77ECA60913;
	Thu, 28 Mar 2024 17:33:24 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 5XOBdK9Oia60-B64OuWg0;
	Thu, 28 Mar 2024 17:33:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1711636403; bh=agUHuLc6sWYp/vb7zT9L+aoPJ6k5EpklUa4uldWqnX4=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=Zfp/zxg8iv++i+MnpV5ba4KflU4IQqfwliLuog2m4i3VOGR2BkJITavjGML9t4h4o
	 nJvZfpx/dwKXW363ysOlJWQT7QLZEb+4hQtU03faEZ53iHmc8uymIlcDTtChl73xHS
	 q2VDBHjn+HibcbMhIaEtmyZhxWT1RnT0vMzfiLww=
Authentication-Results: mail-nwsmtp-smtp-production-main-42.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Mikhail Ukhin <mish.uxin2012@yandex.ru>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Mikhail Ukhin <mish.uxin2012@yandex.ru>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michail Ivanov <iwanov-23@bk.ru>,
	Pavel Koshutin <koshutin.pavel@yandex.ru>,
	Artem Sadovnikov <ancowi69@gmail.com>
Subject: [PATCH] ext4: fix semaphore unlocking order
Date: Thu, 28 Mar 2024 17:33:01 +0300
Message-Id: <20240328143301.6432-1-mish.uxin2012@yandex.ru>
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


