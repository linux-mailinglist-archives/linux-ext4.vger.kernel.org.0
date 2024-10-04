Return-Path: <linux-ext4+bounces-4508-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB8B990FFA
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 22:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94A25B26FAC
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 19:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C78222F262;
	Fri,  4 Oct 2024 18:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdkAuUPI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19FA22F254;
	Fri,  4 Oct 2024 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066717; cv=none; b=p/ZDVG+zw4Dv1KyvhR72tBXqJw/wAPG8EXCDxC95JMIkymYzVVR55kgkTHVwkWKH9kJ1CI3Ewa5deMBGZPpYpBCGabw+0nGx8zGtVqt87IJYrymaFAC5YensP9P8WdI+bb15U1MQOH7F5pJd8/pA0ug5JoU6f8a0gpUTIAcSEAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066717; c=relaxed/simple;
	bh=twSXpgGrC+k8y/TzOeXzORtfsxzFaI+naBa0jRtDwSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GMfD5hatN16/XE/JLegII+lGO/tioLuLz0pV+SQaiJxNwPZG/ZNy+UMv/PBRZp89gnqgse5gBWbz7K/Wtiui5bqWa7bCrqbH0kRK+F74RZzvpvRUjJzThI+29YakCfntzIuVAXgi8bMdK3vYwUBZUVNC58IdrtSKn0taqOcZD18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdkAuUPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47ABC4CECE;
	Fri,  4 Oct 2024 18:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066717;
	bh=twSXpgGrC+k8y/TzOeXzORtfsxzFaI+naBa0jRtDwSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IdkAuUPIRCAv4Baa/5cdG8NjrKRT0zLMMSkhXn68B3wemVNPMBV8FN1mrBSlUixYH
	 jIK4oNADu2G49bsmkmJGbnNf3gfe3O05VRed1W+k7igFTdvCPvgBKUEWWQ6L4HGEdD
	 kQORhhQkJVP5PvDUqFPHzC1YVSWrVRJYRBaIO7lX6EuxA+HYG/Qbsqg0g9nwWOmRpC
	 PGQsLSZaalicEV7ss+ek42wwYsGe9ho/2UPj7gAR5hhCKHgu5N3jZvLVx6QQRphmUZ
	 mWZ25X38KyGV+YeND/HfWcei5vzEvMyHvrwcoGDzPqVXMs1co+4Xa6wRuLjxnLXyi6
	 9UipSEc60qAmQ==
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
Subject: [PATCH AUTOSEL 4.19 04/16] ext4: fix i_data_sem unlock order in ext4_ind_migrate()
Date: Fri,  4 Oct 2024 14:31:31 -0400
Message-ID: <20241004183150.3676355-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004183150.3676355-1-sashal@kernel.org>
References: <20241004183150.3676355-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.322
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
index 4a72583c75593..9f73c2f7f9492 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -678,8 +678,8 @@ int ext4_ind_migrate(struct inode *inode)
 		ei->i_data[i] = cpu_to_le32(blk++);
 	ext4_mark_inode_dirty(handle, inode);
 errout:
-	ext4_journal_stop(handle);
 	up_write(&EXT4_I(inode)->i_data_sem);
+	ext4_journal_stop(handle);
 out_unlock:
 	percpu_up_write(&sbi->s_writepages_rwsem);
 	return ret;
-- 
2.43.0


