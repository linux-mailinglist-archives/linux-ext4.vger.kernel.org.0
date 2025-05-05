Return-Path: <linux-ext4+bounces-7705-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F22DDAAB6F1
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 08:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCA0F7A2724
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 06:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E4533FF2C;
	Tue,  6 May 2025 00:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlPdMvJe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54D23991AF;
	Mon,  5 May 2025 23:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486470; cv=none; b=U8XMeBD/RHnL7fgz2Ltjv+4BPtUjewgzS/kJiUBUuSGxTSBYCI4fiaPwn6/qK17wsHTpW97OXcNlvf4g7l1L8EFWa3025qTK46i1X7AXEkpNjT041v74CVaWZOt/I/8geefAVXWQTucrIwxNTqxspr7lWp2rdGrZXfKwH2W9i0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486470; c=relaxed/simple;
	bh=Kla4zjxFzkrE6Pr2b/gaHFQSldCKjlm/rmVI/KRUkA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NaI0GxXntE9pKDWCeGr6TkSjMeaEB23QfoQggNJXO2RxDMH1p8INiX4fzdOFdLOfXymAAsfXPpHY9L9hGIObLZGOhHgOgN/m/6HzkgS8flHHtIOBh5npi1rtFH7Hb7QbMm2TkJ+p7x4qvk8m6vID3ndq/vLI8bZA9HEwSWaSlHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlPdMvJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F56C4CEF1;
	Mon,  5 May 2025 23:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486469;
	bh=Kla4zjxFzkrE6Pr2b/gaHFQSldCKjlm/rmVI/KRUkA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WlPdMvJeBMiTkPdp7TXxruBxCKvA1lA/ND9QHe0tz5N/wBbB337YQeO64HAsprpvy
	 9x9dQAVIBiYMdXLrF9y/gOjvzi29WRntDdN3EviQDK+kbCu61ra3RQCbJ0FHWWyxuY
	 YIrMwWmLGV3p0W50Z0XJt4Cj0KCqDIth46kyEgQAzUJHSGYtGzvOpjnPI/hYVngAsc
	 Y3P/2UhvHOmnQQYx/m5nix8mqSKy7lxuhnb/1/4v/QikJK5HwI4IJtrRlF4HWWx2bD
	 Qa1ebv0ZNma8ukDjPNG50R5c3KpQAgiN/yj1UOa/v0BlcEwu3/+m8s5S2sE0IyfpBd
	 vv6d0SKZTS/dA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 046/212] ext4: reorder capability check last
Date: Mon,  5 May 2025 19:03:38 -0400
Message-Id: <20250505230624.2692522-46-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

[ Upstream commit 1b419c889c0767a5b66d0a6c566cae491f1cb0f7 ]

capable() calls refer to enabled LSMs whether to permit or deny the
request.  This is relevant in connection with SELinux, where a
capability check results in a policy decision and by default a denial
message on insufficient permission is issued.
It can lead to three undesired cases:
  1. A denial message is generated, even in case the operation was an
     unprivileged one and thus the syscall succeeded, creating noise.
  2. To avoid the noise from 1. the policy writer adds a rule to ignore
     those denial messages, hiding future syscalls, where the task
     performs an actual privileged operation, leading to hidden limited
     functionality of that task.
  3. To avoid the noise from 1. the policy writer adds a rule to permit
     the task the requested capability, while it does not need it,
     violating the principle of least privilege.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250302160657.127253-2-cgoettsche@seltendoof.de
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/balloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index fbd0329cf254e..9efe97f3721bc 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -638,8 +638,8 @@ static int ext4_has_free_clusters(struct ext4_sb_info *sbi,
 	/* Hm, nope.  Are (enough) root reserved clusters available? */
 	if (uid_eq(sbi->s_resuid, current_fsuid()) ||
 	    (!gid_eq(sbi->s_resgid, GLOBAL_ROOT_GID) && in_group_p(sbi->s_resgid)) ||
-	    capable(CAP_SYS_RESOURCE) ||
-	    (flags & EXT4_MB_USE_ROOT_BLOCKS)) {
+	    (flags & EXT4_MB_USE_ROOT_BLOCKS) ||
+	    capable(CAP_SYS_RESOURCE)) {
 
 		if (free_clusters >= (nclusters + dirty_clusters +
 				      resv_clusters))
-- 
2.39.5


