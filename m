Return-Path: <linux-ext4+bounces-11553-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0313C3D99B
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A99154E71B3
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1520A33342D;
	Thu,  6 Nov 2025 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2rFTZA+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3FC30EF91
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468169; cv=none; b=uqhMt1rIrBNLar2a97hPcn+N+xczeQTCb67t1mIG7u+a8WGUWF2vYCXnH6NB2AkOFrrGZ77FOwjWa6SJcif0KnKC2RZitTtLJZA86tFIsxZBs9Iv2wOXe0yejhntxcxnpkx0tuI3eYNY4plw4IVwPKptkLm3ikfkZigVtmWaT3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468169; c=relaxed/simple;
	bh=unvLVV18pZApSORmdmqJug+aXSNf/f5nBVprVBPC0dI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FwKjv2X6WBxlkdmDhajWY7GP70p1JF35rRLudEbmHg98XGttpxsUzDVJSCSS7zVLZJJaszeMdWp8kboBIez5p/dF16q+R5g4qwGYWHdXPhAEje0my3g15DogKSxFu08AXPmabRhR7IMAtg6IUQeRcWdhtk9SfLP2818pQiOUgng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2rFTZA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C85EC4CEF7;
	Thu,  6 Nov 2025 22:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468169;
	bh=unvLVV18pZApSORmdmqJug+aXSNf/f5nBVprVBPC0dI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=c2rFTZA+IL2GZ3MA/LrIEPfQYgzh9cud8aX+Wjo61jea8fBAZ3JSmAtXhhUxV8Jea
	 tYtZPV9swlOoomGFXgg5fuJvhlsPUHak4T2H8QCsBSGVeKnDkHaozDWj7d04OSApMI
	 iBJfXfyUiILUOcxDcjK0C3l6Hj9XArHQehOG5aEcq/rQvumnZm4dYgGxwuyde8B0XY
	 BRJLEn+VTaICcdiCmCq4iAxUY04vM5nATgewk521cPnOsXbZ8L6/eJEz5robWlyChD
	 5fVEiVluXTN6WtsuG0raeglORI9JNDF5vTZLpsyBDOV6mO5Hb5vIRK+MFDEpu6yRSo
	 j8kld3UkHiRvQ==
Date: Thu, 06 Nov 2025 14:29:28 -0800
Subject: [PATCHSET 7/9] fuse2fs: better tracking of writable state
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795040.2863930.4974772996705539351.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |  102 ++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 73 insertions(+), 29 deletions(-)


