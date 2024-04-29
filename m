Return-Path: <linux-ext4+bounces-2239-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8678B61CB
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Apr 2024 21:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6059DB21A90
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Apr 2024 19:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24BD13A3E5;
	Mon, 29 Apr 2024 19:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SNAulEN4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PS0vxXgk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SNAulEN4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PS0vxXgk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E13413AA3B
	for <linux-ext4@vger.kernel.org>; Mon, 29 Apr 2024 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418081; cv=none; b=Ov0Z2G5E2YX6v1sYyhrUjuDl8rV4j4Tes7EprBV5uV3uIN010mX8P/GtGsHHjUAcLcdGq2Eo0TN4wPF7g+tGtdZfw/rtbXAUl6GXZBP4pE4QUuMdrtRZMi6rynbBvI7JDSe3fy6ehT5R7RSW3ZbzZlbkPmyV3LUYxkOsHw7SLqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418081; c=relaxed/simple;
	bh=tPgwfVCZ1oO04ZmZGBatUOhV8UHLGPCJoU9dSZXKy7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKNb2Fw479oykDWVm4ZvdICasb0mKwwP4IC9TbtBGqxxouqZunyxgaU+s0HTBkyWjr+VyFOXMfQmv014hgLqxvrvr/STq+LUfCD01FzT6ixjP2x5GbxydwZsr4m3cJkCIXUUvX6dNGUjwKOYtAP10RLrWvqLrVZhWys0VSIKC+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SNAulEN4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PS0vxXgk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SNAulEN4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PS0vxXgk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A43B1F749;
	Mon, 29 Apr 2024 19:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714418077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pQ4IZMoknWGNdFBkSUXkqOI79EqGmB7kS7uyLyNU7BQ=;
	b=SNAulEN4mXUktPKUJZnnqXdna2yQrSd8IuWqnHfIPsImqqM8WjTJcJoZ6wT53NFebe311L
	mKkh9LawXEbZTCF0B5dfek+fprPXuYkaBXJLSe5rvJJKU12jfpR3YxhXFdlaAva1rv5tAF
	WDbhehDhP8ZUhZ51frcBQgJzs7oi62E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714418077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pQ4IZMoknWGNdFBkSUXkqOI79EqGmB7kS7uyLyNU7BQ=;
	b=PS0vxXgk5P/rbSI9HsHJ5C+Io/TjQ2FX9D2PDawSd+mne7nNI/QDNxf/5oP4+HR1qYh8gs
	bviwAXKo7P7CqMCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714418077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pQ4IZMoknWGNdFBkSUXkqOI79EqGmB7kS7uyLyNU7BQ=;
	b=SNAulEN4mXUktPKUJZnnqXdna2yQrSd8IuWqnHfIPsImqqM8WjTJcJoZ6wT53NFebe311L
	mKkh9LawXEbZTCF0B5dfek+fprPXuYkaBXJLSe5rvJJKU12jfpR3YxhXFdlaAva1rv5tAF
	WDbhehDhP8ZUhZ51frcBQgJzs7oi62E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714418077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pQ4IZMoknWGNdFBkSUXkqOI79EqGmB7kS7uyLyNU7BQ=;
	b=PS0vxXgk5P/rbSI9HsHJ5C+Io/TjQ2FX9D2PDawSd+mne7nNI/QDNxf/5oP4+HR1qYh8gs
	bviwAXKo7P7CqMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 814D7138A7;
	Mon, 29 Apr 2024 19:14:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8BiNH53xL2bkZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 29 Apr 2024 19:14:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 27D57A082F; Mon, 29 Apr 2024 21:14:37 +0200 (CEST)
Date: Mon, 29 Apr 2024 21:14:37 +0200
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v3] jbd2: avoid mount failed when commit block is partial
 submitted
Message-ID: <20240429191437.2pxfg43hgdmkgl2m@quack3>
References: <20240425064515.836633-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425064515.836633-1-yebin@huaweicloud.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Thu 25-04-24 14:45:15, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> We encountered a problem that the file system could not be mounted in
> the power-off scenario. The analysis of the file system mirror shows that
> only part of the data is written to the last commit block.
> The valid data of the commit block is concentrated in the first sector.
> However, the data of the entire block is involved in the checksum calculation.
> For different hardware, the minimum atomic unit may be different.
> If the checksum of a committed block is incorrect, clear the data except the
> 'commit_header' and then calculate the checksum. If the checkusm is correct,
> it is considered that the block is partially committed. However, if there are
> valid description/revoke blocks, it is considered that the data is abnormal
> and the log replay is stopped.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

The patch as a fix looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

I'd just note that the maze of branches and gotos in do_one_pass() is
becoming very hard to follow so ideally we should come up with some
refactoring of the function so that it is easier to follow. But that's
definitely something for a separate patch.

								Honza

> ---
>  fs/jbd2/recovery.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 1f7664984d6e..594bf02a709f 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -443,6 +443,27 @@ static int jbd2_commit_block_csum_verify(journal_t *j, void *buf)
>  	return provided == cpu_to_be32(calculated);
>  }
>  
> +static bool jbd2_commit_block_csum_verify_partial(journal_t *j, void *buf)
> +{
> +	struct commit_header *h;
> +	__be32 provided;
> +	__u32 calculated;
> +	void *tmpbuf;
> +
> +	tmpbuf = kzalloc(j->j_blocksize, GFP_KERNEL);
> +	if (!tmpbuf)
> +		return false;
> +
> +	memcpy(tmpbuf, buf, sizeof(struct commit_header));
> +	h = tmpbuf;
> +	provided = h->h_chksum[0];
> +	h->h_chksum[0] = 0;
> +	calculated = jbd2_chksum(j, j->j_csum_seed, tmpbuf, j->j_blocksize);
> +	kfree(tmpbuf);
> +
> +	return provided == cpu_to_be32(calculated);
> +}
> +
>  static int jbd2_block_tag_csum_verify(journal_t *j, journal_block_tag_t *tag,
>  				      journal_block_tag3_t *tag3,
>  				      void *buf, __u32 sequence)
> @@ -479,6 +500,7 @@ static int do_one_pass(journal_t *journal,
>  	int			descr_csum_size = 0;
>  	int			block_error = 0;
>  	bool			need_check_commit_time = false;
> +	bool                    has_partial_commit = false;
>  	__u64			last_trans_commit_time = 0, commit_time;
>  
>  	/*
> @@ -590,6 +612,14 @@ static int do_one_pass(journal_t *journal,
>  					next_log_block);
>  			}
>  
> +			if (pass == PASS_SCAN && has_partial_commit) {
> +				pr_err("JBD2: Detect validate descriptor block %lu after incomplete commit block\n",
> +				       next_log_block);
> +				err = -EFSBADCRC;
> +				brelse(bh);
> +				goto failed;
> +			}
> +
>  			/* If it is a valid descriptor block, replay it
>  			 * in pass REPLAY; if journal_checksums enabled, then
>  			 * calculate checksums in PASS_SCAN, otherwise,
> @@ -810,6 +840,14 @@ static int do_one_pass(journal_t *journal,
>  			if (pass == PASS_SCAN &&
>  			    !jbd2_commit_block_csum_verify(journal,
>  							   bh->b_data)) {
> +				if (jbd2_commit_block_csum_verify_partial(
> +								  journal,
> +								  bh->b_data)) {
> +					pr_notice("JBD2: Find incomplete commit block in transaction %u block %lu\n",
> +						  next_commit_ID, next_log_block);
> +					has_partial_commit = true;
> +					goto chksum_ok;
> +				}
>  			chksum_error:
>  				if (commit_time < last_trans_commit_time)
>  					goto ignore_crc_mismatch;
> @@ -824,6 +862,7 @@ static int do_one_pass(journal_t *journal,
>  				}
>  			}
>  			if (pass == PASS_SCAN) {
> +			chksum_ok:
>  				last_trans_commit_time = commit_time;
>  				head_block = next_log_block;
>  			}
> @@ -843,6 +882,15 @@ static int do_one_pass(journal_t *journal,
>  					  next_log_block);
>  				need_check_commit_time = true;
>  			}
> +
> +			if (pass == PASS_SCAN && has_partial_commit) {
> +				pr_err("JBD2: Detect validate revoke block %lu after incomplete commit block\n",
> +				       next_log_block);
> +				err = -EFSBADCRC;
> +				brelse(bh);
> +				goto failed;
> +			}
> +
>  			/* If we aren't in the REVOKE pass, then we can
>  			 * just skip over this block. */
>  			if (pass != PASS_REVOKE) {
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

