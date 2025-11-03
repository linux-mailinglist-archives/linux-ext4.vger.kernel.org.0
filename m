Return-Path: <linux-ext4+bounces-11416-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41D0C2B8FC
	for <lists+linux-ext4@lfdr.de>; Mon, 03 Nov 2025 13:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666613A6F7E
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Nov 2025 12:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBA026A1B5;
	Mon,  3 Nov 2025 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wubRer84";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+z2C94mw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wubRer84";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+z2C94mw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC9C305068
	for <linux-ext4@vger.kernel.org>; Mon,  3 Nov 2025 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762171213; cv=none; b=kJWK2o3gQFLHRqxM4NxBI8P3a7C/3u/8SDGLsYdBKK0bFf4A2lI/y1plLvBMbUAsu9OmgUOlWi5fcX6CPWFHyFCzj70+gMEcGDh+NEYlgLYXfB+y4olIl2bw7Z98lJf9tMksq5sxdVoCb7rLK/cqf4DZ8PigWxff+221d6OyCDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762171213; c=relaxed/simple;
	bh=v4Xp7G0snx3B7FNIifvZ7naLQnnzP5zvIDXTYzNwuXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoIeVfdp1aiB/61vMfw+ZFoY6z602OTUeaORjtrHmy55WWcsexclL04KALJsQXP22vU89lV/oIpnYpYZ4XP146ty4ws5Q8hxzQPa6qKbAwhBL5VFX08AmG8xjvkn3XiadBObaG4EFoKoEG3MPrOpsEf/HF4AyCDmUbiaVeq2uQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wubRer84; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+z2C94mw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wubRer84; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+z2C94mw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 916DE1F7A8;
	Mon,  3 Nov 2025 12:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762171208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MJYnlLePcZdIWMVT9onpBpWZVOq1hed6Z2u+y6/MT3w=;
	b=wubRer8497m1+FxKmoOyyVMHNxJfMBANAhDoMb97UwzN6YXw4xuFHGeB6j+ZTtZbT0iz0Q
	JUjn6S9e+k2cG6dNjfJPgw825kJGOVH6DZo2VYOzY6lCcm0kJUyXQwJ2OsjuUj7q9Vv4zJ
	Cpnxaj02f9PSUTSxIRVTpy/W+MEUQzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762171208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MJYnlLePcZdIWMVT9onpBpWZVOq1hed6Z2u+y6/MT3w=;
	b=+z2C94mwD1AbhBM/Zrtpj6TqCE7z7jYRG/3gk9G+sJiBw2V9OaYzglHcs1VV2j6Ubgs5C7
	FJr2e5sO8T3edtBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wubRer84;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+z2C94mw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762171208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MJYnlLePcZdIWMVT9onpBpWZVOq1hed6Z2u+y6/MT3w=;
	b=wubRer8497m1+FxKmoOyyVMHNxJfMBANAhDoMb97UwzN6YXw4xuFHGeB6j+ZTtZbT0iz0Q
	JUjn6S9e+k2cG6dNjfJPgw825kJGOVH6DZo2VYOzY6lCcm0kJUyXQwJ2OsjuUj7q9Vv4zJ
	Cpnxaj02f9PSUTSxIRVTpy/W+MEUQzs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762171208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MJYnlLePcZdIWMVT9onpBpWZVOq1hed6Z2u+y6/MT3w=;
	b=+z2C94mwD1AbhBM/Zrtpj6TqCE7z7jYRG/3gk9G+sJiBw2V9OaYzglHcs1VV2j6Ubgs5C7
	FJr2e5sO8T3edtBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80BC01364F;
	Mon,  3 Nov 2025 12:00:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FFtgH0iZCGlNQQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Nov 2025 12:00:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C67EBA2812; Mon,  3 Nov 2025 13:00:03 +0100 (CET)
Date: Mon, 3 Nov 2025 13:00:03 +0100
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	jack@suse.cz
Subject: Re: [PATCH v2] jbd2: fix the inconsistency between checksum and data
 in memory for journal sb
Message-ID: <c5lle5fuvajx5c2gxfzcmj3rbjisx36baiqq6p7o6hr2jhgtkn@bl5ypp4qissw>
References: <20251103010123.3753631-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103010123.3753631-1-yebin@huaweicloud.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 916DE1F7A8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -4.01

On Mon 03-11-25 09:01:23, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Copying the file system while it is mounted as read-only results in
> a mount failure:
> [~]# mkfs.ext4 -F /dev/sdc
> [~]# mount /dev/sdc -o ro /mnt/test
> [~]# dd if=/dev/sdc of=/dev/sda bs=1M
> [~]# mount /dev/sda /mnt/test1
> [ 1094.849826] JBD2: journal checksum error
> [ 1094.850927] EXT4-fs (sda): Could not load journal inode
> mount: mount /dev/sda on /mnt/test1 failed: Bad message
> 
> The process described above is just an abstracted way I came up with to
> reproduce the issue. In the actual scenario, the file system was mounted
> read-only and then copied while it was still mounted. It was found that
> the mount operation failed. The user intended to verify the data or use
> it as a backup, and this action was performed during a version upgrade.
> Above issue may happen as follows:
> ext4_fill_super
>  set_journal_csum_feature_set(sb)
>   if (ext4_has_metadata_csum(sb))
>    incompat = JBD2_FEATURE_INCOMPAT_CSUM_V3;
>   if (test_opt(sb, JOURNAL_CHECKSUM)
>    jbd2_journal_set_features(sbi->s_journal, compat, 0, incompat);
>     lock_buffer(journal->j_sb_buffer);
>     sb->s_feature_incompat  |= cpu_to_be32(incompat);
>     //The data in the journal sb was modified, but the checksum was not
>       updated, so the data remaining in memory has a mismatch between the
>       data and the checksum.
>     unlock_buffer(journal->j_sb_buffer);
> 
> In this case, the journal sb copied over is in a state where the checksum
> and data are inconsistent, so mounting fails.
> To solve the above issue, update the checksum in memory after modifying
> the journal sb.
> 
> Fixes: 4fd5ea43bc11 ("jbd2: checksum journal superblock")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index d480b94117cd..bf255f8b5eeb 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2349,6 +2349,12 @@ int jbd2_journal_set_features(journal_t *journal, unsigned long compat,
>  	sb->s_feature_compat    |= cpu_to_be32(compat);
>  	sb->s_feature_ro_compat |= cpu_to_be32(ro);
>  	sb->s_feature_incompat  |= cpu_to_be32(incompat);
> +	/*
> +	 * Update the checksum now so that it is valid even for read-only
> +	 * filesystems where jbd2_write_superblock() doesn't get called.
> +	 */
> +	if (jbd2_journal_has_csum_v2or3(journal))
> +		sb->s_checksum = jbd2_superblock_csum(sb);
>  	unlock_buffer(journal->j_sb_buffer);
>  	jbd2_journal_init_transaction_limits(journal);
>  
> @@ -2378,9 +2384,17 @@ void jbd2_journal_clear_features(journal_t *journal, unsigned long compat,
>  
>  	sb = journal->j_superblock;
>  
> +	lock_buffer(journal->j_sb_buffer);
>  	sb->s_feature_compat    &= ~cpu_to_be32(compat);
>  	sb->s_feature_ro_compat &= ~cpu_to_be32(ro);
>  	sb->s_feature_incompat  &= ~cpu_to_be32(incompat);
> +	/*
> +	 * Update the checksum now so that it is valid even for read-only
> +	 * filesystems where jbd2_write_superblock() doesn't get called.
> +	 */
> +	if (jbd2_journal_has_csum_v2or3(journal))
> +		sb->s_checksum = jbd2_superblock_csum(sb);
> +	unlock_buffer(journal->j_sb_buffer);
>  	jbd2_journal_init_transaction_limits(journal);
>  }
>  EXPORT_SYMBOL(jbd2_journal_clear_features);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

