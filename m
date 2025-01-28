Return-Path: <linux-ext4+bounces-6253-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DCEA204F2
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2025 08:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716791887FA4
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2025 07:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DB51DC992;
	Tue, 28 Jan 2025 07:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="flJ1ulaw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2141F192D84;
	Tue, 28 Jan 2025 07:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738048404; cv=none; b=cnvdrNWCGeGPs4iCv9sOHkMxSXSudpbHVTC0ZeL5QC4N5TTdMx4tCB6afgxPsOQZeRA+I4gPmb/zyZEnDuI/uxGhPHkfFwlJY7lZ0PmheCwFpeGGJcor6+iAG6TStbESVZaEg35S2S10pKlJFC6qeygnbd4NhKLhDcXUtEPAZmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738048404; c=relaxed/simple;
	bh=nG8G6X1pk/btilD4mER50RQ1ffbc2wig3W0MgVzfpm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+lsb8vgVZQgA90NT+shBWHgGfN1sGCXwEUO1dG+oxkyp8Szcx7aF2dJWBM2lGjCDHjit53SuuDADmWEwTfAhMJExvAmOHbsr9JhnOchuCa8z66d6Vi3P/nd1M9CUtwdMGCADK9meT4F3+bYWU5zbA9EKNDB5Wjuuod772aUJ8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=flJ1ulaw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MQN+Vq4VN8+umBc/NdH4tEB4seNMP/MtBS7wkjrRyuk=; b=flJ1ulawZy6p771hmkMdQ1KjAO
	apZ+FDxqtunZu2nKHheewRjqsZ96uFO6iGMg2RA+x1PC4TQNE4viPmolNao/M1Wa/DcD+DBY+4vDh
	8NqPz8KmGP4YmzYeD6UmXs3vUkA06dIo3OZXbJd+RxdZHFdcgZ+HO9r9z19kCf3dAM3ElNx3LRIbl
	EVe9k+AQ9Ho02vje87bI9gz8I+toh5FqR/5sAEPLsghUtafpRClkXYFudgjQ1imHdL4hO3za/QfTU
	UrqVI5nf2DSS3JH/qu971Kifu5KqwhMxGCs9CkhuIdOyfEP9Aq7uxuxlAmAbIS32lS6lzNfQaxqlX
	zGrb4FZw==;
Received: from 2a02-8389-2341-5b80-d7c6-3fcb-a44b-90d7.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d7c6:3fcb:a44b:90d7] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcfmk-00000004GOZ-0qHS;
	Tue, 28 Jan 2025 07:13:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 1/3] generic/363: remove _supported_fs xfs
Date: Tue, 28 Jan 2025 08:12:58 +0100
Message-ID: <20250128071315.676272-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250128071315.676272-1-hch@lst.de>
References: <20250128071315.676272-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Run this test for all file systems.  Just because they are broken doesn't
mean that zeroing should not be tested.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
---
 tests/generic/363 | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tests/generic/363 b/tests/generic/363
index 477c111ccb60..74226a458427 100755
--- a/tests/generic/363
+++ b/tests/generic/363
@@ -13,9 +13,6 @@ _begin_fstest rw auto
 
 _require_test
 
-# currently only xfs performs enough zeroing to satisfy fsx
-_supported_fs xfs
-
 # on failure, replace -q with -d to see post-eof writes in the dump output
 run_fsx "-q -S 0 -e 1 -N 100000"
 
-- 
2.45.2


