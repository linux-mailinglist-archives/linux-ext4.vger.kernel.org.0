Return-Path: <linux-ext4+bounces-10108-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61227B58915
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A99627ABB9E
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6A919E992;
	Tue, 16 Sep 2025 00:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9DN0zJc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD05625
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982117; cv=none; b=XXKZ7ZU3jgSoz+oJa7pv5cFz90EDwfA+WfaHnOM0korZpHxW3DQPxpre1epeRd5FSB7MUB3KdqsQu52CK5kVXDTkt00eufUOKPT6xExhqyWSNRtGLMorFth0oWZX+/fqZYE7pzaqFHimLu3J3/OV7ygkV3+NiEXr+o9M3fssCbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982117; c=relaxed/simple;
	bh=z848DgVqTvByaGqU7UHkSN0dakaHOCmWk9X5CkB7Y0g=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OsrsztMLqbixEYkw11C7Ydw15Ol6MCMxZc6xlgSi46Q6vRususQDS4PCpqrJMIFxiI0VIbdgX9XXBEwJMTNMjksuTgH5CMZtZBJ3Nh2y12vw9ZZuJFD7kgZ8MSLDtyU5jRN4ra87sLLr7pvVXCmblHt2Hfsn5C2+uFkWoJJUxRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9DN0zJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359FDC4CEF1;
	Tue, 16 Sep 2025 00:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982117;
	bh=z848DgVqTvByaGqU7UHkSN0dakaHOCmWk9X5CkB7Y0g=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=L9DN0zJcdyRwEM7E8MmwBt9m8KC9JF5ZHa1Mt+beKQ7t8K/gAYh96AqCowxqufiyS
	 dxZhqvOUE/trWZJhCrlPBivBiFsugAfxGZScV2zjaypn3g/J0kw/Eoo8KZM6WnnfhR
	 FKxnR42yQY1rL2ib7lKRj4juikxEdwSEZwnZp+7mAMaT/DE4rRZ/dhTA+0Lze5ZNzF
	 uSPeuFpEPHqpMTjPdpJ2cxxcPEviQ6lUJ71WUJ7xWv2WK3/KCPgw3EB2cp/3bJ9EMn
	 9wzQNO9DbeoRAYwbNIqlGaToDXUZIOhgXHOv+nUmCZe3rOYga9R9DoB7pj/aEfJUiq
	 WoUwb7VVQICQA==
Date: Mon, 15 Sep 2025 17:21:56 -0700
Subject: [PATCHSET 1/9] fuse2fs: upgrade to libfuse 3.17
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: amir73il@gmail.com, linux-ext4@vger.kernel.org
Message-ID: <175798160460.389044.17475177319582767798.stgit@frogsfrogsfrogs>
In-Reply-To: <20250916000759.GA8080@frogsfrogsfrogs>
References: <20250916000759.GA8080@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

In preparation to start hacking on fuse2fs and iomap, upgrade fuse2fs
library support to 3.17, which is the latest upstream release as of this
writing.  Drop support for libfuse2, which is now very obsolete.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-library-upgrade
---
Commits in this patchset:
 * fuse2fs: bump library version
 * fuse2fs: wrap the fuse_set_feature_flag helper for older libfuse
 * fuse2fs: disable nfs exports
 * fuse2fs: drop fuse 2.x support code
---
 configure      |  318 +++++---------------------------------------------------
 configure.ac   |   85 +++++----------
 misc/fuse2fs.c |  252 ++++++++++----------------------------------
 3 files changed, 115 insertions(+), 540 deletions(-)


