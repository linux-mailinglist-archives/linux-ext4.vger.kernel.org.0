Return-Path: <linux-ext4+bounces-9402-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93787B2E8FE
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 01:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B29720D73
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Aug 2025 23:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07EB2E2DDC;
	Wed, 20 Aug 2025 23:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2nk61Bz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AE325D21A
	for <linux-ext4@vger.kernel.org>; Wed, 20 Aug 2025 23:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733263; cv=none; b=RAc2tUkAKZyajKf2FPP/OIYsh24dp12kmVPrfdy0VD4D3XmbJK2+qHEbN+SJwkWJ8TShUuil1LiCzbCJnM2QurdUDKN7q+UrI0wlcRpGH3ZNiKO8jfovCEGLKW9oMtB9m8z3oeDaG0etOHjTgwWhJ31EHgatQSKFxdYCyJYvsgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733263; c=relaxed/simple;
	bh=OLhT3WJFpyG3/LOU6M9LrjtBAIBClycuvc0FTfKsycc=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=uWqXXZBtZ4TJ7SVhh+L2oHOgidS9Bzl2p+6BPxJfs0E605xYJ1ZMAmdAeOz+5HEtsacY2Bu/PcrNzNIAe1GPsSJRFrCMinUt3SWsHDNX7RpG5W4cY5L7nJ3aea5KQyBobrgWgyZ2XCWqiAsyNVwkjKPmru4IVdfsRiI9TxQBmp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2nk61Bz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B2DC4CEE7;
	Wed, 20 Aug 2025 23:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755733262;
	bh=OLhT3WJFpyG3/LOU6M9LrjtBAIBClycuvc0FTfKsycc=;
	h=Date:Subject:From:To:Cc:From;
	b=N2nk61BzWPYw9hQdLlj/kXXnQYn96Bj3qGHzrxpax/guk2b4PN1xcy5nUGQUrs4nY
	 JZBeoDWCgqrkUNpg9MR3fjeZKHbXIVV0ZZhSKpN/QOoYoj6BBqI/Z10JfytqLodQyq
	 zzSC2YEMZ1b+djMFG/J4C2t+NsA7dcs8fdCPXu74sn37+emcdMFMR5TfA2nsFV/whV
	 Z3mSAj7STC7PXz/f6pwYych98OtzfNRH2iwso4eK9yz6Ziw+WHScUXRfwRQZlkTejt
	 Ckvm7lIgZIcb8Qt5B1fgKdO9trmJe5l9S/0qaK/Q+21e83t6Z2o25+oNllc2E1hm2k
	 RammQ1AB3q/gg==
Date: Wed, 20 Aug 2025 16:41:02 -0700
Subject: [PATCHSET] fuse2fs: round 4 bug fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175573318553.4130038.2069350865263085609.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This series fixes more bugs in fuse2fs.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-fixes
---
Commits in this patchset:
 * mke2fs: don't print warnings about dax to stderr
 * fuse2fs: fix readlink failure
 * fuse2fs: fix various problems in get_req_groups
 * fuse2fs: allow O_APPEND and O_TRUNC opens
 * fuse2fs: don't let ENOENT escape from ioctl_fitrim
 * fuse2fs: don't run fallible operations in op_init
 * fuse2fs: check for recorded fs errors before touching things
 * fuse2fs: interpret error codes in remove_ea_inodes correctly
 * fuse2fs: don't write inode when inactivation fails
 * fuse2fs: set EXT2_ERROR_FS when recording errors
 * fuse2fs: disable fallocate/zero range on indirect files
 * libext2fs: relock CACHE_MTX after calling ->write_error
---
 lib/ext2fs/unix_io.c |    1 
 misc/fuse2fs.c       |  172 +++++++++++++++++++++++++++++++++-----------------
 misc/mke2fs.c        |    7 +-
 3 files changed, 117 insertions(+), 63 deletions(-)


