Return-Path: <linux-ext4+bounces-12430-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7572DCCAADB
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 08:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BA7830A1CBA
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 07:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9B32DCBEC;
	Thu, 18 Dec 2025 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rCtu6zRG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE4D1C5D57;
	Thu, 18 Dec 2025 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043069; cv=none; b=AMcamAygE1r52z+sFiu79ZorKCzChTpjlJCha5rmIBuZngj6m7F1f4MoNGLAfQuj5eo1fQU8vyyqBl2NjgBJUbQiblQPW+14LE27OK+rDUVu/JVT/DujpFf7mFf6gq3UOxjR4Q3hxn2N1EtlNb11dh4RwqD8YoFBK8QBeIu/8bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043069; c=relaxed/simple;
	bh=3tT5CT+eu7mZW4GO4QnfQnfzhsceYHManMemh1M2fC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IBz/mloIfK4f03DrLHjdKOz4QRmDbr3TDbcgYWJJbBcM33+6Mazmj516yKKC0AOgyuFXEIu8JFkzx/mwvPQ2YLvvJhZnEBLJ8ygSLsahxofklN6fpnnbVDfiHFpT0XhLFJjCtMzVLiOBfip70WzXDNxBnB2F5WwGqFVN2FPfDFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rCtu6zRG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=im93q7Hzzg4jxsVH9FqL+Om7tMUrqn6JliTC22ng8uM=; b=rCtu6zRG8k2BntdTX8cwZ9hrLL
	/BwTG5ztb9XgI64HBF1cGGhe7x+bXnTVF4qd7ArGanp1VYj64sUppbUYHNWz1z5VtDuK3uHbFynQV
	DyEZhRq8vDIN3MR3VHyfZbQbqpsIaixiYObhItp1M6aklr4hLf4I5R3HawDJtZX+au5wlUncy+XJ4
	dNDFI7eNLJyzLrxUnGErNcAAEoim4iZygKsd8lyclBveZDImHobr5yb06r02IfBePtaV+BDieBwxd
	AMTEyGep5lpbL28T8SNODUVREkHIbjOXJw94WplX6mZb8im3ERdgc4j1nolAdm5bvdqqFOmgf5e1u
	igjBj6Ng==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW8Ta-00000007xbb-0W6W;
	Thu, 18 Dec 2025 07:31:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 10/13] xfs/521: call _require_scratch_size
Date: Thu, 18 Dec 2025 08:30:08 +0100
Message-ID: <20251218073023.1547648-11-hch@lst.de>
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

This tests expects to have at least 400M on the scratch device.
Ensure that, even if test runs with small devices will probably
break in all kinds of other funny ways.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
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


