Return-Path: <linux-ext4+bounces-1857-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 848C08985CB
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 13:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39343285578
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 11:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD94480C09;
	Thu,  4 Apr 2024 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YA2b4pTz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E6C823B0
	for <linux-ext4@vger.kernel.org>; Thu,  4 Apr 2024 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229043; cv=none; b=BZFr4xnk7oCqAkaIdJLOkTsINjlefuyCTbX9T59UjMdfzXqdFw2IcQ+m/7sbIBoUsxNzfVHf/ViMbR1FQxlP7Mzk2bpqw+OeKTZxhqNHzvcLvzzMNTagO1/2Ks3aqOkdI7dGE4Bbn3xeIGMJigS8+O8p04RPPKXqIisItEh4y+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229043; c=relaxed/simple;
	bh=pNAKtrIVYsR9WuMDS7UeRJdP/IFpGkoXl9Ggzowl4Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJvQUUYV4qf1uM2wfIyvuuTx3qPM9pA36iSiAvrOHd1nV31ED8i/34fsmfGFfrH3Ngen81OLDRmXY9rRVXKz42LPp/cVXvwaoUZj7WEdoMKxD3MfNH9SYCCKxCDl+GYK9XrR934JyIvB1oA+40jj95p6SUlwfNGva0cCiWVjtqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YA2b4pTz; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712229039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4d5yxLDZOYtkaoRdt4QlJaQrk8CcY5+L3UcAiDJim3k=;
	b=YA2b4pTzBeeFscLex/cerKQP4HykLMU6FfbUkjk3moyXR1ZUV0GOjtPEwt2Uojs709Slis
	+dBGthk0bBCMTtVjgMoVfc3hx0JLuo9TVaR2UmgOrrSZ2YeNJFbBBqgntZl08yiZcowPRC
	bN1eWn2+H2WdFrZ422aTTz8iR5kKEJ4=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH v2 4/4] tests: new test to check quota after a bad inode deallocation
Date: Thu,  4 Apr 2024 12:10:32 +0100
Message-ID: <20240404111032.10427-5-luis.henriques@linux.dev>
In-Reply-To: <20240404111032.10427-1-luis.henriques@linux.dev>
References: <20240404111032.10427-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This new test validates e2fsck by verifying that quota is updated after a bad
inode is deallocated.  It mimics fstest ext4/019 by including a filesystem image
where a symbolic link was created to an existing file, using a long symlink
name.  This symbolic link was then wiped with:

  # debugfs -w -R 'zap -f /testlink 0' f_testnew/image

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 tests/f_quota_deallocate_inode/expect.1 |  18 ++++++++++++++++++
 tests/f_quota_deallocate_inode/expect.2 |   7 +++++++
 tests/f_quota_deallocate_inode/image.gz | Bin 0 -> 11594 bytes
 tests/f_quota_deallocate_inode/name     |   1 +
 4 files changed, 26 insertions(+)
 create mode 100644 tests/f_quota_deallocate_inode/expect.1
 create mode 100644 tests/f_quota_deallocate_inode/expect.2
 create mode 100644 tests/f_quota_deallocate_inode/image.gz
 create mode 100644 tests/f_quota_deallocate_inode/name

diff --git a/tests/f_quota_deallocate_inode/expect.1 b/tests/f_quota_deallocate_inode/expect.1
new file mode 100644
index 000000000000..2b2f128dbb57
--- /dev/null
+++ b/tests/f_quota_deallocate_inode/expect.1
@@ -0,0 +1,18 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Symlink /testlink (inode #14) is invalid.
+Clear? yes
+
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+[QUOTA WARNING] Usage inconsistent for ID 0:actual (15360, 4) != expected (16384, 5)
+Update quota info for quota type 0? yes
+
+[QUOTA WARNING] Usage inconsistent for ID 0:actual (15360, 4) != expected (16384, 5)
+Update quota info for quota type 1? yes
+
+
+test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
+test_filesys: 13/256 files (15.4% non-contiguous), 1157/8192 blocks
+Exit status is 1
diff --git a/tests/f_quota_deallocate_inode/expect.2 b/tests/f_quota_deallocate_inode/expect.2
new file mode 100644
index 000000000000..802317949959
--- /dev/null
+++ b/tests/f_quota_deallocate_inode/expect.2
@@ -0,0 +1,7 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 13/256 files (15.4% non-contiguous), 1157/8192 blocks
+Exit status is 0
diff --git a/tests/f_quota_deallocate_inode/image.gz b/tests/f_quota_deallocate_inode/image.gz
new file mode 100644
index 0000000000000000000000000000000000000000..798a72c3a0da0323fc55c5e034f778e967394c81
GIT binary patch
literal 11594
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

literal 0
HcmV?d00001

diff --git a/tests/f_quota_deallocate_inode/name b/tests/f_quota_deallocate_inode/name
new file mode 100644
index 000000000000..396887c16f84
--- /dev/null
+++ b/tests/f_quota_deallocate_inode/name
@@ -0,0 +1 @@
+update quota when deallocating bad inode

