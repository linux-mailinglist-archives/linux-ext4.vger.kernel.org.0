Return-Path: <linux-ext4+bounces-7458-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B168A9B9F8
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20941B83060
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8520F21FF2C;
	Thu, 24 Apr 2025 21:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mt0xZ2kO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BCD218ACA
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530727; cv=none; b=Z6gwqMMfiscc94S5FLoW3aX97ypV76pNzugUAKfCsKUpmbZCmNWi2b4H0uJcA6TLhAvA0cGKXH8PZeN7YFo7w+162vpL0Um6QPWmesLa8BsLwe7IHYP0ZkeUisMbMkrequVQIIitlC6Wf8VfVsEeTKxgFjob6LVb0oDbpJ0N8Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530727; c=relaxed/simple;
	bh=Hr1MdgoJnhlg51hwx8Ahrz+gAcAidBnY0SxJu4FREBc=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=nh2r6/2mFKbgCuGil5j65+SMIpaDifKQYB5FwpvFWGG3eqGrrDNSXU7qRrpd+kaDatXDph2fmuo/qmxhRQQBErRgiPcKMyQz+ZD6DEzYFefiCu0nstB4i1tih3Zjdv2mWwGYISdT0/WKx4LZns/pPng8IuTzlrd6BDmjgjKXWzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mt0xZ2kO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D2AC4CEE3;
	Thu, 24 Apr 2025 21:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530727;
	bh=Hr1MdgoJnhlg51hwx8Ahrz+gAcAidBnY0SxJu4FREBc=;
	h=Date:Subject:From:To:Cc:From;
	b=mt0xZ2kOD4haTUGahTar9C53V1AvaqKnGHM27RNfWLBwdchNibHtWiWI7qpphM0qb
	 bsZG88SCoU2OC8YDaBqJmG6hrYDQgyxExlnfzgjZPmoepXwVM3Z5seddK93YkUzjt2
	 67akLHsAZOMRzRDh0mxQUb/3uoFmA8wFXK6TwYsZRZ7VjV1GDGo0lY/G2+B85c/rPr
	 cN5lz8k7TY3NmUSqBtZzuDLy5vTS7QIM7+1NXQEZzzBLko+9pUBXf70Dgkt7moWfOp
	 UVmlRFtjv8lOsdAUHOkmtPOkpuVemyJLOHQYih1H6j7b1L/7svNfgj24tDD4vD7RYx
	 ePCOpvmobdF2A==
Date: Thu, 24 Apr 2025 14:38:46 -0700
Subject: [PATCHSET 4/5] fuse2fs: delegate access control to kernel
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553065332.1161102.2163541286559749682.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

To speed up fuse2fs, let's allow the kernel to make the access control
decisions for mode and acls instead of crappily trying to do that on
our own.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-access-controls
---
Commits in this patchset:
 * fuse2fs: refactor sysadmin predicate
 * fuse2fs: delegate access control decisions to the kernel
---
 misc/fuse2fs.c |   39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)


