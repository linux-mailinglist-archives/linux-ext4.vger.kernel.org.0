Return-Path: <linux-ext4+bounces-10052-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5D7B58798
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C78B94E024C
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 22:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D772D1F7C;
	Mon, 15 Sep 2025 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjFuzqD8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED5D2D052
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975873; cv=none; b=iUrtNRJxWNPLO5E68wdzMNci4+gm8IGJ/3Bw2SHUXmMTHM4XrWOBBGvBAmvnoQyHNwyH0ORRKBcBJcCBPJWBvPdJzejKCSHhqPVyhIsawoBSAsrR5xNqRFQx3msfP2iSze+o3ohGOBw56bgF9u2VLVMiPrxN5gxYXtIpW0I5bEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975873; c=relaxed/simple;
	bh=HxE3Dizk4JvCPYOjBPQgsHtqXe/pMSXUGFT7L2MD+QE=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=CJQMfUryVTLwKE+NoQPsoWMBmX5J1TJwn4uOpNOdTPdZGGMoKelbNZdQxs9L2sSlRipU+QSqse0aCxB94yjRU4n8ws1LL/DWi+IoE1qa+eWsp597wOIgNniEo6RNs91Tkx2saGWM2SIb6C3aAEKomjnwSyg9/nBTDiBOm8YPdkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjFuzqD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02CBAC4CEF1;
	Mon, 15 Sep 2025 22:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757975873;
	bh=HxE3Dizk4JvCPYOjBPQgsHtqXe/pMSXUGFT7L2MD+QE=;
	h=Date:Subject:From:To:Cc:From;
	b=TjFuzqD85Wr7ODq0xEvUS15Oq8KuK3hhcuXGJR8ejApP+sH7K0RFJVmH55yhgWyTa
	 GXDFxMKrukh6UmzjpDGkgbF1/MCvvFjkE3uGINMHskfqJlUcrQ7LW6n6s0+yWF2zp1
	 vGreo4fKyYf8GpscE/avkNwQljVMh8ZFKQsAIg2DY4QbUPlWZbsZvrUAVGEVRdzrh5
	 AciLkwBRgB1cV2H5BQUp5VJebcqW2Bf98cYLH8KTB8wSp9zBBG2Nzg2B6k/yTFYfq0
	 tfMQEdQAY9oMg/Xy3IH5CCATpPO2lKbiZ2qHhUG4EZiaSrVhNvj+Bry7+5gC6WomaP
	 sI9tTnvGXhwvg==
Date: Mon, 15 Sep 2025 15:37:52 -0700
Subject: [PATCHSET 2/2] fuse2fs: add some easy new features
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175797569966.246189.4996503880732213475.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

As of 2025, libfuse is a lot more capable than it was in 2013.
Implement some new features such as readdirplus and directory seeking
for better directory performance, and reduce the amount of filesystem
flushing so that it only happens when userspace explicitly asks for it.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-new-features
---
Commits in this patchset:
 * fuse2fs: check root directory while mounting
 * fuse2fs: read bitmaps asynchronously during initialization
 * fuse2fs: use file handles when possible
 * fuse2fs: implement dir seeking
 * fuse2fs: implement readdirplus
 * fuse2fs: implement dirsync mode
 * fuse2fs: only flush O_SYNC files on close
 * fuse2fs: improve want_extra_isize handling
 * fuse2fs: cache symlink targets in the kernel
 * fuse2fs: constrain worker thread count
 * fuse2fs: improve error handling behaviors
---
 misc/fuse2fs.1.in |    9 +
 misc/fuse2fs.c    |  384 +++++++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 323 insertions(+), 70 deletions(-)


