Return-Path: <linux-ext4+bounces-7529-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E38A7AA0503
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 09:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC8C3A89C5
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 07:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689D4270EBB;
	Tue, 29 Apr 2025 07:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JOWFpnQU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709A0219E93;
	Tue, 29 Apr 2025 07:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745913143; cv=none; b=FTF1Hyt2RozSQejxdPf/B7+PgqzmGeTdHN6oOd4EGCb+wf8ynim67BJcq8HsFJA2dNPBdjyMZmtzyUDLtA0HgKt/8ygQ3GPnwNw1oqVZe7re4oi2OVWW6tJzTs3dOu/tMwm5N49VWl3wGT/UnzC5c6ZHt8OLDFD+L2EOMLZClAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745913143; c=relaxed/simple;
	bh=wE0U2VGA7GlUPMVPWivqfH6B/Zuo/KqSHYZwBGmVYM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c48XbAStRaIkqryaR00DXp2SCsYWYIkmwZAZZXOCkgnXo48kAky8thceZ35Ef39h6F2110TKOHLxb37mqHvpxcKwNjGo8KirZ5UAnHW/LqCAh2q285TSQ9OSWLASU0eMwibotUynIk76ehStsE+nOxWhji3s4pRAtV6dyX5WiYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JOWFpnQU; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=cHS9pP4p6fCGr0o3s86NTXq06gurSik+u2CaY+Hb9ZY=; b=JOWFpnQUdX01m/onw6NGe8aS4M
	Bel5jI4/CeN9GEHAlfG00VN6+tyHswftPpDndvP6B2RJr1KUKZDxVzomZg9ZeURFZ5wz6S1vlMCkn
	FgaHd8IzyA/zIt+hZ4J3qqdVTco+mYOPecCrQBqi/6ospM5vAtF4YfrIKCCz4VXLT8BbJ6wFWRHXm
	keNrf9zFc/7jEygNfLQcQsx8toZBV728yUNVX0ai8E3m/hKv3ee3EcwgyfigOhGmXX16czcCxserN
	MQhxA/MNMgdlY6JlU0aL5UH3qlQTEYYB79TcWCAjYxHxWKsBPgR0zGVN66hqzC9mqKDDnPKwEIgx1
	z9uJTeWA==;
Received: from 53.red-81-38-30.dynamicip.rima-tde.net ([81.38.30.53] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1u9fl4-000DWe-EC; Tue, 29 Apr 2025 09:52:13 +0200
From: =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>
Date: Tue, 29 Apr 2025 09:51:50 +0200
Subject: [PATCH 6.6/6.12] ext4: goto right label 'out_mmap_sem' in
 ext4_setattr()
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250429-rcn-20250429-v6-6-backport-v1-1-9a27617e4ba8@igalia.com>
X-B4-Tracking: v=1; b=H4sIABWFEGgC/z3MwQqDMAwA0F+RnBdXg2Z2vzI81Bq3MKiSDhmI/
 27ZYcd3eTtkMZUM92oHk02zLqmguVQQXyE9BXUqBnLUuZY8Wkz4x8bIOIb4Xhf7YCDvRxf7m+s
 ZSrCazPr95Q/gmq9cNwTDcZyVbd0RdgAAAA==
X-Change-ID: 20250429-rcn-20250429-v6-6-backport-a299b0c87086
To: stable@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, 
 Brian Foster <bfoster@redhat.com>, kernel-dev@igalia.com, 
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Baokun Li <libaokun1@huawei.com>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.14.2

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 7e91ae31e2d264155dfd102101afc2de7bd74a64 ]

Otherwise, if ext4_inode_attach_jinode() fails, a hung task will
happen because filemap_invalidate_unlock() isn't called to unlock
mapping->invalidate_lock. Like this:

EXT4-fs error (device sda) in ext4_setattr:5557: Out of memory
INFO: task fsstress:374 blocked for more than 122 seconds.
      Not tainted 6.14.0-rc1-next-20250206-xfstests-dirty #726
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:fsstress state:D stack:0     pid:374   tgid:374   ppid:373
                                  task_flags:0x440140 flags:0x00000000
Call Trace:
 <TASK>
 __schedule+0x2c9/0x7f0
 schedule+0x27/0xa0
 schedule_preempt_disabled+0x15/0x30
 rwsem_down_read_slowpath+0x278/0x4c0
 down_read+0x59/0xb0
 page_cache_ra_unbounded+0x65/0x1b0
 filemap_get_pages+0x124/0x3e0
 filemap_read+0x114/0x3d0
 vfs_read+0x297/0x360
 ksys_read+0x6c/0xe0
 do_syscall_64+0x4b/0x110
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: c7fc0366c656 ("ext4: partial zero eof block on unaligned inode size extension")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Link: https://patch.msgid.link/20250213112247.3168709-1-libaokun@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>
---
Hi,

Requesting this fix to be backported to stable v6.6 and v6.12, which
contain the backport for upstream patch
c7fc0366c656 ("ext4: partial zero eof block on unaligned inode size extension").
That patch was also backported to v6.14 but the fix is there already as
well.

Thanks,
Ricardo
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ddfeaf19bff1ba22cea7e108c0564daceb09e9ee..ebb8097b11397fb3e8c005035a808712ac31ee77 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5478,7 +5478,7 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			    oldsize & (inode->i_sb->s_blocksize - 1)) {
 				error = ext4_inode_attach_jinode(inode);
 				if (error)
-					goto err_out;
+					goto out_mmap_sem;
 			}
 
 			handle = ext4_journal_start(inode, EXT4_HT_INODE, 3);

---
base-commit: 23ec0b4057294d86cdefafe373b1f03568f75aff
change-id: 20250429-rcn-20250429-v6-6-backport-a299b0c87086


