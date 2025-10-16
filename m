Return-Path: <linux-ext4+bounces-10906-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 085ABBE44F8
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 17:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5CB024E7290
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 15:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2E2313287;
	Thu, 16 Oct 2025 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z1i4gbfQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F283D34AAFB
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629408; cv=none; b=BAogEpSZsMo4g5dnu8pEovypkU83OE6MRGAuAe4j88Slk3vZLFnbE1pnI1nnZwjWWFd+V9bTWSkRLocJh8uiU4uXkF46mV5/mLzyNlxC1fABB+EoEsbBmlHKJa3jBDDIB6ivt2tp7S+H7YbGKmcZCfMxSUHmQDKnzPrW5ykjPSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629408; c=relaxed/simple;
	bh=qCS1SVr6QRg3IGJFfDZRZJAYs//4g9+fF2//XdbEnmU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eINVzVCDEWBeJLZVTetHI3XPypcX9vNvWx1JU5j0pEU2u9sQEBbQ0ofqCvp7attAEb75qUloOlYJghyFaI/gKgw3EgX6iSOe3ggX0qBDuLAhsgxjxkNdNJIufvnGXCXq9i+XEacY+OY77UL+FLNKxznTQb+a59uayTlXhk4RkJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z1i4gbfQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8906FC4CEF1;
	Thu, 16 Oct 2025 15:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629407;
	bh=qCS1SVr6QRg3IGJFfDZRZJAYs//4g9+fF2//XdbEnmU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Z1i4gbfQNwr2Vjjg7ueK+eYvAVBm6H4AhCOnFyd9Zu4K6cgEUPwTcpPUmPGKGoEu3
	 h1Ls/gfCnJ6Ocsn9PckQpwGNvN5HEr+sEISfF1faXye4IsoLnQ6fzssnP0qIKOVjJd
	 Q+3MCa6Ur3FbEjGbeqeZxlbqXTn19JI7FUAfhIrukbmhFB+37nJiPH8nfrSOWjAoJ7
	 ++hnELjfAk7m5XQUhjgY+vnz+tqvzDZU4jId/vdeE3gh/Pyh5Rp2oXXWZ8JIhoVcZ3
	 Y+oYdNDKG23ypElZrkVZdXSB4eWB7LehLxW9KhVcaqa2jn9aCRK0jyHuQFWB6wxo6/
	 rASRXQqyPlLcg==
Date: Thu, 16 Oct 2025 08:43:27 -0700
Subject: [PATCH 14/16] fuse2fs: work around EBUSY discard returns from
 dm-thinp
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176062915719.3343688.5400835821262447159.stgit@frogsfrogsfrogs>
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

generic/500 has this interesting failure mode when fuse2fs is running in
fuseblk mode:

 --- /run/fstests/bin/tests/generic/500.out      2025-07-15 14:45:15.092576090 -0700
 +++ /var/tmp/fstests/generic/500.out.bad        2025-09-05 15:09:35.211499883 -0700
 @@ -1,2 +1,22 @@
  QA output created by 500
 +fstrim: /opt: FITRIM ioctl failed: Device or resource busy

Apparently you can overwhelm dm-thinp with a large number of discard
requests, at which point it starts returning EBUSY.  This is unexpected
behavior but let's mask that off because discard is advisory anyways.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    8 ++++++++
 1 file changed, 8 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index b8db298cde202f..6864466435abfb 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4038,6 +4038,14 @@ static int ioctl_fitrim(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 
 		if (b - start >= minlen) {
 			err = io_channel_discard(fs->io, start, b - start);
+			if (err == EBUSY) {
+				/*
+				 * Apparently dm-thinp can return EBUSY when
+				 * it's too busy deallocating thinp units to
+				 * deallocate more.  Swallow these errors.
+				 */
+				err = 0;
+			}
 			if (err)
 				return translate_error(fs, fh->ino, err);
 			cleared += b - start;


