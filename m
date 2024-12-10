Return-Path: <linux-ext4+bounces-5531-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348359EA92D
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 07:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6E62832FD
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 06:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8800422CBED;
	Tue, 10 Dec 2024 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vy56JuHk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DD03594F;
	Tue, 10 Dec 2024 06:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733813949; cv=none; b=KPkPHAu222oxPZPoHBNpo+DyANa58nVqCnyNYiaYqTO5hIlXmIba8Vkx2dW4TyPyJWn8chnVA/jjPwg8sdhDcv70p0wWS/QluBCI7ErUOYAwoCXKZi1YIbI5Dqom0WRt+hNsNpWZ+7vKEeIzkElQgW+KXqkhxgx89QCcenEilcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733813949; c=relaxed/simple;
	bh=ifFFwiJuz6/cMO4E4Dp/xTjJMWkS4SEg8lOKfgpCjjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHfozFQIKSTji0g2pTPqeh/O4pnCy/lM0Bol2oozf4394/waI52oMRtV/mqqXFV1h7pISLSAAaN0rAXMeNfbhOD/iclaZVQonKfsYh79XCOwPWPLegAB0eDYMRl3XLG42JrmAZ1tDIE7YY0fccCb1jjT/5G+hRlw5feaj7ife/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Vy56JuHk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YsJXWzNl2m1VzRXzCXx6e6l/qn3iXExBbgVJMHezYxE=; b=Vy56JuHkwiK03FAjDt2kIaFjb+
	N5XADdH0wQ3vt7fZb+Gb/na/6hWl6C8m+pCJnatmSi9esaxhqmE7YLgLETRKwgP99vYEhjQHoyfPH
	Vhrxa+TgiTCd4DIA4r4ZN3mVpvysQjNkRQEPK4DicMrY7SmS8PrjZU/Mjz6l0Imgxdwl0KHU0dIde
	YS6JkjTJ62fS1ykVTeZlpOcrn1TfOGF98JpBSByLXkR8aoiQiaz1K/ETwNWd/wJy+YTy4FGWMO/5y
	HzCMwncuklcMqE9XwNNLezhXdhcIuRYPufXZcPTn5p87/XVpa/XirMvPjVA3EK9xGqveYPKtwv0rn
	nTKTuBlg==;
Received: from 2a02-8389-2341-5b80-e2a6-542f-4e27-82ec.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e2a6:542f:4e27:82ec] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKuD4-0000000AUcm-3CSK;
	Tue, 10 Dec 2024 06:59:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 1/4] generic/363: remove _supported_fs xfs
Date: Tue, 10 Dec 2024 07:58:25 +0100
Message-ID: <20241210065900.1235379-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210065900.1235379-1-hch@lst.de>
References: <20241210065900.1235379-1-hch@lst.de>
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


