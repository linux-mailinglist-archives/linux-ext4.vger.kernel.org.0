Return-Path: <linux-ext4+bounces-13668-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mImPIY7ni2kcdAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13668-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 03:21:02 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8A2120C12
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 03:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49C8F304C08A
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Feb 2026 02:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83FA23D7CF;
	Wed, 11 Feb 2026 02:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b="HClJQGQc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65DF1DF27D
	for <linux-ext4@vger.kernel.org>; Wed, 11 Feb 2026 02:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770776458; cv=none; b=ADNLOq+aIL4F556vM+2jf6Z7qZgu/JukeRT1DkdH0ZZn8QXe6PRD7YpqWR9cGCINimoD6uolt73g7hYJTtPjJAgcGGJqxECqTWMUTLvhWgq1ZXLqyM//on+0BY/PONZNZ9BMegMWCpLgBXgkwEHPkP5tt7sGGZmgv6NmErYhqrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770776458; c=relaxed/simple;
	bh=egiVMHh4lmyL3w4B4fzP4ZddDJeJokEIBFd10KuZl/s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=djJbZGRQiWnjnly4wAHEg73lpwrbIU9F+S8bF4fxdcAoLsNYZ1t0d/fdtY5PdKM5ZSGERfeuIuAoxVM4U+kV0o7YizSjddYMrucc4YM0sPeSfkRvHjFq1ZMrowY/B+lfsLsHTh8Oq3+f/NlSKatvkq+hnPsNPRPgtY5AADWowuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu; spf=pass smtp.mailfrom=u.northwestern.edu; dkim=pass (2048-bit key) header.d=u-northwestern-edu.20230601.gappssmtp.com header.i=@u-northwestern-edu.20230601.gappssmtp.com header.b=HClJQGQc; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u.northwestern.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u.northwestern.edu
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c52c67f64cso544032985a.0
        for <linux-ext4@vger.kernel.org>; Tue, 10 Feb 2026 18:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=u-northwestern-edu.20230601.gappssmtp.com; s=20230601; t=1770776456; x=1771381256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3wCcBHsr4Uji4qqJCqhFZkc8S1LuJex4vz87CBE8FEM=;
        b=HClJQGQcOM2R2sJURWiF9MrjxVPrddG8zil2Q1tJu0TKHQau+GP+ake3R6gQW02bRe
         s49npc0cMMXUiMZYhlPpsTmvr78TV0KHcxWKsPeD3yXDkCEGZwLWOUrK8ts4T9bFbexN
         OssyziCpHu969iPiqkKTA7e6TAOQIOwBcsOYivuavHkFcVgHIryIVEGo4tcy1Q9Q/63L
         okTwXFAHMCNqkOBcsNnbJr9+bE9AR93uw8PpTVztgecOin37KEjtADa3LEOzxI2+wZAc
         qUHsuU7dnHlRvud3A9C48AFXdGodJGtcoBCFmIUddbYH0fzM38WPYW+7un3sE1W+OKdu
         SYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770776456; x=1771381256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3wCcBHsr4Uji4qqJCqhFZkc8S1LuJex4vz87CBE8FEM=;
        b=nk+zH3o5wkivyOGDGtD9vxWNNgaplNfqy2Ge6PZS+X+CeyXdES3Sb8Dpf+Owan5g8i
         qfi00ZEZPyvUL39qW+ysDYupxHovckVwut35cb25gFGuzxkkj78ki1bfV6KdIYw+5XPh
         FQXh6WKEmqPuGLVr0sTl7xCFOq6QuVd6OF/Rju+WQsI14E1CSk7byw5VlOXy0PADw3IC
         R2ZmzRa8ajzrlxBbQBnsxHDaIiFBnCigj//tdaAKHgZprPPUJOwEcVR/pVWpRQpQFigi
         i4h9l1MY7b8hq9v4X+BULtEv0+UfO1S0jMG0cudI5LVwVO8DykP8fb13WhJFrjlwzXs5
         Ztdg==
X-Gm-Message-State: AOJu0YzYCRIoQTtN2ySpIRy969mlmLttb0yYGThk7470rS+McXEXx/LK
	CPNKcmiK5ZJCEd9jKt5XtDwjh1Upg5oqFlj5bmnYNPn8oNV1HP59Dl8ZEmIWedg+rD/667nJaUT
	B5LGV
X-Gm-Gg: AZuq6aK7eoA2D29UPqJ9z7rbigp+/A+Z2V6+Gl7eHgnultfrN/S/9abpXpunsl+7Wio
	gVmLbPTUvUqrF552AQA+77/jI7irNaXbfWy1QRNVVPyFjT25TOgK1uhzX1qFHUBLDlB/KMWg5JU
	LqT81ZOe3THzNqTa+P7hyx9hBmz3iH1g7l8tDmgfwy6dWTGIFLKbXOGWwwQr9lnzwmVX6j4zpye
	moFL2xg9NHXlUjmxh4XanZizmIyLk2O2cZn2VYW9IXh0LTfjzrmysH8/PCuU5LBA5X0bCKNnktB
	z8aacaW8ma7dKGddAWpAeQIMpK2nRmM3E0ScV2aNWEwAzeVIhI3RP5fzJuGE0syz5jtK7eiSyJY
	QORlJoL7w/eBhsGGV5sWTo/e4LmM3Df+72tRfBmDFd82DSD05cf3cfHpZ5dPNLXuFSwcpEnAbsJ
	IIAVAuVh2PHpbqpVXERmELIn5GfVxTzCaAvxDuKFls66NRvdR1f47L1alWnZulbwJfMO+ONpq/2
	I06UxjVLOwn2g7nEbYCOmkeax5tc/J2pj826OAb9rbev7iw2jQ2Eg==
X-Received: by 2002:a05:620a:4502:b0:8c7:1118:c514 with SMTP id af79cd13be357-8cb2a2bd947mr36446385a.17.1770776455955;
        Tue, 10 Feb 2026 18:20:55 -0800 (PST)
Received: from security.cs.northwestern.edu (security.cs.northwestern.edu. [165.124.184.136])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b0ce73fsm15817385a.11.2026.02.10.18.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 18:20:54 -0800 (PST)
From: Ziyi Guo <n7l8m4@u.northwestern.edu>
To: Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ziyi Guo <n7l8m4@u.northwestern.edu>
Subject: [PATCH] ext2: avoid drop_nlink() during unlink of zero-nlink inode in ext2_unlink()
Date: Wed, 11 Feb 2026 02:20:52 +0000
Message-Id: <20260211022052.973114-1-n7l8m4@u.northwestern.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[u-northwestern-edu.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[northwestern.edu : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13668-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n7l8m4@u.northwestern.edu,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[u-northwestern-edu.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CC8A2120C12
X-Rspamd-Action: no action

ext2_unlink() calls inode_dec_link_count() unconditionally, which
invokes drop_nlink(). If the inode was loaded from a corrupted disk
image with i_links_count == 0, drop_nlink()
triggers WARN_ON(inode->i_nlink == 0)

Follow the ext4 pattern from __ext4_unlink(): check i_nlink before
decrementing. If already zero, skip the decrement.

Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
---
 fs/ext2/namei.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index bde617a66cec..c746cf169a4d 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -293,7 +293,10 @@ static int ext2_unlink(struct inode *dir, struct dentry *dentry)
 		goto out;
 
 	inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
-	inode_dec_link_count(inode);
+
+	if (inode->i_nlink)
+		inode_dec_link_count(inode);
+
 	err = 0;
 out:
 	return err;
-- 
2.34.1


