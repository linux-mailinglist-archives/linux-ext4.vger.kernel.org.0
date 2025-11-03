Return-Path: <linux-ext4+bounces-11414-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44830C2B758
	for <lists+linux-ext4@lfdr.de>; Mon, 03 Nov 2025 12:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504603A1B53
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Nov 2025 11:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D271E3016E4;
	Mon,  3 Nov 2025 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MG9xlSvt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ta1VofWc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ltsbtwnz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y4jhUG0C"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6942FC029
	for <linux-ext4@vger.kernel.org>; Mon,  3 Nov 2025 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169942; cv=none; b=Iu9gqeyvKmPVF3pAZpsLFgBcq9hishaAloEVxwiFnLEJvCVjEJhn4lisISsxth3jPeH1fm2kipr0kBo3nmlERPYmtW5s4ASQ7meggKWXqQlzzWpHkhgx4rRw06VXcORLk4dZvYTD3N5YSh/znFY40Wvi2iRC0fQCHKvR/gQKJAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169942; c=relaxed/simple;
	bh=diYjVia0HK+w69Tt9+W1DdB8KkUDVsm8RZW56+01Kig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjLbeYpW/wMVdLe0+D60n/5DuWZk7bJoC23/C11DMsYvqi6gFOrhYKB8iqe29+NvOCRdDUhONjwQh0e64qfNj9veMQCzQx9UKceH01gkA2joHRkVdEJRDFF8r5eQ4N5ljE0KPilpOZlqJYUHCthIHxEVAKVgRR5OsF3unffOYNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MG9xlSvt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ta1VofWc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ltsbtwnz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y4jhUG0C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9F8621F7A8;
	Mon,  3 Nov 2025 11:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762169938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=baZLbPFJhUHKJx1yA2N8Zvf7R+Dm/bu5TppOa9b3gzk=;
	b=MG9xlSvtqaTCwvA3mxX0NQn1NcSV6rwDVBuNW3DpLlrATqxHxBy7lRGavjB1LYipSYBxSK
	3dkKpFNtiWEIbUsj2pMZ6w8tZ4ZDoq9ubDsCnq2fMdCM4GeO4/+KiVK20/EN3aNPXVQrgl
	dnaw0F3GGwSKGC9Bh8t0zI6KEjTdYiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762169938;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=baZLbPFJhUHKJx1yA2N8Zvf7R+Dm/bu5TppOa9b3gzk=;
	b=Ta1VofWc5ecaLGtqj8rTERtSwOuASpjNAn6hOfNK5oZog0wvZ47dmQYes6vpN/+wfoApks
	U6tGShWv74RS1uBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ltsbtwnz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Y4jhUG0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762169937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=baZLbPFJhUHKJx1yA2N8Zvf7R+Dm/bu5TppOa9b3gzk=;
	b=ltsbtwnzrxAEqVzEAVa8g/3u33CH5B2u6KWq5YhOqRtH/Nb1r1hmCr7ofoYUWSdY8XDcRY
	ZXmHy0QSmwc1rjnANYVf7BMpwTCSec4sL417l5xljzzkFFc6hVRw3h75yMuXRpE14hh4Td
	hyuxqNaLho8Ls8gBfhwznseYPc2qN5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762169937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=baZLbPFJhUHKJx1yA2N8Zvf7R+Dm/bu5TppOa9b3gzk=;
	b=Y4jhUG0CtHCqQw2khQuD3JEd7qM5Ts/l91OEbS9cC4cY+VfC4EYtNC209imHixAPAURg98
	EWv61+YEZ0sXZdAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F3E01364F;
	Mon,  3 Nov 2025 11:38:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +VLnIlGUCGm5LAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Nov 2025 11:38:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 02062A2812; Mon,  3 Nov 2025 12:38:56 +0100 (CET)
Date: Mon, 3 Nov 2025 12:38:56 +0100
From: Jan Kara <jack@suse.cz>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, 
	linux-ext4@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ext4: fix string copying in
 parse_apply_sb_mount_options()
Message-ID: <rczp7azxizqhn5677vk6mpbrglu4khlrj5yfiq6fuoewdj6wqz@ryux7tf7g4mj>
References: <20251101160430.222297-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251101160430.222297-1-pchelkin@ispras.ru>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9F8621F7A8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[ispras.ru:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linuxtesting.org:url,suse.cz:dkim,suse.cz:email];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,linuxtesting.org:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -4.01

On Sat 01-11-25 19:04:28, Fedor Pchelkin wrote:
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

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

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
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

