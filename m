Return-Path: <linux-ext4+bounces-7812-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8433AB4B11
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 07:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43D5B7ADEE8
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 05:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FFD1E5B6A;
	Tue, 13 May 2025 05:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDTj3BBv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764F81DDA1B
	for <linux-ext4@vger.kernel.org>; Tue, 13 May 2025 05:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747114734; cv=none; b=M/tiH53chmHHb4CYk104K2R0I+/W3/3siC6rv1Q+9tNpWztpdfDYdSsxVNusmb8tUM50XTiHrxvOCtckDBsdHjQv3T831OJWjYPIiZ32I9WTXK3O7hATBYEMr3qHI3o3fvyvSFfR1YlzjLxjfHjfEo4QiWmhr2l1MJo/9Dr8c/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747114734; c=relaxed/simple;
	bh=DYjA0ovWAOW4O37nzwjhU5+3HWRp+aK+dQ+/O5M8vCQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=pS1djjEj2M594M2UD+oFjk2p7E+Z+1kHMKFJ7HyXajyxeoMfC67B1MQ8v/hukG6TK0u87+yKkr76I//QbCY8U3uU8drx0HS9jW4dAhxV3JdNm6E3yDZbATC1eSS4oFuHzBH2i1CxmIOr91dMI95YTZ7hPpBs36YIsTwtiBWzUGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDTj3BBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96ABC4CEE4
	for <linux-ext4@vger.kernel.org>; Tue, 13 May 2025 05:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747114733;
	bh=DYjA0ovWAOW4O37nzwjhU5+3HWRp+aK+dQ+/O5M8vCQ=;
	h=From:To:Subject:Date:From;
	b=JDTj3BBvXwIyqtz8pqPJ1GdBPdGIbqQObsKh8o057G0sghMjHs6xL0Skj4dZ/6uUK
	 QC7nIVlSsGLOybwP6Yg78YPF+qKquz+faFfn23iBCtKeHq23T94L9xeZ/IHD9l8Ae3
	 m+0oHh+jRxKYtcxsjTX8iAdA1wMFC3EEnP9ccMwx9L89KRo2I4rd8uEBBcJPf5NaRZ
	 ESPHeqtBbmBrE9YyXHLtx8/F0lIbIXfsywquB80kHPmDzMxLXMPv7dUocGkCSlX0T8
	 gdl8kMvHXOsVmylMN6KBNhf/CB853OFYCxHna7Z6CVM7dyDwCSZg7NC07PlyJ5HpFB
	 e4sNfBD5DIOVQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-ext4@vger.kernel.org
Subject: [PATCH 0/4] ext4,jbd2: clean up unused arguments to checksum functions
Date: Mon, 12 May 2025 22:38:05 -0700
Message-ID: <20250513053809.699974-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since ext4_chksum() and jbd2_chksum() now call crc32c() directly, they
no longer use their ext4_sb_info and journal_t arguments.  Remove these
unnecessary arguments.  No functional changes.

Eric Biggers (4):
  ext4: remove sbi argument from ext4_chksum()
  ext4: remove sb argument from ext4_superblock_csum()
  jbd2: remove journal_t argument from jbd2_chksum()
  jbd2: remove journal_t argument from jbd2_superblock_csum()

 fs/ext4/bitmap.c      |  8 ++++----
 fs/ext4/ext4.h        |  6 ++----
 fs/ext4/extents.c     |  3 +--
 fs/ext4/fast_commit.c | 10 +++++-----
 fs/ext4/ialloc.c      |  5 ++---
 fs/ext4/inode.c       | 19 ++++++++-----------
 fs/ext4/ioctl.c       |  8 ++++----
 fs/ext4/mmp.c         |  2 +-
 fs/ext4/namei.c       | 10 ++++------
 fs/ext4/orphan.c      | 13 ++++++-------
 fs/ext4/resize.c      |  2 +-
 fs/ext4/super.c       | 22 ++++++++++------------
 fs/ext4/xattr.c       | 10 +++++-----
 fs/jbd2/commit.c      |  6 +++---
 fs/jbd2/journal.c     | 14 +++++++-------
 fs/jbd2/recovery.c    | 10 +++++-----
 include/linux/jbd2.h  |  3 +--
 17 files changed, 69 insertions(+), 82 deletions(-)

base-commit: 94824ac9a8aaf2fb3c54b4bdde842db80ffa555d
-- 
2.49.0


