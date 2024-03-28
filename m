Return-Path: <linux-ext4+bounces-1768-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F327889072C
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Mar 2024 18:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AB41B2216F
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Mar 2024 17:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E7881751;
	Thu, 28 Mar 2024 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QlomeoeT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CF37E115
	for <linux-ext4@vger.kernel.org>; Thu, 28 Mar 2024 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711646988; cv=none; b=BV6pXOu4iiLbKNeAJvusaKeoWfP2djYxd1Zfj6HYrs9xd4d2Qa9gtQH5jq/0nHYxmP6QIh78rsR8KlCZjEltv7Lnuqyl5tAGP8V5YUTtqy5nhiJ8ucZIOWwLTPVI8CmFsAqzUGi+Ifh5ZuUJDX1vEV7sYN0+piO9JZoiEf9xHvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711646988; c=relaxed/simple;
	bh=qUAamefM6ZUmnmlScGs1W0h/IiJRr10AeQs0Ofy+edg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVU/lxrP6vozFA7Ugca6H6jLwV82k6PXoPSVGyvF8bzrZJqYbcawagwbifrn4F4dsuDPNWsG373Kv3igh09Bktled3ufiaJ1JwPCLHebg6uDEm0ZL/HB1YpTJ46KsKyAi9RuDxh+fDvwrJ+Ub/kROxx1xu/hWXiZBXtsr7EJw1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QlomeoeT; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711646984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vexROfUgZbp9joWEGcKEkiLDV8xtcwtsPBPisRYUDBA=;
	b=QlomeoeTry+9JLk+0RL64plx/pL+ORy66x70Td+sLVykqhvoVZ6dsL0jZWmqP1i0MCODHv
	zurwbzVFTi9ru55WVi/93lyzSXUTzhVOwqQjhyJcodch5hq/EITI9A6lRPEHD170luZh5r
	k044OWgyCGFqdcgdwaC6sY5H+KowSGU=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH 3/4] tests: new test to check quota after directory optimization
Date: Thu, 28 Mar 2024 17:29:39 +0000
Message-ID: <20240328172940.1609-4-luis.henriques@linux.dev>
In-Reply-To: <20240328172940.1609-1-luis.henriques@linux.dev>
References: <20240328172940.1609-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This new test validates e2fsck by verifying that quota data is updated after a
directory optimization is performed.  It mimics fstest ext4/014 by including a
filesystem image where a file is created inside a new directory on the
filesystem root and then root block 0 is wiped:

  # debugfs -w -R 'zap -f / 0' f_testnew/image

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 tests/f_quota_shrinkdir/expect.1 |  40 +++++++++++++++++++++++++++++++
 tests/f_quota_shrinkdir/expect.2 |   7 ++++++
 tests/f_quota_shrinkdir/image.gz | Bin 0 -> 11453 bytes
 tests/f_quota_shrinkdir/name     |   1 +
 4 files changed, 48 insertions(+)
 create mode 100644 tests/f_quota_shrinkdir/expect.1
 create mode 100644 tests/f_quota_shrinkdir/expect.2
 create mode 100644 tests/f_quota_shrinkdir/image.gz
 create mode 100644 tests/f_quota_shrinkdir/name

diff --git a/tests/f_quota_shrinkdir/expect.1 b/tests/f_quota_shrinkdir/expect.1
new file mode 100644
index 000000000000..812fe44b887d
--- /dev/null
+++ b/tests/f_quota_shrinkdir/expect.1
@@ -0,0 +1,40 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Directory inode 2, block #0, offset 0: directory corrupted
+Salvage? yes
+
+Missing '.' in directory inode 2.
+Fix? yes
+
+Missing '..' in directory inode 2.
+Fix? yes
+
+Pass 3: Checking directory connectivity
+'..' in / (2) is <The NULL inode> (0), should be / (2).
+Fix? yes
+
+Unconnected directory inode 11 (was in /)
+Connect to /lost+found? yes
+
+/lost+found not found.  Create? yes
+
+Unconnected directory inode 12 (was in /)
+Connect to /lost+found? yes
+
+Pass 3A: Optimizing directories
+Pass 4: Checking reference counts
+Inode 11 ref count is 3, should be 2.  Fix? yes
+
+Inode 12 ref count is 3, should be 2.  Fix? yes
+
+Pass 5: Checking group summary information
+[QUOTA WARNING] Usage inconsistent for ID 0:actual (4096, 5) != expected (14336, 4)
+Update quota info for quota type 0? yes
+
+[QUOTA WARNING] Usage inconsistent for ID 0:actual (4096, 5) != expected (14336, 4)
+Update quota info for quota type 1? yes
+
+
+test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
+test_filesys: 14/256 files (14.3% non-contiguous), 1146/8192 blocks
+Exit status is 1
diff --git a/tests/f_quota_shrinkdir/expect.2 b/tests/f_quota_shrinkdir/expect.2
new file mode 100644
index 000000000000..814f84a54fd6
--- /dev/null
+++ b/tests/f_quota_shrinkdir/expect.2
@@ -0,0 +1,7 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 14/256 files (14.3% non-contiguous), 1146/8192 blocks
+Exit status is 0
diff --git a/tests/f_quota_shrinkdir/image.gz b/tests/f_quota_shrinkdir/image.gz
new file mode 100644
index 0000000000000000000000000000000000000000..753774f6a11f8a60fdbdf2ce205e64a36d753893
GIT binary patch
literal 11453
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
Z|MrZm3H(16$j;kv=2v{eh7H*p{tBVyta$(c

literal 0
HcmV?d00001

diff --git a/tests/f_quota_shrinkdir/name b/tests/f_quota_shrinkdir/name
new file mode 100644
index 000000000000..8772ae5c814b
--- /dev/null
+++ b/tests/f_quota_shrinkdir/name
@@ -0,0 +1 @@
+update quota on directory optimization

