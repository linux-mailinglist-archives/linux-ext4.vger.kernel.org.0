Return-Path: <linux-ext4+bounces-4311-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A4C985FD4
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2024 16:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115E01C239ED
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2024 14:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C3B22B26E;
	Wed, 25 Sep 2024 12:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOPnROnW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA35322B264;
	Wed, 25 Sep 2024 12:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266675; cv=none; b=TjlRe+mo1LkAoP7jVCEDu5VqTa/VWb+n2g7Gs7JgLhZvTcH3jnuQ7O5S2nGTzsu/9YCs5vDOBx7UUBuirkUKXEVh2ioFgfstxil0dI+sjmCyE5CI+qTspdYa/YLlyeyYRTHIU7fvca/aaI5vVIZ7nbNktlgxn90bMcCy1bNSG/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266675; c=relaxed/simple;
	bh=4jToFmSIR5aDlyoRs9BnwTV29M77Ck1lRKUTkVyMIHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnFiZqOVhqw3P2sRplvpAzRdAWw24bI7uoarB+zgOMBpXz/4NilJkMmErJblXAzARTqG2QnOvWRJGqQlRRxjTZ1KaIMDvxuc5I/rH+MEWlB9sae0MYgXOxAovDn2zrJfV6XUjsK/7jUgwl6/iotZpe06ShoUg/gNQD/VoP50P8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOPnROnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD4FC4CECE;
	Wed, 25 Sep 2024 12:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266675;
	bh=4jToFmSIR5aDlyoRs9BnwTV29M77Ck1lRKUTkVyMIHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZOPnROnWSwy4NTgKg6WP0dF9xBDtHZRUZxPeNJu2uPORvGGMZgFmer6YfKIs7UZbS
	 OHjAHAhd3Gzxk71KTrkrRJeplRDFeppXq5gLhaN40/QEGyCcIUB+09HG+0RpJwwsjc
	 RuByxxW/wdkpL+GxBYxyI/edRoC6em2APb3fRgqFo4MUm5q3xY/Db6lHsD8Aa5H7/w
	 DdTB2RnG9fD7eEXbFeENpuqWMiUdk8AVmrk6niJRGC2IIpn6wszVWyZeA/rhpxYzTe
	 9ge90PUzDNnp52bCIUiK55w6X8I8mmxCygGfHd/5RMf+FEI43kDmZEK5A+pCHvbuQV
	 dinGuYa4RFsKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 131/139] ext4: don't set SB_RDONLY after filesystem errors
Date: Wed, 25 Sep 2024 08:09:11 -0400
Message-ID: <20240925121137.1307574-131-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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
index 5baacb3058abd..b7d8abef2beba 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -744,11 +744,12 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 
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
 
 static void update_super_work(struct work_struct *work)
-- 
2.43.0


