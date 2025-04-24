Return-Path: <linux-ext4+bounces-7459-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4820A9B9F9
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65D71B82ABD
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B41D21ADCB;
	Thu, 24 Apr 2025 21:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6pqRu4G"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF14198851
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530733; cv=none; b=bJAPLeid5N6VdIzX3ktmbh07NRmOXVgE2Iii4ehiIoc0av8eWIyKFqdkWK4UkSrsOkUKjFSR2WtxaFueJIm5IHn751GqpjL93AvgjHIOSGlLQTqDwUDH1tSivWhA7hz8ERtBxA280E5yOjJ4yht7/wemv+8V1aPcyZ/WwiTapa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530733; c=relaxed/simple;
	bh=Xpi2zMUnOltX0ibfG2O5YwFRAXve1J6NZ19eyotKSsc=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=ULthEuNwhbhGJtKnnrTRnbpcGVuTHY7k/SkRJeEKKypT+NM883HmD8NZXJZ0suaSPjw4YZqq6zJ8ZxVx3dnqptaUSZWI24afOQW0dRMoi6p6s2yfNN2H/Y4XimFPt9qYhQrWHTLArIpMCXLDQ9VMnuCrfBCdbauXrzB4Kv5RY2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6pqRu4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1370C4CEE3;
	Thu, 24 Apr 2025 21:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530732;
	bh=Xpi2zMUnOltX0ibfG2O5YwFRAXve1J6NZ19eyotKSsc=;
	h=Date:Subject:From:To:Cc:From;
	b=R6pqRu4GuWH+E5BBO0U1+yorNz9ZvSeo20zafr50Cxk7wRXL+YB1M9tCrZwVYX9RT
	 XxU2sjWJnZxSFd6TAFzImhrXq84CNYl9/bVdU6fikeGOTtI7S+Cd9vPha83MDsfsvF
	 Pbsh/rKgEBVSmxnEVa6wK3DK2RKiEmhDTEX6Qh8kQ5OTq71XUBXu0H+QQSkhzRjBji
	 XuU4jz+/r9+zNPCr16BdF6iBO4SCfqYPSoNHDtj7vc4jc/Q+JTp0N+8NSE64SFSO1E
	 5MOB8/4cEJBqeRKFmCC7uuDSKOGS71/LXsJEfol5npzxiv1mssZ2IItPu8KAANDxfX
	 R/Dn947SHiE3w==
Date: Thu, 24 Apr 2025 14:38:52 -0700
Subject: [PATCHSET 5/5] fuse2fs: better disk cache
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553065491.1161238.812958177319322832.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Improve the libext2fs unix io manager's disk cache by allowing clients
to make it bigger and allowing hashed lookups, then make fuse2fs ask
for a much bigger cache.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-disk-cache
---
Commits in this patchset:
 * fuse2fs: report cache hits and misses at unmount time
 * libext2fs: make unix_io cache size configurable
 * libext2fs: use hashing for cache lookups in unix IO manager
 * fuse2fs: allow use of direct io for disk access
 * fuse2fs: allow setting of the cache size
---
 lib/ext2fs/ext2_io.h |    2 
 lib/ext2fs/unix_io.c |  210 ++++++++++++++++++++++++++++++++++++++++++++++++--
 misc/Makefile.in     |    7 +-
 misc/fuse2fs.1.in    |    9 ++
 misc/fuse2fs.c       |   69 ++++++++++++++++
 5 files changed, 286 insertions(+), 11 deletions(-)


