Return-Path: <linux-ext4+bounces-7480-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEDAA9BA12
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE88176555
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9065B21FF2C;
	Thu, 24 Apr 2025 21:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahOChj8O"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3229A214A7A
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531052; cv=none; b=gzjr5PH83QcSdjxMCRjFCMV1u0zrjqC+dG0wvLNhsJ87TeVqPc/VnIrqbKRKyxOZypxwOnJP4Epk1uaxK6HGRYb2+eUyZC4qPLbvOZId19PxeU8xGqRsmVVite9XzrD1Izz0dlmwXtYtluErMaaA1vSP7AKI/v7VNmIMzG5fDbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531052; c=relaxed/simple;
	bh=iToVKcpBO0yXTryFfVGjySUD3whJPZ/zHKrwP2k2mGE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fYtDzkwrfC+98wPiq+N/JVruDgGBuX7WwIZNEhJc3rzqea7Qkd0tzXaWD8dzxHM9C+eXcrpSo7HVfQE79wKg1ey2hRQ0ZM4dlPHUUx3eWY3IPTjIHzEVYY6RkT5UdWKyzEZNaqYjd6JyNQa8nAw5gAEtvcEqZcGlk0vBKxotAgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahOChj8O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1AEEC4CEE4;
	Thu, 24 Apr 2025 21:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745531050;
	bh=iToVKcpBO0yXTryFfVGjySUD3whJPZ/zHKrwP2k2mGE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ahOChj8OWNvXi+0UcqFrqZ65qXt5pmQigm77A3eGzmZtFI3vTCkxzVvJyt4X56Bdb
	 StvlsGOqSfDjeQUi2j29FHhRgnvHY+bSjc32KQyn10Rd6u/GQ6s61wDqsLjOZlaYu/
	 ztjawRaZvl7EwD0uhyV2KhDhkjPXDI9uobsd0Fr5r8TbbqGgsvrDfsqMroEawSzRkE
	 y7O5SiMxtxKL05qCOJ7z2qxZhMq6fXzYBfRl2ObJ0CxPQrTtQ1alyq2W5tU9ddZLHS
	 pgj11P1RO04Kt/M8cMYHdv9n97YSHrihkAKh9UWrDl805xDArAGmuyVvJJ684Wuygh
	 QMBYrzocSRbMQ==
Date: Thu, 24 Apr 2025 14:44:10 -0700
Subject: [PATCH 13/16] fuse2fs: report real inode numbers
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553065159.1160461.12395515521619169511.stgit@frogsfrogsfrogs>
In-Reply-To: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
References: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Report real inode numbers in stat instead of letting fuse invent them
for us.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    1 +
 1 file changed, 1 insertion(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index a13564a30575da..7db0a2d1f2d855 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -611,6 +611,7 @@ static void *op_init(struct fuse_conn_info *conn
 #endif
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
 	conn->time_gran = 1;
+	cfg->use_ino = 1;
 #endif
 	if (fs->flags & EXT2_FLAG_RW) {
 		fs->super->s_mnt_count++;


