Return-Path: <linux-ext4+bounces-837-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BB7830658
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jan 2024 13:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E08A1F23606
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jan 2024 12:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08021EB2C;
	Wed, 17 Jan 2024 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AW2+XlZx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9a8MnInu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HMqJAxle";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+emHwdpi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB981EA90
	for <linux-ext4@vger.kernel.org>; Wed, 17 Jan 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705496309; cv=none; b=HIl6Mauah5r6kLLhhEbyf2dDwXFAf6aWeD3KuHyDTPHVpuPDaEZ0XRx755ZRDcDmZGXdMo3s1MuR6fAHSx3Fb1rnra7lUO59WyUG3lC97a1L/WDoQdciGxiVoj098Yvag8tsjxjyivzumEUVAu8cSRiXT6od79wbXZhpHI48xwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705496309; c=relaxed/simple;
	bh=S9abj65QDTQEkvuxx4SAaoKRXixzWkx3ZI/m18Lenyc=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spamd-Result:X-Rspamd-Server:
	 X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Level:X-Spam-Flag:
	 X-Spamd-Bar; b=PfD00NrF2dYS6SXxccC2Rw68f3fCh+okFeU1EuIalMv3yN0XdspmkugS4RmH81VeNraINYj4tx+oFVQA9IPMNXb0U5y1BZ1BJ+xMgv27uAl1o8uHMVUVPi7opXQEyJhZLwO4hlZtzenPSgbxSIoFSpPEgi219HQYt5NnlqcP/fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AW2+XlZx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9a8MnInu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HMqJAxle; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+emHwdpi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF3DB1FC0A;
	Wed, 17 Jan 2024 12:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705496306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QHWTIj2m5hvwdOliYX/CzUONwD3exih5d7pycCAO+sg=;
	b=AW2+XlZxMcwuuLRPl4tF5iSLxX6Gm3m2Fe7TG/8+v17cyN1xq6V2hfDEdujxPUmcHyjL1u
	LpzKNuA9dlKiDXZk1vvw3xMy9XChchA8NBa6iSxfqS5ffdkXauzd2JxAYx2wQJCCkB19or
	8bgCTjhzVoHq34P13P5yImioBdMRv6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705496306;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QHWTIj2m5hvwdOliYX/CzUONwD3exih5d7pycCAO+sg=;
	b=9a8MnInuV5y8RmJaErFrs5323904mP6wYJfhVgEZgbDS6UbvduTm+xYlTk48Y2/mtHSPHs
	CLXtzFmXms6Z9aAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705496304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QHWTIj2m5hvwdOliYX/CzUONwD3exih5d7pycCAO+sg=;
	b=HMqJAxleXBIhDkv8VOillblZpgTO9MN0VRr1Fsz8XbnHUXtaBec6TadFGG+9yXorz27iF7
	EIUz9TQoGgNrnxq5MXKaO+n4lhfyYl7RcwtsUYC2xGMgs7zxkDMLmFFes6SnGDd6ZNb2Jx
	4O/8+giwFpkpNnwbz9Bsf2IQ4xFDd84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705496304;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QHWTIj2m5hvwdOliYX/CzUONwD3exih5d7pycCAO+sg=;
	b=+emHwdpi0cusfkKgNPoxGCNcjTuoRB7MjlSebhySnzOEKaaNb08PKmDfatrcOrIQ+xurC5
	rxEM8R87otCV3GCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D524413800;
	Wed, 17 Jan 2024 12:58:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MiYINPDOp2XNYwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jan 2024 12:58:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 95A3CA0803; Wed, 17 Jan 2024 13:58:24 +0100 (CET)
Date: Wed, 17 Jan 2024 13:58:24 +0100
From: Jan Kara <jack@suse.cz>
To: yangerkun <yangerkun@huawei.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	linux-ext4@vger.kernel.org, yangerkun@huaweicloud.com
Subject: Re: [PATCH 2/2] ext4: distinguish different error in
 ext4_mb_seq_groups_show
Message-ID: <20240117125824.paah5ncjhmoyzwom@quack3>
References: <20240117115223.80253-1-yangerkun@huawei.com>
 <20240117115223.80253-2-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117115223.80253-2-yangerkun@huawei.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HMqJAxle;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+emHwdpi
X-Spamd-Result: default: False [0.19 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.19
X-Rspamd-Queue-Id: DF3DB1FC0A
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Wed 17-01-24 19:52:23, yangerkun wrote:
> While cat mb_groups for a mounted ext4 image which has some corrupted
> group, the string return to userspace was just "I/O error" which confuse
> me a lot. Use ext4_decode_error to help distinguish different error.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

I guess this is an improvement :). Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 139f232bdbb5..77d6113e2822 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2991,6 +2991,7 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
>  	struct super_block *sb = pde_data(file_inode(seq->file));
>  	ext4_group_t group = (ext4_group_t) ((unsigned long) v);
>  	int i, err;
> +	char nbuf[16];
>  	struct ext4_buddy e4b;
>  	struct ext4_group_info *grinfo;
>  	unsigned char blocksize_bits = min_t(unsigned char,
> @@ -3017,7 +3018,7 @@ static int ext4_mb_seq_groups_show(struct seq_file *seq, void *v)
>  	if (unlikely(EXT4_MB_GRP_NEED_INIT(grinfo))) {
>  		err = ext4_mb_load_buddy(sb, group, &e4b);
>  		if (err) {
> -			seq_printf(seq, "#%-5u: I/O error\n", group);
> +			seq_printf(seq, "#%-5u: %s\n", group, ext4_decode_error(NULL, err, nbuf));
>  			return 0;
>  		}
>  		ext4_mb_unload_buddy(&e4b);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

