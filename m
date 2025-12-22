Return-Path: <linux-ext4+bounces-12475-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C051DCD682C
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Dec 2025 16:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 841673096230
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Dec 2025 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04E8324B16;
	Mon, 22 Dec 2025 15:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="M4bomEHu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F01B425C;
	Mon, 22 Dec 2025 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416764; cv=pass; b=GJMB22g25Q233+yvsNUzjhNvtGFFZzPqqspjxda42RC+5c+9JocxDgpHZmKFLGmSbckBUdG7GJJ83Gc2iCiCUPjzblaXKNydZ+PINnZ8mgVaPg/HVVqCusPHgpfoT8DYFrnpihKrL9fBwoIVQAKCRVjth8/fsho0UMQshjtcp0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416764; c=relaxed/simple;
	bh=9slh+yTyYfyOsnERXC/xiUSQfHSfi34nvlHhjX9hvPs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IB+JR87jeMxiDuJLas2X+LgErNHBfY4DzRjzqXPPGGZ8JMY3z8qA8p6t8IDtTEtuIQmYQd8Co9k9NZAfEFZ4pV8JGJ9ItXHiPzr39T2bbW534zGznpngDLNTV1EMul/FoZkQ2d+yohNzk892uNhqgilcK/OV5g8vTX/4rLG5oNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=M4bomEHu; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1766416758; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BXmp86MO2L422y8iQfUGQGZ6rvX6uuoLN0VxCc1D9XOjtapR+3Xq7kMlMs+ApaqufYwPnFwVy+MnKmUNBw+aS1lUu0KXD5irvQ6ayFHdYLUxXVYQjw7NZnZ0OaEFZy0ZI0rYTt9w8//4RVbC2Yjro/z7949LDkhLMniND9fYV1k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766416758; h=Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=Y3ySZggD1t92+2NuJmwV+ZrhvF4Tj8vnoXwkGfJFrxI=; 
	b=cjjrwzSMBGTn8dYmiIZNJQkM9lli2rq/K/lLECgIDc70sZjvUasaE/qMLM+Bhgbt8KnpRTwhf9b1UMbKP4fn78/0pTNhDZJrfyKu0ZJ3MB8z5eZ08fP6J0DoiP7g2XgGRewex4wuZkWUo9T85JR41on4SwON6I1YgES3MYUpfqA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766416758;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=Y3ySZggD1t92+2NuJmwV+ZrhvF4Tj8vnoXwkGfJFrxI=;
	b=M4bomEHuEiX7wbgilDXP7WDp1X/7A4KGz+dw8SxYTAzltwHt2nDqW1YxL9fpJGhR
	zqAXRNpiRgRH3Ki7U5IOlEmHcyQWBmTXb2qxcl/FEOJ/VxuOHcKR15qLLBDfWi2wBvn
	00kE/IX4jDKo+XjHa3bMmJsOFDwE9qoPdIm/u/QU=
Received: by mx.zohomail.com with SMTPS id 1766416756601165.74241964251075;
	Mon, 22 Dec 2025 07:19:16 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/2] ext4: fast commit: fix lockdep issues
Date: Mon, 22 Dec 2025 23:19:04 +0800
Message-ID: <20251222151906.24607-1-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

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

RFC v1 -> RFC v2:
 - patch 1: move comments to correct place
 - patch 2: add it to patchset.
 - add missing RFC prefix

RFC v1: https://lore.kernel.org/linux-ext4/20251222032655.87056-1-me@linux.beauty/T/#u

Li Chen (2):
  ext4: fast_commit: assert i_data_sem only before sleep
  ext4: fast commit: fix s_fc_lock vs i_data_sem inversion

 fs/ext4/fast_commit.c | 96 +++++++++++++++++++++++++++++++------------
 1 file changed, 69 insertions(+), 27 deletions(-)

-- 
2.51.0


