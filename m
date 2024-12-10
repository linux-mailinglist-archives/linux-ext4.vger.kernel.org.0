Return-Path: <linux-ext4+bounces-5532-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A310A9EA92E
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 07:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 638F32819C7
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 06:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9026222CBDC;
	Tue, 10 Dec 2024 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ffFsetZl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D7A3594F;
	Tue, 10 Dec 2024 06:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733813952; cv=none; b=TBGmm0lihxX4Ve8K3lcnf2Ys0h2/PKtkKCVvvN7VjHNwPvjoMFpMPMwnUksIzTVC3hRf+VizVWKSgysjyG0frGpBeA5fd8X2LVobfuVht9Q8FPvcK5LP4iJPPHmILuBQL+DslXS7zDHzgdiKerZMgO/wnYWhvErgHy63A4vVCJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733813952; c=relaxed/simple;
	bh=dwGF6mLcJfkXtHJJXOjBveyRJWWXxsREUL2xpBYdFjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gpNLunqT5q7VoBq5ZkjFkTt5KG9jDxPQn7bPthum1ShRVEMDsBO6eVphoZAbRvnIJsWtdcNlywwqZtXiEhmj+5v3XlR30xUiyc/Ex+z0hlYJDOxPwKh5JB9qoKJtICdBwVAUITx4tcWD4sv/ecYw0+B3s+GsXd4tvJFcRMV5jY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ffFsetZl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PKzzfVBql7i8wGfJDdQ09uq+CnqXomKoX4wVRK4OYwE=; b=ffFsetZlEVDO6luKHvYrb1bgLf
	fNlFNf9h2mXXfr2v+W88Qu008E0Vf5hdQSjNUlMbwM5k3WTAatDyPE3vxcNascjuQ6ury4l0FBTTo
	wiBpOx+IAqU9KBsDPH9z9+8L+2RltZvdDDaq+hFUsFLrx8DWS7fAmxDX86YwMGbTtLqqgS5lOE7td
	KkrLhW0yCe3sP1rojU6/z7MVAjUpPNpBHSaMzCF02u5Tw69j/hgYRvDEaAt44BeaTGKAZboW3G8HO
	4igH4LF8q5nKBaxjiwRJ872u7wHFhUmcgYtEH9xOuKHxRGwEd5oflj4VQHX1vD6knsmA//LYjFfgI
	sQytPmpA==;
Received: from 2a02-8389-2341-5b80-e2a6-542f-4e27-82ec.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e2a6:542f:4e27:82ec] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKuD8-0000000AUcy-03kL;
	Tue, 10 Dec 2024 06:59:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 2/4] common: remove the $FSYP check in _cleanup_dump
Date: Tue, 10 Dec 2024 07:58:26 +0100
Message-ID: <20241210065900.1235379-3-hch@lst.de>
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

Despite the comment, _cleanup_dump is only called from xfs specific
tests, so this is superfluous.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/dump | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/common/dump b/common/dump
index 50b2ba03c670..3761c16100d8 100644
--- a/common/dump
+++ b/common/dump
@@ -223,12 +223,6 @@ _require_tape()
 #
 _cleanup_dump()
 {
-    # Some tests include this before checking _supported_fs xfs
-    # and the sleeps & checks here get annoying
-    if [ "$FSTYP" != "xfs" ]; then
-       return
-    fi
-
     cd $here
 
     if [ -n "$DEBUGDUMP" ]; then
-- 
2.45.2


