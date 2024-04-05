Return-Path: <linux-ext4+bounces-1902-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0D1899F78
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Apr 2024 16:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8583B2840DB
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Apr 2024 14:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26ADE16EBE8;
	Fri,  5 Apr 2024 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hZhCit3V"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE5E16EBEE
	for <linux-ext4@vger.kernel.org>; Fri,  5 Apr 2024 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327053; cv=none; b=n/jRHTjb5LE2UDbNdTcaffGyNkOXCHaJgd7QmwN+SrAnvhSSKkfLUGeChOT5nyobPFRcGhHeqRZOFm9EUC4q6/mhXkuBnxuJuIQ0lglAUgf2AgQJATXcbvDgke2dSIMhaL+QRwxpthEpC0l9qst6ld3Uidn8tSCme8UGsgG8DzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327053; c=relaxed/simple;
	bh=wKemBMY8CuyogRcNlPvt0OFO7viiLuThmcGKiyyXoxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8q4mYe51p41z6d2x+a7H3gQCTcLTCZdtjvjEwbdDFeHMe9Gn2iTMUUtng9x1LhnCWMZfDHTPGlzbP1f8s78UXYN1XLTqYB7qDCA1vBlXLjMDSiQbrqwuCbqRugETmFZk9AYt9ts6mxrJbLKz52Z+TBdKbMZcXmyFY64Zvu0gYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hZhCit3V; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712327050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uu4jMZtAqF2jfhYct7x3/bM+bfcCRqhTVsT6Ei2gC34=;
	b=hZhCit3Vo4gDHENYXY9ESLPtdCnJSftmsDb5g/GgMaCBUehQQ4aXttHnz7A2uOOYiEs/c3
	Ij/M27SUs/di16mBXFXs83UtDI18VWbkoAFpZ5qrpdlVAmUvtW6Q1lK7+UNr3/Gk9e4FeD
	NaMHfN4KqjX9BgXMWchjMid9WZmeJtk=
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH v3 3/4] tests: new test to check quota after directory optimization
Date: Fri,  5 Apr 2024 15:24:04 +0100
Message-ID: <20240405142405.12312-4-luis.henriques@linux.dev>
In-Reply-To: <20240405142405.12312-1-luis.henriques@linux.dev>
References: <20240405142405.12312-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This new test validates e2fsck by verifying that quota data is updated after a
directory optimization is performed.  This issue was initially found by fstest
ext4/014, and this test was based on it.  It includes a filesystem image where
the lost+found directory is unlinked after a new link to it is created:

  # debugfs -w -R "ln lost+found foo" f_testnew/image
  # debugfs -w -R "unlink lost+found" f_testnew/image

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 tests/f_quota_shrinkdir/expect.1 |  18 ++++++++++++++++++
 tests/f_quota_shrinkdir/expect.2 |   7 +++++++
 tests/f_quota_shrinkdir/image.gz | Bin 0 -> 10761 bytes
 tests/f_quota_shrinkdir/name     |   1 +
 4 files changed, 26 insertions(+)
 create mode 100644 tests/f_quota_shrinkdir/expect.1
 create mode 100644 tests/f_quota_shrinkdir/expect.2
 create mode 100644 tests/f_quota_shrinkdir/image.gz
 create mode 100644 tests/f_quota_shrinkdir/name

diff --git a/tests/f_quota_shrinkdir/expect.1 b/tests/f_quota_shrinkdir/expect.1
new file mode 100644
index 000000000000..e4fc48ea6f90
--- /dev/null
+++ b/tests/f_quota_shrinkdir/expect.1
@@ -0,0 +1,18 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+/lost+found not found.  Create? yes
+
+Pass 3A: Optimizing directories
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+[QUOTA WARNING] Usage inconsistent for ID 0:actual (3072, 3) != expected (13312, 2)
+Update quota info for quota type 0? yes
+
+[QUOTA WARNING] Usage inconsistent for ID 0:actual (3072, 3) != expected (13312, 2)
+Update quota info for quota type 1? yes
+
+
+test_filesys: ***** FILE SYSTEM WAS MODIFIED *****
+test_filesys: 12/256 files (16.7% non-contiguous), 1145/8192 blocks
+Exit status is 1
diff --git a/tests/f_quota_shrinkdir/expect.2 b/tests/f_quota_shrinkdir/expect.2
new file mode 100644
index 000000000000..fcb2cb81441e
--- /dev/null
+++ b/tests/f_quota_shrinkdir/expect.2
@@ -0,0 +1,7 @@
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 12/256 files (16.7% non-contiguous), 1145/8192 blocks
+Exit status is 0
diff --git a/tests/f_quota_shrinkdir/image.gz b/tests/f_quota_shrinkdir/image.gz
new file mode 100644
index 0000000000000000000000000000000000000000..1fee3ca9c9b4cb61974be54b063c8f9e1ba49da1
GIT binary patch
literal 10761
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

literal 0
HcmV?d00001

diff --git a/tests/f_quota_shrinkdir/name b/tests/f_quota_shrinkdir/name
new file mode 100644
index 000000000000..8772ae5c814b
--- /dev/null
+++ b/tests/f_quota_shrinkdir/name
@@ -0,0 +1 @@
+update quota on directory optimization

