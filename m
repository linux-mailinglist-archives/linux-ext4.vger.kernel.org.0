Return-Path: <linux-ext4+bounces-4499-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A088990E17
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 21:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6B0284ADE
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 19:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0862221CABF;
	Fri,  4 Oct 2024 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPTpd6ir"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911E021CAB1;
	Fri,  4 Oct 2024 18:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066551; cv=none; b=P96fTqI0zMFy4Jtw/82T+fIz9Xng9rFdWpHE6m2SJm7LGGo49epBiuUIZNMerbrCg6uZa3QgHkzmYUn189lsKyN0GuAiDxeY6UcgyYF7/wo/HhD9CSCzNDgtqRsThnB5rZ4V2QeQFZx0V+Og8UMyHcwaygOCULzVKF8sHR+RojY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066551; c=relaxed/simple;
	bh=7KsdUYsx0mqG93eBQ1UwLX1plpEzS7CoypLGvF9n4OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XiSryJh3e44ti1wm2bh54Far9rPhb2HA6aCX0T4jCfRVPmANnQp/imRu/sT+9JCRxmofuhKXwLtzrxpuLy5Zl/rUR1JvD3gpn4OVf/G61HSZng1y5pnDxLGxE505N59c/2k0S9I1zaP9hcPOFKN6mdLdfNm7VRTvK9Dr826qbQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPTpd6ir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89220C4CECC;
	Fri,  4 Oct 2024 18:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066551;
	bh=7KsdUYsx0mqG93eBQ1UwLX1plpEzS7CoypLGvF9n4OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PPTpd6ir6u9vc6PK+3JzOA94zCzxe1Ri+8XVlqLME8SqSi5IYn6GqZH3/m+At9pEK
	 lEbHyHGXl6JFviMe+nJPn9+rAMqHavCHemeDBb/KXELpMmTrsjcXSKafpDNEISQSmj
	 CD+++ockSgO6Ce1PE27Mc1mGnTDvn5aieJlnh++H4MhQFE7VMEzafpId7LMGn9EoCv
	 QXgZ9Kz9jqIlkG573+Q1iTDwqxghnE42sBbVKZJqSpwlfqCxfswKUMGq9iKCBDEy6n
	 8TOzv6RUDcoHNUc3W6VAGilcC841t2mKAjtM/8LwqfADFD6FVGq6sM6PRFdXQutW/I
	 NKif6VRSAChyw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 09/31] ext4: don't set SB_RDONLY after filesystem errors
Date: Fri,  4 Oct 2024 14:28:17 -0400
Message-ID: <20241004182854.3674661-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182854.3674661-1-sashal@kernel.org>
References: <20241004182854.3674661-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit d3476f3dad4ad68ae5f6b008ea6591d1520da5d8 ]

When the filesystem is mounted with errors=remount-ro, we were setting
SB_RDONLY flag to stop all filesystem modifications. We knew this misses
proper locking (sb->s_umount) and does not go through proper filesystem
remount procedure but it has been the way this worked since early ext2
days and it was good enough for catastrophic situation damage
mitigation. Recently, syzbot has found a way (see link) to trigger
warnings in filesystem freezing because the code got confused by
SB_RDONLY changing under its hands. Since these days we set
EXT4_FLAGS_SHUTDOWN on the superblock which is enough to stop all
filesystem modifications, modifying SB_RDONLY shouldn't be needed. So
stop doing that.

Link: https://lore.kernel.org/all/000000000000b90a8e061e21d12f@google.com
Reported-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Link: https://patch.msgid.link/20240805201241.27286-1-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b09b7a6b7a154..93eb26c162422 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -674,11 +674,12 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 
 	ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
 	/*
-	 * Make sure updated value of ->s_mount_flags will be visible before
-	 * ->s_flags update
+	 * EXT4_FLAGS_SHUTDOWN was set which stops all filesystem
+	 * modifications. We don't set SB_RDONLY because that requires
+	 * sb->s_umount semaphore and setting it without proper remount
+	 * procedure is confusing code such as freeze_super() leading to
+	 * deadlocks and other problems.
 	 */
-	smp_wmb();
-	sb->s_flags |= SB_RDONLY;
 }
 
 static void flush_stashed_error_work(struct work_struct *work)
-- 
2.43.0


