Return-Path: <linux-ext4+bounces-8078-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B999AABFF99
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1643A9C0A
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF64239E9B;
	Wed, 21 May 2025 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBwpcRkv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B5423958D
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866900; cv=none; b=J/FTLWLI30tV8/k2d5JSTXCzoV3zyfLGxY/dpZl5uZRyFV2dE8cSCQLKn5a3txPPfjcraiBWTZC7Qje7YVO1uaz24iFI59ytjkSFWwKLMr1EYTew9vnr3R9Nvvexh0wtbPaxGS99cf478eKj+DTR5mHXMPdKDeaNgBlaSN1FZLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866900; c=relaxed/simple;
	bh=fUe8zw70F4EXpHMPN+KgQWNCLoAPk3aoL3+NL4awvbs=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=OyP3nwwlaFTMzi1sx1YhDWIsBbbsBhiBiv3/fVzYjteQ9jYZg18Qj+bPNEKW0ohRLULlG03z4lVd9e0KjjihS+OGzaV8Zprzeuow90jXpyjxVQDyf3H4m1h+DUIKGCE5biXBq1U9FevGT8cHS3zdtK2uPCKcS2fxMQsjfqJcVLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBwpcRkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19ADC4CEE4;
	Wed, 21 May 2025 22:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747866899;
	bh=fUe8zw70F4EXpHMPN+KgQWNCLoAPk3aoL3+NL4awvbs=;
	h=Date:Subject:From:To:Cc:From;
	b=vBwpcRkvC6Xq8vNM9sH/nwvAoPGJ5PdrgspDnhTwVxDzbw3pvaM4u2r+bP89ziRhu
	 HWAJknFEPR8H36TL2ELJTGY/VyqUTYR0Bm3ES09IW61L69pC1XRfNjYyLMvHx6DI69
	 Aue9Dr6zsUZCkHoFDdgoWgyh23gUi4J4N4OjhRWH7E3I5D+DObEh+wm4vTQMucokxr
	 knzC7Qy3gODNWiDQ2o7e7fkg2d6DOTfEmGxDgOXRT9SVKkE7F5Ujn9Txq1TleMzaHG
	 1KndUivrFlv+eVOk3M1I/9S7bj2dfxzmGD5kRhyIHvJXSJ/Tpvw19LV6miHV4uPsO/
	 jAsnf9dWphwFw==
Date: Wed, 21 May 2025 15:34:59 -0700
Subject: [PATCHSET 5/6] fuse2fs: improve operation tracing
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678990.1385778.5352134289344525189.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This series improves the ability for developers to trace the activities
of fuse2fs by adding more debugging printfs and tracing abilities of
fuse2fs.  It also registers a com_err handler for libext2fs so we can
capture errors coming out of there, and changes filesystem error
reporting to tell us the function name instead of just fuse2fs.c.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-tracing
---
Commits in this patchset:
 * fuse2fs: register as an IO flusher thread
 * fuse2fs: hook library error message printing
 * fuse2fs: log all errors being sent to libfuse
 * fuse2fs: print the function name in error messages, not the file name
---
 configure       |   37 +++++++++++++++++++
 configure.ac    |   19 ++++++++++
 lib/config.h.in |    3 ++
 misc/fuse2fs.c  |  109 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 161 insertions(+), 7 deletions(-)


