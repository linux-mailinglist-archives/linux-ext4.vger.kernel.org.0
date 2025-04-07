Return-Path: <linux-ext4+bounces-7087-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE836A7DE71
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 15:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF423A93F6
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Apr 2025 13:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA29A24F5A5;
	Mon,  7 Apr 2025 13:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vHXqawzj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kCpajPkj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vHXqawzj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kCpajPkj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572EE22D7A7
	for <linux-ext4@vger.kernel.org>; Mon,  7 Apr 2025 13:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744030984; cv=none; b=nFPdr2AJEuTuwV6rEGW718gqFuRTcUuKX+PfJ0KFWZ2/+IyEY+mkr0Rhy8uctWpFMK6Byxhd3fJDgOMDlTbPz12mIyqKdxceV7OxkndBEk0CSzt999aQF2pnfscI4IwmMrUi6fTYK1o0vEdakOKjA6sMZfKkUcwrrsqtqpv5EAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744030984; c=relaxed/simple;
	bh=eWQPgI8XSPxRiYYryfl8uQnSfNBvxwSJhnDq76893Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9tUxFHEPlLxgZX7tppOohQFIkVnYmWTZX8xpeC/vwbkiB5txOL7JcBzqzrr5pVn7t32SvFDQ8LVmVsJhXoeJoa6HlIgFFzFF6qUz13OtAcqwU6ko0Dn1DhrhypRgbxTCECTSOT5mH5gfpLgnr0FPRRNhEo95BjahUtNwboSNdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vHXqawzj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kCpajPkj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vHXqawzj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kCpajPkj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5DADD1F388;
	Mon,  7 Apr 2025 13:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744030979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ts9MnOf3nqjoKJZUrQWgTAssq3+KWbI9ih4Wh/9+zYs=;
	b=vHXqawzjFpkWyVcPcgkHdGxWOoRHjbu+Z43399bXGkcC9/x9uGRV8wtFB2ngBkzeZN41XO
	s0qZS22zEq5c5gDSJcrU+KAV7wiAehRs0IYEQK6WEHP3l8W9fh3nzjaWtMPgsVjTuruB8O
	gP7261s9hQTN2h7zktDluNgRHqMtwdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744030979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ts9MnOf3nqjoKJZUrQWgTAssq3+KWbI9ih4Wh/9+zYs=;
	b=kCpajPkj7sgkHbQK596rrHxDh6C/7EVSq1taHyEInxIrPJl9RFbi4/49OMRzdvBaQuHI2g
	V3Bc4djqlHooP2CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744030979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ts9MnOf3nqjoKJZUrQWgTAssq3+KWbI9ih4Wh/9+zYs=;
	b=vHXqawzjFpkWyVcPcgkHdGxWOoRHjbu+Z43399bXGkcC9/x9uGRV8wtFB2ngBkzeZN41XO
	s0qZS22zEq5c5gDSJcrU+KAV7wiAehRs0IYEQK6WEHP3l8W9fh3nzjaWtMPgsVjTuruB8O
	gP7261s9hQTN2h7zktDluNgRHqMtwdU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744030979;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ts9MnOf3nqjoKJZUrQWgTAssq3+KWbI9ih4Wh/9+zYs=;
	b=kCpajPkj7sgkHbQK596rrHxDh6C/7EVSq1taHyEInxIrPJl9RFbi4/49OMRzdvBaQuHI2g
	V3Bc4djqlHooP2CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5115113691;
	Mon,  7 Apr 2025 13:02:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WY3EEwPN82dlDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Apr 2025 13:02:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 00A91A08D2; Mon,  7 Apr 2025 15:02:58 +0200 (CEST)
Date: Mon, 7 Apr 2025 15:02:58 +0200
From: Jan Kara <jack@suse.cz>
To: Artem Sadovnikov <a.sadovnikov@ispras.ru>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Eric Sandeen <sandeen@redhat.com>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] ext4: fix off-by-one error in do_split
Message-ID: <odgkvml62unm4ux3sbnympgyzj22z7dwjgdvdmlbgtiybq4j7z@gnnaygdp7muw>
References: <20250404082804.2567-3-a.sadovnikov@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404082804.2567-3-a.sadovnikov@ispras.ru>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 04-04-25 08:28:05, Artem Sadovnikov wrote:
> Syzkaller detected a use-after-free issue in ext4_insert_dentry that was
> caused by out-of-bounds access due to incorrect splitting in do_split.
> 
> BUG: KASAN: use-after-free in ext4_insert_dentry+0x36a/0x6d0 fs/ext4/namei.c:2109
> Write of size 251 at addr ffff888074572f14 by task syz-executor335/5847
> 
> CPU: 0 UID: 0 PID: 5847 Comm: syz-executor335 Not tainted 6.12.0-rc6-syzkaller-00318-ga9cda7c0ffed #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:377 [inline]
>  print_report+0x169/0x550 mm/kasan/report.c:488
>  kasan_report+0x143/0x180 mm/kasan/report.c:601
>  kasan_check_range+0x282/0x290 mm/kasan/generic.c:189
>  __asan_memcpy+0x40/0x70 mm/kasan/shadow.c:106
>  ext4_insert_dentry+0x36a/0x6d0 fs/ext4/namei.c:2109
>  add_dirent_to_buf+0x3d9/0x750 fs/ext4/namei.c:2154
>  make_indexed_dir+0xf98/0x1600 fs/ext4/namei.c:2351
>  ext4_add_entry+0x222a/0x25d0 fs/ext4/namei.c:2455
>  ext4_add_nondir+0x8d/0x290 fs/ext4/namei.c:2796
>  ext4_symlink+0x920/0xb50 fs/ext4/namei.c:3431
>  vfs_symlink+0x137/0x2e0 fs/namei.c:4615
>  do_symlinkat+0x222/0x3a0 fs/namei.c:4641
>  __do_sys_symlink fs/namei.c:4662 [inline]
>  __se_sys_symlink fs/namei.c:4660 [inline]
>  __x64_sys_symlink+0x7a/0x90 fs/namei.c:4660
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  </TASK>
> 
> The following loop is located right above 'if' statement.
> 
> for (i = count-1; i >= 0; i--) {
> 	/* is more than half of this entry in 2nd half of the block? */
> 	if (size + map[i].size/2 > blocksize/2)
> 		break;
> 	size += map[i].size;
> 	move++;
> }
> 
> 'i' in this case could go down to -1, in which case sum of active entries
> wouldn't exceed half the block size, but previous behaviour would also do
> split in half if sum would exceed at the very last block, which in case of
> having too many long name files in a single block could lead to
> out-of-bounds access and following use-after-free.

Thanks for debugging this! The fix looks good, but I'm still failing to see
the use-after-free / end-of-buffer issue. If we wrongly split to two parts
count/2 each, then dx_move_dirents() and dx_pack_dirents() seem to still
work correctly. Just they will make too small amount of space in bh but
still at least one dir entry gets moved? Following add_dirent_to_buf() is
more likely to fail due to ENOSPC but still I don't see the buffer overrun
issue? Can you please tell me what I'm missing? Thanks!

Anyway, since the fix looks obviously correct feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>


								Honza
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Cc: stable@vger.kernel.org
> Fixes: 5872331b3d91 ("ext4: fix potential negative array index in do_split()")
> Signed-off-by: Artem Sadovnikov <a.sadovnikov@ispras.ru>
> ---
>  fs/ext4/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index cb5cb33b1d91..e9712e64ec8f 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1971,7 +1971,7 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
>  	 * split it in half by count; each resulting block will have at least
>  	 * half the space free.
>  	 */
> -	if (i > 0)
> +	if (i >= 0)
>  		split = count - move;
>  	else
>  		split = count/2;
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

