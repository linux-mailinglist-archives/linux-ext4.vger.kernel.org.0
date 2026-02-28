Return-Path: <linux-ext4+bounces-14229-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B+VJdhZommp2AQAu9opvQ
	(envelope-from <linux-ext4+bounces-14229-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Feb 2026 03:58:32 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5641C00B2
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Feb 2026 03:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 891D4304C080
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Feb 2026 02:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755D8326928;
	Sat, 28 Feb 2026 02:58:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E2220C463
	for <linux-ext4@vger.kernel.org>; Sat, 28 Feb 2026 02:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772247509; cv=none; b=HBvSeYX/NS0ZZ7AM5pAyqjIW7pmArHD9SdEm/SWQRXKv+NqPwGDNxvpAfE68MoGDNAcOGfa7zOKIhCwAwAkoQj3Q5PzK5otSxMW+8suFUyEFAGpUy+I2YXUJKzL39qL+KWe3G/VOoEwg2eQuViXklbCbOwj79KnJsUFOZuqdibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772247509; c=relaxed/simple;
	bh=kZs6e65XA+iG2UXiFCiQ0FiHeJNLSZbcY2hCNwrnNkk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W/wG2hGun9gN7N+E85D70XeLIUMrLBWB1EQsH4I7uFGcomU65q4mJTOHPSo3x5KwxD/JgSP/tW9HyhAmNnh81fajopEkPHq27hWWRRDySqK3N+zWeOMtogV57ryfvf5lRvPM+Uo22Lxv9rjv4TcJbmCga/3MFjVPeNxk1jRCBYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fN8y56l9xzYQtll
	for <linux-ext4@vger.kernel.org>; Sat, 28 Feb 2026 10:57:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1198B40539
	for <linux-ext4@vger.kernel.org>; Sat, 28 Feb 2026 10:58:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP4 (Coremail) with SMTP id gCh0CgAXePjIWaJpklgXJA--.39888S4;
	Sat, 28 Feb 2026 10:58:17 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: jack@suse.cz
Subject: [PATCH v2] ext4: test if inode's all dirty pages are submitted to disk
Date: Sat, 28 Feb 2026 10:56:50 +0800
Message-Id: <20260228025650.2664098-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXePjIWaJpklgXJA--.39888S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uF1DWryxCw43Ar13Kw4rKrg_yoW8XF1DpF
	95GFW5Grn5Ww4qkrWIya17Zry5Kan7GFW5ZFWFyF1Fg3sxWry0vF1akF4FkayUtrZ3Gr4F
	vF45K34fArZxu3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnI
	WIevJa73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14229-lists,linux-ext4=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	NEURAL_HAM(-0.00)[-0.969];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: DA5641C00B2
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
 fs/ext4/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 396dc3a5d16b..a64d9c7381ea 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -184,6 +184,12 @@ void ext4_evict_inode(struct inode *inode)
 	if (EXT4_I(inode)->i_flags & EXT4_EA_INODE_FL)
 		ext4_evict_ea_inode(inode);
 	if (inode->i_nlink) {
+		/*
+		 * If there's dirty page will lead to data loss, user
+		 * could see stale data.
+		 */
+		WARN_ON(!ext4_emergency_state(inode->i_sb) &&
+			mapping_tagged(&inode->i_data, PAGECACHE_TAG_DIRTY));
 		truncate_inode_pages_final(&inode->i_data);
 
 		goto no_delete;
-- 
2.34.1


