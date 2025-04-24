Return-Path: <linux-ext4+bounces-7455-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF679A9B9F5
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9F8468333
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CDE218ACA;
	Thu, 24 Apr 2025 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZpuu6oB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C741F4297
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530710; cv=none; b=X2c+egX1EgfgB0k/O0f0RuSfAkzJYfWrx5l4GPkXkf4W8fi590/N4QJu/ETX70VgGVq1Pw8Ax3zAHBCxO5XQtmP3SDq5xxpEWE/ioQPmsmywOrlPam0JbEJeMy02RcSXe/g0X/UM0kbutDILYeyOZHrfMJZPUna9Z9ld3MEOYEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530710; c=relaxed/simple;
	bh=TPpCcvT06E4jQZSUH7Tjl0fLiErP2nZitdqF6r+tv9g=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=JQzWB4BIcSvTgILECR9n9DZ/Rwd4Yb1MnyaKmh9eq8vUGUijKRUTJ+w4uWW/dpjSUK4hKU4PcWhGLqJy7z7SyYdrdQpsh322ypRB6rgVkuwqMlvXfeGA5SQflSQGu5IJzYhUwkEED3Ce9UnBiElO2fx7asYEYNZK2WSNOwhgy7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZpuu6oB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0845DC4CEE3;
	Thu, 24 Apr 2025 21:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530710;
	bh=TPpCcvT06E4jQZSUH7Tjl0fLiErP2nZitdqF6r+tv9g=;
	h=Date:Subject:From:To:Cc:From;
	b=sZpuu6oBN9CQBAavqMLCxddOy2hgUK0A1ymC83bx7Fuyf0MiB4qIQLANf6xuoXt96
	 x1W+DQl1HkbcqCLI3taZcArJcBJ3R7n36SQRuDAhGbja3C9Ib6/RXwP3+LGn7SmOOu
	 ZvkXpLSQbr3CeSfBc8Eb865yPPtLhgDr5TCob+5OZ1zdfaGwV7omlIkwthA10HP2PX
	 k5Z/OaVQimW0v6eTdPIlCUr9UH1rVSHCrpY3m7JL6uywgFx8RcpCwvdt1ZBAyQMaqx
	 FXZpcKEe9zJ6Eq57tAsS9XQkLH9rbinp8Ok6BFYPSEtVbHT/S30haQlW8amHbILqAe
	 wDAU/h0um81Ng==
Date: Thu, 24 Apr 2025 14:38:29 -0700
Subject: [PATCHSET 1/5] fuse2fs: better logging
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553064436.1160047.577374015997116030.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This series improves logging in fuse2fs by prefixing all messages with
the name of the driver and the device; and ensures that messages are
flusehd immediately.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-logging
---
Commits in this patchset:
 * fuse2fs: enable runtime debugging
 * fuse2fs: stop aliasing stderr with ff->err_fp
 * fuse2fs: use error logging macro for mount errors
 * fuse2fs: make other logging consistent
 * fuse2fs: redirect all messages when FUSE2FS_LOGFILE is set
---
 misc/fuse2fs.c |  253 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 135 insertions(+), 118 deletions(-)


