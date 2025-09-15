Return-Path: <linux-ext4+bounces-10081-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 743D8B588AB
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 01:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC72584017
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 23:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FD22DC336;
	Mon, 15 Sep 2025 23:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AapwlW/y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F018C2D1F6B
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 23:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980757; cv=none; b=QaXJZsvlh1cKqpnORB7npyEaFhRbsmWe7KVTVWSgMc99tFbkTJSYhIgyZTOTxwk6GijKiVnLM8G4qkJPsIE4gDRxv2M0YuAQsDsJZL7kQlzQbMkW9rqkuLynXz0VkHcz/YwoMtg5lRdiM1dy2P8lAbqQUngMkJIqiVPLu8xgEg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980757; c=relaxed/simple;
	bh=zKZKpDaF6MVIo6TRVzuLPCxiah7bLP4XKtz9iD2KtGs=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=sQTIZKU7Afs4AB34CxJBvzzGc9fw9GtR415wIhimnlr0arMZEBTmcOj0kkzqzLpcZ8J982nbkhSRsKh5JwPVVJgLerCBe8prQnxDjCSnYp3E6LwT6nAi5pAo81HZhrZxaCk5WjsfsaRQ0J8o7BBiPhR9jA6cO7VcdSLFH7LHecA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AapwlW/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB28C4CEF1;
	Mon, 15 Sep 2025 23:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980753;
	bh=zKZKpDaF6MVIo6TRVzuLPCxiah7bLP4XKtz9iD2KtGs=;
	h=Date:Subject:From:To:Cc:From;
	b=AapwlW/y5LbeDp1095+gEA5BGfSWvhR2dW5BzPK8LSobirYNhL0uLalCjUtzd6Gco
	 QKjtXwjuLYF85rzScuKj/CcOvOICO8xM52ws5hD+IxSWKQ+3+2PgEof6XpsFKgXtZO
	 ImC7fUtbWc30fwCDBcKGtneT6bkqU8MvZDkHbAiYDIGC69UbZr1Yg8Z/oPgSxPC69N
	 ShOo47jdcLjAlRc7gzzOi26tp1HsN6O+twqwsARFbRMbgZXxkfd66DT70wqVZAnwJI
	 K4C2ezyURmOTTTNFOAcNzG3tS9HJ1CL3JBCbxud2vo/xcjKWjbO/Ao21HRI4hr/pKe
	 b+qehkhylfOtg==
Date: Mon, 15 Sep 2025 16:59:12 -0700
Subject: [PATCHSET 6/6] fuse2fs: better tracking of writable state
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798065146.350393.10618193797364129539.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

There are multiple mutability variables in play in fuse2fs -- first,
EXT2_FLAG_RW tracks whether or not we can write anything to the
filesystem.  However, there's a second state, which is whether or not
we actually want to write to the filesystem, regardless of the library
state.  This can happen if we open libext2fs for writing, but then
discover something about the filesystem that makes us not want to write
to it after all.

Split out this second variable into an explicit variable in fuse2fs.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-writability
---
Commits in this patchset:
 * fuse2fs: pass a struct fuse2fs to fs_writeable
 * fuse2fs: track our own writable state
 * fuse2fs: enable the shutdown ioctl
---
 misc/fuse2fs.c |   97 ++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 69 insertions(+), 28 deletions(-)


