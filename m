Return-Path: <linux-ext4+bounces-12326-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B339BCB8414
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 09:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63ADC308D46B
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 08:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DCA30FC2D;
	Fri, 12 Dec 2025 08:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SMPvHCyO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7228530F7E3;
	Fri, 12 Dec 2025 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765527788; cv=none; b=UmklcgilNi7WqSZLWHty9NJVu3e8k6fzcT02VlMaGjHhjoufgVXq8RjXfVXw6CMPYO6BZFTbfVp5zIcHkcmu2T9ygvW+Albd33oELceHfHHnfEzM1LhKrcrMWKJrpKC2X1SbmSQpDMCE058hHknQ4j7n0Pltru7S+Rr0o3G0+50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765527788; c=relaxed/simple;
	bh=5apyVjkfMaxKoWiNsETnYrPbIisSGydyKB4Ofn0uDJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcm9OixYMIIq3Vvfw4BO05MgN/8fYpPpKXlkaB3Ib00yLMumc7zymv0Ph0Qvhpah5PLBf2xaCLxwS1CuiZK4u0jqPZ42qdygMgGc+QeDEN9DAwkQRuybDg/8CoW4xsebgC0Zw9pjQNvVV+f4L5QSFlf/PAozY2FRcKzXP56k3rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SMPvHCyO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Je51zbfIQmTNysaoInOzguA68BB7Y6gLL7bGi8LRKJs=; b=SMPvHCyOpKjy1fzBhkdWP06EsX
	4oESypwhAw4gtnADyeXgUbymknC3r+5r8Z6DQwEz2azTp3MjS8TycsTLMA7Qa7pu1C8eLK/3znBXt
	3F+a4kvR9+GcjXLNvfmSEzm6sFt6qewUqlyYyHWp1qQbPcMAH0hsznt245hBAhsDuq4AnAgL+f18C
	vG6opTan6UaTobnE5NSvn3N2jC9vwAt2jaIobI3+C9WSqRmWIIyXUNpcCiOZe3VB5+NEMywZYWY3g
	RELDGSbr3d43zeISAelsRQqkB525xXiZgT6KqZ8F9qqXxXogFGyNeEnMyw+4j4r2N3OI68TrjRkhD
	JyOKUptA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTyQc-00000000GDv-3c5v;
	Fri, 12 Dec 2025 08:23:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 10/13] xfs/521: call _require_scratch_size
Date: Fri, 12 Dec 2025 09:21:58 +0100
Message-ID: <20251212082210.23401-11-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251212082210.23401-1-hch@lst.de>
References: <20251212082210.23401-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This tests expects to have at least 400M on the scratch device.
Ensure that, even if test runs with small devices will probably
break in all kinds of other funny ways.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/xfs/521 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/xfs/521 b/tests/xfs/521
index 5cd6649c50c7..4d359d641716 100755
--- a/tests/xfs/521
+++ b/tests/xfs/521
@@ -20,6 +20,7 @@ _begin_fstest auto quick realtime growfs
 
 _require_realtime
 _require_scratch
+_require_scratch_size $((400 * 1024))
 
 echo "Format and mount 100m rt volume"
 _scratch_mkfs -r size=100m > $seqres.full
-- 
2.47.3


