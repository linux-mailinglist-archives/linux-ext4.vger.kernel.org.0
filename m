Return-Path: <linux-ext4+bounces-12295-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC063CB5BB3
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 13:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 243C4304744B
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 12:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4F530C342;
	Thu, 11 Dec 2025 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="YVjCLbge"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFAA3019C7;
	Thu, 11 Dec 2025 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765453988; cv=pass; b=GcjzLAvyxAfVpqHD8rHUF/ACiQxLE3Fl2vrJOMgyp+D9CFpUsk9pI8KPFLUF4jlcPWCocM6saYteVl+R6SSvrgRyw0aBedivnJI8co9bPMPGZhLSke25mKVK69HYEIRBcCtHrIlv/3sFHx78e3ia3scAKLIM0dAHppJbm8cHiH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765453988; c=relaxed/simple;
	bh=+HUSdOr8NWWRkdYoDBZEOdwvEx8lxuLm9f5q4yRmgvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMDPHzBMrOVrsPV8xoeGJwoEvpHQrlSRsRVEqzm4K9mqK15kJfNgozVuHKL6JHUsiNyfRk7mY/q+O8+rJs1H9lBPrR23k4wzRKBSQWgALPpiLhFwovydorJA3Sf+nVE17abNSE4p9niJ/UxHjXzcCpYgsqc7Fd63rziPIYFfT/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=unknown smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=YVjCLbge; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1765453935; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ORxm8/LZA6Ek4RFD0Yk/xyVxl8p4PMR+rQA1C8MrAH302PYnKfJwl4fxKXd1X39q6SJjA+FRRBwvf7wP+HjeUnpLiQGef0/WLdOvM356cHgI9DygEXGbLBmCTpLKOpOKCvWO4tD990NEut73vUGKXbv8Eluv3/31laJTXHXo2wE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765453935; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UHHv0+HlKFGfny4sGBUCRmGh7ywqTRASV5X/HQmso7w=; 
	b=e0aKXh2NtwYWsN4uCjBCWMlXmBOgHamIAX5+2ZousBsb/YhzqTMRDP8Al5f7zv9gyaaurHi1mSbMvWkRfg++raXNMhZSKXlZ7n0mMbb7TgpJDAf45jpZKE7Na4lAhtz8Cu+zwsN5iXjoJJGA+f0ydfQBh8Ay1eXpKgGQLCs+8ro=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765453935;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=UHHv0+HlKFGfny4sGBUCRmGh7ywqTRASV5X/HQmso7w=;
	b=YVjCLbgex6qnLs4AunHhPZOJAPmWiN+LAjG1yBY3ZfRfxSeVY40RH+ChOHc2Qvfi
	JIReWJN2YWsKaSxOpbX2rPJG/r4kXMJXfgV/uXNzCO/Akjft32/MCEMhqWHPEGjuj/G
	u56OkGZztE1kTNVBCX+gm/rc2//1HSjsN0B89pTQ=
Received: by mx.zohomail.com with SMTPS id 176545393326719.79287948199783;
	Thu, 11 Dec 2025 03:52:13 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [RFC 5/5] ext4: mark group extend fast-commit ineligible
Date: Thu, 11 Dec 2025 19:51:42 +0800
Message-ID: <20251211115146.897420-6-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251211115146.897420-1-me@linux.beauty>
References: <20251211115146.897420-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Fast commits only log operations that have dedicated replay support.
EXT4_IOC_GROUP_EXTEND grows the filesystem to the end of the last
block group and updates the same on-disk metadata without going
through the fast commit tracking paths.
In practice these operations are rare and usually followed by further
updates, but mixing them into a fast commit makes the overall
semantics harder to reason about and risks replay gaps if new call
sites appear.

Teach ext4 to mark the filesystem fast-commit ineligible when
EXT4_IOC_GROUP_EXTEND grows the filesystem.
This forces those transactions to fall back to a full commit,
ensuring that the group extension changes are captured by the normal
journal rather than partially encoded in fast commit TLVs.
This change should not affect common workloads but makes online
resize via GROUP_EXTEND safer and easier to reason about under fast
commit.

Testing:
1. prepare:
    dd if=/dev/zero of=/root/fc_resize.img bs=1M count=0 seek=256
    mkfs.ext4 -O fast_commit -F /root/fc_resize.img
    mkdir -p /mnt/fc_resize && mount -t ext4 -o loop /root/fc_resize.img /mnt/fc_resize
2. Extended the filesystem to the end of the last block group using a
   helper that calls EXT4_IOC_GROUP_EXTEND on the mounted filesystem
   and checked fc_info:
    ./group_extend_helper /mnt/fc_resize
    cat /proc/fs/ext4/loop0/fc_info
   shows the "Resize" ineligible reason increased.
3. Fsynced a file on the resized filesystem and confirmed that the fast
   commit ineligible counter incremented for the resize transaction:
    touch /mnt/fc_resize/file
    /root/fsync_file /mnt/fc_resize/file
    sync
    cat /proc/fs/ext4/loop0/fc_info

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/ext4/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 57b47b9843f3..ce92652f8332 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1608,6 +1608,8 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 		err = ext4_group_extend(sb, EXT4_SB(sb)->s_es, n_blocks_count);
 		if (EXT4_SB(sb)->s_journal) {
+			ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_RESIZE,
+						NULL);
 			jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
 			err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal, 0);
 			jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
-- 
2.51.0


