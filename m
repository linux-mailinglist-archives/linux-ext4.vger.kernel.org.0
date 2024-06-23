Return-Path: <linux-ext4+bounces-2922-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42581913A69
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Jun 2024 14:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008192823D3
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Jun 2024 12:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985D2181325;
	Sun, 23 Jun 2024 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H/P+ODof"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B931180A92;
	Sun, 23 Jun 2024 12:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719144678; cv=none; b=Ogy9pO9OK/YAsLNvBD1ZWIqa/7YLJTmKKdiE/h22bQqj35wqvShmPgMRgOzTIep8mwhVkGQRiEE4f8XF1sgp47iiDVGt5mdNMo4SpMeJAT1ljXXg5b4NjpHHQfxD/Mb4891eDvDc+cXnnJdO9QZk1mkjkLS10ox21LD2hYxluB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719144678; c=relaxed/simple;
	bh=90nR2d5W9VdMeKWc4HdeKbsRu6+Hx98HuT55OWXxG4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gNWFzu05R1lLBstUzxKEQXHs2+S560x7LBFDo7pX73o2mljVidTbK26WLdVrv7vvzoLr1PwTxm+Ae73+/F5qapiapvPgY/ECQEjHsuJNzRqznPoybOb8/IIk77z+IxL66qySfJzwL95nbf69xDkrWqJkRIAWTc6u3Cwl5oXWcY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H/P+ODof; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=d+VcLaHbPh/gG24+MOgaL+rmlxf/A2dGW7+Fo+jllQg=; b=H/P+ODof4vcRfhiunHNLnGi6s+
	fRsW/1CI2VPiABNfZHZVXLuNGjvRC+NdMhdvsLp5HZhFnrXqdM3gxKOlfoQyymT+Tmq9NNjS64oWi
	zrGZ90KpXkzwyTNaTY0/9z+YEjnxbQGIdvlVQPI7EVyo6EPtj8lSAARMEhZT7pBUjGAtGkStTdwJ8
	EQyePijyIcngBXMASdfzqQnXfrkkdFAoE0x4hxaEKVxl/44insMEoqhHdVy0snI8vUFCuiydeMt2k
	9k1OfAon7KwIQvEHZx/yMF8tfV7sPnIGaDhckKTww4yFp87CW5/27qt0mh3b+MPC+nCNkKnsjVQlJ
	BWe0DIrA==;
Received: from 2a02-8389-2341-5b80-9456-578d-194f-dacd.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9456:578d:194f:dacd] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLM3v-0000000Dwxc-1aoi;
	Sun, 23 Jun 2024 12:11:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org,
	"Theodore Ts'o" <tytso@mit.edu>,
	linux-ext4@vger.kernel.org
Subject: [PATCH 3/8] generic/740: pass the --quick option to mkfs.ntfs
Date: Sun, 23 Jun 2024 14:10:32 +0200
Message-ID: <20240623121103.974270-4-hch@lst.de>
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

Without --quick mkfs.ntfs will zero the entire device, which can take
a very long time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/740 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/generic/740 b/tests/generic/740
index fc2ec627f..6a97ac69a 100755
--- a/tests/generic/740
+++ b/tests/generic/740
@@ -57,6 +57,10 @@ do
 		# restrict to 2000 blocks
 		postargs=2000
 		;;
+	ntfs)
+		# "quick" format that doesn't zero the entire device
+		postargs="--quick"
+		;;
 	reiserfs|reiser4)
 		preop="echo y |"
 		preargs="-f"
-- 
2.43.0


