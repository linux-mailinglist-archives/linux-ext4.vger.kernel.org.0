Return-Path: <linux-ext4+bounces-4336-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC63E987455
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2024 15:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 215AE1C21B66
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2024 13:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8430C1CAB8;
	Thu, 26 Sep 2024 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EfYc/Gy1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jbon3asE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EfYc/Gy1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jbon3asE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFAC27473
	for <linux-ext4@vger.kernel.org>; Thu, 26 Sep 2024 13:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727356803; cv=none; b=kPneQpBOtx6BGnx+rCX4qmhQcGokfsoLoEbdcZ4Zb3RzMffv6OQysRtxB1ovGvHGyNHjBHrdcINLvNRlumVX667HWs5eSwNS3cCTqxT7GCboYrBb9bX1IL8D50J8bw0z4QyZ4PWhpYn5I7Vsn9CGK/4QQfomZGmAuyA1U4jhGNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727356803; c=relaxed/simple;
	bh=uyRj4MjgDBT4hxxEBnfYowVnAgsWbGh2hx9XQ1OLXR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdOTJotFOxrfU9SaJmCmmw5fnRGmTV2EB43DFtCmXRUxvxcdcWEFuT7JKJUV/FDP4iPyu1XEcw7py7xQ/BOVTO9jbyGhZ9D32gjwOgvQzwFD/0Bu7iYQOYcac6HXyfppTpzAmLsc5FlkSptiO9ltGa489d9W2jV38FGUTNYOvko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EfYc/Gy1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jbon3asE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EfYc/Gy1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jbon3asE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA19621A0F;
	Thu, 26 Sep 2024 13:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727356799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3wwPANEVQUESfEDIW04GIC3IX5qxxlAFJj5AjmNrOrM=;
	b=EfYc/Gy1TXCZqa9WBpAtaGiacW+4aKR7K0dMB+m1YZDNBZ6cPQ4Xus5B+H5u2G9yCZzpjZ
	Z2qrrukT9QE9fuTEh8CL6B++E4APNjmdNMARq9SkJotD4NMX4y8vAnh1+0iz69OOJJ0JPD
	uMPlAR5ys1LO6pLwYspCnlmzRqm02Vg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727356799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3wwPANEVQUESfEDIW04GIC3IX5qxxlAFJj5AjmNrOrM=;
	b=Jbon3asEFBTNwQKvduSia1U9fSgyGzJcez/zyIx7978wHy22KBRsJ/ZhZx28jYpDNkwRce
	LBK0r7c6yu+P1zDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727356799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3wwPANEVQUESfEDIW04GIC3IX5qxxlAFJj5AjmNrOrM=;
	b=EfYc/Gy1TXCZqa9WBpAtaGiacW+4aKR7K0dMB+m1YZDNBZ6cPQ4Xus5B+H5u2G9yCZzpjZ
	Z2qrrukT9QE9fuTEh8CL6B++E4APNjmdNMARq9SkJotD4NMX4y8vAnh1+0iz69OOJJ0JPD
	uMPlAR5ys1LO6pLwYspCnlmzRqm02Vg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727356799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3wwPANEVQUESfEDIW04GIC3IX5qxxlAFJj5AjmNrOrM=;
	b=Jbon3asEFBTNwQKvduSia1U9fSgyGzJcez/zyIx7978wHy22KBRsJ/ZhZx28jYpDNkwRce
	LBK0r7c6yu+P1zDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E78513793;
	Thu, 26 Sep 2024 13:19:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tCSqJn9f9WYCYwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Sep 2024 13:19:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 61BBCA0845; Thu, 26 Sep 2024 15:19:59 +0200 (CEST)
Date: Thu, 26 Sep 2024 15:19:59 +0200
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jack@suse.cz, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 5/5] jbd2: remove useless 'block_error' variable
Message-ID: <20240926131959.wavfwciftg76l52r@quack3>
References: <20240918113604.660640-1-yebin@huaweicloud.com>
 <20240918113604.660640-6-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918113604.660640-6-yebin@huaweicloud.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,huawei.com:email,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 18-09-24 19:36:04, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> The judgement 'if (block_error && success == 0)' is never valid. Just
> remove useless 'block_error' variable.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/recovery.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 05ea449b95c4..0bcbb58d634b 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -490,7 +490,7 @@ static __always_inline int jbd2_do_replay(journal_t *journal,
>  					  struct buffer_head *bh,
>  					  unsigned long *next_log_block,
>  					  unsigned int next_commit_ID,
> -					  int *success, int *block_error)
> +					  int *success)
>  {
>  	char *tagp;
>  	int flags;
> @@ -542,7 +542,6 @@ static __always_inline int jbd2_do_replay(journal_t *journal,
>  				*success = -EFSBADCRC;
>  				pr_err("JBD2: Invalid checksum recovering data block %llu in journal block %lu\n",
>  				      blocknr, io_block);
> -				*block_error = 1;
>  				goto skip_write;
>  			}
>  
> @@ -596,7 +595,6 @@ static int do_one_pass(journal_t *journal,
>  	unsigned int		sequence;
>  	int			blocktype;
>  	__u32			crc32_sum = ~0; /* Transactional Checksums */
> -	int			block_error = 0;
>  	bool			need_check_commit_time = false;
>  	__u64			last_trans_commit_time = 0, commit_time;
>  
> @@ -721,8 +719,7 @@ static int do_one_pass(journal_t *journal,
>  			 * done here!
>  			 */
>  			err = jbd2_do_replay(journal, info, bh, &next_log_block,
> -					     next_commit_ID, &success,
> -					     &block_error);
> +					     next_commit_ID, &success);
>  			if (err)
>  				goto failed;
>  
> @@ -913,8 +910,6 @@ static int do_one_pass(journal_t *journal,
>  			success = err;
>  	}
>  
> -	if (block_error && success == 0)
> -		success = -EIO;
>  	return success;
>  
>   failed:
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

