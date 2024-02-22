Return-Path: <linux-ext4+bounces-1364-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFA585FD25
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 16:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC041282A97
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 15:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C6214F9FD;
	Thu, 22 Feb 2024 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bqGt0Nsu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1EE14E2EE
	for <linux-ext4@vger.kernel.org>; Thu, 22 Feb 2024 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617293; cv=none; b=FzDtsf5rmn/w3DNht6+EgJ7I6p1joH9rXPIaYPbH34vcBYDjlR5c5sMLTcTG6xhpOpaWezT+VIjcho39Uglq2Z29qxubBGtrNIz+gAZHr4JOJI+zY5WSH3G523AfaekDYdUqxLMrHf4Yr1wq1xUzTysUP/6KOj+cSOQDge5qmRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617293; c=relaxed/simple;
	bh=yOAwOJvsUlx20Jyx84l2CmAseJwCelehXibIteCw3bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tia4voHIfgmwf6Mpwi9arCGFXOJP9xhS6ZP9z/cnmTne6V3KvKSoxj6pHBbLJmqlysYrkYL+hRw+9nUJSXofPYIs77i0CM0xWqCNGkAy18y7dvyNMKAk+FD7/ynz2ger42UN/ZGyABx4xrJFcanGwsgnMdaRXwQBpzwybh9Ih6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bqGt0Nsu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-102-198.bstnma.fios.verizon.net [173.48.102.198])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 41MFseFr030785
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 10:54:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1708617281; bh=l+zsidX5lYKr7UKh5z7+xWH5p/iDx2oF+97//X4PKUQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=bqGt0NsupNIFMryXwwvqNNsRhz4r5ctGhL+aGNIsOEbhwFxW/sV0lVV7qm9GAc+AG
	 ebFTdyLOBs4AyqAB+Se5Yb04onNEMNTMjoWwWQcpCAKmp6Q46tvcFVDM9F2mHmBTnJ
	 Lo7fdQFs00m0fdP4fudziTqY1iEEtS7c5IC/Q9UOOtc2ZtksSLF0k0nRjT24fNmBy/
	 FN42h5f5sbTGzM8JBN42iJC0n0vfWz23+1GDpzL+qdN8+zebGtPO3gK5ClYop2nTy1
	 ssl4JP/+X6mIVGkPPd8GBpLHyzHZwmu9DYHE5ecComJnSpjMe9MbQxpiEZ00Po3LOU
	 G9bEumrr1nvSw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 32AAC15C0336; Thu, 22 Feb 2024 10:54:40 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/3] ext4: Create EA inodes outside of buffer lock
Date: Thu, 22 Feb 2024 10:54:28 -0500
Message-ID: <170861726753.823885.13307584683621806125.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240209111418.22308-1-jack@suse.cz>
References: <20240209111418.22308-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 09 Feb 2024 12:20:58 +0100, Jan Kara wrote:
> ext4_xattr_set_entry() creates new EA inodes while holding buffer lock on the
> external xattr block. This is problematic as it nests all the allocation
> locking (which acquires locks on other buffers) under the buffer lock. This can
> even deadlock when the filesystem is corrupted and e.g. quota file is setup to
> contain xattr block as data block as syzbot has spotted. This series moves
> the allocation of EA inode to happen outside of the buffer lock which is
> generally more sensible and also fixes the syzbot reproducer.
> 
> [...]

Applied, thanks!

[1/3] ext4: Fold quota accounting into ext4_xattr_inode_lookup_create()
      commit: 8208c41c43ad5e9b63dce6c45a73e326109ca658
[2/3] ext4: Do not create EA inode under buffer lock
      commit: ea554578483b351693923be42bcff139c8023552
[3/3] ext4: Drop duplicate ea_inode handling in ext4_xattr_block_set()
      commit: 72e38f8615148d118ffb82f9055068f8c491c385

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

