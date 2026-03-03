Return-Path: <linux-ext4+bounces-14468-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lTrUDUY4pmnQMgAAu9opvQ
	(envelope-from <linux-ext4+bounces-14468-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 02:24:22 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2191E7A33
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 02:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F20B430790A6
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 01:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A1E3563DD;
	Tue,  3 Mar 2026 01:24:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F411A6810
	for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2026 01:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772501058; cv=none; b=bcht0VL/y4HRPdzg7oo9xcd2gnfP1cYgsW7Dhdg0iRHCpA00b66O6u5Ebe5+vRhhzUy1DkHMcjywH4EyhOZwpvKmRPlkpf7tMDkQx9F8Qvfrh4vX753eawY5+Lna7QGpC939bwpuT8zsSICnCkaBUX2c+dG0xa8kRf8drdGm+EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772501058; c=relaxed/simple;
	bh=T26qdnd/NFAnwX+HuVFfAZZHs+wLkoIsehNBNR9zHc0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M/dmTRfA3iyfzLN+Qa8gZRFkQrHC4NsnIkykrMDSTrtk+3Qhs/HI51IhQw+5Ve1zP5bl+bNPmi4Pln5uN09rLgzEeD4do1OHL3abE+7dvp/lEW224PZF2dctpVcSvu8DCeCx8UJ1mWSrWgQkTffl/xZ8P54sW9JqNl2swAU7jM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fPykd62R0zKHLtC
	for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2026 09:24:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7CC1240591
	for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2026 09:24:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP4 (Coremail) with SMTP id gCh0CgC3ZPU8OKZpUh5+JQ--.63131S4;
	Tue, 03 Mar 2026 09:24:13 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz
Subject: [PATCH -next v3] ext4: test if inode's all dirty pages are submitted to disk
Date: Tue,  3 Mar 2026 09:22:42 +0800
Message-Id: <20260303012242.3206465-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3ZPU8OKZpUh5+JQ--.63131S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1DWryxCw43Ar13Kw4rKrg_yoW8Xw4kpF
	95GrZ8Grn8WrWqk3yIyr42vry5Kan7GFW5XFWFyr10g3sxXry0qF1akF1FkayxtrWfGr4F
	vF45Kw1fCrZxu3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
	xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-Rspamd-Queue-Id: 4A2191E7A33
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14468-lists,linux-ext4=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yebin@huaweicloud.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.898];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huaweicloud.com:mid]
X-Rspamd-Action: no action

From: Ye Bin <yebin10@huawei.com>

The commit aa373cf55099 ("writeback: stop background/kupdate works from
livelocking other works") introduced an issue where unmounting a filesystem
in a multi-logical-partition scenario could lead to batch file data loss.
This problem was not fixed until the commit d92109891f21 ("fs/writeback:
bail out if there is no more inodes for IO and queued once"). It took
considerable time to identify the root cause. Additionally, in actual
production environments, we frequently encountered file data loss after
normal system reboots. Therefore, we are adding a check in the inode
release flow to verify whether all dirty pages have been flushed to disk,
in order to determine whether the data loss is caused by a logic issue in
the filesystem code.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 396dc3a5d16b..d4d65593bce2 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -184,6 +184,14 @@ void ext4_evict_inode(struct inode *inode)
 	if (EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)
 		ext4_evict_ea_inode(inode);
 	if (inode->i_nlink) {
+		/*
+		 * If there's dirty page will lead to data loss, user
+		 * could see stale data.
+		 */
+		if (unlikely(!ext4_emergency_state(inode->i_sb) &&
+		    mapping_tagged(&inode->i_data, PAGECACHE_TAG_DIRTY)))
+			ext4_warning_inode(inode, "data will be lost");
+
 		truncate_inode_pages_final(&inode->i_data);
 
 		goto no_delete;
-- 
2.34.1


