Return-Path: <linux-ext4+bounces-10062-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0060B587A5
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0C83AA8C5
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 22:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43392D46B7;
	Mon, 15 Sep 2025 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDdRygIn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F0C299A96
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976020; cv=none; b=phLpCxZYtj/DIVK23wnH0X5TBTzWoOKDFYpKZ3uUXawiePwYLay7gX7qSGHTtixuPFG8VpAOhrSo6SmgcZL5BliFTBvVtYK+/a7UjZdlcyaldfrRslRgJjBvmV8blJgEz6VQET0QXbETKMFLCEtJTW6KPKsqJGwpfMonCtDNKwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976020; c=relaxed/simple;
	bh=iEgiUIuDWa43USvwoyHB/s1MZueE2KXArEkmsVzQJrk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EFWH6SsRDQwm/4Wa1N7c8WeiVkHvqt3osHOO0V0WZOTlc+wjIagdx6pBK9nytKqDM8cPDUn0WFgEB8WgR4qkE9eAQoCKp6UB1DgVl66M3yK6SU7a2wXz540H0u7gHhttCOkpWlAqHV6flH2nYkSdNweHzK5ZJoz1D+u2bCdN1WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDdRygIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C62BC4CEF1;
	Mon, 15 Sep 2025 22:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757976020;
	bh=iEgiUIuDWa43USvwoyHB/s1MZueE2KXArEkmsVzQJrk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=eDdRygInfBmnjjIfC7cKGz9YuTS5SHJ8rbm1GdQX3MQxHyTd/X5fHAMCsVGFty3Pi
	 GI0NTnn7ngZz2NXSNynFWwRFqfHmGCh3N4mvfQtJhlPTwaaQMb7OSaXx/L1vO7benu
	 4cIR/MwcTDugthDcgL47Npw3JYGEKbH6yGJ9HkXeHEVFWV5LM84bB0cBSVC6YKlCB2
	 z2VpPj5Lj6aTMBgaJMK7XWBwth6J6Sh7vBa9lSC0195yM/VMNiNIH6EJWzTaymdvey
	 nv0gXds0lisvPfkGG6MDd14rqlshLU5pPawsTH57Tc6QMc88UzAqDHUxvGtnV/TZT6
	 hXcPI2dUoeHOw==
Date: Mon, 15 Sep 2025 15:40:19 -0700
Subject: [PATCH 10/12] fuse2fs: fix in_file_group missing the primary process
 gid
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175797569799.245695.16735941049251169393.stgit@frogsfrogsfrogs>
In-Reply-To: <175797569564.245695.4628729304068635201.stgit@frogsfrogsfrogs>
References: <175797569564.245695.4628729304068635201.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

I forgot that Unix processes have both a primary group id and a list of
supplementary group ids.  The primary is provided by the fuse client;
the supplemental groups are noted by the Groups: field of
/proc/self/status.

If a process does not have /any/ supplemental group ids, then
in_file_group returns the wrong answer if the inode gid matches the
group id provided by the fuse client because it doesn't check that
anymore.  Make it so the primary group id check always happens.

Found by generic/375.

Cc: <linux-ext4@vger.kernel.org> # v1.47.3
Fixes: 3469e6ff606af8 ("fuse2fs: fix group membership checking in op_chmod")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index a075e3055bd743..7ec7875d9108a2 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2303,10 +2303,14 @@ static int in_file_group(struct fuse_context *ctxt,
 	gid_t gid = inode_gid(*inode);
 	int ret;
 
+	/* If the inode gid matches the process' primary group, we're done. */
+	if (ctxt->gid == gid)
+		return 1;
+
 	ret = get_req_groups(ff, &gids, &nr_gids);
 	if (ret == -ENOENT) {
 		/* magic return code for "could not get caller group info" */
-		return ctxt->gid == inode_gid(*inode);
+		return 0;
 	}
 	if (ret < 0)
 		return ret;


