Return-Path: <linux-ext4+bounces-4303-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F04DB985BE8
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2024 14:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52602873A1
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2024 12:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955DE1C9DDA;
	Wed, 25 Sep 2024 11:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUrGqeFK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332131A0700;
	Wed, 25 Sep 2024 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265200; cv=none; b=GVAr8OwD0ASg2ZEwsXWP4ierUH3B5tg/Myx89qvUjcr+PCpC/qdqc78KCe1ZkoMc28u2XHx2Urj1C7uApaUToABEArSf2qn/HMR9nEf0w64x9pluvhD35hXD/FwNV8GE6ZStr5jytcXzwmqGv5kZYaPwbzEhKdQCmM7YI963C7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265200; c=relaxed/simple;
	bh=7a+u2aQp9KkjT17IDYDnpdLVIEQuezHMJ9IEQG72aew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gX7LYYLyGyUEkSG0AeZxfxNp2rJQan0/MVKvh/UbUL9jClS8hKVU58mLZYFfTEFI/kJEAOR5S66/Ntqi+0xCBNci0Yy8GYgpr4ZYwuuThglBGoit4f/oBVhV+nGg+bz61KLGm6NKbfg93skT9d3eJMfFExsxp+A3UN5egpShVFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUrGqeFK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65080C4CEC3;
	Wed, 25 Sep 2024 11:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265198;
	bh=7a+u2aQp9KkjT17IDYDnpdLVIEQuezHMJ9IEQG72aew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fUrGqeFKsqTqy6GqCLNQeA3JD7MxiKF4u9D+5t8ojOSfEJi7nMhDG1oX3RvFc4LG+
	 grFHLHRfTO57jBWwvjFIPySVA4KU7iNDVxM7wqg5nQoXSZSGGDiXRWn9wfHvLwCUth
	 cIaqFcBTHegecMi9m/PYtD14TZGLdm50ECdxLVhLwB84Cu+n3l9AirD23hawVRJF7h
	 buJfcfqrFjioROvMpA/UKaZvPTqryQ7oRN6yEwPekeBsai0ts0arPmHopz2rwqqF39
	 y5342KPmEkRocIf1IOY6f5cngB2m8ry9Txn2on1rYDJ3LYir4NhACGiJeAOK0fBo3c
	 RS3rVCMY9fayg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 235/244] ext4: don't set SB_RDONLY after filesystem errors
Date: Wed, 25 Sep 2024 07:27:36 -0400
Message-ID: <20240925113641.1297102-235-sashal@kernel.org>
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
index 25cd0d662e31b..e8e32cf3e2228 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -735,11 +735,12 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 
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


