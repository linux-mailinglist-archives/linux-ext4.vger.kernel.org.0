Return-Path: <linux-ext4+bounces-9335-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27960B21AAE
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Aug 2025 04:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 510593B5519
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Aug 2025 02:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D46F2DEA60;
	Tue, 12 Aug 2025 02:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="I43MsbSk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3192D13D8A4;
	Tue, 12 Aug 2025 02:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754965079; cv=none; b=WTqOw0+yzh4u+e5kY/riohybXIjwJkM/im88Zh28zovPsiAJv8IOH5Rnlto9HKZNSa5N8OuLaj7a3ez/pnVWCgzjmz5PsO/DyjYwuzzW4/gj2pQd5kvx0JfmzOvcQpmUc8TbPA3VKXsHBL1byQN3NZF+fMyB5oyel+AfU6Gh2Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754965079; c=relaxed/simple;
	bh=p8rIpSOUd8wR9bvs3gGvqLbx8KrOSm2aQbTqFSvf1ow=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aOGDro/5DI92Mxdp8NQHqYCBp6pGpFUlFg6fq5t/+tZs2LmXvJ7Brkzpahrbr/UNeHCbqOJ4DiTTxegcDXp0CHGezr8n3EqRdNyptf1epnY7/SpHLCWk5GLiTyiqbLujWnqSkgx5wiOa+EM1xOW76pOYu2DaFOPhm3PmKoknpPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=I43MsbSk; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=3Q
	OTaZ52O6+1gNzGEBm2ulp2/tQEcCZJjcbyg+KHPhc=; b=I43MsbSkTvZEomIfuq
	6ZW0k9NAiD5PHmmOqTmxZzD0Pa7BB4zRfMtYHcz3hw/KEof9n2EdEruK0BDxtsJi
	HWl0Y/U3gIdcwsti9e9g7F9KlUM7PeuGoYwzUFOAtdO9bfhNaXk1N97/P3YCbnt3
	KgfH2m6WsAoODz7+BWJ7c1DBs=
Received: from liubaolin-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3939EpJpoxPx8BQ--.48488S2;
	Tue, 12 Aug 2025 10:17:42 +0800 (CST)
From: Baolin Liu <liubaolin12138@163.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: [PATCH v1] ext4: fix incorrect function name in comment
Date: Tue, 12 Aug 2025 10:17:09 +0800
Message-Id: <20250812021709.1120716-1-liubaolin12138@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3939EpJpoxPx8BQ--.48488S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7WryUuryUGr43JrW3ZF1DKFg_yoW3twc_W3
	WkXws5J3ZxJFn3AF4rJ3yYqrn29w1fWr1UZ395JF43Z3yYvan5Cwn8XFyUAr98WF1jgrW5
	CrnrXFW3AFyxXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8kwIDUUUUU==
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/1tbiMRanymiaoBXO1gAAsV

From: Baolin Liu <liubaolin@kylinos.cn>

The comment mentions block_write_begin(), but the actual function
called is ext4_block_write_begin().
Fix the comment to match the real function name.

Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ed54c4d0f2f9..b0e3814f8502 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3155,7 +3155,7 @@ static int ext4_da_write_begin(const struct kiocb *iocb,
 		folio_unlock(folio);
 		folio_put(folio);
 		/*
-		 * block_write_begin may have instantiated a few blocks
+		 * ext4_block_write_begin may have instantiated a few blocks
 		 * outside i_size.  Trim these off again. Don't need
 		 * i_size_read because we hold inode lock.
 		 */
-- 
2.39.2


