Return-Path: <linux-ext4+bounces-8106-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC53ABFFD9
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF7634E4F7D
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C26239E85;
	Wed, 21 May 2025 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGoMjSZl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36FC23816A
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867319; cv=none; b=quq+LrbNe6RJjuKY133Bi7ZfPmSWrbcnkIK/5bPtKoTrCDtBOn2b5n4MV7/O7bIVvw9kZmzAS9GZOIBBun4LfLm2yUYvUizpAeWl1DSrCQcGKPbtsbeMqeOlynbNUmc3SPP1bUtMuOC4XwX4gacRD5ZOkXG7MHdAAIxS/C6hwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867319; c=relaxed/simple;
	bh=LGqQAgp2z6pynBlgQqVbSCsdpr+0BLpf//K1QWTmVN0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7dx8UF63XV2Ynj/fqDi2YnqGkzBfifetmZTr/zi7Bf3Ne8jLrTLtHx9IVBi8Hltx0SeTLjyis8esVEbJQUr1JRi1yFPLHqHWoGR6216PVKeCDln0ZlIzIvJBNLjn7lbxgIYqDxgL8dPW07/ol3tEdNzdD4RUkyddysESDZafQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGoMjSZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE39C4CEE4;
	Wed, 21 May 2025 22:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867319;
	bh=LGqQAgp2z6pynBlgQqVbSCsdpr+0BLpf//K1QWTmVN0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=rGoMjSZlBoI6aBDFAmcUoa+ycep8d16siuTtZpmRdPfvOS5kBVo8lJYtFOfkDuxzG
	 w5m5J7JxaO/FLQahwoOCTwQzjMhOLQ/E3F2ncEGCSKPaseSylwqmA2AzJgfjLaUJoK
	 oKHyN2t3/D0cRBUW+h+piyvTHvQzZpHn4U56AQB9jpvZgKMrzirlx/ddVLjh8d6njQ
	 GfnxtnmWzeaLgUoKo8Pjyzb7t9Fm9yU9bDMx6fJmDbpyrRewjotsjTOF1b2JryBRwP
	 unAT/mxn3oDuVEWD9D6AJWeWJBycjUe0SaNd8Ot41/khp+3b5/V3pIVmGNIL2a9NXF
	 x/6IT6Hi151MA==
Date: Wed, 21 May 2025 15:41:59 -0700
Subject: [PATCH 27/29] fuse2fs: also ignore the nodelalloc mount option
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678032.1383760.18384774850296194367.stgit@frogsfrogsfrogs>
In-Reply-To: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
References: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

We don't support delalloc, so accept the nodelalloc option even if we do
nothing about it.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    1 +
 1 file changed, 1 insertion(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 626e3a42181148..71e81992cc1819 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4071,6 +4071,7 @@ static struct fuse_opt fuse2fs_opts[] = {
 
 	FUSE_OPT_KEY("user_xattr",	FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("noblock_validity", FUSE2FS_IGNORED),
+	FUSE_OPT_KEY("nodelalloc",	FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("cache_size=%s",	FUSE2FS_CACHE_SIZE),
 
 	FUSE_OPT_KEY("-V",             FUSE2FS_VERSION),


