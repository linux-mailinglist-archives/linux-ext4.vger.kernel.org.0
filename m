Return-Path: <linux-ext4+bounces-12961-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E80FD39825
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Jan 2026 17:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A87293009809
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Jan 2026 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B54221FB6;
	Sun, 18 Jan 2026 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="GHCRGU8c"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F8917A2F0
	for <linux-ext4@vger.kernel.org>; Sun, 18 Jan 2026 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768755132; cv=none; b=MKitT4srb+M1XfPMZgRkEbjf4xWbUS4EAV89xkcyWvYwZSxFJUzRE9cUq00MtmfuIznz9u1++yMg5IT5XPzqt2gnkZ/LOjQvi6+HajEON4wUlboTLJQfWMgGh5iFZAYBocRrZHacAVFljD4MonXZAcRC9MUuFxgiV+pbaAC1XlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768755132; c=relaxed/simple;
	bh=PmIHue3zRQrYZkjC4yA6WZ6enNwD2hckD/7V+Qo7LFY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cPeSJ5AocuJhJXBHm96d03ml925/M36kFMqSLsOWqZfgXiKgYEWaCcYbvbz9IOcLSiwz68InzF+kmZJ75f5BQyA5XHXYPZXVNTIkjyOt1qhGDa01qRmfRWn/ddwxrxw20s5b02PCP4gb/7NxWEqNnvCbwlA+fsxVVczPp83jR0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=GHCRGU8c; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-142.bstnma.fios.verizon.net [173.48.112.142])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 60IGq0e9032267
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Jan 2026 11:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1768755121; bh=CFRC+CmV8PWGQKe+L6+tdpYt5x4zWoNAMVaLq6gACD0=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=GHCRGU8cOGjh9P1mXkyiSxcxKq6/PPYBLnou1NaoYgQr2WrCKnOvb0vWUlqUuFkQP
	 qDMJZ79+dAjOgBjGrq5PjHZI/ROJJb3VpqJYy+baLVBnsrZ+bq1UddSf+T3XlXVKS2
	 wjREGukERDZz53TJu89MU2Ufe/KNXcXoVRRclZiV3seTljFA5GPi+CcDqOFDbMhZ6M
	 6sCqu+tfkN549vmAO7zmqyMTzDySV3K82CQ+n5LgXDKE7yLbdfhTbd3zvYEGuBx/a1
	 xHyf/M4I8hC6Q2ASJn46fcKkBaGj9RL+WFOLhOEAsY316rYAKA3ezMlKjhToGvS55r
	 buhc8CryPrHKA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D6BB72E00D7; Sun, 18 Jan 2026 11:51:59 -0500 (EST)
Date: Sun, 18 Jan 2026 11:51:59 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: [GIT PULL] ext4 fixes for 6.19-rc6
Message-ID: <20260118165159.GA580401@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb:

  Linux 6.19-rc4 (2026-01-04 14:41:55 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.19-rc6

for you to fetch changes up to d250bdf531d9cd4096fedbb9f172bb2ca660c868:

  ext4: fix iloc.bh leak in ext4_xattr_inode_update_ref (2026-01-18 11:23:10 -0500)

----------------------------------------------------------------
Ext4 bug fixes for 6.19:

   * Fix an inconsistency in structure size on 32-bit platforms caused by padding
     differences for the new EXT4_IOC_[GS]ET_TUNE_SB_PARAM ioctls
   * Fix a buffer leak on the error path when dropping the refcount an xattr
     value stored in an inode
   * Fix missing locking on the error path for the file defragmentation ioctl
     leading to a BUG

----------------------------------------------------------------
Arnd Bergmann (1):
      ext4: fix ext4_tune_sb_params padding

Julian Sun (1):
      ext4: add missing down_write_data_sem in mext_move_extent().

Yang Erkun (1):
      ext4: fix iloc.bh leak in ext4_xattr_inode_update_ref

 fs/ext4/move_extent.c     | 2 ++
 fs/ext4/xattr.c           | 1 +
 include/uapi/linux/ext4.h | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

