Return-Path: <linux-ext4+bounces-10076-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2372BB588A6
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 01:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFF7584099
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 23:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB3E2DAFD2;
	Mon, 15 Sep 2025 23:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHIamgKQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B306D5C96
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 23:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980725; cv=none; b=VFnsfechrdXUbREGpvVb83oyb58ts1673t0CEZPvSQKDTLT55MBWtb923vXTcyTNtWPwKxfYHakQfqjZlQFja3hukIHOkvj95tas/iQp8xlh6C9Ehty25IxynwIUTRYO0MBlwMg+I0Ei6PYyDMDspR4FN//Cc8EBqG0ti/cUwJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980725; c=relaxed/simple;
	bh=F9+gUeJBoWiCc6xuxFkKitruZFssIqP9lq7en9Kwg10=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=EOT2bN6nDWgnOIWjyB7Cly3jec4wTTTxOAcvEc5STVTdBrYT5ziQZX1RFRT4Lw9+Ri5Mb6k9AUlZkI1LJl+oDXcaCUx4stL1oWhfSy9BVmB9eczZla/18qH+/60b3Drk9eDRCZokxEr40hLcIcoBYb11K2ocWDle063AaX+WUPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHIamgKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3060EC4CEF1;
	Mon, 15 Sep 2025 23:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980725;
	bh=F9+gUeJBoWiCc6xuxFkKitruZFssIqP9lq7en9Kwg10=;
	h=Date:Subject:From:To:Cc:From;
	b=CHIamgKQOk3vSQphBEsJ610j3FnpjoLMxHXJKwLJwhqx5grddQts7S/EgfrjC7sBc
	 nofqHKuw7NbY3l7eG60xnK9WbB9BFpxf2W4VECN7OS8ARp9Nuwt2dzM2cRlX8NF16+
	 OQe7Wfz4HTht0jDdeG0Jh8ZomYL2aTHJEg3nxqNnC3RZ98jPSrngTP9URHL5Ju+kjA
	 ovJOwOmD4IGTy53BCjRG7ZeLHoydrHRPTjFhcLudOamYm/e8HtNQPGGLO1Y9P1or94
	 nLZARs9FkrcnTSPd7BTaCTWkBWIA/wMiZ+AbZWMSMF1kUbxftRAcFh4Fu4DLAjUNzH
	 p14VMcdE2u86A==
Date: Mon, 15 Sep 2025 16:58:44 -0700
Subject: [PATCHSET 1/6] fuse2fs: clean up operation startup
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064057.349283.17144996472212778619.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Reduce the amount of boilerplate in fuse2fs by creating helper functions
to start and finish a file operation instead of open-coding the logic
all over the place.  This also fixes a couple of theoretical races.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-refactor-operation-startup
---
Commits in this patchset:
 * fuse2fs: rework FUSE2FS_CHECK_CONTEXT not to rely on global_fs
 * fuse2fs: rework checking file handles
 * fuse2fs: rework fallocate file handle extraction
 * fuse2fs: consolidate file handle checking in op_ioctl
 * fuse2fs: move fs assignment closer to locking the bfl
 * fuse2fs: clean up operation startup
 * fuse2fs: clean up operation completion
 * fuse2fs: clean up more boilerplate
 * fuse2fs: collect runtime of various operations
---
 configure       |   37 ++++
 configure.ac    |   19 ++
 lib/config.h.in |    3 
 misc/fuse2fs.c  |  495 ++++++++++++++++++++++++++++++-------------------------
 4 files changed, 325 insertions(+), 229 deletions(-)


