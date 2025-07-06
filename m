Return-Path: <linux-ext4+bounces-8837-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 123E8AFA734
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Jul 2025 20:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492333B5AFA
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Jul 2025 18:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A12D19F421;
	Sun,  6 Jul 2025 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFApjrCp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15C4846F
	for <linux-ext4@vger.kernel.org>; Sun,  6 Jul 2025 18:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751826755; cv=none; b=PFxjf7DAl5tEEtArbTea1BWAJngokeMCNfd72rchL0prUtwV9O/Gems/S0CE1/B0WhmBCdG7bbUTsEnzWLcJMAnRgPW6AZvwYUK+jvNE5epKx2OZ9Ukiecqk7V0Rco+5n+5NcpA524zmvxD7hWaamqzh68mLZxlS4T4QbNJx8J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751826755; c=relaxed/simple;
	bh=FA/yiUNYxjkAXp261Y/rgZM51d7Mo4L8drmt7fOFdT0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SsHXe6O4S/rUzF0NmU9OtyhXRuW8a5rxkuB2r5OMVTL35hxvjn3Jry8RFl/J7KIeoMA++6xRrlzbPz5CZdwnGvA1Cxf5IDti+0z7xrAcTx4ZknO+KNDOcg9N/OVeLr8WMh9ROeMA8SHxM2IYkf8ZUUORHkJPI+uECOWkVv59tt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFApjrCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27678C4CEED;
	Sun,  6 Jul 2025 18:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751826755;
	bh=FA/yiUNYxjkAXp261Y/rgZM51d7Mo4L8drmt7fOFdT0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hFApjrCpsbOt77XlpPNsjlxU53vEdp3wCTvXE7avO3PxaXJ+tj18oLbmKuTzpf7Hs
	 /KDJhmjTq4Sw7bMnUoyv2ky19J/aJbO/IZswG6drj0qhbDJBbV5hzEqfr80rWz4Mr7
	 rOYpTVm985q3pNcQ1Vqf667+uYE/ovHBVB/ByRVuZ7EhGNS0DfZrDrR4nEYXcPf7p6
	 gHx0Dc0pXSKRJY5G3IVVir+su8hn5A3be3cKysXhYxQP4tSXaKtIe6r12aWoTMXKv4
	 KVcaFT25Ji1e0K63Pldn2JmNPmnppXaTm19Ajkm0furaMIrVe1UZ9fPIZrGorvw3qW
	 Vi8U77MUdZgwA==
Date: Sun, 06 Jul 2025 11:32:34 -0700
Subject: [PATCH 7/8] fuse2fs: fix incorrect unit conversion at the end of
 FITRIM
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175182663095.1984706.13547873393931840622.stgit@frogsfrogsfrogs>
In-Reply-To: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
References: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

generic/260 also points out that the bytes cleared are in the wrong
units -- they're supposed to be in bytes, but the "cleared" variable is
in units of fsblocks.  Fix that.

Cc: <linux-ext4@vger.kernel.org> # v1.47.3-rc1
Fixes: 7235b58533b9cd ("fuse2fs: fix FITRIM validation")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 34eaad1573132f..ff8aa023d1c555 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3831,7 +3831,8 @@ static int ioctl_fitrim(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	}
 
 out:
-	fr->len = cleared;
+	fr->len = FUSE2FS_FSB_TO_B(ff, cleared);
+	dbg_printf(ff, "%s: len=%llu err=%ld\n", __func__, fr->len, err);
 	return err;
 }
 #endif /* FITRIM */


