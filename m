Return-Path: <linux-ext4+bounces-11549-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E52C3D97A
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94D43A7DCA
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB7032E6AD;
	Thu,  6 Nov 2025 22:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnDRL3lV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C052FC034
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468105; cv=none; b=dFpHZG4HlBm97mEge9cH0AYPtJQTwWG+qhxw+EBNgs+3rtozGF3X7vdCkjOI30o1FhOWXmWjbqMbmbaawnBOwV9Hb8Oh91MNoEQWaPIdlguxaBhmJXPvtEfQj3inncah33RHO8HekpSUuSfGADGDnXbVEWDcYr/80DmZUsjqkUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468105; c=relaxed/simple;
	bh=BrCD8Qzl4LpjKGqf0cVDpB4EhTt9ovJefRuoXjEZ/GA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQ3nnedAJH22VTI0hLg5c/xwp6mfO7+A+6NVDfFwat/opIUgIbhsqkMN5vkiS+EW3Xskr9ITDTYs3W1Gb2DJy+didkz31BXwo0lmuOQjfaGBbLMYRCg7cmVh4iwlmgvEGrFSMvIVVGQFcmtCoTpmU0rH8h2BOqH0kE3dbWixF54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnDRL3lV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45701C113D0;
	Thu,  6 Nov 2025 22:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468105;
	bh=BrCD8Qzl4LpjKGqf0cVDpB4EhTt9ovJefRuoXjEZ/GA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=GnDRL3lVGIvzFBRfpanB5LdkcBZWHuMFY6GxaXMh33tBni3V67UixgntRto/teM0t
	 xywZCZB9N7L1Fupv0PNBpSvCMT4EmX4hi4Vsa1zIluZ8200x1XJC1x/rMvUrBvYqJJ
	 R1wSlKXNWJ9QBJlROxwyjM3APXTP+sMcG9k3r4AmBECwzI0osTTn1TucwYgF7Quqs5
	 6x5Vx7dsTcYtZjjX0K4+Oeb1yPpFOR2N2+KYWNRy32zvPy6JC1L3rRTDhZkbPjW5ch
	 G5T7ofOto0p6BKOyQhZd/oe6QRDSECrogT1S0eWiPOR0KXF9HMgVOrOPVvAF8loRHZ
	 H48K/iy92Detw==
Date: Thu, 06 Nov 2025 14:28:24 -0800
Subject: [PATCHSET 3/9] fuse2fs: clean up operation startup
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246794125.2862990.7275258954976277948.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c  |  475 ++++++++++++++++++++++++++++---------------------------
 4 files changed, 303 insertions(+), 231 deletions(-)


