Return-Path: <linux-ext4+bounces-8363-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB48AD5C84
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jun 2025 18:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065043A2241
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Jun 2025 16:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9081F5435;
	Wed, 11 Jun 2025 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0gzBABy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025B41A9B32
	for <linux-ext4@vger.kernel.org>; Wed, 11 Jun 2025 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660221; cv=none; b=lYAPQEOO8LbYsR4Um+wpw8imbP4nUVN9kuTEEeFoaoQ7sGC65ysg845bSmGNHT1P/bSsZGtb5ygwmMYt+XMFP6AWxIToPdWsAiHpL7gYA9ywS5UKdBq1awqfjbndc6yulqvVtxzJaxWUTBhsIUvDNxZVkj5vNelYi2shljT4iuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660221; c=relaxed/simple;
	bh=5/YnqdRwo0p1SrsanALQpfVFbfywaUbEZNbpDjqxFyo=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=uddX0Bx0YkuS7Lv5R23dh0nymMH+YtigELAUQv5S8yzLbChrcxrbNClBG+RvGWgZl1A/IlczCo0yAajArOiCnNI0P8fyyYXfzJ+oRj3rGm6QBVoHTOe5l8Hqr/dZGaNp5hs0B8NaCqlddktGJ3GV6GXf3MxDrpkpUBU1GYZuKYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0gzBABy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7675CC4CEE3;
	Wed, 11 Jun 2025 16:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749660220;
	bh=5/YnqdRwo0p1SrsanALQpfVFbfywaUbEZNbpDjqxFyo=;
	h=Date:Subject:From:To:Cc:From;
	b=f0gzBAByaV9+RQUGvZSWY0Ra5i3IVjkgAUyguZ2UkBdiU6zZLB3aGq8eNL1WIChzw
	 ChPOFR8YGtnVLcSYeaxaw8mjaSodgfxuRCjxahuw57l9QWtcLP5jpqzTtkeura3a5t
	 HZHWPdxGHkSXadG4PAnMaWb5k5NvxBmwl7+OUYhg02cp4Aj0I79+eQYmCCBAdsMkZB
	 3U9gLKBmkFAAHHOlUTqMGbdbzdUVwJ9Ocfc6yKxTl8LUY7Z8A06zDUGDvl3yzW85Gj
	 HmwACsByzEI7AuzfqwA9J+8e2wbMuO+uNxTn/d0rQk78D01J1b98/ydA5HVAtgAfCN
	 VUgNemmSPO1Ow==
Date: Wed, 11 Jun 2025 09:43:39 -0700
Subject: [PATCHSET] fuse2fs: more bug fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, debianbugs@woodall.me.uk,
 linux-ext4@vger.kernel.org
Message-ID: <174966018041.3972888.391896904012834159.stgit@frogsfrogsfrogs>
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
 * libext2fs: fix spurious warnings from fallocate
 * fuse2fs: fix error bailout in op_create
 * fuse2fs: catch positive errnos coming from libext2fs
---
 lib/ext2fs/fallocate.c |    5 +++++
 misc/fuse2fs.c         |   19 ++++++++++++++++---
 2 files changed, 21 insertions(+), 3 deletions(-)


