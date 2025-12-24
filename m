Return-Path: <linux-ext4+bounces-12505-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3ABCDB435
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Dec 2025 04:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF8873027DA9
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Dec 2025 03:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA72E313E0D;
	Wed, 24 Dec 2025 03:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="UhFNLfUO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB172E9EDA;
	Wed, 24 Dec 2025 03:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766546998; cv=pass; b=r5Pcp4bolQK9vnoNY2hkfHiWS85E9KJ5gTHJGQUN/HPK2/R/+b9d1Gbh4Uiudr7zTZXV46wR5Nm2uRfvOageiY1EPPoYjwZShY7S7CtXNibZhutkBHe9wRheKhk3d5H4+LbBBcQ2xYw/w6u/7ghCkiZak9CaDyp6NbMNeyNKyqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766546998; c=relaxed/simple;
	bh=hFr0dR5M1xeCMubpgRA9lYFROYlJXJ19iAjUH/IZrVI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QBbAZv/2v4KMw9gInLwNY+wQ4HwJMLT4Gr7KwWJofETDIrPqmXiDhwRq2xUSXfX6S/Ca9TQS6grGtuga5jYoea7yJsUI6a41gmmGYCB2oveHPTU16HBJth4L1Ny3kk6MBd3VlE6t0tJ5kzpeDcLEDP51dV8+hN+HQ0ZTHlA0/zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=UhFNLfUO; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1766546990; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eeRro6DOcLunveEX5OK0y0Mlj3zzqiCs38gucB1b6MjeVcgKIwanIokibmAAEzzfr7w1/3FXSNMytPeGwLkZPU9atRKV6ZQyi9ugmPB7/9SSVHwgH3NVkxhiyMGACHaDlxvWl8hXioTzUaxPoJACxf+Cwdmg3GnKPMtpFo3n0aw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766546990; h=Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=bMv+8WixTPBRfX1Uk0wyVux8/v5sQ9R2990ZoKvaRFU=; 
	b=nYmEBe7u7HdFkr9XP3aap2fmbXPZL/6OD9+dqrJN/N878ARjb38nKtizO5rHP9YmGhHoYJOETw1a9Q3eFhABV5O/cVSi5jwmIUlhyPkT1ZKPvdjRapXCS/pnHkHD79kCuP8kqDU8xx4v7X92t5iF4o0Mdc0AFduHn8ozwWNAIAQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766546990;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=bMv+8WixTPBRfX1Uk0wyVux8/v5sQ9R2990ZoKvaRFU=;
	b=UhFNLfUOwSgJAglNN8p1a49w/usORqOwwqQ0yyeHyfmu9mFhRGExR0l7k/2pZBJO
	2ZUjdmERhy0rKZzDB53cPZyAl2uVBefq5WtZn5/pEmAEQZCri64gugjJiE1dW9fhl3L
	kXhNDq8odgHBINWE3odIBLrTX4AlFvu7eaazTbXs=
Received: by mx.zohomail.com with SMTPS id 1766546987060969.1966780513108;
	Tue, 23 Dec 2025 19:29:47 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC v3 0/2] ext4: fast commit: fix lockdep issues
Date: Wed, 24 Dec 2025 11:29:40 +0800
Message-ID: <20251224032943.134063-1-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

(This RFC v3 series is based on top of the patch posted at
https://lore.kernel.org/linux-ext4/20251223131342.287864-1-me@linux.beauty/T/#u)

This series fixes two lockdep issues in the ext4 fast commit paths.

1) ext4_fc_track_inode() can return without sleeping when
   EXT4_STATE_FC_COMMITTING is already clear. The lockdep assertion for
   i_data_sem should only fire when we actually go to sleep.

2) lockdep reports a possible deadlock due to lock order inversion
   between s_fc_lock and i_data_sem. The fast commit writer held s_fc_lock
   while writing the fast commit log. Writing the journal inode mapping
   can call ext4_map_blocks() and take i_data_sem, while metadata update
   paths can hold i_data_sem and call ext4_fc_track_inode() which takes
   s_fc_lock.

The fix drops s_fc_lock before the log writing step and uses
EXT4_STATE_FC_COMMITTING to keep inode and create dentry state stable
until cleanup.

Testing:
- QEMU VM, ext4 -O fast_commit on virtio-pmem + dax, verified both lockdep
  report reproduces on an older kernel and is gone with this series.

RFC v2 -> RFC v3:
 - rebase ontop of https://lore.kernel.org/linux-ext4/20251223131342.287864-1-me@linux.beauty/T/#u

RFC v1 -> RFC v2:
 - patch 1: move comments to correct place
 - patch 2: add it to patchset.
 - add missing RFC prefix

RFC v1: https://lore.kernel.org/linux-ext4/20251222032655.87056-1-me@linux.beauty/T/#u
RFC v2: https://lore.kernel.org/linux-ext4/20251222151906.24607-1-me@linux.beauty/T/#t

Li Chen (2):
  ext4: fast_commit: assert i_data_sem only before sleep
  ext4: fast commit: fix s_fc_lock vs i_data_sem inversion

 fs/ext4/fast_commit.c | 96 +++++++++++++++++++++++++++++++------------
 1 file changed, 69 insertions(+), 27 deletions(-)

-- 
2.52.0


