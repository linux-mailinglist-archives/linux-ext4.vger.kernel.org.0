Return-Path: <linux-ext4+bounces-8076-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9240AABFF97
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7FB63A5908
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A99230269;
	Wed, 21 May 2025 22:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ql8hxJmp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D085F2B9A9
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866888; cv=none; b=a6QNiqn+KxnYLlnExy7IHYvQRznxSyLUU27Aq0UOnA8UHwXeDzcjHHHKrvTOnNwzcfGLUBXGJSlLXLQq2QIZ2oK1Avk7HnLLS+SNkUVtgrkppB9LUhnuX/nE4YhWPBbUenliR8Sud9BmGCjmoMLWsSCNYLSqulDG4Ka0JpQ2hPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866888; c=relaxed/simple;
	bh=mJSokA191aQ8Gn4g8FANyVP3UM1ZziYCsPPnG23/6kE=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=T8gYHrrbqA4Ckp4L5CggO3n4Jpd7Sl+aSLqbx6QHsAE54rQEOWDecTYQGcwq7Wd8eLd9oarv9h7k8/DAspEO9FRCORuvok46Y0mP68h8qex5cng3HAYqFhDkQ4nwJD/etDuxPiLn6cm2641MjUfaK/0faKY12yeF4xroa5WCuFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ql8hxJmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B035C4CEE4;
	Wed, 21 May 2025 22:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747866888;
	bh=mJSokA191aQ8Gn4g8FANyVP3UM1ZziYCsPPnG23/6kE=;
	h=Date:Subject:From:To:Cc:From;
	b=Ql8hxJmpoDH3vDGoWdlrdCNMAWaB0f1pDSD67dKKulexFTc3sNaCoWfpdDqt4ipZq
	 cAttuW8dACIteuiNX8umYArMwm8qD9cBx9FzSD1I4kG9qtyGK5BkS1c2uQQrdj4HAK
	 0uJEM6pFfVu28M1habeNprYNUyyKxaHFxFOKlFlFYQ6sUSNr9g72M/BXduLrXmkKe/
	 b9D0EvNLf+PaJOOjL0pF+LVydLiTUAu9FiNKEHfNAYCtFNDq2L+zD+PYx/qbA+v66L
	 ZpZZctnhQq+h83amX/xombX+xcRQ3gKrGkHfhahkKuNjN8kjIdw7tJYTK/4/Qr/3z0
	 /0njBDuF2ssMw==
Date: Wed, 21 May 2025 15:34:47 -0700
Subject: [PATCHSET 3/6] fuse2fs: add some easy new features
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678371.1385038.908946555361173764.stgit@frogsfrogsfrogs>
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
 * fuse2fs: use file handles when possible
 * fuse2fs: implement dir seeking
 * fuse2fs: implement readdirplus
 * fuse2fs: implement dirsync mode
 * fuse2fs: only flush O_SYNC files on close
 * fuse2fs: improve want_extra_isize handling
 * fuse2fs: cache symlink targets in the kernel
---
 misc/fuse2fs.c |  211 ++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 164 insertions(+), 47 deletions(-)


