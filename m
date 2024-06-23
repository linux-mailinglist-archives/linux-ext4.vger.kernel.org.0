Return-Path: <linux-ext4+bounces-2925-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A965A913A6C
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Jun 2024 14:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD1741C20BC0
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Jun 2024 12:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C710A18133A;
	Sun, 23 Jun 2024 12:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nc3w/KqH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FC2180A98;
	Sun, 23 Jun 2024 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719144685; cv=none; b=rWiYTlwWamZHQmeZWpugKvStvH7zX1svcwW1rSMpmXjVQewRQh8JGSncfCX3e6k4mHsE9nvUSgiGPWn3ycPXdyabsSSROrN3u3c+AwcEV+GdOagxznY+SAbIslt4L2MiQVddBojujMJV90GQHk7cmEypAM2eB9har3zpQHCUaEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719144685; c=relaxed/simple;
	bh=R5//j9toUb8XanQFv6D4pUel44h1sm9ZtNqaI7X1mE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbt4Nc3EPqDowvqm9cNUTL1RZ7jHIyl/BBnpRima8pp/MIfkSyOYqLij7aI9jI7b7WTo3UuT5M43qbhlZTPXWoDPzo2vRqvj/iTGLg+tvzhUUr5wBZC1p5EI+noaVqUHj0A61ucPYq9iKpONcO2M6YNHqrLKgoWeY8BK3kTWViE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nc3w/KqH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XqKaXtmEF1xYp9b9MfCLVponyCLwmAX9/MlT3ziYY6g=; b=nc3w/KqHjzzOthFbUdm7nD4Ltn
	S98WWNbhoMkcpqkoabV3lR9G6uH80w/Uk8IIec9DxetaYYdOg8PZRtkGk+9QoWnqxGmYIS04BmYOZ
	lWCy5sGkcHi+qBvn78rdWIVni8jI+uTDDf/pIss/NAb43HZnyEzMmuaYYNmCKBfweAR+2F9aeQIXn
	sBRGoVLJCq10Q730FsLoXUvyOgZOl9gH12RQfxV5mCpN4AEw5lzTdsiKV5iQ37XAB29lSVjbSyY0c
	OtcVHCmFbuAyrAw4ydiF/qyUYGVch7tI64DmoUU6lLrwU2HlaSolYEcWQVbRaY0RkYKNSB/u0JpCD
	8O1hCFqg==;
Received: from 2a02-8389-2341-5b80-9456-578d-194f-dacd.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9456:578d:194f:dacd] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLM43-0000000Dwyx-0NXY;
	Sun, 23 Jun 2024 12:11:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org,
	"Theodore Ts'o" <tytso@mit.edu>,
	linux-ext4@vger.kernel.org
Subject: [PATCH 6/8] generic/745: rework support fs checking
Date: Sun, 23 Jun 2024 14:10:35 +0200
Message-ID: <20240623121103.974270-7-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623121103.974270-1-hch@lst.de>
References: <20240623121103.974270-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

To prepare for deprecating _supported_fs use a case statement and
_notrun.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/745 | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tests/generic/745 b/tests/generic/745
index 0f47f9c69..bed43578a 100755
--- a/tests/generic/745
+++ b/tests/generic/745
@@ -27,16 +27,21 @@ _cleanup()
 . ./common/dmflakey
 . ./common/attr
 
-# real QA test starts here
+_require_scratch
+_require_dm_target flakey
+_require_attrs
 
 # We create a lot of xattrs for a single file. Only btrfs and xfs are currently
 # able to store such a large mount of xattrs per file, other filesystems such
 # as ext3/4 and f2fs for example, fail with ENOSPC even if we attempt to add
 # less than 1000 xattrs with very small values.
-_supported_fs btrfs xfs
-_require_scratch
-_require_dm_target flakey
-_require_attrs
+case "$FSTYP" in
+btrfs|xfs)
+	;;
+*)
+	_notrun "Requires support for > 1000 xattrs"
+	;;
+esac
 
 _scratch_mkfs >> $seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
-- 
2.43.0


