Return-Path: <linux-ext4+bounces-4310-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0C3985E3E
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2024 15:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C84E288DD8
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2024 13:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E0320E8CB;
	Wed, 25 Sep 2024 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpS5UIWU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF6320E8C8;
	Wed, 25 Sep 2024 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266151; cv=none; b=pHr1kNXjKkF9r5Ko8uYV0dNdpfMueNTYKzDpAhAKzo1XINnGKOakE4oCvNI1CkcrkRETF37sBYPxCDXpV9To8CDHrMXnXnuOiLyinNPm4io3/Ovs2FIxNz9crXngIfDTk/KXxruwxQK5fTAJuFXAXJ44PpLFEm+y4ksbFGKYCg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266151; c=relaxed/simple;
	bh=v2mvxM65+HybBi/a2juuSaSOAdhlM+sU0raG1huyRQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6zVCigYLniKIqotj/R8DVzGyQ+EkYUjl47IJMZs8kTVbcIT/QpTdmW2xwBCfaDmBjrjpUeph/rhvfx2gKT77EBJUu8/y3CrsEFqzx+h/IGTfMRy89HjZGWNPjSKBECYWjcl0v3d4LbOAG0TbO4/NQvroiGXnRZKX5uhaHn/Cpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpS5UIWU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB9AC4CEC3;
	Wed, 25 Sep 2024 12:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266151;
	bh=v2mvxM65+HybBi/a2juuSaSOAdhlM+sU0raG1huyRQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VpS5UIWUL4tOicYXLnj3fNQVyuWndMdc44A3yRAz4a0GMkAWnDY0lcIQv0tsuFTrl
	 g6N1kHxg23m1slMGcDaY8yZ0dEIyX+A2JmUkMrLWLpXqBKJrqEoaaGa+EEGy4HTCrA
	 kdkSDebdZu7N5uycozh6NZPAN42nJQmOeWUaBz2XazAEMoo9bxg4Wx2asDBf76tiYa
	 3sY78DCxXvh9dWrjK78a/ObJ49dul2pnq92fAS+QPIe13lk+lQa8WrASZsNNtueI7I
	 mwOBil3BgQu+myx4OMH5f7pz+/ZXhC3wn3ko5V+79qbIzwAmGAyq4WdPafWoYi1h9h
	 OdhiFdLWwKyAw==
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
Subject: [PATCH AUTOSEL 6.10 193/197] ext4: fix i_data_sem unlock order in ext4_ind_migrate()
Date: Wed, 25 Sep 2024 07:53:32 -0400
Message-ID: <20240925115823.1303019-193-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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


