Return-Path: <linux-ext4+bounces-12422-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEA4CCAAB1
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 08:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDC743068D49
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 07:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2C22DE71D;
	Thu, 18 Dec 2025 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RD6Ig7JX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DBE2DA75B;
	Thu, 18 Dec 2025 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043039; cv=none; b=Acqq01Dt6lZFFFmNMYRUTLMkwJm6iRoOz2yzD66uYWrLdzBbz0oHF9RYms8WWRkR88Q55uNx41MjH8P9KQ3meLRcLl0MCUX2zFpvYzWLx2u6ecjOQO98dQi6l8deVFmEDukoqqL8/NPsFDHfbJwP4Unf9FlCwgOopQ7cXf24XaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043039; c=relaxed/simple;
	bh=dCrlxPY7GUbVatP3slffknCzhhRqAxrXZLRttqwwcck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NbeoaRsehWvTUJdd4QAxx1DbvHvzQy4zFn76zfkA1VOKI/MiCz349TpEmJfiDy02tWNqxb3CLghRT5h/ae9se0pnH/m0hXQpTLzAeyLwcfEZJHwnv191EHV4rNuyc2ZlfZ5/ThqrSFu1WSsDrYXrJWYGuMbMjDEaVVc8J9O+RZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RD6Ig7JX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ghDxzyrXjgcmCxFp0s9S5JC8EgBUEYW8v71ygoSuzvQ=; b=RD6Ig7JX1tW0dk1YXIUMsH/dm9
	STcI2xqgEs+A8284aBUBjYZa+2jxNmE5kl0hwl5NEhtI9HG4gcx/ZXFRCaD/aoEGoTBKFvYiTcQTJ
	FuLd0Xt3pTCfGQlK8vaRL4SqQ7j9/PkxDpHNDBDIIfhCX5yuC1lEz8vTLg2o0Pqt5+DqF9T6Ux0LZ
	aemv2WvbuqT6QgHg1mAUFN6SnEC2Q8PFMneAH3oHAGKXb3eKuNrd1Q0fFhTaQGuGXmn7kUYTgAYFa
	lgQhJMuwBvxHPyI3lifJUkcQFx+pcEaflZEpzccftVW+LysibtwYOL8PN87Ns3xP3Cd3nqKGa/Kj5
	MIryuAhA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW8T5-00000007xYr-2Qtl;
	Thu, 18 Dec 2025 07:30:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 02/13] ext4/006: call e2fsck directly
Date: Thu, 18 Dec 2025 08:30:00 +0100
Message-ID: <20251218073023.1547648-3-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218073023.1547648-1-hch@lst.de>
References: <20251218073023.1547648-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

_check_scratch_fs takes an optional device name, but no optional
arguments.  Call e2fsck directly for this extN-specific test instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anand Jain <asj@kernel.org>
---
 tests/ext4/006 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ext4/006 b/tests/ext4/006
index 2ece22a4bd1e..ab78e79d272d 100755
--- a/tests/ext4/006
+++ b/tests/ext4/006
@@ -44,7 +44,7 @@ repair_scratch() {
 	res=$?
 	if [ "${res}" -eq 0 ]; then
 		echo "++ allegedly fixed, reverify" >> "${FSCK_LOG}"
-		_check_scratch_fs -n >> "${FSCK_LOG}" 2>&1
+		e2fsck -n "${SCRATCH_DEV}" >> "${FSCK_LOG}" 2>&1
 		res=$?
 	fi
 	echo "++ fsck returns ${res}" >> "${FSCK_LOG}"
-- 
2.47.3


