Return-Path: <linux-ext4+bounces-13585-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMRhEb/4hWlEIwQAu9opvQ
	(envelope-from <linux-ext4+bounces-13585-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 15:20:47 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8DCFEBEA
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 15:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF7093013A50
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Feb 2026 14:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3EF3EF0DC;
	Fri,  6 Feb 2026 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IuSoCLRs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A383D301F;
	Fri,  6 Feb 2026 14:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770387622; cv=none; b=jlN54921ZrT0h9onGveDqRSe4BMOyc6fSPafn7XvnXPk39yOZz7g+VzdRrdvxXUZIFSxne5Q8xOydy7VBucxKbI5mCLNC+Bat66diL+uJF1oRi3yCM4VLZnBz+r23t2WFE0EGSxQyui0jjcHnpCJrBaUd9A4lCJGK3P5Wb9TQ1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770387622; c=relaxed/simple;
	bh=uCTjK/Y0kFMcypq3m/UrIiqMil9+P7DfzqeY+hnGZNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCJTkFO5nTnyf8qKyPpMs332NM+sdb3jI1fuNeb+P5JvviZrUGobnLcw3QA2akCOVCYt/lR5Po25n69WXp2vhl6t0FyJqGbhR7scfKpvxa4Ftd5ZsLoK1QNHdatxP6EKoiVoYMaDIWyslio5uitV8uvJuZEbEdehOZE8lU9Y+rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IuSoCLRs; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770387621; x=1801923621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uCTjK/Y0kFMcypq3m/UrIiqMil9+P7DfzqeY+hnGZNo=;
  b=IuSoCLRsje0DhOTeMI+a3VP6OCDtaURmohsCdkxOxjpCkaYZ5LIZzEvd
   wZSWDSlanWUmZxC+8Mf9V7eXLIy8QDCc93+1JHrSAE2QZcbzyq7jJXE3r
   5a7HmTstWLgFNfPh165SOfJjmbAs14HBVyBud93eNiXV6kHdBQcvdbUdP
   0ZAmXv5RLlcEeYqJuQs/B8JQ/Fl5CUFFlxOjLUiSOgrasxg2MVro+UmO/
   218FeSw5CxvTDqHMebeohqR4B+MLJzfeGIOly5Tcb07xTcN8Qw0LMmqbI
   8O3gN1U0FZEk7urk7k8t4Iiw58K/TcZNQpzw8Ie46QI4tN+Dfxy/5LSBW
   w==;
X-CSE-ConnectionGUID: FHTVssddRiSl2Z77OV+ZfA==
X-CSE-MsgGUID: l6yro6JUR46UmNwDME6pNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="75212717"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="75212717"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 06:20:20 -0800
X-CSE-ConnectionGUID: PA7dGKLlSXitAghISqB7eg==
X-CSE-MsgGUID: ygzttfDSSFePBMoGVK9j4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="233825471"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.202])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 06:20:17 -0800
Date: Fri, 6 Feb 2026 16:20:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: =?utf-8?B?5p2O6b6Z5YW0?= <coregee2000@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org
Cc: syzkaller@googlegroups.com, kees@kernel.org, andy@kernel.org,
	akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Kernel Bug] WARNING in ext4_fill_super
Message-ID: <aYX4n42gmy75aw4Y@smile.fi.intel.com>
References: <CAHPqNmzBb2LruMA6jymoHXQRsoiAKMFZ1wVEz8JcYKg4U6TBbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHPqNmzBb2LruMA6jymoHXQRsoiAKMFZ1wVEz8JcYKg4U6TBbw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13585-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,mit.edu,dilger.ca,vger.kernel.org];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@intel.com,linux-ext4@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smile.fi.intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A8DCFEBEA
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 12:19:45PM +0800, 李龙兴 wrote:
> Dear Linux kernel developers and maintainers,
> 
> We would like to report a new kernel bug found by our tool. The issue
> is a WARNING in ext4_fill_super. Details are as follows.

First of all, the warning appears in parse_apply_sb_mount_options().

> Kernel commit: v6.18.2
> Kernel config: see attachment
> report: see attachment

Second, you should include people based on the actual subsystem, unless it's
proven that the problem is in lib/*.

Cc'ed to ext4.

> We are currently analyzing the root cause and  working on a
> reproducible PoC. We will provide further updates in this thread as
> soon as we have more information.


> loop4: detected capacity change from 0 to 514
> ------------[ cut here ]------------
> strnlen: detected buffer overflow: 65 byte read of buffer size 64
> WARNING: CPU: 0 PID: 12320 at lib/string_helpers.c:1035
> __fortify_report+0x9c/0xd0 lib/string_helpers.c:1035
> Modules linked in:
> CPU: 0 UID: 0 PID: 12320 Comm: syz.4.59 Not tainted 6.18.2 #1 PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:__fortify_report+0x9c/0xd0 lib/string_helpers.c:1035
> Code: ed 48 c7 c0 80 c8 cf 8b 48 0f 44 d8 e8 cd dd 17 fd 4d 89 e0 48
> 89 ea 4c 89 f6 48 89 d9 48 c7 c7 00 c9 cf 8b e8 b5 57 d6 fc 90 <0f> 0b
> 90 90 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc 48 89 de 48 c7
> RSP: 0018:ffffc90011f9fa18 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffffffff8bcfc880 RCX: ffffffff817afc38
> RDX: ffff8881095eca80 RSI: ffffffff817afc45 RDI: 0000000000000001
> RBP: 0000000000000041 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000040
> R13: 0000000000000000 R14: ffffffff8bcfd240 R15: ffff88803c484400
> FS:  00007f9e5f45c640(0000) GS:ffff8880cf053000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000123400000 CR4: 0000000000752ef0
> PKRU: 80000000
> Call Trace:
>  <TASK>
>  __fortify_panic+0x23/0x30 lib/string_helpers.c:1042
>  strnlen include/linux/fortify-string.h:235 [inline]
>  sized_strscpy include/linux/fortify-string.h:309 [inline]
>  parse_apply_sb_mount_options fs/ext4/super.c:2486 [inline]
>  __ext4_fill_super fs/ext4/super.c:5306 [inline]
>  ext4_fill_super+0x3972/0xaf70 fs/ext4/super.c:5736
>  get_tree_bdev_flags+0x38c/0x620 fs/super.c:1698
>  vfs_get_tree+0x8e/0x340 fs/super.c:1758
>  fc_mount fs/namespace.c:1199 [inline]
>  do_new_mount_fc fs/namespace.c:3642 [inline]
>  do_new_mount fs/namespace.c:3718 [inline]
>  path_mount+0x7b9/0x23a0 fs/namespace.c:4028
>  do_mount fs/namespace.c:4041 [inline]
>  __do_sys_mount fs/namespace.c:4229 [inline]
>  __se_sys_mount fs/namespace.c:4206 [inline]
>  __x64_sys_mount+0x293/0x310 fs/namespace.c:4206
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x56755e
> Code: 48 c7 c0 ff ff ff ff eb aa e8 3e 1c 00 00 66 2e 0f 1f 84 00 00
> 00 00 00 0f 1f 40 00 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f9e5f45bdf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007f9e5f45be80 RCX: 000000000056755e
> RDX: 0000000020000140 RSI: 0000000020000440 RDI: 00007f9e5f45be40
> RBP: 0000000020000140 R08: 00007f9e5f45be80 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020000440
> R13: 00007f9e5f45be40 R14: 00000000000003d5 R15: 0000000020000200
>  </TASK>
> 
> https://drive.google.com/file/d/12W8B3IU88RBdBpV4nMcAj9TVOzlx6xL-/
> https://drive.google.com/file/d/1efTUJTmSTMuJqSpCq686RjXdUzhyEJDL/

-- 
With Best Regards,
Andy Shevchenko



