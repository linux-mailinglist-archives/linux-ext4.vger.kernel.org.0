Return-Path: <linux-ext4+bounces-12294-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDF1CB5BA7
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 13:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E69DD30413D4
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Dec 2025 12:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A1030C614;
	Thu, 11 Dec 2025 11:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="LLrZEcTU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F5930C344;
	Thu, 11 Dec 2025 11:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765453978; cv=pass; b=TML60y2Dfu6I87/CYAXBlBzy8xYRxmaxhRnft4MnpErZqee22/013+sCZIdAXk5NKsSqws3nbLAvifGxoibLX2gB2ztxTmKkxWwzUu9FZ8JxwxxTp/YNODe/iuIlRFWaY8XZ2DeXch7Qh73328D9V99ntLPq731JKwuHkVVBi+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765453978; c=relaxed/simple;
	bh=bbF+b0TqA2KDpVd4df3EjhwLQXMixlh8mu1jC8tXUcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3gxi3AP2Rp10BFQtwpzjuWjAR8v1yx+SYiXJed3qK6fNtC+1YDHhxxHyVSG46wxBTz+SW1c/NehtWmhrjIGIk8ElnKCkLFsjHiMZAIpADdCz6PruzOEXvo2Ldo8XA8XXCJhSX2zjbRKxKxQDP7wJ7WzUCyTjV0TeeWfDUV/YuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=LLrZEcTU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1765453931; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TUwQdPtmSuAN4EEf7lda+roXdy7muybkuXGbt6HstraA2SkyUwkzfXZ/qeswT78AIINWsaBeic/4ki+FkblcTC6CXEoccp7mR45Lyx7p6qNZAr5esWAddI3Di7oPE8BR129qgySWvtt416xBRms60G1VILVEAFUQbwK2QyryQ1Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1765453931; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vG83/ngcRcACF4tz1GPHGb6JSWUP/wRNZv0bkUKhuJs=; 
	b=BRPh4HuB+zdlPQp5CrOx3uyusVQ/7sUhXxop/GTnNyF1CqgteCLvyyTGptdb8TqBNprwoMXRGPM2OZGMBv/3MBqyzkTz4CR+MOAioOz9jFKgzl6BJOVq4EB2oXK34n+ZtKnRyMxXvLxcXsizTkPxjz8V3ROfgAo3IOSgjmXFWTg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765453931;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=vG83/ngcRcACF4tz1GPHGb6JSWUP/wRNZv0bkUKhuJs=;
	b=LLrZEcTUBTooS5tn0Xv7fzfvo8F/LdzovBQxjyAxCrlLW7YQcGBWhLkOnrOIH4lF
	5m2qWPu9V8mzOfk/7H624Us3qiPIprO/tVjyqkDVXd0/eOUm6aCDcPGS32SGrhnJN3j
	0p/kMHEXZfUDB8qaipKJca5SS1ZIMDU2DWP3jrN0=
Received: by mx.zohomail.com with SMTPS id 1765453930381288.50213733743146;
	Thu, 11 Dec 2025 03:52:10 -0800 (PST)
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
Subject: [RFC 4/5] ext4: mark group add fast-commit ineligible
Date: Thu, 11 Dec 2025 19:51:41 +0800
Message-ID: <20251211115146.897420-5-me@linux.beauty>
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
Online resize via EXT4_IOC_GROUP_ADD updates the superblock and group
descriptor metadata without going through the fast commit tracking
paths.
In practice these operations are rare and usually followed by further
updates, but mixing them into a fast commit makes the overall
semantics harder to reason about and risks replay gaps if new call
sites appear.

Teach ext4 to mark the filesystem fast-commit ineligible when
ext4_ioctl_group_add() adds new block groups.
This forces those transactions to fall back to a full commit,
ensuring that the filesystem geometry updates are captured by the
normal journal rather than partially encoded in fast commit TLVs.
This change should not affect common workloads but makes online
resize via GROUP_ADD safer and easier to reason about under fast
commit.

Testing:
1. prepare:
    dd if=/dev/zero of=/root/fc_resize.img bs=1M count=0 seek=256
    mkfs.ext4 -O fast_commit -F /root/fc_resize.img
    mkdir -p /mnt/fc_resize && mount -t ext4 -o loop /root/fc_resize.img /mnt/fc_resize
2. Ran a helper that issues EXT4_IOC_GROUP_ADD on the mounted
   filesystem and checked the resize ineligible reason:
    ./group_add_helper /mnt/fc_resize
    cat /proc/fs/ext4/loop0/fc_info
   shows "Resize": > 0.
3. Fsynced a file on the resized filesystem and verified that the fast
   commit stats report at least one ineligible commit:
    touch /mnt/fc_resize/file
    /root/fsync_file /mnt/fc_resize/file
    sync
    cat /proc/fs/ext4/loop0/fc_info
   shows fc stats ineligible > 0.

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/ext4/ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index a93a7baae990..57b47b9843f3 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -966,6 +966,7 @@ static long ext4_ioctl_group_add(struct file *file,
 
 	err = ext4_group_add(sb, input);
 	if (EXT4_SB(sb)->s_journal) {
+		ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_RESIZE, NULL);
 		jbd2_journal_lock_updates(EXT4_SB(sb)->s_journal);
 		err2 = jbd2_journal_flush(EXT4_SB(sb)->s_journal, 0);
 		jbd2_journal_unlock_updates(EXT4_SB(sb)->s_journal);
-- 
2.51.0


