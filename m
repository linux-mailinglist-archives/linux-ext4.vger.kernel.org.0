Return-Path: <linux-ext4+bounces-3725-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C545D9511E4
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Aug 2024 04:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F02EB22562
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Aug 2024 02:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565711BF53;
	Wed, 14 Aug 2024 02:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VNQCkvmD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7542327713;
	Wed, 14 Aug 2024 02:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723601532; cv=none; b=lS+AMpQ+YYCumGA63mHe2NHd6d8ajPGQZfUOAyQOY3syJxZ7Hi79XKbj8xELUxQzFHrjjHvbjaJ1tQoA8pYey3UsB3CH+TPoF8U8scEsuMu8yKxcOuHjUCFUmBQ4p70axMXBFVbQ4uslDU9qLjNmxzMs0OOoxs4arH0WbfT2XS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723601532; c=relaxed/simple;
	bh=aNasdxu4yIswcEWQRn7spxwYDmyLSm0tj1clLR5XF0I=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=A481zbTznNtr69uPVqtlCo9fEFnhHTPHZD4nGs27XR/dxzDAIW6SlFHiSjrxPaJ9vGYx3N5KSxMLkEKy3xKISQnJ9h0JvbBbktMup0pIwTeSJSzNAZyAx+r742spxU4TZqYy0dvHv9julyXpWUOnDmZ8bFglvnXYL1VkRlGVw80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=VNQCkvmD; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723601523; bh=3wsPyn91f/PVLo4SVvbVk5KTI6RKkQpp5yoClszyFoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VNQCkvmDW3yKfUo9+PnYbl7xA8a4O9MW8++7yIZ0/6Fp9HFSlVJsxyK8QLKSBt/ew
	 /GxXLueUMNo3j/tZRAt2lB3I0KasVqZNKsQLPftws1hmjezcCzjdD+90kuFZXaFG5B
	 T9rTFB+HHE5VPOCfSqNpDw+zsZ6nfkMgkT+VeQHw=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 300060B1; Wed, 14 Aug 2024 10:12:00 +0800
X-QQ-mid: xmsmtpt1723601520ten4rqrpk
Message-ID: <tencent_42D9D2CB066909BF6EDDAEDB8C8067F3C606@qq.com>
X-QQ-XMAILINFO: M589RIiAniBCFCgDGCNO+FPRn8oVsIM3oyBNFg2Xh78Tso9bAEpOnZxstfE7zi
	 RjH5tTZIo9D4uSGmJinkfJQy3WO1SZ4JR0XHbATaSwsvksx8FjbfWOTkoS4JPJF6VuTWqvdtFW4O
	 9OQ1MHTwEjsrX2guwU1IslKAdFhzoNrxXDmbLSZBS/gC2IiUISc5d1Zt8ow2yOaU9tC87LluR18D
	 Qblrmwgdj+mZX1A+bi9XaQdH7KHHzdQa4vkAFfS2n9sib9WaCE/Ll14xm2Vwa4tRLml6bsDQaPAb
	 Pt43MmR3rXN5COIR7GBrb1bmn+KOK8hk9NfrtudRanXq7Lup7wVwITrBAw/inpnX5Y4bu6H0BbIk
	 bdnAKTCgTJ49o46VXQ8jLWo+p2Xmo8zvaiXbGKKe02sZVw3XPSChGeJzMHEB0J8u2kWymxlKbeZE
	 ukBk14zQgo+VRcTUAZDlafmpfCvOP/uCX6maOV1fZ/9Z2ZYgjj6z46vPh5mfXuYLLP8ziqH8i5OQ
	 IoSWt66nZDXtJFVxOzCwS+p1+5C5Ux1kCihJ+GGLQaHeZQ+xbD4M4hcrv+g1nW9AI++U2EUsAllc
	 flf6Fq6fXnemwMOdya7psjATJNCPH8I+M/NG+eTKVviivYLk4jMIirQ32TpohI3609MbMZvrWzT6
	 83FoaRYM/3P4MiGdhpYTrWuM3WFoGIEAn2X8Dp63eWMx1fMVHqQetg5gz7fmLdA6VAWE1M8si+iF
	 WtkcyNQ7oqBpSDkHuB4GupBNSmFJJwIPqFcngggg9GLNvnAv2ix7+bB4oRjGaPZzFFtxFbLcKU/K
	 iyWN46u92vBdob4GcnJWTRKfdOB7FJtyflz+stFV/0JdEpZWT+O+dY4WQW28p0HLDMt/cIhxGz95
	 3nBSbwpgJBVHNLNSEHmJdLHwD9AmhSSDhSgsFgYVYWW5wAv/J/+HR/oDBtYGiR6wfNJbxmx7vo
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
Cc: adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com,
	syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: [PATCH] ext4: fix divide error in ext4_mb_regular_allocator
Date: Wed, 14 Aug 2024 10:12:00 +0800
X-OQ-MSGID: <20240814021159.587619-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000b1b164061f96213d@google.com>
References: <000000000000b1b164061f96213d@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before determining that the goal length is a multiple of the stripe size,
check CR_GOAL_LEN_FAST and CR_BEST_AVAIL_LEN first.

Fixes: 1f6bc02f1848 ("ext4: fallback to complex scan if aligned scan doesn't work")
Reported-and-tested-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1ad8bac5af24d01e2cbd
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/ext4/mballoc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9dda9cd68ab2..451f92cde461 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2928,13 +2928,12 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			if (cr == CR_POWER2_ALIGNED)
 				ext4_mb_simple_scan_group(ac, &e4b);
 			else {
-				bool is_stripe_aligned = sbi->s_stripe &&
+				bool is_stripe_aligned = (cr == CR_GOAL_LEN_FAST ||
+					cr == CR_BEST_AVAIL_LEN) && sbi->s_stripe &&
 					!(ac->ac_g_ex.fe_len %
 					  EXT4_B2C(sbi, sbi->s_stripe));
 
-				if ((cr == CR_GOAL_LEN_FAST ||
-				     cr == CR_BEST_AVAIL_LEN) &&
-				    is_stripe_aligned)
+				if (is_stripe_aligned)
 					ext4_mb_scan_aligned(ac, &e4b);
 
 				if (ac->ac_status == AC_STATUS_CONTINUE)
-- 
2.43.0


