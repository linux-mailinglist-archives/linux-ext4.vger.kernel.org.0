Return-Path: <linux-ext4+bounces-13377-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LQPKM2+eWl/ywEAu9opvQ
	(envelope-from <linux-ext4+bounces-13377-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 08:46:21 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 627659DD94
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 08:46:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF661300E3BB
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 07:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374CE31ED88;
	Wed, 28 Jan 2026 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="f+qEiSG9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AFB3161A8
	for <linux-ext4@vger.kernel.org>; Wed, 28 Jan 2026 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769586377; cv=none; b=Wnz7GWFNyGnQBXcu19qKXfMfC8pUnDWvqsWN5ZYIJgKe5mlXVGMAb362QYa7s/tRKx55cDaXm6+6zbCmToFuCmjbvGeqM4n11ML8AF2ADbgOzdw5BaXKLwWh/5q4APO3/co5CrkoL1AtzsywtCrldtr/K37E49SKxwPSq1PHmfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769586377; c=relaxed/simple;
	bh=GvSxX/6fLXVeaPSQG2McNMhXej+D7HQAlplTMiM95Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jadf6qG0UN006r/tqpdeVZ9jCoXMsjsfMf1R6sCP9jP+LLSbzlkIqz1KpZV+m73wlY9BepBiHtK/PKsaT5vWlAXWEkCElAOpqjK4qx9OFa9RvmiHRjWlYZQqPRhDylz29MesSTOrHUPd/zwotQatooGqG7Zgx7/VyPS2CWVwjo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=f+qEiSG9; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 746FA3F2BA
	for <linux-ext4@vger.kernel.org>; Wed, 28 Jan 2026 07:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1769586367;
	bh=Gpd2omspOUj0LE8fFt7xpcbIn/cwC6f49DqbEAmzflE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=f+qEiSG9qtR0glMK9Qrvc6FHlECNZlIp8XJ/G6Dz75xzAsxLpluKLvb5m7OjTbh4X
	 vFOlV5w+vbKJdPlPOnkbIsFKGPuHiN5ulkEeMz/Bj9cOO0xRcuyv1mV7YKAv1mTHOD
	 XgOl4Q8j1i+Im6CPKZRpQfClH6Ia0I9HqHSLjI8lNESOgjgOiYxk22cG6668/BFb9l
	 7Xv12v2b7CsQllcRuxcIut00JV+wldvC0MJn9cjowNQkQLzLzlcWvkMCwxVb+6nUYX
	 1u3rmfV8m/FPUOXWx9hCPOLGx/eIhkx91tPB6mk6WBRk/u5QIZqGX1bFMCKojdNsrd
	 Y+IlbexzXvyD+OoBmqt2qhYxPL8aViluQImjMXg8g8PDxWYjGIP3RSrHZWF2QQkhhM
	 KlGh8EsNArFAP2rDpCNidCJN1FcxEtt9smPe53VJE1fjKowcv3HVlzzWNGEw8WEL8q
	 97sXAQGi8kDItdXZE3Ra7A5WWHg6tal+oNmnfMPKFNKLUhCmMY2YzzyWEp3ujlRlSI
	 1mHMlEf+aZZh5zYLG3LMEXlL6ZkX041CvSeSlkW4XHOjiLdC6NxDREuIUkVdlaVH8K
	 Tmv+zsP49hhBxwdpwMpsFfCugxE9l6S/GqVoaGwv82qXOi9MkPUYsnKIbz8vTYDn0a
	 Rf2BmpAzCtAmCOpo0YGuS3CE=
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c63597a63a6so3306531a12.3
        for <linux-ext4@vger.kernel.org>; Tue, 27 Jan 2026 23:46:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769586366; x=1770191166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gpd2omspOUj0LE8fFt7xpcbIn/cwC6f49DqbEAmzflE=;
        b=BLedB0i70pLyL/92ucpHDXu7C0t0FowlPuGNalEid+H6+uH4muKJl6Y0uHnVlqFEgI
         +lCRWlorUoknCV/U/cLbKyCZDsxUolQzxl1N4AENWqpeYCieGTgmiWLzIN9SP9/zrYts
         qseBjilQBLK7VajVEVi1dCZLg7nov3E9MLEGgnTQTgI5dYyMxrRnp6HoU4TGgS6iwu68
         UoG2+WEUC7upc7a/hzUlstZA6487F13dg7Ej45Noi6JWqPJUF3uOCaDaYEM9MVC26Qcr
         pQD0IWTS6p/PUf7/Rs5vjbnoRU9/2tM3hAJ+8apPR5885CyxH+yF/cWS70+ZOxYby/jP
         69Dg==
X-Gm-Message-State: AOJu0YyrJrPjZmtiKdhoCaTCpEp0lRQKxsbaZlCCUJKQHuSQyy9bfaWv
	JZEa814NpleePTefyhmT2VmEp3cNqsg54GEa8bOvNyF9yugXAjmI3579igpzYVAYlu3JCED1AHF
	jsWKNIDateWUix5oZ94QXljbwUBOqDDElLnaiGCugD35JgDyU8fVlKvrwRCQQ4jkQC65tsLcR9m
	IEq4U=
X-Gm-Gg: AZuq6aKdmo1R3uIYGrFnBIWmHmnqfgDotiGHdll1I3xNsxBM3B1x15ZNmEYcQMK1YL2
	5zcPr1GQO/PierSX+Z3r91fEyrz3QmmFABGv9d97CJi2Cr6ILqOllsX5m2bnaxitJdbLYsHhHNa
	Xy5LqGIhTHeBUipldty86vxXnVCxcl70V0J+GT4zfJ/TWojMb0GiitRix3B+JbutljizcvVXb+E
	u+dvdLiRzzmPeVbpTF01m18EfMda0hhb3w4UmKF3zmp/8lSD1z3kGaBI5BkPlBhaUD5aDo+GZZA
	XBzPUpz5ET2ElU602zDgHDCy+gyxWUus//UGQ9QIJpoqhQZ4nTBIxAWbLmsJ4V+3NBTgTYgu25+
	4mRRJjTYR5eMI2XsBGG38w8iaZ2S8qlSXaVsQW8Sc9qA8R6cpNik2UUOfKq+nAtLy9w==
X-Received: by 2002:a17:90a:9f93:b0:340:f7d6:dc70 with SMTP id 98e67ed59e1d1-353fecdf887mr2781747a91.13.1769586365892;
        Tue, 27 Jan 2026 23:46:05 -0800 (PST)
X-Received: by 2002:a17:90a:9f93:b0:340:f7d6:dc70 with SMTP id 98e67ed59e1d1-353fecdf887mr2781732a91.13.1769586365474;
        Tue, 27 Jan 2026 23:46:05 -0800 (PST)
Received: from localhost.localdomain (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-353f61dfac1sm4725598a91.9.2026.01.27.23.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 23:46:04 -0800 (PST)
From: Gerald Yang <gerald.yang@canonical.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz
Cc: linux-ext4@vger.kernel.org,
	gerald.yang.tw@gmail.com,
	Gerald Yang <gerald.yang@canonical.com>
Subject: [PATCH] ext4: Fix call trace when remounting to read only in data=journal mode
Date: Wed, 28 Jan 2026 15:45:15 +0800
Message-ID: <20260128074515.2028982-1-gerald.yang@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,canonical.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13377-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gerald.yang@canonical.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-0.990];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:email,canonical.com:dkim,canonical.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 627659DD94
X-Rspamd-Action: no action

When remounting the filesystem to read only in data=journal mode
it may dump the following call trace:

[   71.629350] CPU: 0 UID: 0 PID: 177 Comm: kworker/u96:5 Tainted: G            E       6.19.0-rc7 #1 PREEMPT(voluntary)
[   71.629352] Tainted: [E]=UNSIGNED_MODULE
[   71.629353] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)/LXD, BIOS unknown 2/2/2022
[   71.629354] Workqueue: writeback wb_workfn (flush-7:4)
[   71.629359] RIP: 0010:ext4_journal_check_start+0x8b/0xd0
[   71.629360] Code: 31 ff 45 31 c0 45 31 c9 e9 42 ad c4 00 48 8b 5d f8 b8 fb ff ff ff c9 31 d2 31 c9 31 f6 31 ff 45 31 c0 45 31 c9 c3 cc cc cc cc <0f> 0b b8 e2 ff ff ff eb c2 0f 0b eb
 a9 44 8b 42 08 68 c7 53 ce b8
[   71.629361] RSP: 0018:ffffcf32c0fdf6a8 EFLAGS: 00010202
[   71.629364] RAX: ffff8f08c8505000 RBX: ffff8f08c67ee800 RCX: 0000000000000000
[   71.629366] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   71.629367] RBP: ffffcf32c0fdf6b0 R08: 0000000000000001 R09: 0000000000000000
[   71.629368] R10: ffff8f08db18b3a8 R11: 0000000000000000 R12: 0000000000000000
[   71.629368] R13: 0000000000000002 R14: 0000000000000a48 R15: ffff8f08c67ee800
[   71.629369] FS:  0000000000000000(0000) GS:ffff8f0a7d273000(0000) knlGS:0000000000000000
[   71.629370] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   71.629371] CR2: 00007b66825905cc CR3: 000000011053d004 CR4: 0000000000772ef0
[   71.629374] PKRU: 55555554
[   71.629374] Call Trace:
[   71.629378]  <TASK>
[   71.629382]  __ext4_journal_start_sb+0x38/0x1c0
[   71.629383]  mpage_prepare_extent_to_map+0x4af/0x580
[   71.629389]  ? sbitmap_get+0x73/0x180
[   71.629399]  ext4_do_writepages+0x3cc/0x10a0
[   71.629400]  ? kvm_sched_clock_read+0x11/0x20
[   71.629409]  ext4_writepages+0xc8/0x1b0
[   71.629410]  ? ext4_writepages+0xc8/0x1b0
[   71.629411]  do_writepages+0xc4/0x180
[   71.629416]  __writeback_single_inode+0x45/0x350
[   71.629419]  ? _raw_spin_unlock+0xe/0x40
[   71.629423]  writeback_sb_inodes+0x260/0x5c0
[   71.629425]  ? __schedule+0x4d1/0x1870
[   71.629429]  __writeback_inodes_wb+0x54/0x100
[   71.629431]  ? queue_io+0x82/0x140
[   71.629433]  wb_writeback+0x1ab/0x330
[   71.629448]  wb_workfn+0x31d/0x410
[   71.629450]  process_one_work+0x191/0x3e0
[   71.629455]  worker_thread+0x2e3/0x420

This issue can be easily reproduced by:
mkdir -p mnt
dd if=/dev/zero of=ext4disk bs=1G count=2 oflag=direct
mkfs.ext4 ext4disk
tune2fs -o journal_data ext4disk
mount ext4disk mnt
fio --name=fiotest --rw=randwrite --bs=4k --runtime=3 --ioengine=libaio --iodepth=128 --numjobs=4 --filename=mnt/fiotest --filesize=1G --group_reporting
mount -o remount,ro ext4disk mnt
sync

In data=journal mode, metadata and data are both written to the journal
first, but for the second write, ext4 relies on the writeback thread to
flush the data to the real file location.

After the filesystem is remounted to read only, writeback thread still
writes data to it and causes the issue. Return early to avoid starting
a journal transaction on a read only filesystem, once the filesystem
becomes writable again, the write thread will continue writing data.

Signed-off-by: Gerald Yang <gerald.yang@canonical.com>
---
 fs/ext4/inode.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 15ba4d42982f..4e3bbf17995e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2787,6 +2787,17 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 	if (unlikely(ret))
 		goto out_writepages;
 
+	/*
+	 * For data=journal, if the filesystem was remounted read-only,
+	 * the writeback thread may still write dirty pages to it.
+	 * Return early to avoid starting a journal transaction on a
+	 * read-only filesystem.
+	 */
+	if (ext4_should_journal_data(inode) && sb_rdonly(inode->i_sb)) {
+		ret = -EROFS;
+		goto out_writepages;
+	}
+
 	/*
 	 * If we have inline data and arrive here, it means that
 	 * we will soon create the block for the 1st page, so
-- 
2.43.0


