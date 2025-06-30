Return-Path: <linux-ext4+bounces-8717-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48953AEE5AD
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 19:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 691E63BF673
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 17:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F672E4243;
	Mon, 30 Jun 2025 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+dvIOd6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26829293C52;
	Mon, 30 Jun 2025 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751304249; cv=none; b=M7QDTw7mBjQJjo3ov4mddS5xC0M/afAK0JpHHXcYJ94Eb1IqatoawW0iQL6zCjT8Xs4hPhS03VC4JJYcpaXkjr4dOsk8k6dKkgO+uasPT7GVMUmZ0L+Dg7336WyyT5AHKO8oB0pewd4qlzqfnlC43aB1JVSQK1l0ryFVYvZwYMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751304249; c=relaxed/simple;
	bh=2ss1z+u5lNz4mtpxqOkRg3/823azXS0wN/bTXoBHKxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VvUk6Mm1EGawS8AdrImYr4V8PeXHEypalTGQ0lEJatTdZLuJ0XPTYecZV+SCJ6vgXWjeiJ0NlTvP+ITOLUO1UMXFyqQDD0kBSlcCIdvRDbeDEpMXsU6gcc1OugPiJAzSQbOlbtKGVFLsl5QHH9clO0VANYrbJYpTaTMl9UJAVSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+dvIOd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0F1C4CEE3;
	Mon, 30 Jun 2025 17:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751304248;
	bh=2ss1z+u5lNz4mtpxqOkRg3/823azXS0wN/bTXoBHKxY=;
	h=From:To:Cc:Subject:Date:From;
	b=s+dvIOd6tblfiP+FP5N3YqoXcALT9orqIV2/EdJGByixJ+wy2EpolTgjDbQiQBNdC
	 /041gDK/TVoafEDYTGqo/lw91xjV+QIB+hAsyWJK9MOaE7M+vryw0pzRgN7ZWHrq2D
	 fcBnjz2YShIC0Giw0nfbbtQxtontWDOyc9pLKIe4I71FKF4PZ4WPvS6uczM3wQ2q4j
	 pTzaZYjRj98jZg06wWJouMvOpUpGVJhvH0/0USGnxgQCypu1sAr4/nAu5nd8M+aLpi
	 Htk4dm8mQa2CX5FwFpXNOo+P8P5oMwjgZzVze8wdYacN3J2xnCRFfxQn1aKShmLCje
	 3mdc0OzLVjbaA==
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-btrfs@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 0/2] Convert fs/verity/ to use SHA-2 library API
Date: Mon, 30 Jun 2025 10:22:22 -0700
Message-ID: <20250630172224.46909-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series, including all its prerequisites, is also available at:

    git fetch https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git fsverity-libcrypto-v1

This series makes fs/verity/ use the SHA-2 library API instead of the
old-school crypto API.  This is simpler and more efficient.

This depends on my SHA-2 library improvements for 6.17 (many patches),
so this patchset might need to wait until 6.18.  But I'm also thinking
about just basing the fsverity tree on libcrypto-next for 6.17.

Eric Biggers (2):
  lib/crypto: hash_info: Move hash_info.c into lib/crypto/
  fsverity: Switch from crypto_shash to SHA-2 library

 Documentation/filesystems/fsverity.rst |   3 +-
 crypto/Kconfig                         |   3 -
 crypto/Makefile                        |   1 -
 fs/verity/Kconfig                      |   6 +-
 fs/verity/enable.c                     |   8 +-
 fs/verity/fsverity_private.h           |  24 +--
 fs/verity/hash_algs.c                  | 194 +++++++++----------------
 fs/verity/open.c                       |  36 ++---
 fs/verity/verify.c                     |   7 +-
 lib/crypto/Kconfig                     |   3 +
 lib/crypto/Makefile                    |   2 +
 {crypto => lib/crypto}/hash_info.c     |   0
 12 files changed, 107 insertions(+), 180 deletions(-)
 rename {crypto => lib/crypto}/hash_info.c (100%)

-- 
2.50.0


