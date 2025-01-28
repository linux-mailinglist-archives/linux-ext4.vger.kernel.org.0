Return-Path: <linux-ext4+bounces-6254-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4799FA204F3
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2025 08:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CDE7188869A
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2025 07:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B191DD0D4;
	Tue, 28 Jan 2025 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S5RJlDGj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646FD192D84;
	Tue, 28 Jan 2025 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738048407; cv=none; b=dpAJNczs5el/Wx1nu8o8qR7LirjH+198uB6QmL1vbJsB/PzvXXcP2mosC65swsTRssx5zva1+P3qqQgDXAr5FqEf14ffpxxH7+7bfO7hO/W9JpUrB8mye/AnI+1TgCHnmM7BkeX9sii4/9vYcwJV4TEON6g/JafkdQsiq0FFJd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738048407; c=relaxed/simple;
	bh=dwGF6mLcJfkXtHJJXOjBveyRJWWXxsREUL2xpBYdFjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SaOuv0tHExXhzIQyLzSPsN3f60MSmiqfZxn61zNpjaAuZwhf4tspMvyEzdtdCE4FVZu1XjivI8kxUIaCv4/PekFXH1zQeedzkEzr5iGq1YuAy8qkgFgo3pg/8HAqKchd9LOaATrtTnvta0Ygl0ZZLiwXOrI2ccbd7KRVP4Rzvis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S5RJlDGj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PKzzfVBql7i8wGfJDdQ09uq+CnqXomKoX4wVRK4OYwE=; b=S5RJlDGjceWUt6DMCATa84s9VY
	hGJ+1LjVHzHgs111ZpfnHWzsIQBI3qigO3VD8JH6a17mbnmFASR6iTpqhccuEDZlMNXD5khd4TQPU
	v8d93KmLdLPEJNTLDVvpnnm1c8/euUieFQlYbhnOMVTvIVxSj3usvrc/GSSdwBFsKL8osjh/+Nhxt
	8jPZrzaniswDLG+pYM1OLuM/l0kjvkryZm0cwDYugYfGUp266LREYjYtfZlk4/FhKa3CyLaaa2mqa
	S09p6J4eHV8+r8bgz5V/SJn7R4tE0hQAXQiFHxzyCpUHWWyrLT9JorNNfMwIoyHyrMt15vmx6mt43
	FvJ9S+iw==;
Received: from 2a02-8389-2341-5b80-d7c6-3fcb-a44b-90d7.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d7c6:3fcb:a44b:90d7] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcfmn-00000004GOh-1o3K;
	Tue, 28 Jan 2025 07:13:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 2/3] common: remove the $FSYP check in _cleanup_dump
Date: Tue, 28 Jan 2025 08:12:59 +0100
Message-ID: <20250128071315.676272-3-hch@lst.de>
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


