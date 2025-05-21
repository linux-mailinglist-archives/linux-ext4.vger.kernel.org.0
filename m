Return-Path: <linux-ext4+bounces-8074-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F38DABFF95
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C57AC7A3F1E
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D38239E62;
	Wed, 21 May 2025 22:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtQFEnQB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F622B9A9
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866877; cv=none; b=hqmUkG2QI5gUEuk9RCwzyFR/6Ro8qquMJCJQiFPueCEvE6ARjtw/iwK2RzAE68YBpI5Nz+Ii1JM2Suw9t8OWLyVKpXY9qx5ClaOsf0E41N/Yd2B30LUwRq+ln7QbIAeHsx1UYTmT88hiudNewn63QQAtnn3EZ87VSuu6PfPttH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866877; c=relaxed/simple;
	bh=VF6EhBD38MhSUKFE9Q03RHtda0zQla8B2+gEC/vs5fs=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=hLadPWsT3AWyNEng+2UmcBsYiGe0AEqPkVnFXzRAShI2PepXHhg08VDhqhwxh+3ukxqkPEcaGv6ymo8FnqVvqmHufu255ovZF8DF2Bt47QuGcEHY1wh9xTdxbtodRWtWHTyVLzxkEytCq95e/gTpZb5bZvYye/qQP1oqi4QuGAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtQFEnQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD864C4CEE4;
	Wed, 21 May 2025 22:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747866876;
	bh=VF6EhBD38MhSUKFE9Q03RHtda0zQla8B2+gEC/vs5fs=;
	h=Date:Subject:From:To:Cc:From;
	b=WtQFEnQBKleGR+lU2bp6LdPDktMXrS+HdXrxYUpl17KsJAMsp6n8JCtFq7G3Qyxzd
	 DzwpNbQ/bhC/ywxxEn6Gbt8XCXQq/oXSKPz5Cihfc/2i+/8RReFYpGxJsx9CDveE0f
	 Ap1ajpUs5wercp/Fcpq++fp6Jrih4It188G6kNaaWthxiWQQ8DIDimpYmapaVKL+et
	 Dv7SM6TVc4KwG4oz7USMniSYQerresBPjP4YYuCxoOd+WKU6eRmZDHnVdX62NucNcD
	 SPuvlwfcIqBBJlQxPAF5MKMl9gu4S6+F/OTA4BOp64H3TlqKyDGtjXlNWCBAMK0e9I
	 GZvG9vWMo8lbA==
Date: Wed, 21 May 2025 15:34:36 -0700
Subject: [PATCHSET 1/6] fuse2fs: even more bug fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This series fixes even more bugs in fuse2fs.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-fixes
---
Commits in this patchset:
 * libext2fs: fix unix io manager invalidation
 * libext2fs: fix livelock in the unix io manager
 * fuse2fs: clean up error messages
 * fuse2fs: fix cache size parsing
 * fuse2fs: compact all the boolean flags in struct fuse2fs
 * fuse2fs: support XATTR_CREATE/REPLACE in setxattr
 * fuse2fs: fix error return handling in op_truncate
 * fuse2fs: flip parameter order in __translate_error
 * fuse2fs: fix CLI argument parsing leaks
 * fuse2fs: allow some control over acls
 * fuse2fs: enable processing of acls in the kernel
 * fuse2fs: make removexattr work correctly
 * fuse2fs: implement O_TRUNC correctly
 * fuse2fs: rearrange check_inum_access parameters a bit
 * fuse2fs: make filesystem corruption a hard error
 * fuse2fs: make internal state corruption a hard error
 * fuse2fs: make bad magic numbers report a corruption error too
 * fuse2fs: return EPERM for write access to EXT2_IMMUTABLE_FL files
 * fuse2fs: check the immutable flag in more places
 * fuse2fs: implement O_APPEND correctly
 * fuse2fs: decode fuse_main error codes
 * fuse2fs: fix fallocate zero range
 * fuse2fs: check for supported xattr name prefixes
 * fuse2fs: fix return value handling
 * fuse2fs: fix removing ea inodes when freeing a file
 * fuse2fs: fix post-EOF preallocation clearing on truncation
 * fuse2fs: also ignore the nodelalloc mount option
 * fuse2fs: propagate default ACLs to new children
 * fuse2fs: fix group membership checking in op_chmod
---
 lib/ext2fs/ext2fs.h          |    1 
 lib/ext2fs/ext2fsP.h         |    3 
 debian/libext2fs2t64.symbols |    1 
 lib/ext2fs/ext_attr.c        |   19 +
 lib/ext2fs/unix_io.c         |   53 ++-
 misc/fuse2fs.c               |  769 +++++++++++++++++++++++++++++++++++-------
 6 files changed, 705 insertions(+), 141 deletions(-)


