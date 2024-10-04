Return-Path: <linux-ext4+bounces-4481-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1501F990C08
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 20:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468DE1C20340
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 18:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FFB1F22AF;
	Fri,  4 Oct 2024 18:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9VPROM7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F431F22A2;
	Fri,  4 Oct 2024 18:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066143; cv=none; b=JNvy4TmPQmeFFkUPbGHPtiw4w+iymHpCu8O7Bg8FxMNSRPz+KVhfNtC+BKytLjSzN+YQeHKOFMh5DJKzogjT1cYy2WDQA16iKiE6Ab2Gvf0RgDNssENxHIGq9iyaG2094EXgxChN6f/BM8K0ltlxWynz70bjyDO/kxQUmmHn2mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066143; c=relaxed/simple;
	bh=v2mvxM65+HybBi/a2juuSaSOAdhlM+sU0raG1huyRQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEk62a5bRp685LRQWF4NlZlCKo+js+dKLXR3JiIRD/J3+ei4DcyUsx1vBUwevtaqx1RmemH2SqdQvhGxHL/8DpUjJKJ8iA0n61vZtsB852qbd2Q3UtcIR+fYB23+UQZDRsm+eCx3LbLKU86Wzyt0wmka/8BZMcUlExewYhRkRCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9VPROM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E575C4CED0;
	Fri,  4 Oct 2024 18:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066142;
	bh=v2mvxM65+HybBi/a2juuSaSOAdhlM+sU0raG1huyRQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I9VPROM7unD7Gw6er1cs7/Tm1PdUyitpwhgmkwXg5t0Lv5i2UpP7GVCF0GUAZtwJo
	 GUUI4LqisPKVjkmMxQTRRL5Bs7Mu16smUQgsLlMSD0tLuP15xJ2puDz5BAMI3n4pMx
	 N/muVxIQ30oZDJ3RM94A3Qn4RnUsV/yslP1qVcyVVE4sbyW6o+kus5puQs6icm/lR0
	 CiRByZ79cgNJqppvlXvkq10XDw1XOKa6Ip82OK24J02Uz0h/gBqCd60lQ8OOAft8Bd
	 +bTKJCRYWVCrfo/BzRg3j73IroBLHistmZ87GfyDhTEiz1co4oEZ+zA7qo/Cvf56pM
	 dP0Q/M2ejzs2g==
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
Subject: [PATCH AUTOSEL 6.10 11/70] ext4: fix i_data_sem unlock order in ext4_ind_migrate()
Date: Fri,  4 Oct 2024 14:20:09 -0400
Message-ID: <20241004182200.3670903-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
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


