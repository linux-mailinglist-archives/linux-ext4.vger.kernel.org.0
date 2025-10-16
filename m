Return-Path: <linux-ext4+bounces-10892-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96711BE44E3
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 17:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8453D3A8C19
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 15:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFF934AB10;
	Thu, 16 Oct 2025 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkUgecJq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC711607AC
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629198; cv=none; b=FrNFaois3Xu/zN6NQ20tsfTWxKGAMz2yPatuQwQN76+ZoO7Ngznwmud7HBUSF+KqSaSsi4hz/nkRVShXYDLuxoL5Os+umbOc5a2Kb8C1IJLaiUY+uF6Ej/XasNnV8pwf+ehzxQlF1/9wdZXPuEIJQgDsKf1RZFrvfxT6Pxm/y98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629198; c=relaxed/simple;
	bh=n0wVYjks5a2kNMmTmB7+Of6ta7kIOjy9tnixAesnTJE=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=gPyckEf3IHG/k3aBtC/jmd4e3dJRAwzd4nVkoRx5lrRS6UxQwGEXyLNFcxrU3l33whEyqhpnzHJCIddDJUjWs6sHggFsMqHHlZ/mj+L6MWrbcvy5CpQFv49LJYaD+dEDjbBcEB+OiNGoNwUbeOtDQ93em7JCufeJu2PTym/gBsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkUgecJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A315BC4CEFB;
	Thu, 16 Oct 2025 15:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629197;
	bh=n0wVYjks5a2kNMmTmB7+Of6ta7kIOjy9tnixAesnTJE=;
	h=Date:Subject:From:To:Cc:From;
	b=MkUgecJqWC4vP04IjLVozvUUGT4nIj0Rh5oYkMBIxijtB6AJprkWbAf9byn067YJB
	 tI8fye8trXtwzWOjENPXEgMUe5reBezthAsxcDKB2LjBlb9iYjD/J3fKPixSHAXgEK
	 CJfxjTIKzj44OxlvSWlqR5pe4ssrF1R3ieEwQ4nClls7CdF23CsqPSZtOO6LkIe8TD
	 dt7qWYsmZx7xATkLD+9A4T9uDUBE7CQL85wtzyH/Tos+82IZ1pslTnN1jrt+dCnzZj
	 8a6kkC6tGkz//zPsvabHl2jGCzJEIP4gMJSmkRBxSZfK4Y0uuwFZB0YOUCutQceo18
	 JvcvjroQ47yoQ==
Date: Thu, 16 Oct 2025 08:39:57 -0700
Subject: [PATCHSET] fuse2fs: round 6 bug fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This series fixes more bugs in libext2fs and fuse2fs.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-fixes
---
Commits in this patchset:
 * debian/rules: remove extra pkg-config
 * libext2fs: use F_GETFL, not F_GETFD, in unixfd_open
 * libext2fs: don't look for O_EXCL in the F_GETFL output
 * libext2fs: fix ind_punch recursive block computation
 * libext2fs: the unixfd IO manager shouldn't close its fd
 * fuse2fs: update manpage
 * fuse2fs: quiet down EXT2_ET_RO_FILSYS errors
 * fuse2fs: free global_fs after a failed ext2fs_close call
 * fuse2fs: fix memory corruption when parsing mount options
 * fuse2fs: fix fssetxattr flags updates
 * fuse2fs: fix default acls propagating to non-dir children
 * fuse2fs: don't update atime when reading executable file content
 * fuse2fs: fix in_file_group missing the primary process gid
 * fuse2fs: work around EBUSY discard returns from dm-thinp
 * fuse2fs: check free space when creating a symlink
 * fuse2fs: spot check clean journals
---
 debugfs/journal.h    |    2 +
 debian/rules         |    2 +
 debugfs/journal.c    |    2 +
 lib/ext2fs/punch.c   |   12 +++++-
 lib/ext2fs/unix_io.c |   11 +++---
 misc/fuse2fs.1.in    |   42 ++++++++++++++-------
 misc/fuse2fs.c       |  100 +++++++++++++++++++++++++++++++++++++++-----------
 7 files changed, 124 insertions(+), 47 deletions(-)


