Return-Path: <linux-ext4+bounces-10898-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23D2BE4501
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 17:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673E33B4D09
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 15:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062A134DCCF;
	Thu, 16 Oct 2025 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWf3u9Xc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E10434AB10
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629282; cv=none; b=PTwmTKb7Yl08Vuexs9L0hOBBqHZN221JC5p9JzosnwkoI9UgE4lSsFU/o56+LV/NbByItoyRSbDE1PPddoTsaTFvVqkABKl5bCcu0DvfV0lFmF9IQphoCYagkT6VAhogWy3g8EM3JvovONoCJQsuZ5kLJ05W6aTShtghYD8NUO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629282; c=relaxed/simple;
	bh=y2SAowTCinK9xYskAy7nNuJDm/hD3M9iy0XMyVjsGFM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tn6KRY9a1pydxcer8Vj38YpZukjBcz1Hl2W3Ap6/WD0pavKdpCLys/oa7eOUb4VfWxnfJ7S/dWA1op3UaUh+l+NzYB4PzC102Z8NR8oZOVrQ3wFi0G3ywcqFpaxaU1A9LomO4m3bBWW0S3+jWCWtaxgU6kf5L9u7BrdJQ/s8oMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWf3u9Xc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9FEC4CEFB;
	Thu, 16 Oct 2025 15:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629282;
	bh=y2SAowTCinK9xYskAy7nNuJDm/hD3M9iy0XMyVjsGFM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=SWf3u9Xcd731DM0inYQNJvAgUNkmJE0dwzJ7UY3mSbBKqOUYpkSjSQG8nDAlNcBOA
	 69QdRFW1odO6x8uueLl8f/am846JhiIlxp13M/1V7QjUYZRig/5F+yQLF2O8qN1hTv
	 TylAW0sYQxhbV8MLLVd0BQaYI6fww4R1bIYFw1KfKeyn5s3XIZ6Nt330+9lq2gvSaS
	 LObibVd7+UETXWput91NyhX3arCqjSnM3BHSughZbMQfbqxJYdabB3wmCA4NzSyDCG
	 LCW5yPBkRasV1hcEMQfz65qeiDdbO+Qb9ectKb8m5F2D54NCTmWDt4QByQGZKJX+Tu
	 18VIMS0nRSoew==
Date: Thu, 16 Oct 2025 08:41:21 -0700
Subject: [PATCH 06/16] fuse2fs: update manpage
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176062915573.3343688.15932523126008034856.stgit@frogsfrogsfrogs>
In-Reply-To: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
References: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Update the manpage to list current options for fuse2fs.  While we're at
it, alphabetize the non-grouped mount options (e.g. rw/ro, *df).

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.1.in |   42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)


diff --git a/misc/fuse2fs.1.in b/misc/fuse2fs.1.in
index 21f5760742c639..69fc6b01d7b639 100644
--- a/misc/fuse2fs.1.in
+++ b/misc/fuse2fs.1.in
@@ -36,21 +36,33 @@ .SS "fuse2fs options:"
 \fB-o\fR ro
 read-only mount
 .TP
-\fB-o\fR errors=panic
-dump core on error
+\fB-o\fR rw
+read-write mount (default)
+.TP
+\fB-o\fR bsddf
+bsd-style df (default)
 .TP
 \fB-o\fR minixdf
 minix-style df
 .TP
+\fB-o\fR acl
+enable file access control lists
+.TP
+\fB-o\fR cache_size
+Set the disk cache size to this quantity.
+The quantity may contain the suffixes k, m, or g.
+By default, the size is 32MB.
+The size may not be larger than 2GB.
+.TP
+\fB-o\fR direct
+Use O_DIRECT to access the block device.
+.TP
+\fB-o\fR errors=panic
+dump core on error
+.TP
 \fB-o\fR fakeroot
 pretend to be root for permission checks
 .TP
-\fB-o\fR no_default_opts
-do not include default fuse options
-.TP
-\fB-o\fR norecovery
-do not replay the journal and mount the file system read-only
-.TP
 \fB-o\fR fuse2fs_debug
 enable fuse2fs debugging
 .TP
@@ -63,14 +75,14 @@ .SS "fuse2fs options:"
 .I nosuid
 ) later.
 .TP
-\fB-o\fR direct
-Use O_DIRECT to access the block device.
+\fB-o\fR lockfile=path
+use this file to control access to the filesystem
 .TP
-\fB-o\fR cache_size
-Set the disk cache size to this quantity.
-The quantity may contain the suffixes k, m, or g.
-By default, the size is 32MB.
-The size may not be larger than 2GB.
+\fB-o\fR no_default_opts
+do not include default fuse options
+.TP
+\fB-o\fR norecovery
+do not replay the journal and mount the file system read-only
 .SS "FUSE options:"
 .TP
 \fB-d -o\fR debug


