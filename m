Return-Path: <linux-ext4+bounces-13355-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGgOJIjLeGmNtQEAu9opvQ
	(envelope-from <linux-ext4+bounces-13355-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jan 2026 15:28:24 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3131795A84
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jan 2026 15:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B80E23065D4D
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jan 2026 14:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB56357A26;
	Tue, 27 Jan 2026 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fa2/4dNb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3CE33B6FC
	for <linux-ext4@vger.kernel.org>; Tue, 27 Jan 2026 14:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523810; cv=none; b=XcSr0Z/dkqiqjhsx4vS1/UHrqxCcKdopD9eOLcfauk1S2z/u8Mp999/FfCZY0/uZ83mcXexx3zQZA0DommzMnmDfveJ5HJBw58eLwvBsTAD0TkCd3B3bvDpBEk4i9wt4quU4Uiu/n0Yh8PdVBWXLiKCGW9Y76sKqhqGkzZa/iIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523810; c=relaxed/simple;
	bh=/43NTVER+1X1uTWs1qLJMdDkJzK7k1BHZT5ZPLTsXsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NJNwu/8ip7/gXgQRh/gfoXRJ3WKM0MmyhNYKm9gxG5/Ji/UACkBEel2uCPO66ONurQAcrWRhaAD7zYKpBjtlHd2SMdwr8mTLfcmV6mexS5PJrTHnNS+bVY6JXvMVMJfbvwdpYbBw4HZXujVynancRAmM/IUe5jFrBeRI1IknVns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fa2/4dNb; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a7b47a5460so28406485ad.1
        for <linux-ext4@vger.kernel.org>; Tue, 27 Jan 2026 06:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769523809; x=1770128609; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wxBsL8rjioxCsA14jZXgtyRCy4Ul5M3AG/gOUFcFYso=;
        b=fa2/4dNbRvq40HuxRGLeZRPjbsQ5LPcn1MAv6GO21TrHbwogzsTLVtXCg7Srs9txW4
         os9NWinhy5oykwVYwTyn8BI/9u+Dk5L8Omx5fBEu/S+VPy39OR3jfkLBTadcH96r1nDi
         DV11wDgraMBTuw8Mux0rsFjPI/fuGz4w4VpoWEfYCAUJOIfn+FAZhpLDfHK01CI4h8AJ
         nJnLI5O4nW5gQcOeRZPnSoXfUmEv84qstim/CJXFTQQVK6d24HlalMH3PkUkEIWlr8LG
         ijeNVvgXp00rYTk3xNbEmFjSG67vC84IwbMUAR4jUSVWCHXndjJA5Namp+YlxpyfcICM
         jEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769523809; x=1770128609;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxBsL8rjioxCsA14jZXgtyRCy4Ul5M3AG/gOUFcFYso=;
        b=tF06JOiYLD0UooLZf84K+bQxQkXcBF4XYgYZRC9UoNHnYuMTdYvf52HLMtMl/rAvdo
         wifZr8dleZhbZREXEttV8nFHeNhDnrURQg+BAOEVuh+OGPLVNp/Psu1N0sEct9bBLoDG
         wE5laFbjZj1DvNYshg6KeS9GKdU2dA+NArIukcW6WmAHPI8e1h3+yqw//K1nYE1f69vp
         r82eY8cERxqO+QE8mEbdVAcSDvkYW/fp/dHIMNZfcseHtZHgfoDBTPALETTQ5ZKo4TeJ
         mwleqi4mIfPW+Y4f/ZktpfyMxCvWMxEV7F3700eAoaSqyMWMNZjnsKvMc+7tlHvMoKcv
         G7QQ==
X-Gm-Message-State: AOJu0Yx13m/u7UQe0XZTzeUM72FDiwKzBgYNFbfTqVKOfnmgCeKfksy9
	673lTdilZmgC28+oYJNcY63NGEZeWR26oqx+8mqhsErgVzdbdJn2aodL
X-Gm-Gg: AZuq6aK9VXimqM5l6xBds2fuJFUkEFIhUYl/uzUTWEXFNl6B0N2eG2vNfwHBV3C9Y00
	VtbmqfhLqJKvrw4O2aN+0VN8lojDebUCZT5S4aiNoiaAZzZJRFqlU1EsBpO97bSYjiod3Oko1Kn
	9BzjQn35S3Thkg/dLVCbhNVvwzOb9cyDFy2EVdyMPtL2Se3fPdAFBh6rOWvZeAhWZna5VFxg0Xn
	B9FVsxH0uaKgZa+RpPiVvOL3ZlMcoRIpZ1ituoj9ZHXTWqfrrs9r4fo2iBQDSYQNzfB8jDim5ij
	GALt1v6ut1Jis+YeOZlc6MxmZtTqBzmxRoBgmqzqkFVGzeeg7vA8fOXRCc8E9L7Bu2ITe6SRosn
	odGLCuh75heyfdO6SnPgKJPse4vRNtsjNL9q7kbZM27hESzbe5MbKZUcFMunD+qhM4Hau+Y5Jix
	teNag7+uAIc6AtJMiKA+c=
X-Received: by 2002:a17:902:f54f:b0:2a7:b412:6cc8 with SMTP id d9443c01a7336-2a87122683emr15530315ad.1.1769523808569;
        Tue, 27 Jan 2026 06:23:28 -0800 (PST)
Received: from [172.16.80.107] ([210.228.119.9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802ede6fesm118812305ad.45.2026.01.27.06.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 06:23:27 -0800 (PST)
From: Ryota Sakamoto <sakamo.ryota@gmail.com>
Date: Tue, 27 Jan 2026 23:23:23 +0900
Subject: [PATCH] ext4: Replace KUnit tests for memcmp() with
 KUNIT_ASSERT_MEMEQ()
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-fix-fs_ext4-memcmp-v1-1-5c269ae906b6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvyJ7bkFNMvpKRISttQdLNEKI/p50H
 JiZBzIlpgyDeCDRzZnPo4JqBLh9OTZCXiuDlrqTSlv0XNDnmcplMFBwISL1Uhlre+dtCzWMiar
 1T8fpfT9+yhNIZAAAAA==
X-Change-ID: 20260127-fix-fs_ext4-memcmp-e8014778cf73
To: Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ryota Sakamoto <sakamo.ryota@gmail.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13355-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sakamoryota@gmail.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3131795A84
X-Rspamd-Action: no action

Replace KUnit tests for memcmp() with KUNIT_ASSERT_MEMEQ() to improve
debugging that prints the hex dump of the buffers when the assertion fails,
whereas memcmp() only returns an integer difference.

Signed-off-by: Ryota Sakamoto <sakamo.ryota@gmail.com>
---
 fs/ext4/mballoc-test.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/mballoc-test.c b/fs/ext4/mballoc-test.c
index a9416b20ff64c930d90fc177d01cd6a4639d8333..85613b1811cd7c7b7410acff6028f0eabf28ef2c 100644
--- a/fs/ext4/mballoc-test.c
+++ b/fs/ext4/mballoc-test.c
@@ -710,8 +710,7 @@ do_test_generate_buddy(struct kunit *test, struct super_block *sb, void *bitmap,
 	ext4_mb_generate_buddy(sb, ext4_buddy, bitmap, TEST_GOAL_GROUP,
 			       ext4_grp);
 
-	KUNIT_ASSERT_EQ(test, memcmp(mbt_buddy, ext4_buddy, sb->s_blocksize),
-			0);
+	KUNIT_ASSERT_MEMEQ(test, mbt_buddy, ext4_buddy, sb->s_blocksize);
 	mbt_validate_group_info(test, mbt_grp, ext4_grp);
 }
 
@@ -772,8 +771,7 @@ test_mb_mark_used_range(struct kunit *test, struct ext4_buddy *e4b,
 		grp->bb_counters[i] = 0;
 	ext4_mb_generate_buddy(sb, buddy, bitmap, 0, grp);
 
-	KUNIT_ASSERT_EQ(test, memcmp(buddy, e4b->bd_buddy, sb->s_blocksize),
-			0);
+	KUNIT_ASSERT_MEMEQ(test, buddy, e4b->bd_buddy, sb->s_blocksize);
 	mbt_validate_group_info(test, grp, e4b->bd_info);
 }
 
@@ -837,8 +835,7 @@ test_mb_free_blocks_range(struct kunit *test, struct ext4_buddy *e4b,
 		grp->bb_counters[i] = 0;
 	ext4_mb_generate_buddy(sb, buddy, bitmap, 0, grp);
 
-	KUNIT_ASSERT_EQ(test, memcmp(buddy, e4b->bd_buddy, sb->s_blocksize),
-			0);
+	KUNIT_ASSERT_MEMEQ(test, buddy, e4b->bd_buddy, sb->s_blocksize);
 	mbt_validate_group_info(test, grp, e4b->bd_info);
 
 }

---
base-commit: fcb70a56f4d81450114034b2c61f48ce7444a0e2
change-id: 20260127-fix-fs_ext4-memcmp-e8014778cf73

Best regards,
-- 
Ryota Sakamoto <sakamo.ryota@gmail.com>


