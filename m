Return-Path: <linux-ext4+bounces-8756-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04405AEFBBA
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 16:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFBAB1623B0
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Jul 2025 14:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B076F2749C9;
	Tue,  1 Jul 2025 14:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="dlq4IhSk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB46226B755
	for <linux-ext4@vger.kernel.org>; Tue,  1 Jul 2025 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379130; cv=none; b=Rc1ndoqabsT5sTTzX3pDt1mGm5x0yCzz24/ZvipJropUdPE8vjx9Kc6UPzzTcPlUgN5M9u2eyKxClHxffLMlyJtW0KUfZjX2K+nzH5rEA6nNkGTS+qKRvs/4KfTdE1sWG4Sbu672DEi5Rl8bdCwT2fCrM/UmyosCdCm/pwoK9OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379130; c=relaxed/simple;
	bh=R875AKwCEXUj1/YADOtdtYJyIMfMyzxGZ03L9Kjo9zs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K0CgngXVdjks4NxQDSpkzTPIOXcOh1WG9WavnWdxkftOpLr1Y3hZM07t7rUWSR0DBqUAa2DQwnf8yt1tfAL1BZLOFQ1GbGW7o/+70gtMv6nBt4aWkG+OHpC2oVXd0Px60P2NadKfu8mNbKyKI8QR0UWUO9oxTuKnNABGtccFd+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=dlq4IhSk; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:5915:0:640:b034:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id 37FE960E8C;
	Tue,  1 Jul 2025 17:11:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id uBbmqxCLrKo0-E6oTYCWS;
	Tue, 01 Jul 2025 17:11:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1751379117; bh=r7Q1Sa9+IWzR6aoJTjOOzAKaXXilRJbvrTxm69a0mpg=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=dlq4IhSkNjZXuZ80Dj9KwjELYXbInDgLkFdF4tUfFep7MZOs10m/+ky/kgRioVJ4o
	 TfiCLIZXU2kvYuGNUVdBAJ+6jdzuTY29uzp7ICtEqPkpcK6NEk1AvEeMbMSvWu1c10
	 JqoPf9O2HkD6kNOGUJLTxmY5Ody9dDbIwEy6Y5E8=
Authentication-Results: mail-nwsmtp-smtp-production-main-95.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+5322c5c260eb44d209ed@syzkaller.appspotmail.com
Subject: [PATCH] ext4: verify dirent offset in ext4_readdir()
Date: Tue,  1 Jul 2025 17:11:41 +0300
Message-ID: <20250701141141.55938-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a corrupted filesystem, an unexpectedly large invalid value
returned by 'ext4_rec_len_from_disk()' may cause 'ext4_readdir()'
to read the next dirent from an area beyond the corresponding
buffer head's data. At this point, an exact length of the dirent
is not known yet but it's possible to check whether the shortest
possible dirent will be read from within the bh's data at least.

Reported-by: syzbot+5322c5c260eb44d209ed@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5322c5c260eb44d209ed
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 fs/ext4/dir.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index d4164c507a90..8097016f69aa 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -258,6 +258,12 @@ static int ext4_readdir(struct file *file, struct dir_context *ctx)
 
 		while (ctx->pos < inode->i_size
 		       && offset < sb->s_blocksize) {
+			/* Ensure that at least the shortest possible
+			 * dirent will be read from within the bh's data.
+			 */
+			if (offset + offsetof(struct ext4_dir_entry_2, name)
+			    > bh->b_size)
+				break;
 			de = (struct ext4_dir_entry_2 *) (bh->b_data + offset);
 			if (ext4_check_dir_entry(inode, file, de, bh,
 						 bh->b_data, bh->b_size,
-- 
2.50.0


