Return-Path: <linux-ext4+bounces-13413-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sE0mO2lQemnk5AEAu9opvQ
	(envelope-from <linux-ext4+bounces-13413-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 19:07:37 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21895A77A4
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 19:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 569003015FE3
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jan 2026 18:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90981B4257;
	Wed, 28 Jan 2026 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="XReZ3WPt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEBB325495
	for <linux-ext4@vger.kernel.org>; Wed, 28 Jan 2026 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623549; cv=none; b=cNz+d81Kp/mjHbA3tZkSXFzw9shDdzmcYxoximB4DTrdw027Y3LocJXhO+QsnkXeDuXRLeaFvGvsd5k3iJU+G9iPDu7sZhOKd2o5qcLHwR80uXwWMCtmqGkGIQ5Ae9SJIQ6GuhrSGnzbe1XGjtoESfJ6VBFIvSj9BvAadaj5Qeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623549; c=relaxed/simple;
	bh=qFQS3o1l1rxRw6aX6GmDgG9TM4WF3WVtJOm9x7dyjq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=njanx9iTrni+h7oGZ7uu69X1jiaTeTGOuHG4GXo1UcFNGu7IhwhMVczrYaen5j7AyJ0ZhJ22JKuJRLmBSNMscgyWkHzTSMhiVfqxG/SM+YiW5ggWGjAo2n+QMqGXw/Md6DCwE05mAEbAEzyIanZC1ZRKI2gJI+tdllIHKr0YRWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=XReZ3WPt; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-123-50.bstnma.fios.verizon.net [173.48.123.50])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 60SI5Gqp028637
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Jan 2026 13:05:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1769623518; bh=B19L/8chwZF2e8JPRyGJKcXcgpbTlcTxeJqfBKAJHDs=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=XReZ3WPtJuZw95nvqgDaEBPhI/PvtKDdW30H1oZSIk7X96CD3Ktvt1P4c/diEf7OI
	 42ud+VIWQKgC9PtCQOphxFzhtct+h86Dq7ERY+GwLUCzaAuQAarfSVxy3BHBKiJtty
	 PHlzGdw3YJOESuxvcMCzcWaew71in88LyK8KvQO3XCySFggqifTcty5AtOd6NoRoT1
	 kQeMYQqsI5zlZrNkFPFG8jm1snnjxcZg7nH5jQ2niUxAKUvKWvs7Yn31YyREyAZRoQ
	 g5W7TRlqWiEAQ64Dwhb7GTKPwVxhMPzyHxmrGSuwObaGGqtNSIS7lEk/1MnesBwGvs
	 LswuGTqz6KMzQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 0EDE02E00DB; Wed, 28 Jan 2026 13:05:16 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, libaokun@huaweicloud.com
Cc: "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH] ext4: move ext4_percpu_param_init() before ext4_mb_init()
Date: Wed, 28 Jan 2026 13:05:01 -0500
Message-ID: <176962347637.1138505.14003201012666831144.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209133116.731350-1-libaokun@huaweicloud.com>
References: <20251209133116.731350-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mit.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mit.edu:s=outgoing];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[mit.edu:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13413-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tytso@mit.edu,linux-ext4@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21895A77A4
X-Rspamd-Action: no action


On Tue, 09 Dec 2025 21:31:16 +0800, libaokun@huaweicloud.com wrote:
> When running `kvm-xfstests -c ext4/1k -C 1 generic/383` with the
> `DOUBLE_CHECK` macro defined, the following panic is triggered:
> 
> ==================================================================
> EXT4-fs error (device vdc): ext4_validate_block_bitmap:423:
>                         comm mount: bg 0: bad block bitmap checksum
> BUG: unable to handle page fault for address: ff110000fa2cc000
> PGD 3e01067 P4D 3e02067 PUD 0
> Oops: Oops: 0000 [#1] SMP NOPTI
> CPU: 0 UID: 0 PID: 2386 Comm: mount Tainted: G W
>                         6.18.0-gba65a4e7120a-dirty #1152 PREEMPT(none)
> RIP: 0010:percpu_counter_add_batch+0x13/0xa0
> Call Trace:
>  <TASK>
>  ext4_mark_group_bitmap_corrupted+0xcb/0xe0
>  ext4_validate_block_bitmap+0x2a1/0x2f0
>  ext4_read_block_bitmap+0x33/0x50
>  mb_group_bb_bitmap_alloc+0x33/0x80
>  ext4_mb_add_groupinfo+0x190/0x250
>  ext4_mb_init_backend+0x87/0x290
>  ext4_mb_init+0x456/0x640
>  __ext4_fill_super+0x1072/0x1680
>  ext4_fill_super+0xd3/0x280
>  get_tree_bdev_flags+0x132/0x1d0
>  vfs_get_tree+0x29/0xd0
>  vfs_cmd_create+0x59/0xe0
>  __do_sys_fsconfig+0x4f6/0x6b0
>  do_syscall_64+0x50/0x1f0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> ==================================================================
> 
> [...]

Applied, thanks!

[1/1] ext4: move ext4_percpu_param_init() before ext4_mb_init()
      commit: 270564513489d98b721a1e4a10017978d5213bff

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

