Return-Path: <linux-ext4+bounces-11550-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF0EC3D986
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2711C3A86FF
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0BC332904;
	Thu,  6 Nov 2025 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aewQ+tY5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AAB30EF91
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468121; cv=none; b=nBezGs2s0CA4xn6D1ifixE0HWA+Z+V8hOY39DBRNzoTNXcgSS4KOvHAT4KvszSnjLlRJdFUcFF917H0BIjoO5G9ty5PUpUr4H8FHXaXvP4kdgdSc4y6H82QnCfmgBHp5P5JPkWBsVrNKrGlu84Ikonq0S10BEq0pCFOGmuGhZ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468121; c=relaxed/simple;
	bh=oKtdYd18xdpAxWKN6pN5ZZaAw7EzlnU32K39U4NDYd8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YN6q34DK1zC/Jqnq/RmSGdc8qwo3FqVVN6GSeaMpm5ozu6no15oZWBhwIjTzq8SEuPxjQ/+nK94zn2kw6/THJ4LbP0fyLmidmxpqTiEEiVg8r5EuaDz91DdYW5vsCQFCvQCBPp3XxciFuRN/B/4HuYpC2DvBC/XC5Q2gN+rjXEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aewQ+tY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305F2C4CEFB;
	Thu,  6 Nov 2025 22:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468121;
	bh=oKtdYd18xdpAxWKN6pN5ZZaAw7EzlnU32K39U4NDYd8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=aewQ+tY5Brl5dzD1ujeoFnfityghzDKhRdw4WXIgsscYctxN1myOjgrLUyO4Dnwe7
	 oBWKLNt1pPzNjPLVDsF+Tu6AQ+2OGPFPpDoXWYuSnKrBM8IgBT4rAbeJRVhTgZ8hZP
	 X5t3YYEsGKDtgC4GTPqRNBcvrgc44UB3gu2iCU+YnqxrO3t1Fpw8s75CSDrSAFPntc
	 Dcx1ghmfu/dmxEfyWUgfnRkiMYEg8E1xYvVgt9+JxXwXtUJfgRShhVGn60VkkFriVx
	 CkFNh84z8pRlsX4PQwy8qlqTDcUvVBNDXxsRyQVNN/aIKWvda0mb+0eJd2oWe7X+u0
	 1pWi0qFaYG2tw==
Date: Thu, 06 Nov 2025 14:28:40 -0800
Subject: [PATCHSET 4/9] fuse2fs: refactor unmount code
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794450.2863378.4457886029233676166.stgit@frogsfrogsfrogs>
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

In this series, we refactor the code around ext2fs_close to get ready
for iomap mode.  The significant part of this series is moving the
unmount code to op_destroy, because we want to release the block device
as a part of the umount(2) process to maintain expected behavior of the
in-kernel local filesystem drivers.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-refactor-unmounting
---
Commits in this patchset:
 * fuse2fs: get rid of the global_fs variable
 * fuse2fs: hoist lockfile code
 * fuse2fs: hoist unmount code from main
---
 misc/fuse2fs.c |  195 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 106 insertions(+), 89 deletions(-)


