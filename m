Return-Path: <linux-ext4+bounces-11884-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E56C65EFC
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 20:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09FEF4F1F69
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Nov 2025 19:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C7B33C530;
	Mon, 17 Nov 2025 19:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="I8XmeTTz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08CA3093AE
	for <linux-ext4@vger.kernel.org>; Mon, 17 Nov 2025 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763406985; cv=none; b=t08ZJX5zKMiDaT0RqvSlzxS/dQNwfWp+yqVcqX9bDSuHD9r5jygQV++VFG1eb3LxxGLHslkEy6ISfJhLL0j9ghmhvFL3NT6kKrpCKP/7q2jobKm94ZeaR68huO/v9FI/DMZYWil6PBDRM1ExpFLZhOCtNeyar5qw1WLHaQ2Bv60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763406985; c=relaxed/simple;
	bh=rbJzXKItKYr+U5o4o4OscBnQtNIZzlJEJXtz7E9/Z9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oiasYhCex2fpp/XgNc03s45EZhO3ac0aNxClpzLqM+DClJu/b0BEnIp0K0xcoQ81UVCmHQi1v3lhly/AjJt7/2T+9pECclYCjgMOxfwH7YmukH6FKtLgZSJh4wli9CzFgFq3jlFThjb75kc1yx0+rT6zMxRDTVMqTp2at8wQPPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=I8XmeTTz; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-114-69.bstnma.fios.verizon.net [173.48.114.69])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AHJDoSK020573
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 14:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1763406833; bh=kSvqqUPl7yymxqG13UPEos8QgcCE/m0fKfgNjTXmHno=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=I8XmeTTzPDUgk9nUO8xIxg5D5G4qzB4sjelJgQlzD5M7VG6wjq/yjgDvp+RCLej7R
	 bpXZiel+XISW5FTjMpnUwWq9FbjIsiVBFRUKDFgpgpeeO0+aLofSoR0tCPtrDNBj9u
	 kUZIa3q1115ENhkQiN7IIIV56vXbSNVfr0lDjc3CpK5yvB3pwTqm/MXtR0vhU8aA0O
	 TmJe/2SBlnVO5KaWKu/tQb17kD75TetRnDXbwWjUMOcn/d1ExoO2oVfBzC9dncRrsk
	 R9VuwH/MN99XtXpkANf4eb2O0RPtGdExahljHDq3Bncx9d2GLW8wo2QOUUG1pjcY0S
	 ZC41ONAbnWZ1A==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 42FB02E00DD; Mon, 17 Nov 2025 14:13:50 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Fedor Pchelkin <pchelkin@ispras.ru>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ext4: fix string copying in parse_apply_sb_mount_options()
Date: Mon, 17 Nov 2025 14:13:34 -0500
Message-ID: <176340680644.138575.9603909521172863181.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251101160430.222297-1-pchelkin@ispras.ru>
References: <20251101160430.222297-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 01 Nov 2025 19:04:28 +0300, Fedor Pchelkin wrote:
> strscpy_pad() can't be used to copy a non-NUL-term string into a NUL-term
> string of possibly bigger size.  Commit 0efc5990bca5 ("string.h: Introduce
> memtostr() and memtostr_pad()") provides additional information in that
> regard.  So if this happens, the following warning is observed:
> 
> strnlen: detected buffer overflow: 65 byte read of buffer size 64
> WARNING: CPU: 0 PID: 28655 at lib/string_helpers.c:1032 __fortify_report+0x96/0xc0 lib/string_helpers.c:1032
> Modules linked in:
> CPU: 0 UID: 0 PID: 28655 Comm: syz-executor.3 Not tainted 6.12.54-syzkaller-00144-g5f0270f1ba00 #0
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:__fortify_report+0x96/0xc0 lib/string_helpers.c:1032
> Call Trace:
>  <TASK>
>  __fortify_panic+0x1f/0x30 lib/string_helpers.c:1039
>  strnlen include/linux/fortify-string.h:235 [inline]
>  sized_strscpy include/linux/fortify-string.h:309 [inline]
>  parse_apply_sb_mount_options fs/ext4/super.c:2504 [inline]
>  __ext4_fill_super fs/ext4/super.c:5261 [inline]
>  ext4_fill_super+0x3c35/0xad00 fs/ext4/super.c:5706
>  get_tree_bdev_flags+0x387/0x620 fs/super.c:1636
>  vfs_get_tree+0x93/0x380 fs/super.c:1814
>  do_new_mount fs/namespace.c:3553 [inline]
>  path_mount+0x6ae/0x1f70 fs/namespace.c:3880
>  do_mount fs/namespace.c:3893 [inline]
>  __do_sys_mount fs/namespace.c:4103 [inline]
>  __se_sys_mount fs/namespace.c:4080 [inline]
>  __x64_sys_mount+0x280/0x300 fs/namespace.c:4080
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x64/0x140 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [...]

Applied, thanks!

[1/2] ext4: fix string copying in parse_apply_sb_mount_options()
      commit: c517b381de9490b910ab451c2177aa32064678ad
[2/2] ext4: check if mount_opts is NUL-terminated in ext4_ioctl_set_tune_sb()
      commit: 687524bafd4e86cfa783857f8045460f4caee921

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

