Return-Path: <linux-ext4+bounces-3723-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B622951119
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Aug 2024 02:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA90284077
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Aug 2024 00:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64374A1B;
	Wed, 14 Aug 2024 00:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JuX3qUZx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23D81C2D;
	Wed, 14 Aug 2024 00:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723596117; cv=none; b=t6Kf7syYZoJ8SPoeT3qmNnote5LlZkvpV3c6EIOcD6/2fqbjY5/Sh3ctBm1xTPEHrT0g1DfUEi6IM6eygbqKlE5zUU8felXAlj1o7z6iIBBwSMMdHg5CMDv4HCTGtwq6/HQW60IgYxEP4fK0+wkcTb6WFkmoQ+5AwNl7kEeiKzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723596117; c=relaxed/simple;
	bh=SZueXCPsSwfQWQQRkkfy9Gvaa/gZGT4D4UaM1oMlS7c=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=QEW/tMmOmgbZCAIt/qoRQfT2LdfrCKh7q97GXn+8ArB9OWsW6LtxViqwUR/Fk40gnf8xlvJx9s7piAJQuvzE/9lpE3aOSmZJedTFRIGJnOn5dcLAq4bIEbhjJZ0YPDtHBK7WqmauXaTy8mRoQxRFjczVnzqS1xrIiYvtoypqrBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JuX3qUZx; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723596103; bh=1WoIqjyPOPpAbzQq1AkdHEQBFtRD7wsw0eve6XHnTzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JuX3qUZxn8A16aGvAuc2WJ9onBFKuTrUX0nt7DLp4Fm77EF83JtRNBfezhZ3p5E6D
	 i/rRJUjKZ1LQSs2F/PbuRcxLUz06dIidKjvUW+hUdvmq6c4Wnb9vXKiudmlFyrmhZO
	 J8dFVuF5rJn9Gq35YZaNqUZn2ovkrw16QIcNiov4=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 8DF11A6A; Wed, 14 Aug 2024 08:35:31 +0800
X-QQ-mid: xmsmtpt1723595731t2onn319p
Message-ID: <tencent_0F27C706CC52D386584988EECBEEC0CCA206@qq.com>
X-QQ-XMAILINFO: MK3JR/K3P3T7Gsg+hjNuBVrNdLaojcyfnqq8oxqSxnS3PyoRfOBicmuGAlKK5g
	 U7DiHH8M7nNo6wlJvId7HYwlc51Riby+d5VHR8ih7xNyztRPR42ckpAfxvstOnxlT6ohq/BNyT7y
	 RThrYxZM3bmzhWd9NAPco6Xo6YT4BhbvPhNlEr3K00ZpNzTziKQ9M+Ibxovg68KD8J1WhP7jgRx3
	 RNimmFk8HQLNpi+08BgYsvC9XGqWIBGo5rykeTSluwPVs9KQnfPHksSPgbE+l1z9hcgsddJWoTVM
	 wQZ7+0XZz6Ql4W2wEqdsyHAvHheIALQslS6TKRL7r7fUP8ZEacn4n5SPau6/CsL3KQSYErzdJidV
	 6JKC/Ecu4Pyota/aXCZToH7OZ9hpG9PS6HCcvwCOalhqs8VtqwxCwRAJSCe7N9Rw/lZhxNIbOKx/
	 TlNIvBlsPsWYtueCR7gEHy39BQzZJSAuZY/7qqRz7fe0+pUfVtYYcq1dzSBVeSEsWVaNBcBwVIYd
	 tnKR2c77DSR/qVC9+pibea1vwIJI0EaVXk2ykmvfdckNWLAuJCev+XgWOkOvXB+B1pzb/4DFE7Yq
	 vqJp7i9n7Hfm5DEy/6ZI/YniSsRWL0Ta0SqF6jg3CN7jEvq4mL4jYaGhBmBq7OSYtbcMM4KJ7lN6
	 6LoymJDIM9i5BXPz6+4iC1+OxHz/jPcZA9ILxnJPOfgxSFp6p+UCF1vhJXAmwEV33ahZF40wSoAV
	 XWgh3CCCvvdIQAUipWA+Q/RaBmF84+QtNOOy/JmZ6UcbD3hbpuoCi1sM0ORPkqUORcOIa7IpScqf
	 s5E2TeS6z5WWu4aDETCdnjI5k3FfakANeK7na2W6j1RsfrTm90I8WVi62FzxTpJKtTjXdUpGtpIm
	 L/jjSjg/Fhwrf7lJvLLgLDQ7gN0Tyos4xAGWiHFAjMshYX0o8yh24p9M76hPNO+w==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
Cc: adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com,
	syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: Re: [syzbot] [ext4?] divide error in ext4_mb_regular_allocator
Date: Wed, 14 Aug 2024 08:35:26 +0800
X-OQ-MSGID: <20240814003525.489111-2-eadavis@qq.com>
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
Reported-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com

#syz test: upstream ee9a43b7cfe2

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


