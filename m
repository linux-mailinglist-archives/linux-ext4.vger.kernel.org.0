Return-Path: <linux-ext4+bounces-10077-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05099B588A7
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 01:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D6D584046
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 23:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EFB2DAFD2;
	Mon, 15 Sep 2025 23:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyEcPS6R"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7485C96
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757980731; cv=none; b=r1bt/2V5xUP9SaIWyVj/GIHKy970gxN/wpgrjUuZBr27zOQSSfPaqYV5cxu1zZ8B+wUFxw9bhMyDK9Bk05C/f9MjuOx6wrZxIGMNEijRT3DZ9vkdL+RYQ/VaJ8VAbhG0kytGr9LPBjjucGJ+fytI/6HTo9EDSzn5eq5G5kgLVz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757980731; c=relaxed/simple;
	bh=UwfUbuuyU0IFh48WZvJSE5ixp4QHzSlufry/zbjoOWA=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=Olf4BErMDpDz9S3nikoiBNrT2muzp2EXQHdqlwGmwHC8zsOg3hFTnCOBL9Phyl5W46hlIkjDcy28OhdF8EspkddsdiYsiXyZwA9ANh7jTolRTxB27v0BPLWUmI3oQnHoTYWn9vfIgBZ04WFjxWKxW6Mc28q1wEw9CTCqjAlU2c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyEcPS6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4457C4CEF1;
	Mon, 15 Sep 2025 23:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757980730;
	bh=UwfUbuuyU0IFh48WZvJSE5ixp4QHzSlufry/zbjoOWA=;
	h=Date:Subject:From:To:Cc:From;
	b=DyEcPS6RRruNdbuOY1mrvo4npep/TPWD2pyGt/wWhNqb+tyCodg0vBwXqRQdEck+j
	 6qT1dIbv6GEto0ShvRfTkR53lhlMG9ol+5PEcK9jqeyc4MgWsT5r0G8LvB/I6SY8Uq
	 pHQ17nTFWHXus/mo/b2VxH5LvW7S3RRKrQgtpjhX6+7gGMptGvmJwovnCVDX/8qmwq
	 pUYlZzeTU2n5GCeimBgZH3dqTaltYeGU6Rogzys3N9yDZubDBYQ/TK3iUn27Iy/8pc
	 Ga/4G6AwMpIloJByC9zvzxW6Uf0gGRQAcrTFL0MHbXKgbEwG5cylNSuKkNQKHUM2bM
	 zAALgdpvQVg5g==
Date: Mon, 15 Sep 2025 16:58:50 -0700
Subject: [PATCHSET 2/6] fuse2fs: refactor unmount code
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798064383.349669.5686318690824770898.stgit@frogsfrogsfrogs>
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
 misc/fuse2fs.c |  189 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 104 insertions(+), 85 deletions(-)


