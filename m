Return-Path: <linux-ext4+bounces-8868-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3876AFB84E
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Jul 2025 18:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 402CB188A2BB
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Jul 2025 16:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF883227EA7;
	Mon,  7 Jul 2025 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXNOjbv1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696152264AB
	for <linux-ext4@vger.kernel.org>; Mon,  7 Jul 2025 16:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751904326; cv=none; b=n6s5aAHC6TX/y9cBrsOo4WePk3p38k4iTnKUa8Lvl4JnIvi4UWZxkWlYV1jh651iyuM0sdYQPI7nBDlBdOpjHHZ5l4iI+Obn79k2VKmUT4oOz21doHQJEfnTZnNdAgi1VhxY//ptECBqNw1qPPAOLwXI8LvTCuQLS8JMeoK+lL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751904326; c=relaxed/simple;
	bh=HV2X2ECneCbvCGMDMePgQ2C0augHCPhGlZSBd6UdJqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaXFw9s4mpPjGElp7U5MZoVkVVYtJn8s16yqtHEQTaVkbhib6sXG+b10sXegECbp8b89BstpYwA3a32lpNTecGFDDtibrkHRyyhBRVatpaXueQT8Jk1YflKxIoeUd0KDoK2uyR9Rf6weSxN5acTpgRkHjtiWgypXgibaws34Tto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXNOjbv1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2D0C4CEF4;
	Mon,  7 Jul 2025 16:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751904326;
	bh=HV2X2ECneCbvCGMDMePgQ2C0augHCPhGlZSBd6UdJqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HXNOjbv1e56DnwCfm7b9Z40H6O5g4HO5e6IRefbRYy1WLWD33o2Hy6oFmaNC0KXj2
	 87SnlmqLzur/Sf+OMHybxuKsFZ89hWPeLgvvjdvt3CvU12uRD4/qZQ6Fq938gdCrBB
	 Pu4GgolBilAD7vgFq9MbtlBd6TnhmMLsukgp3wpFh2jb6X+5HetULYidaYvortcL/7
	 lZTUssz/ToavancI1JgskFBD4SVz0dfHEWrpr6SoccdtJQNAkmidgh4iIQ3NmIXbBs
	 WVmXLx4J7OqUpMZm5WOzKVeR8VPJuJo0X4btbeUqA8EFi+Hl5INiIt64OTBhWXr3XI
	 2MfHsnZlwbj6g==
Date: Mon, 7 Jul 2025 09:05:25 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Subject: [PATCH 9/8] fuse2fs: fix relatime comparisons
Message-ID: <20250707160525.GC2672022@frogsfrogsfrogs>
References: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

generic/192 fails like this even before we start adding iomap code:

    --- tests/generic/192.out   2025-04-30 16:20:44.512675591 -0700
    +++ tests/generic/192.out.bad    2025-07-06 22:26:11.666015735 -0700
    @@ -1,5 +1,6 @@
     QA output created by 192
     sleep for 5 seconds
     test
    -delta1 is in range
    +delta1 has value of 0
    +delta1 is NOT in range 5 .. 7
     delta2 is in range

The cause of this regression is that the timestamp comparisons account
only for seconds, not nanoseconds.  If a write came in 100ms after the
last read but still in the same second, then we fail to update atime on
a subsequent read.

Fix this by converting the timespecs to doubles so that we can include
the nanoseconds component, and then perform the comparison in floating
point mode.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index ab3efea66d3def..b7201f7c8ed185 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -461,6 +461,7 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 	errcode_t err;
 	struct ext2_inode_large inode, *pinode;
 	struct timespec atime, mtime, now;
+	double datime, dmtime, dnow;
 
 	if (!(fs->flags & EXT2_FLAG_RW))
 		return 0;
@@ -472,11 +473,17 @@ static int update_atime(ext2_filsys fs, ext2_ino_t ino)
 	EXT4_INODE_GET_XTIME(i_atime, &atime, pinode);
 	EXT4_INODE_GET_XTIME(i_mtime, &mtime, pinode);
 	get_now(&now);
+
+	datime = atime.tv_sec + ((double)atime.tv_nsec / 1000000000);
+	dmtime = mtime.tv_sec + ((double)mtime.tv_nsec / 1000000000);
+	dnow = now.tv_sec + ((double)now.tv_nsec / 1000000000);
+
 	/*
 	 * If atime is newer than mtime and atime hasn't been updated in thirty
-	 * seconds, skip the atime update.  Same idea as Linux "relatime".
+	 * seconds, skip the atime update.  Same idea as Linux "relatime".  Use
+	 * doubles to account for nanosecond resolution.
 	 */
-	if (atime.tv_sec >= mtime.tv_sec && atime.tv_sec >= now.tv_sec - 30)
+	if (datime >= dmtime && datime >= dnow - 30)
 		return 0;
 	EXT4_INODE_SET_XTIME(i_atime, &now, &inode);
 

