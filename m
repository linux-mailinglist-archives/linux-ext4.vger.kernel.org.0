Return-Path: <linux-ext4+bounces-8079-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF852ABFF9A
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273433A5C06
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2883023A9B3;
	Wed, 21 May 2025 22:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ts+RUpwS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D76523A563
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866905; cv=none; b=B6M9O0obPYjtDulOcwUjbo2Jgb/tdojSiCuil9tkVQWNz8mA9bTEp5oxnACogmTHpmKByF6hLw4tKIOALx8LEah+mUExADoqCRrYM47c2GpGOxF26iH+bUmc2mikJiKfYq1zOXpjH+WGnqvH7akYP521pqQ9tgb1E5nLPx95l7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866905; c=relaxed/simple;
	bh=oMXSEMbQ0BVPRpy9Wpz+HFasV0FHm0VhG5NEOnnOGfQ=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=cLcaYyqyxiXHeiudIrhAiJBEqMBWigAR9ESYQSFR2nrwBChxo7KLpewi3RCPnH3gUxGYigAmExocWYFGu676fu5tJA/9XPEW3v/bpbgRrFz99jYFQiA/eyc43z7Y7d7HQq30vB6rp403bpDk9DVjJnlYP/TV6oKweEY09FUgf30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ts+RUpwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522E0C4CEE4;
	Wed, 21 May 2025 22:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747866905;
	bh=oMXSEMbQ0BVPRpy9Wpz+HFasV0FHm0VhG5NEOnnOGfQ=;
	h=Date:Subject:From:To:Cc:From;
	b=ts+RUpwSVf4i+9z7qdEgTiIKquIHDR3K/6t8Zewgwwi9sq1Kr9s3LKAEUH0vAob6V
	 8PSmiJ7PwB6m1+qoLwfLXVXksJiRSbGFjqGH99sLtrRnsoKSa930IhjWei33372IK8
	 JKVXw3zago36GWUPKJPU2eiXhCDWsj4T59SFBYBpFRSHe0vyjd1pmkbP8VGAKelwKO
	 hkQD420d5M/sIgaDGkh/DOUzfgHhrdgA/EtPgsWahXzNMGP83HaW8ykmcBpKKwFCGj
	 7G+gwDyCDMyXNq1M6sdAX54cFaRK7HgN/TFJ/xj+HiLsvHwyb826RP4vtMuLUJDUua
	 npQ61eQx1gVDw==
Date: Wed, 21 May 2025 15:35:04 -0700
Subject: [PATCHSET 6/6] fuse2fs: better tracking of writable state
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786679193.1385986.6656255712144313017.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

There are multiple mutability variables in play in fuse2fs -- first,
EXT2_FLAG_RW tracks whether or not we can write anything to the
filesystem.  However, there's a second state, which is whether or not
we actually want to write to the filesystem, regardless of the library
state.  This can happen if we open libext2fs for writing, but then
discover something about the filesystem that makes us not want to write
to it after all.

Split out this second variable into an explicit variable in fuse2fs.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-writability
---
Commits in this patchset:
 * fuse2fs: pass a struct fuse2fs to fs_writeable
 * fuse2fs: track our own writable state
---
 misc/fuse2fs.c |   41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)


