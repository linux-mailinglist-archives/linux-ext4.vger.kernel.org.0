Return-Path: <linux-ext4+bounces-11547-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3907DC3D974
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B3B189078A
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320F532E6A6;
	Thu,  6 Nov 2025 22:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVcBU0C3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F25305E28
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468073; cv=none; b=jWmdhxFJ3IZbyF5rif7gtf0D00fwuMR80Rmjg+U36WFw4zFz0WMp5IfFHpmJebw5jcDqvGtJWLsKv7q6wPeadFk078txsLKvMZFTxr06XMR7ZvUJELqGfAnAOXV6Dxm6v5dv50gqTrXuod6CEFCdpVQL7YDwNh65Sg72CFeokSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468073; c=relaxed/simple;
	bh=F+iFXIB3IrC51I01uchMD0FzHtTQmua1V1YuS8bjwjc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHZyTKFG8HViX90RLQto4oQD6MfFoiC2fLF8HMtcNnoPRaBk4/erWr+m/u95WNCyjlgIST6Atvvy6GZTuQq1JID4I2efkK6NSXEq/e/SPVkp2jtXlGUIAoqjqBUrJSBYqoxIfS3MEo0DO7XSvQXzJ7Mb0hxHAbBWRLwy3CveQA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVcBU0C3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469B1C116D0;
	Thu,  6 Nov 2025 22:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468073;
	bh=F+iFXIB3IrC51I01uchMD0FzHtTQmua1V1YuS8bjwjc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=sVcBU0C3mu/sAmrGmWU6n4XGVqSJEmn3IjIYkH8sQVUXyJaIZe1XDgbzmF/bIUoKr
	 RP9NcLotf+v7RXH64oL9mTY3TUox233W9GQEIP8vcXNDjYmrT3Oubb8xvaWvjcHAMr
	 x9rGkS5aU18rhN+t/qA3G6hI/ydG8LestIFE4UK33l7zlnqxJolRwdoWtT8Gid+3tN
	 STAqbZvZUPXGESxvypBtBmmI1GL889bOJr4gnPw23wRQRXPMVUlYwyxy9i/79v7RmG
	 2Zi1iGmuIua/Z3bRWtZdRLAHCplGFZOtF+VunAH4M7bFi2ZgJZEMc7FgbmTbFihn5a
	 y6Bp0wEa61hcA==
Date: Thu, 06 Nov 2025 14:27:52 -0800
Subject: [PATCHSET 1/9] fuse2fs: fix locking problems
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176246793314.2862036.15869840216751367735.stgit@frogsfrogsfrogs>
In-Reply-To: <20251106221440.GJ196358@frogsfrogsfrogs>
References: <20251106221440.GJ196358@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Teach fuse2fs to flock the file(s) underlying the filesystem if the fs
is stored in a regular file, so that we don't have to create and
maintain separate lockfiles.

For block devices, fix a weird race between mount and unmount that is
causing testing failures by waiting a small amount of time to grab a
lock.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-locking
---
Commits in this patchset:
 * libext2fs: add POSIX advisory locking to the unix IO manager
 * fuse2fs: try to lock filesystem image files before using them
 * fuse2fs: quiet down write-protect warning
 * fuse2fs: try to grab block device O_EXCL repeatedly
---
 lib/ext2fs/ext2_io.h         |   12 +++-
 debian/libext2fs2t64.symbols |    2 +
 lib/ext2fs/io_manager.c      |   16 +++++
 lib/ext2fs/unix_io.c         |   71 +++++++++++++++++++++
 misc/fuse2fs.c               |  144 +++++++++++++++++++++++++++++++++++++++---
 5 files changed, 232 insertions(+), 13 deletions(-)


