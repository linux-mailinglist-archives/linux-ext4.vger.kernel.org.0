Return-Path: <linux-ext4+bounces-4306-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF95985BF7
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2024 14:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21DA91F26014
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2024 12:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB411CB50C;
	Wed, 25 Sep 2024 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLxpQjPd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAEC1CB500;
	Wed, 25 Sep 2024 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265207; cv=none; b=IVEZAcwCz/+5blTKN9zxdiFgp6sx1TNByU9qUDY0/cSOZ1QRnrVcpHmQzVwNlIlUA9NvT0DZySgmrKfvCy8vSMqQhvlQFwGzunmICJcOycXWLCBO9Taw9dX63B8ETektX/YDPKoU62YR+3LgFOA1fhn+UETA4yC7bfvWC6OcCkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265207; c=relaxed/simple;
	bh=v2mvxM65+HybBi/a2juuSaSOAdhlM+sU0raG1huyRQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0DphX3R7VRs8iPz2rjC9MvXhQ5qDRXs7SIhrltFWckCvn5VSr/oIoPRBn5Ad/cOac/nSbM2LzMavxOFr6Bede5JO3oF396DdzwoxLk/+Np/rY5k+kYR6sTUtf1VoQX7w1xdbGhsAM1597GQ0AduRD7gXo6rEp4xMjI/QGqwPWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLxpQjPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CABC4CECD;
	Wed, 25 Sep 2024 11:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265207;
	bh=v2mvxM65+HybBi/a2juuSaSOAdhlM+sU0raG1huyRQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rLxpQjPdjWtonO7twrxE/UWiovljgAI5JU1QQsPgO1psvaDP2gjxjTrJaYx2MOThl
	 1Mp8j6tD8u55zsZZnRxdoIcyM/vHa1tKV+1jqh3gM9cLaLfPXmMB2bdFuxwpJY5nDl
	 Gt3nj56eEERzNeioGk6nkH/HTi6Blts4IRLTuf3kWrfpBvcBXS7Qj5ocQPEenIIDmA
	 Wke0tWtvWrZQWvxILAbKLwKzIHoI5DddqQFMcfjzWecGUjziLWXK7jUu6SZklgSZao
	 nyG1cU0sXVzHTy42nalAi6yGsB3GNDhI48UTl0AxOkLDWyjHVxCWjzyLA03dmPQ7xk
	 018TlWolj9vig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Artem Sadovnikov <ancowi69@gmail.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Mikhail Ukhin <mish.uxin2012@yandex.ru>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 240/244] ext4: fix i_data_sem unlock order in ext4_ind_migrate()
Date: Wed, 25 Sep 2024 07:27:41 -0400
Message-ID: <20240925113641.1297102-240-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Artem Sadovnikov <ancowi69@gmail.com>

[ Upstream commit cc749e61c011c255d81b192a822db650c68b313f ]

Fuzzing reports a possible deadlock in jbd2_log_wait_commit.

This issue is triggered when an EXT4_IOC_MIGRATE ioctl is set to require
synchronous updates because the file descriptor is opened with O_SYNC.
This can lead to the jbd2_journal_stop() function calling
jbd2_might_wait_for_commit(), potentially causing a deadlock if the
EXT4_IOC_MIGRATE call races with a write(2) system call.

This problem only arises when CONFIG_PROVE_LOCKING is enabled. In this
case, the jbd2_might_wait_for_commit macro locks jbd2_handle in the
jbd2_journal_stop function while i_data_sem is locked. This triggers
lockdep because the jbd2_journal_start function might also lock the same
jbd2_handle simultaneously.

Found by Linux Verification Center (linuxtesting.org) with syzkaller.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Co-developed-by: Mikhail Ukhin <mish.uxin2012@yandex.ru>
Signed-off-by: Mikhail Ukhin <mish.uxin2012@yandex.ru>
Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>
Rule: add
Link: https://lore.kernel.org/stable/20240404095000.5872-1-mish.uxin2012%40yandex.ru
Link: https://patch.msgid.link/20240829152210.2754-1-ancowi69@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index d98ac2af8199f..a5e1492bbaaa5 100644
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
2.43.0


