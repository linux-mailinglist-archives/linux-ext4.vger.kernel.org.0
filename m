Return-Path: <linux-ext4+bounces-4494-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F0C990DA1
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 21:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A0F1C2221B
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 19:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8197D20F157;
	Fri,  4 Oct 2024 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4Sn6m11"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B86A20F149;
	Fri,  4 Oct 2024 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066456; cv=none; b=EkPeMDVs+1vSyWVa8RB2vp3hSzZYm9p7c1O50scykKmA4C9TlGh6i/WqL1PQnKsi8KTysLdAa3nz1nONppt/PNysKsf4NwqX3ZTLVD1u492QNSriVOfLHBxigpo6KHxpu6rGN/yr/U4f++GsoxTiAxsfaEbWotZdrcyMkGeyOK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066456; c=relaxed/simple;
	bh=OCCs5OiQLjs6eDiIaCmMXrSMp8ufgAgkbAVZDTZJULE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8UgbkUajnZ+ZvpjAaecMHo6amPLOWeOdmE2mfDo+g1FB+7eBpWhPoDEUobc8fEtEeRpRvLk2Gg+4JxL2spAcnLmUBwYEahAu1wz0kgoOlUadz7VcpKadigWb9enso4kIA6B9hthyuXMJmmy3gFIbI0zl8+9J+xcY8L53a2qYfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4Sn6m11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD335C4CECC;
	Fri,  4 Oct 2024 18:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066454;
	bh=OCCs5OiQLjs6eDiIaCmMXrSMp8ufgAgkbAVZDTZJULE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s4Sn6m114q7oHHWX3Tb/837rwN4+VQEV2xk02BFHqHvtjWcU6ffr3ohtycfQ8nbFG
	 RkXU9KswmX9VRFpBt2DM4BKFMeyyg+tULKz/FyxKhykIwcxe0nasAtNl509FrBJuMz
	 hQ3KlrJhRMD/2tXKtllZmfrhuBbXttLh3R7ncfYPLfotz/XfB9iktrmddh5EPUof5a
	 +oucE/xVM+vwjnqPzvfVC2tJkTHBqsloqrZGcDOh4HbhFAVKgK3k/t785JzzWWoOhp
	 F5krOKw1B1ImK6uLGxk1JNmUMJdBhH/RTFzpb7Hw7WBjIrurqsVVVkEKbK0Bi5MKin
	 TAzQIznyKOV1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 09/42] ext4: don't set SB_RDONLY after filesystem errors
Date: Fri,  4 Oct 2024 14:26:20 -0400
Message-ID: <20241004182718.3673735-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182718.3673735-1-sashal@kernel.org>
References: <20241004182718.3673735-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.112
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
index 3db39758486e9..3bf214d4afef5 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -692,11 +692,12 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 
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


