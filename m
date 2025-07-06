Return-Path: <linux-ext4+bounces-8836-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61815AFA733
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Jul 2025 20:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241791891625
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Jul 2025 18:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C5019DF4F;
	Sun,  6 Jul 2025 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGSlGHHA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0B846F
	for <linux-ext4@vger.kernel.org>; Sun,  6 Jul 2025 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751826741; cv=none; b=MBbtfv7KFSp3N9oZSvRBAaX8QGt4DNv1WT+aDXWfibcb8Kzm22OzCrt3v+gTtZ0+0ahGPIn861YkckP8rxqOeWZMGXewPATeySUGsRriFpfQjfqTffJrwOTL/dePiiYRmWGsBk954Vb2HfpRJe1ggS07PpBkjufWuzsgtCFiPC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751826741; c=relaxed/simple;
	bh=orfHJxjgjIddUw+wKyh25AxkGyRekzrVVyoUXSqXtuI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HsxG5IqM1K79wKyoyam7IeJWiDtT89BOl0yRAsgE9y2eBlqOFNbf6RgACSsmKkfiAorBSwAylpjqObgjMuvG1mc+vY9zDUZlGX+lOtMEm2hBqR+YhpqeXe40JFipoqInbeDvx7Il+VZkTJpuS+O1L3a0ZGATd6utD51d0xc37LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGSlGHHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA02C4CEED;
	Sun,  6 Jul 2025 18:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751826739;
	bh=orfHJxjgjIddUw+wKyh25AxkGyRekzrVVyoUXSqXtuI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ZGSlGHHAHFC9gt33LrrIkdP65ff5A+7jEZBOILX8qnjscUeeRcPfJlLORgwwMwLb6
	 TT0RbIJdc0gXWNcGbpqVzwDq+4NPSgj8Kyc/DWpUSiFfOavtLmSw8Y9rDJp+QIa66D
	 tJk0zYGv5MWgQCLHkZqo85b141PGeF2T2APgHyxBZwVfHkprypl/n/PO/p2roiN0cT
	 P5ar2i8r2IXLQ2tv6rzQvy2ekE6muOykrPvb/peGjp7rufmO4wyKFfUSjEGmQhaCVr
	 5D+XOkMUze8E9Bj7xwx2EaN2hOmP0izj639SntO3uH41SfgJNdpOhHrbF+IqgVM6sd
	 VQzMx8EgWfNMQ==
Date: Sun, 06 Jul 2025 11:32:18 -0700
Subject: [PATCH 6/8] fuse2fs: fix incorrect EOFS input handling in FITRIM
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175182663077.1984706.5289392692912386059.stgit@frogsfrogsfrogs>
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

FITRIM isn't well documented, which means that I missed that
len == -1ULL always means "trim to end of filesystem".  generic/260 has
been failing with:

--- a/tests/generic/260.out      2025-04-30 16:20:44.532797310 -0700
+++ b/tests/generic/260.out.bad        2025-07-03 11:44:26.946394170 -0700
@@ -11,4 +11,5 @@
 [+] Default length with start set (should succeed)
 [+] Length beyond the end of fs (should succeed)
 [+] Length beyond the end of fs with start set (should succeed)
+After the full fs discard 0 bytes were discarded however the file system is 10401542144 bytes long.
 Test done

because the addition used to compute end suffered an integer overflow,
resulting in end < start, which meant nothing happened.  Fix this by
explicitly checking for -1ULL.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 5b866aed98237f..34eaad1573132f 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3775,7 +3775,10 @@ static int ioctl_fitrim(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 		return -EROFS;
 
 	start = FUSE2FS_B_TO_FSBT(ff, fr->start);
-	end = FUSE2FS_B_TO_FSBT(ff, fr->start + fr->len - 1);
+	if (fr->len == -1ULL)
+		end = -1ULL;
+	else
+		end = FUSE2FS_B_TO_FSBT(ff, fr->start + fr->len - 1);
 	minlen = FUSE2FS_B_TO_FSBT(ff, fr->minlen);
 
 	if (EXT2FS_NUM_B2C(fs, minlen) > EXT2_CLUSTERS_PER_GROUP(fs->super) ||


