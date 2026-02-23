Return-Path: <linux-ext4+bounces-13775-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH5BG0JJnGmODAQAu9opvQ
	(envelope-from <linux-ext4+bounces-13775-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Feb 2026 13:34:10 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BFE17624C
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Feb 2026 13:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 407CF300E691
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Feb 2026 12:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79BC36073E;
	Mon, 23 Feb 2026 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="CYhVWaz3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.83.148.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587FB343D8F;
	Mon, 23 Feb 2026 12:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.83.148.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850043; cv=none; b=YABKm7TIy7GZYNxLJNCueq/VxR/2Fc876rypH+JzKSdDulF4emKmreV2YZZzTjGtZSOUyvI8ABVbN6NMANU+dvd0KS6YtqrQJQvKSo6UbhkjkRcYZKGTqFRvh7sRwbCSebx+2D0Fi/J2VEhJFifi3u8OywZKFua78g6Wf1pQAPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850043; c=relaxed/simple;
	bh=lsewbD6I+rSux6LezybNyII9fOD7541CfZBaa+70dms=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kZtLOmWBLWyw8/NX08qEtQosmTlm05QWyeHGLehlWExYXhySveoDeYKRXUqsWb5CueBPIt6Oo7UXKwXpN54qhaMgbisjuwRc5B5hRMe859c+j1DzeBwzqXVz1iQiWODWX3N+3B8aCAEOjqvHp4aLrviPN7fb/FMhjU8f+E1/kq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=CYhVWaz3; arc=none smtp.client-ip=35.83.148.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1771850042; x=1803386042;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5ozhSRhDXJCXOVBObQmD4X7K/uE6XpdJiQsWhftQtRs=;
  b=CYhVWaz3qie7F8uiya8YSLG9DAOvbfjZBkJBgrFdVa2VOcUgc6Ctsj/G
   U8+M5U+YG6RbcWWZyYkCBbcrkPstwSTmNJMnaNpV563b0XgXdZzE5tbqn
   1Wb6pn/WLV1M2w4zAnN9Bh8/jhoVmr1fHaQRJDkmnWMGNCnOTiMN9Q4de
   fB2xlZqS6fcuDjrmf5IaWI84L/Jf80yCKkEkxDmu8Y5k28/5FLzjR3Xn0
   /zveN/9lveTOWOe9NS8AnTpDa0quQdrAy1iNR2IQTwt20zRAHjItdM3HX
   7vkEoIfiABLiaBLdkbUfDm3FXNAtPe2ANJ9SVDvmsXyWQnmKwFU2jj/LG
   Q==;
X-CSE-ConnectionGUID: OStkjPB/To+jrS674xKUTA==
X-CSE-MsgGUID: vB/uqwGUQUyqQNFvRvkQ2w==
X-IronPort-AV: E=Sophos;i="6.21,306,1763424000"; 
   d="scan'208";a="13367537"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 12:33:59 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:15992]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.129:2525] with esmtp (Farcaster)
 id f8bc6900-77dd-476b-a4f6-c81d61fa31d2; Mon, 23 Feb 2026 12:33:59 +0000 (UTC)
X-Farcaster-Flow-ID: f8bc6900-77dd-476b-a4f6-c81d61fa31d2
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 23 Feb 2026 12:33:58 +0000
Received: from c889f3b07a0a.amazon.com (10.106.82.17) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 23 Feb 2026 12:33:57 +0000
From: Yuto Ohnuki <ytohnuki@amazon.com>
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yuto Ohnuki
	<ytohnuki@amazon.com>
Subject: [PATCH] ext4: replace BUG_ON with proper error handling in ext4_read_inline_folio
Date: Mon, 23 Feb 2026 12:33:46 +0000
Message-ID: <20260223123345.14838-2-ytohnuki@amazon.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D041UWA001.ant.amazon.com (10.13.139.124) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-8.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-13775-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,iloc.bh:url];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ytohnuki@amazon.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B8BFE17624C
X-Rspamd-Action: no action

Replace BUG_ON() with proper error handling when inline data size
exceeds PAGE_SIZE. This prevents kernel panic and allows the system to
continue running while properly reporting the filesystem corruption.

The error is logged via ext4_error_inode(), the buffer head is released
to prevent memory leak, and -EFSCORRUPTED is returned to indicate
filesystem corruption.

Signed-off-by: Yuto Ohnuki <ytohnuki@amazon.com>
---
 fs/ext4/inline.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1f6bc05593df..408677fa8196 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -522,7 +522,15 @@ static int ext4_read_inline_folio(struct inode *inode, struct folio *folio)
 		goto out;
 
 	len = min_t(size_t, ext4_get_inline_size(inode), i_size_read(inode));
-	BUG_ON(len > PAGE_SIZE);
+
+	if (len > PAGE_SIZE) {
+		ext4_error_inode(inode, __func__, __LINE__, 0,
+				 "inline size %zu exceeds PAGE_SIZE", len);
+		ret = -EFSCORRUPTED;
+		brelse(iloc.bh);
+		goto out;
+	}
+
 	kaddr = kmap_local_folio(folio, 0);
 	ret = ext4_read_inline_data(inode, kaddr, len, &iloc);
 	kaddr = folio_zero_tail(folio, len, kaddr + len);
-- 
2.50.1




Amazon Web Services EMEA SARL, 38 avenue John F. Kennedy, L-1855 Luxembourg, R.C.S. Luxembourg B186284

Amazon Web Services EMEA SARL, Irish Branch, One Burlington Plaza, Burlington Road, Dublin 4, Ireland, branch registration number 908705




