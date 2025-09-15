Return-Path: <linux-ext4+bounces-10055-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E5AB5879B
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCA912035EE
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 22:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A44B2D46AF;
	Mon, 15 Sep 2025 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/NS1D8F"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0B52D052
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975910; cv=none; b=hTWGsbVn7iVSyglOC++QkeW8+0Cvc3JR6KDQW9LCE5dJRhAf0V+phxywkGw0CWYMKWuJqkhnCQ2UmY2r0TNSHJaP7edYBG4HAVVAIbQXvYKQpXc4ibsrSeMpgGoH9y7C0dj91YKXBEMbn7lVpId6abLizvDyrrld9rhV2TiEL/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975910; c=relaxed/simple;
	bh=y2SAowTCinK9xYskAy7nNuJDm/hD3M9iy0XMyVjsGFM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2Byt4bKJx0k4NnWIarTd8brjtplGeKip4V43PFfTTgGj/zUMls+/8riRpk3T0ohmQxA28Clcjv2ljX6bKYHl4hC3zBh8mXUsGhZ5sEvxDeOy0UTCYiJIJgbAiKTDig+ikgEXvqOU46mAPYzkTE8gKhklcrve3++I+6YD+qMWqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/NS1D8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADFFC4CEF1;
	Mon, 15 Sep 2025 22:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757975910;
	bh=y2SAowTCinK9xYskAy7nNuJDm/hD3M9iy0XMyVjsGFM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=P/NS1D8FMjIoPc4ew/F0yO8YryVkHHewy9f0XtbRXfgxSOAdo76y7BfDRAdtSG3Fy
	 k9DhfK18NJmntyIOyJVLVH0+bo3mblaHngJdc/9bh1B0XNpxXBe3JkBd746dKv5Xe1
	 hhyqmJbJvUYWCeuOm7ly1BdZApl/2DZ9uK3mpol4JplfUWR23lCQe+aXjzO8cbE4j+
	 s8NpnHc/yCJqiKtR9+6nYpsabd4rjpjRfuQJj7QSq+K2TlMVlQeRlGoE420wjjQvjj
	 xzPOteImY5OQckepTbH1GJSeQpi8c5zIq02ZPxPl77EF/hzqrFnJ/Sax9MdKHNSVJD
	 wOuH1ApVkEpjA==
Date: Mon, 15 Sep 2025 15:38:29 -0700
Subject: [PATCH 03/12] fuse2fs: update manpage
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175797569673.245695.5213142680462010974.stgit@frogsfrogsfrogs>
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


