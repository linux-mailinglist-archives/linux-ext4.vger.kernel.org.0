Return-Path: <linux-ext4+bounces-1823-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E628955A0
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 15:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96AB61C219B3
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 13:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F98085289;
	Tue,  2 Apr 2024 13:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rbhe9tJX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LSxPVE3W"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B166883CDF;
	Tue,  2 Apr 2024 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712065365; cv=none; b=HuaGzInCNJsZKTXgMP6PDQ6ydA9jOwHiYTwi2+XMPrO7iHfHQG8lbVhEDbWMe81/LF45scm/fJbFvmLiEdiOfEPp7Qhgh0y18o9m260m+8D3b2nA8DgqeuLPm0yDeG28VXiB74hGH+eWUMOZbOVLn0SoTIaCniwEJQh2+pZEX9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712065365; c=relaxed/simple;
	bh=KCpoKnmdTz0VAHWww95Y90FoR+Y0HSgHboUU+hzpLgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCIX9PwoU857aZEqZbscetJ5/Wi4aQprtfkCIePmbsbFFJXaeoIJ7e+w9VZt0mAXdLN8xeIXQlIaoSuxtuaI89E0L4a+F+OzVcxpHwefsUOP2STw2telUv1QnQgaw9BO/DFhWRihUXYmByTI2caE7HiZ6T2ma74YEDhnMMpdutU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rbhe9tJX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LSxPVE3W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1760F5BDCC;
	Tue,  2 Apr 2024 13:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712065361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tJ17AaD59GXqdePGVIdcSs+8v2xjngNqmcDlQWQ/U5s=;
	b=Rbhe9tJXpu3ONq4Et9gW1KyAzCDTOClH6GhDH0+0KO0kTISQP6pl1FiBpebwvJsznX1fqg
	edqw+AYdRXLYNoXs/DKbDu7E4vghLRfALaPszEtEUDdYigtLw1lBKaH00+gvIrsjaC2i3S
	LCtiNKxxm4XVmTQ8T71o9Y/prwOwZYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712065361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tJ17AaD59GXqdePGVIdcSs+8v2xjngNqmcDlQWQ/U5s=;
	b=LSxPVE3WYtQKQsgWRLDqXLr6bksmCVdqtYPM+CUWzHwQvBVTF7BnetTnt2MvwhYgX9tVQ+
	eWjtlRfp9pWuiKDA==
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E18D13A90;
	Tue,  2 Apr 2024 13:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id jelrA1ELDGaIWQAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 02 Apr 2024 13:42:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B3E24A0813; Tue,  2 Apr 2024 15:42:40 +0200 (CEST)
Date: Tue, 2 Apr 2024 15:42:40 +0200
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin10@huawei.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH] jbd2: avoid mount failed when commit block is partial
 submitted
Message-ID: <20240402134240.5he4mxei3nvzolb3@quack3>
References: <20240402090951.527619-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402090951.527619-1-yebin10@huawei.com>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO

On Tue 02-04-24 17:09:51, Ye Bin wrote:
> We encountered a problem that the file system could not be mounted in
> the power-off scenario. The analysis of the file system mirror shows that
> only part of the data is written to the last commit block.
> To solve above issue, if commit block checksum is incorrect, check the next
> block if has valid magic and transaction ID. If next block hasn't valid
> magic or transaction ID then just drop the last transaction ignore checksum
> error. Theoretically, the transaction ID maybe occur loopback, which may cause
> the mounting failure.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

So this is curious. The commit block data is fully within one sector and
the expectation of the journaling is that either full sector or nothing is
written. So what kind of storage were you using that it breaks these
expectations?

								Honza

> ---
>  fs/jbd2/recovery.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 1f7664984d6e..0a09f1a5fd1e 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -463,6 +463,41 @@ static int jbd2_block_tag_csum_verify(journal_t *j, journal_block_tag_t *tag,
>  		return tag->t_checksum == cpu_to_be16(csum32);
>  }
>  
> +static int check_incomplete_commit(journal_t *journal, unsigned long next_block,
> +				   unsigned int next_commit_ID)
> +{
> +	journal_header_t *tmp;
> +	struct buffer_head *bh;
> +	int err = 0;
> +
> +	err = jread(&bh, journal, next_block);
> +	if (err)
> +		return err;
> +
> +	tmp = (journal_header_t *)bh->b_data;
> +	/*
> +	 * If the next block does not contain consecutive transactions, it can
> +	 * be considered that the checksum error of the current commit block
> +	 * is caused by incomplete commit. Ignore the checksum error and drop
> +	 * the last transaction.
> +	 */
> +	if (tmp->h_magic != cpu_to_be32(JBD2_MAGIC_NUMBER) ||
> +	    be32_to_cpu(tmp->h_sequence) != next_commit_ID) {
> +		jbd2_debug("JBD2: will drop incomplete transaction %u commit block %lu\n",
> +			   next_commit_ID - 1, next_block - 1);
> +		goto out;
> +	}
> +
> +	pr_err("JBD2: potential continuous transaction detected %u at %lu, "
> +	       "likely invalid checksum in transaction %u\n",
> +	       next_commit_ID,  next_block, next_commit_ID - 1);
> +
> +	err = -EFSBADCRC;
> +out:
> +	brelse(bh);
> +	return err;
> +}
> +
>  static int do_one_pass(journal_t *journal,
>  			struct recovery_info *info, enum passtype pass)
>  {
> @@ -810,6 +845,10 @@ static int do_one_pass(journal_t *journal,
>  			if (pass == PASS_SCAN &&
>  			    !jbd2_commit_block_csum_verify(journal,
>  							   bh->b_data)) {
> +				if (!check_incomplete_commit(journal,
> +							     next_log_block,
> +							     next_commit_ID + 1))
> +					goto ignore_crc_mismatch;
>  			chksum_error:
>  				if (commit_time < last_trans_commit_time)
>  					goto ignore_crc_mismatch;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

