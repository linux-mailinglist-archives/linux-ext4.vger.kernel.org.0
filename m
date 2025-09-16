Return-Path: <linux-ext4+bounces-10097-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA1CB588C5
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E14263AB3A4
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600F0F507;
	Tue, 16 Sep 2025 00:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EYFhHAmO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB548849C
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980995; cv=none; b=gKWD/taqbKJAYIjBO34omuS6p6i00GWemqDTH7nP/xYk2XeBlKXfuL0y+Gi/WJ6AV06IicUBdLUU0wuwy8QBmHtNsWoGErPVx+JZoTvGIZSWxIin5pjbsB8fHch+H1ARtpcS+E0L4pUxSuvMpjEA/dU9olDAupyopThlPrq16mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980995; c=relaxed/simple;
	bh=USD0VgwGKES1LF7TWoSVTqNLuFst96ibj6kWTuo+Ta4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kbSkPNnou6ogXU32pw920IcFbOcUEu2/NMEPD9DYJ/bDFSJ5XlaSA+YK4NVFe60H4SO/Gu7p3dgPHOtuLnZIQmi4F0aZ0bBOiuVRCyMjFGQCsRqhWwih51SpR5Ok25oBcx7saBIgj7vAR1uY5GSyDo3vPY72cU9aX4b7tI2B234=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYFhHAmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AFDC4CEF1;
	Tue, 16 Sep 2025 00:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980994;
	bh=USD0VgwGKES1LF7TWoSVTqNLuFst96ibj6kWTuo+Ta4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=EYFhHAmOCYlBJNy5Nesrcrhx+YSHXj5rypKt6Fc+uCkSrR/d2zziFDHihhwRhuA9R
	 +eE8MeXfXTarqD3NF+fYY4p5202gonQmj4o6SVVsdywA/SfZNYcEmfZiqp1y5qYHm1
	 Z7PDY+jV/vd41hsRbyZTHULZXMuMzpn3sb0o8X80txLo5/o374N9t9c/a39D1w8cNi
	 WvKjtaXRMdZzHalNKuOZ5fCt/HKAhi+CFxy4gR7BRMVZiL6FHl5BIGX86KgiuIuEg6
	 G+x5n6m5M2Fv9ER/tBOq74ycoNzPspXF5AZshfVcqG4qCwQygipe3xtPUW+958lVj8
	 KOtiAFl0Zg4Dg==
Date: Mon, 15 Sep 2025 17:03:14 -0700
Subject: [PATCH 1/2] fuse2fs: mount norecovery if main block device is
 readonly
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064776.350013.6744611652039454651.stgit@frogsfrogsfrogs>
In-Reply-To: <175798064753.350013.16579522589765092470.stgit@frogsfrogsfrogs>
References: <175798064753.350013.16579522589765092470.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

If the main block device is read-only, downgrade the mount to an ro
norecovery mount.  This will make generic/050 somewhat less grouchy.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    9 +++++++++
 1 file changed, 9 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 48473321f469dc..fb44b0a79b53e6 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -946,6 +946,15 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff, int libext2_flags)
 
 	err = ext2fs_open2(ff->device, options, flags, 0, 0, unix_io_manager,
 			   &ff->fs);
+	if (err == EPERM) {
+		err_printf(ff, "%s.\n",
+			   _("read-only device, trying to mount norecovery"));
+		flags &= ~EXT2_FLAG_RW;
+		ff->ro = 1;
+		ff->norecovery = 1;
+		err = ext2fs_open2(ff->device, options, flags, 0, 0,
+				   unix_io_manager, &ff->fs);
+	}
 	if (err) {
 		err_printf(ff, "%s.\n", error_message(err));
 		err_printf(ff, "%s\n", _("Please run e2fsck -fy."));


