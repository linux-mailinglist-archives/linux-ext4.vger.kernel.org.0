Return-Path: <linux-ext4+bounces-11698-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6481C4265B
	for <lists+linux-ext4@lfdr.de>; Sat, 08 Nov 2025 05:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D90474E36E5
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Nov 2025 04:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D047F2D738A;
	Sat,  8 Nov 2025 04:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="g3gswGtw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43975213E89;
	Sat,  8 Nov 2025 04:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762574703; cv=none; b=Hs2+sWqwglzSpWjoxBegiKWPMQpdmaR6UJdmlZKfQWyj4rZ7CYG4DhjoFbFCN4hYcrYDWC88Z5UMiwZi2B8C90iTnCKxTlOS5m6VtIDlXFJ/Ze6rgBgWZVq+r2jAlPtaKS8G1NBcmbRl47+cImTiK7kTs6rO7+IIXopONgPZ6BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762574703; c=relaxed/simple;
	bh=DAPBOunjrN2WBG1qy858QFtGOAdDA5SvkDZT8mq+yTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JGk4LYUtUXqQpvED93ZSMQgR5nV0Fq03erWKfSb9KNPDAjf5/cM69owDTXhz6WWhx32EKN5yoFBA52HQ8f3QoRwRJhzB/XChIUkceK2dDiHMSNBeDqOnXC6znH61RAKvB0tUJa+OLrT/XFKd1rLgtSxslChIkLbqs7I2etRD09Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=g3gswGtw; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from canpmsgout06.his.huawei.com (unknown [172.19.92.157])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4d3Mdm54HDzThDX;
	Sat,  8 Nov 2025 12:00:12 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lqgvkFa3e8i8MM1SshqaM3MIjNOge6PEtlvJ9SHBLBk=;
	b=g3gswGtw+MWqpjhot7+3x63T2c+j1EPMEHCwWwtp1u8aQZeuAWJYBdd++dZgb3Qxr3fPPkUwX
	0zBMKiD1H+e8lI+DQqk6trAevmhC8v8DkLrEr45KOwwY/yX+blMti+GSreYFI50AuZdCZD5QEJk
	giXuE6u8mxaNqZghKHUCJMA=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4d3MjD5pJtzRhRF;
	Sat,  8 Nov 2025 12:03:12 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 45CA318048E;
	Sat,  8 Nov 2025 12:04:49 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 8 Nov
 2025 12:04:48 +0800
Message-ID: <7350e19f-f2d2-4b2a-8ced-b57c73f4fccb@huawei.com>
Date: Sat, 8 Nov 2025 12:04:47 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ext4: fix string copying in
 parse_apply_sb_mount_options()
Content-Language: en-GB
To: Fedor Pchelkin <pchelkin@ispras.ru>
CC: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
	<linux-ext4@vger.kernel.org>, Andreas Dilger <adilger.kernel@dilger.ca>,
	"Darrick J. Wong" <djwong@kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, <stable@vger.kernel.org>
References: <20251101160430.222297-1-pchelkin@ispras.ru>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251101160430.222297-1-pchelkin@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-11-02 00:04, Fedor Pchelkin wrote:
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
> Since userspace is expected to provide s_mount_opts field to be at most 63
> characters long with the ending byte being NUL-term, use a 64-byte buffer
> which matches the size of s_mount_opts, so that strscpy_pad() does its job
> properly.  Return with error if the user still managed to provide a
> non-NUL-term string here.
>
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>
> Fixes: 8ecb790ea8c3 ("ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Looks good to me.

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>
> v2: - treat non-NUL-term s_mount_opts as invalid case (Jan Kara)
>     - swap order of patches in series so the fixing-one goes first
>
> v1: https://lore.kernel.org/lkml/20251028130949.599847-1-pchelkin@ispras.ru/T/#u
>
>  fs/ext4/super.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 33e7c08c9529..15bef41f08bd 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2475,7 +2475,7 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
>  					struct ext4_fs_context *m_ctx)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> -	char s_mount_opts[65];
> +	char s_mount_opts[64];
>  	struct ext4_fs_context *s_ctx = NULL;
>  	struct fs_context *fc = NULL;
>  	int ret = -ENOMEM;
> @@ -2483,7 +2483,8 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
>  	if (!sbi->s_es->s_mount_opts[0])
>  		return 0;
>  
> -	strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts);
> +	if (strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts) < 0)
> +		return -E2BIG;
>  
>  	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
>  	if (!fc)



