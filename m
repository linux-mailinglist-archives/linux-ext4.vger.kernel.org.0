Return-Path: <linux-ext4+bounces-7695-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACADAAAE82
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 04:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E6EF7B5DD2
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 02:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A650F28150A;
	Mon,  5 May 2025 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6DcJeJJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A939435D794;
	Mon,  5 May 2025 22:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485903; cv=none; b=IcnSTDuJfKemb26PuyGquRxnItrkiVLX5MhggJn98N2VBxS9+t07tZUTm32RiphgR/1KSsmHSHPUySXDPeeQX54YvDkjT1gjamE7FYHkDrnyDUvCmL4rvucDiyJnZXMgyq2O2PNH6TswoLGkxrW8u0AGPBbiOqzvFE+aEQejB7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485903; c=relaxed/simple;
	bh=qSgfxMf0t+AJZRB84N9nDSjPGFk8pimZAGPHfZDaF7k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrKs8MweajY3toDpJFpauDZwGtegA2ctTU4MkEWD0STOlpwaGXrN2pVdEvm9qAT7/DTtJuTxfkBlhVl7kCQSplEegERHtDCwXhBljpVKDUqbbjezq3vkwQOi9ep/1GxIqJdp0crMWEJ9G5UlsE8I7fWpfCmkRfmVwr/zkbI6or8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6DcJeJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86066C4CEED;
	Mon,  5 May 2025 22:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485902;
	bh=qSgfxMf0t+AJZRB84N9nDSjPGFk8pimZAGPHfZDaF7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q6DcJeJJ0U+pWEd5PmNDnHCGggf7tcyt2Oulcmu/kRUrEk2VfyNxsbGcQUgVoDcsY
	 JtVHtaLwqknpRsQQLDPf5Zw5B8hkE7VOIFN+wd0LLo4SoBflrtwToX7HGtdJadCEUw
	 ULliDcaDk1z2wr4rXgy3qrpp6V0Q2NlahJg0QdvObQGy7K0tsTIgHv0tw0tQYDa+Yf
	 H2tQL5m/2dojFhqG8l0yrZAyenU3DjycxCXVRmvF2vEqMSIbnKduEueRYvaCy+nHeo
	 5gtOFKydrWl8ePPkwEvcUWKZGGO4Io5fEg+JUWdB5cmvJ5YLPczrGUZjlxlb9fH8fB
	 q612TGiNK+DzA==
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
Subject: [PATCH AUTOSEL 6.6 056/294] ext4: reorder capability check last
Date: Mon,  5 May 2025 18:52:36 -0400
Message-Id: <20250505225634.2688578-56-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 396474e9e2bff..3a2dfc59fb40f 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -641,8 +641,8 @@ static int ext4_has_free_clusters(struct ext4_sb_info *sbi,
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


