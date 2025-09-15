Return-Path: <linux-ext4+bounces-10063-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF78EB587A6
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C724189627E
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 22:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B3A2D46B7;
	Mon, 15 Sep 2025 22:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etYEzQCP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D2F299A96
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 22:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976036; cv=none; b=KoHi/ilcPtJADBX4q1lrPP02XeIr8+/zYwEADzNCYVl3zyHLCLHArBwaoO/wdoMZ3CQoAf2xIbvAM0uF9Ufzx0sJkR07dmV9OJCnX+BmZyjXWz7sbO4bgTLkn+zFDrpWV6uBSWAR3EgS5JjV3hUuS2ZLuy1BuE0tIO46JWFGXUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976036; c=relaxed/simple;
	bh=RlGRHuSRWzXS3qKwUcCyUZuatpA4VBXEjo3T0t6kt2I=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIjpRHkr6LmIQ2JoVKM2OahQUq1uDdJTAeSUmjk8wQMK3D8h/QIYXF4+FpNkzhU4Aj6+mBRXbASH385LdF4aCIsdzu4M0vj1JL/oGzMwgT0vFqOZoTY8KlDaWcqizua1JcrBbIFsmvUIkHpXG0Innzah6nXSqJO7aiDuqtE4Cwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etYEzQCP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D61C4CEF1;
	Mon, 15 Sep 2025 22:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757976035;
	bh=RlGRHuSRWzXS3qKwUcCyUZuatpA4VBXEjo3T0t6kt2I=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=etYEzQCP2CSuYu1raKMzFyWK4JCKix1UXNOEvufEkmaHlUzyaRvDwLw68l94wHGVg
	 6yiaTyI6TEzs5dWWbWN3lPR1G9GfLeEkCsSXvBmfwznO72v/mhHqXANhsHClKvkLle
	 65LiUqkGMc7H+c+XdUd3/EUoRV44QeLk6tAYGw1Qsh5UILr+ZlLiF1+gLJ3v0nTMvr
	 bGenDqjUM9BlKNeDmkZIPjdcslK6rBemcFqE/uLuL/o6ME2uePrpC/b4vyn9OqeciV
	 5gBW6jNF66+7kAkCx+ZBijkVxG73LYU7ZzfSFvuJJYrulz/+agTuTEyuY1fuf6BfbP
	 rt9GAP2CYUmOg==
Date: Mon, 15 Sep 2025 15:40:35 -0700
Subject: [PATCH 11/12] fuse2fs: work around EBUSY discard returns from
 dm-thinp
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175797569817.245695.5933808486760481103.stgit@frogsfrogsfrogs>
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
index 7ec7875d9108a2..c09b2aa04c02fb 100644
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


