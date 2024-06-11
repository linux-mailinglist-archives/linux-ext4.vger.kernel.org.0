Return-Path: <linux-ext4+bounces-2852-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C1F903EB5
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Jun 2024 16:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5060E1C22D1B
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Jun 2024 14:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B933817D896;
	Tue, 11 Jun 2024 14:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RTMCoK7u"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A3D17D37F
	for <linux-ext4@vger.kernel.org>; Tue, 11 Jun 2024 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718116044; cv=none; b=rl1PsnZrponDRPq9DqFwuAmZ25HGX7xUEYpEiS+qzXzWP+7sccMGuscsJ6TCL/q6GWM8omnfXSqsx6wiYdVbAOIedngFHG/1QjBF+9L5+t6mnHKjQINp67n1KDkGtw1VUrngd0vzgzPCLFfYniRM/4ep7lEqdmu1NXXM2AWm/4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718116044; c=relaxed/simple;
	bh=9OVLDd3Yu9UCiziiAvm9ItkzIFw1PjMJSxfOXYmGtgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYGyJhiRk1F/tsU0TO8l+72kKLbPcpfQF7NNMeQzZO5tnMSiGLgePhHyWKlP/sLZXaNrTohhsTU7iAcD1IjqLPI8ACNGqj5YuZ0Ej/BSZJ3IXydizsoDjeQelmoX4LSPVYBPISkHub6AWgTUMoycuD4QDrJE3hxXTb3y8uFywkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RTMCoK7u; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tytso@mit.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718116039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4+a1L/4As5eiy1DYW4abQi34HRzCHFF0qxZs0Epg74=;
	b=RTMCoK7u48V8Bz1WH5IkzQ3kL4iwfxB/0GIA+nZ+uFN8rA+XyAbn60xcbxLvdIZEtptwVB
	lxw8ddt5Ctx/hFZFidgMg3+8w82dGrRw7j8NVIKruHecSuKMnxMa4nKYeL7WD9FzGu4qhy
	WwC1rMewTloGzYFwsuoJZALr6Ne2Nrg=
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: luis.henriques@linux.dev
X-Envelope-To: adilger@dilger.ca
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH 2/2] tests: new test to check that the orphan file is cleaned up
Date: Tue, 11 Jun 2024 15:27:04 +0100
Message-ID: <20240611142704.14307-3-luis.henriques@linux.dev>
In-Reply-To: <20240611142704.14307-1-luis.henriques@linux.dev>
References: <20240611142704.14307-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This test verifies that e2fsck clears the orphan file if it is present.
The filesystem was created by simply creating a bunch of empty files and,
while those files were open by an application, delete some of them in
order to add them to the orphan file.  After this, the filesystem is
simply powered off.  An e2fsck will need to clear the orphaned inodes but
also to clean the orphan file.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 tests/f_clear_orphan_file/expect.1 |  35 +++++++++++++++++++++++++++++
 tests/f_clear_orphan_file/expect.2 |   7 ++++++
 tests/f_clear_orphan_file/image.gz | Bin 0 -> 12449 bytes
 tests/f_clear_orphan_file/name     |   1 +
 tests/f_clear_orphan_file/script   |   2 ++
 5 files changed, 45 insertions(+)
 create mode 100644 tests/f_clear_orphan_file/expect.1
 create mode 100644 tests/f_clear_orphan_file/expect.2
 create mode 100644 tests/f_clear_orphan_file/image.gz
 create mode 100644 tests/f_clear_orphan_file/name
 create mode 100644 tests/f_clear_orphan_file/script

diff --git a/tests/f_clear_orphan_file/expect.1 b/tests/f_clear_orphan_file/expect.1
new file mode 100644
index 000000000000..281b131cbba0
--- /dev/null
+++ b/tests/f_clear_orphan_file/expect.1
@@ -0,0 +1,35 @@
+test_filesys: recovering journal
+Clearing orphaned inode 13 (uid=0, gid=0, mode=0100644, size=0)
+Clearing orphaned inode 14 (uid=0, gid=0, mode=0100644, size=0)
+Clearing orphaned inode 15 (uid=0, gid=0, mode=0100644, size=0)
+Clearing orphaned inode 16 (uid=0, gid=0, mode=0100644, size=0)
+Clearing orphaned inode 17 (uid=0, gid=0, mode=0100644, size=0)
+Clearing orphaned inode 18 (uid=0, gid=0, mode=0100644, size=0)
+Clearing orphaned inode 19 (uid=0, gid=0, mode=0100644, size=0)
+Clearing orphaned inode 20 (uid=0, gid=0, mode=0100644, size=0)
+Clearing orphaned inode 21 (uid=0, gid=0, mode=0100644, size=0)
+Clearing orphaned inode 22 (uid=0, gid=0, mode=0100644, size=0)
+Clearing orphaned inode 23 (uid=0, gid=0, mode=0100644, size=0)
+Clearing orphaned inode 24 (uid=0, gid=0, mode=0100644, size=0)
+Clearing orphaned inode 25 (uid=0, gid=0, mode=0100644, size=0)
+Clearing orphaned inode 26 (uid=0, gid=0, mode=0100644, size=0)
+Clearing orphaned inode 27 (uid=0, gid=0, mode=0100644, size=0)
+Clearing orphaned inode 28 (uid=0, gid=0, mode=0100644, size=0)
+Clearing orphaned inode 29 (uid=0, gid=0, mode=0100644, size=0)
+Clearing orphaned inode 30 (uid=0, gid=0, mode=0100644, size=0)
+Clearing orphaned inode 31 (uid=0, gid=0, mode=0100644, size=0)
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+Free inodes count wrong (2055, counted=2005).
+Fix? yes
+
+Orphan file (inode 12) block 0 is not clean.
+Clear? yes
+
+
+test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
+test_filesys: 43/2048 files (2.3% non-contiguous), 1650/8192 blocks
+Exit status is 1
diff --git a/tests/f_clear_orphan_file/expect.2 b/tests/f_clear_orphan_file/expect.2
new file mode 100644
index 000000000000..f719dbbaad08
--- /dev/null
+++ b/tests/f_clear_orphan_file/expect.2
@@ -0,0 +1,7 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 43/2048 files (2.3% non-contiguous), 1650/8192 blocks
+Exit status is 0
diff --git a/tests/f_clear_orphan_file/image.gz b/tests/f_clear_orphan_file/image.gz
new file mode 100644
index 0000000000000000000000000000000000000000..c93cf754ddbe02dfad966364cc943a3824052cce
GIT binary patch
literal 12449
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
IExNks-^UvQM*si-

literal 0
HcmV?d00001

diff --git a/tests/f_clear_orphan_file/name b/tests/f_clear_orphan_file/name
new file mode 100644
index 000000000000..89ba2247f437
--- /dev/null
+++ b/tests/f_clear_orphan_file/name
@@ -0,0 +1 @@
+clear orphan file
diff --git a/tests/f_clear_orphan_file/script b/tests/f_clear_orphan_file/script
new file mode 100644
index 000000000000..2210e9ddc643
--- /dev/null
+++ b/tests/f_clear_orphan_file/script
@@ -0,0 +1,2 @@
+FSCK_OPT=-y
+. $cmd_dir/run_e2fsck

