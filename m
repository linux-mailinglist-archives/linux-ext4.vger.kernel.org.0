Return-Path: <linux-ext4+bounces-7708-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9172EAAB5BD
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 07:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7AE37A5E15
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 05:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9101434D2AD;
	Tue,  6 May 2025 00:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zea7wgyc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE6A3BA89A;
	Mon,  5 May 2025 23:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487345; cv=none; b=Lx8NrPJ4zNYabNKwO+3rC2omfwWO9jfHyb4U6giWelR266nuA6KQD68+Qtk7VJdVBjykxbWvNwJBXiuH9dosYmkc5zh6RiaEWUirylBXGWcKgsppWyVu0JNeEYk2nuaeXcWtlbW+e9CAMP47h/DBL0LCsiLTGrANzfQj/0yXQc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487345; c=relaxed/simple;
	bh=AFK/OQ0OUylW3kDlFFn7G+WF7ksViGgUTGH+b4cqYfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9oUcVkeZWQxankRbeH2ZEBuxOeTcFnrNNup69Z2v9YtMfLUwTdFkHJN2jgYCBMVzLtbjIamdUd0fIMSUveKMCOy3PYSyGJbjtbpR6IWOJl8tERWK5MxdLuSJP2FWa09mye6Mye5jmvL84nXQ/1vicawu+DIuyudHjNy6G8qd2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zea7wgyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543F1C4CEEE;
	Mon,  5 May 2025 23:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487344;
	bh=AFK/OQ0OUylW3kDlFFn7G+WF7ksViGgUTGH+b4cqYfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zea7wgych5rVnyVPI+LBsLUYcNyex0GKvMsvs5+DrLzW9mMUYKCVKj7a5yLIKDLuU
	 zwyiFkJpTRmRamvE9//TfmTMGGegd/f/poac6Sjwpz8lNRA4hgaooiXKhC6S4WAT0+
	 zrpBWNnwCp+pglmrf+HkBRRgMjoGjDTxXMAqbZ1IDR3uDLrWCgdDF3FvSvJO5GNxY1
	 zg/siYruPUkHwi/6j8jMCsLeYT5fVKLAbppZnwwHmnkdDEKav8OrP98iTfhA788UkA
	 SJCl9lS8BWfdUZJC4Rt03KRpa4TTIwhOSLpwbqO4sXkmIOLSFRHOmGoS97oeoZHNFV
	 8mwoIBQ5f3pOw==
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
Subject: [PATCH AUTOSEL 5.4 18/79] ext4: reorder capability check last
Date: Mon,  5 May 2025 19:20:50 -0400
Message-Id: <20250505232151.2698893-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index b68cee75f5c58..a32eb67a8f0e2 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -609,8 +609,8 @@ static int ext4_has_free_clusters(struct ext4_sb_info *sbi,
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


