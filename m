Return-Path: <linux-ext4+bounces-1045-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F536843F99
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jan 2024 13:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C312128EA15
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Jan 2024 12:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38337AE43;
	Wed, 31 Jan 2024 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RtmyCQWp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FOw4IlKV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RtmyCQWp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FOw4IlKV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571E87690E;
	Wed, 31 Jan 2024 12:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705201; cv=none; b=JISTD/yyjc4dItxFUJb5bGvaaaR9kJUP6qtvaGLWIPn5ijJ7iURzHMgHtHet0IGEZJY/IQoLldELI7Tr8zXBtqzOqFIozF7YGZTz4BAxxFToe+CUq9kY95lO4PNBJXsBkuAx/ghW6po1E/1nb4zGc5cy67kDZ5ysMufFZrGYw/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705201; c=relaxed/simple;
	bh=1IPPGnuyc8eiE2l9ctUhcE32IyTYiQr4s6ZSFeTvVZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LX5ieKZ7algtxmKScDyljj/zSrNNScr74vkeG7y/ryJjuSJffQFEk7ImDj5HEoVFrspi6xM5AY2KY4wmOrQ2MkuCHjDhil6owm995NMpmaCM//j7WcvpjTu/XlSt+9cMYkTvgDFaUoT3f6387jdpzEVM5A5t8RTHghQ1exxpfk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RtmyCQWp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FOw4IlKV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RtmyCQWp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FOw4IlKV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5D87A21FFC;
	Wed, 31 Jan 2024 12:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706705197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3C7Lak3dvLjIVuOE+go6tRBC1cR0+Mdscg1hy5G174w=;
	b=RtmyCQWpVjM8W1QpZiEEzuRCEfuohSi3aZZ2p7m4uXeazw0zN+nAI4so3b2elcXBtWoQ0X
	W3hPoRFVo+IYLYa6cwPT8A+Q0l3GBkxWm6f9Tqm8Fa9J65frE67PLrmodHYx1vfzb81X4r
	Ut9SH4dQ0SE5Zd21lQHbmG+Cirsv57E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706705197;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3C7Lak3dvLjIVuOE+go6tRBC1cR0+Mdscg1hy5G174w=;
	b=FOw4IlKVV3k3fUSgNYjR8ql71edpTTWRLN5sIoHEtR9SHEH4wer03oTKb1+6TL3iSyDlqn
	Z0X0BkXx62r6mcCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706705197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3C7Lak3dvLjIVuOE+go6tRBC1cR0+Mdscg1hy5G174w=;
	b=RtmyCQWpVjM8W1QpZiEEzuRCEfuohSi3aZZ2p7m4uXeazw0zN+nAI4so3b2elcXBtWoQ0X
	W3hPoRFVo+IYLYa6cwPT8A+Q0l3GBkxWm6f9Tqm8Fa9J65frE67PLrmodHYx1vfzb81X4r
	Ut9SH4dQ0SE5Zd21lQHbmG+Cirsv57E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706705197;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3C7Lak3dvLjIVuOE+go6tRBC1cR0+Mdscg1hy5G174w=;
	b=FOw4IlKVV3k3fUSgNYjR8ql71edpTTWRLN5sIoHEtR9SHEH4wer03oTKb1+6TL3iSyDlqn
	Z0X0BkXx62r6mcCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B4BC132FA;
	Wed, 31 Jan 2024 12:46:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id i29YEi1BumXtVQAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 31 Jan 2024 12:46:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C289AA0809; Wed, 31 Jan 2024 13:46:36 +0100 (CET)
Date: Wed, 31 Jan 2024 13:46:36 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
	stable@kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [PATCH] ext4: correct best extent lstart adjustment logic
Message-ID: <20240131124636.gmxaiex6yqrhvxcj@quack3>
References: <20240122123332.555370-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122123332.555370-1-libaokun1@huawei.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RtmyCQWp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FOw4IlKV
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.37 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_HAM_SHORT(-0.06)[-0.324];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com,kernel.org,linux.ibm.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.37
X-Rspamd-Queue-Id: 5D87A21FFC
X-Spam-Flag: NO

[Added Ojaswin to CC as an author of the discussed patch]

On Mon 22-01-24 20:33:32, Baokun Li wrote:
> When yangerkun review commit 93cdf49f6eca ("ext4: Fix best extent lstart
> adjustment logic in ext4_mb_new_inode_pa()"), it was found that the best
> extent did not completely cover the original request after adjusting the
> best extent lstart in ext4_mb_new_inode_pa() as follows:
> 
>   original request: 2/10(8)
>   normalized request: 0/64(64)
>   best extent: 0/9(9)
> 
> When we check if best ex can be kept at start of goal, ac_o_ex.fe_logical
> is 2 less than the adjusted best extent logical end 9, so we think the
> adjustment is done. But obviously 0/9(9) doesn't cover 2/10(8), so we
> should determine here if the original request logical end is less than or
> equal to the adjusted best extent logical end.

I'm sorry for a bit delayed reply. Why do you think it is a problem if the
resulting extent doesn't cover the full original range? We must always
cover the first block of the original extent so that the allocation makes
forward progress. But otherwise we choose to align to the start / end of
the goal range to reduce fragmentation even if we don't cover the whole
requested range - the rest of the range will be covered by the next
allocation. Also there is a problem with trying to cover the whole original
range described in [1]. Essentially the goal range does not need to cover
the whole original range and if we try to align the allocated range to
cover the whole original range, it may result in exceeding the goal range
and thus overlapping preallocations and triggering asserts in the prealloc
code.

So if we decided we want to handle the case you describe in a better way,
we'd need something making sure we don't exceed the goal range.

								Honza

[1] https://lore.kernel.org/all/Y+UzQJRIJEiAr4Z4@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com/

> 
> Moreover, the best extent len is not modified during the adjustment
> process, and it is already checked by the previous assertion, so replace
> the check for fe_len with a check for the best extent logical end.
> 
> Cc: stable@kernel.org
> Fixes: 93cdf49f6eca ("ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()")
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/mballoc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index f44f668e407f..fa5977fe8d72 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5146,6 +5146,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  			.fe_len = ac->ac_orig_goal_len,
>  		};
>  		loff_t orig_goal_end = extent_logical_end(sbi, &ex);
> +		loff_t o_ex_end = extent_logical_end(sbi, &ac->ac_o_ex);
>  
>  		/* we can't allocate as much as normalizer wants.
>  		 * so, found space must get proper lstart
> @@ -5161,7 +5162,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  		 * 1. Check if best ex can be kept at end of goal (before
>  		 *    cr_best_avail trimmed it) and still cover original start
>  		 * 2. Else, check if best ex can be kept at start of goal and
> -		 *    still cover original start
> +		 *    still cover original end
>  		 * 3. Else, keep the best ex at start of original request.
>  		 */
>  		ex.fe_len = ac->ac_b_ex.fe_len;
> @@ -5171,7 +5172,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  			goto adjust_bex;
>  
>  		ex.fe_logical = ac->ac_g_ex.fe_logical;
> -		if (ac->ac_o_ex.fe_logical < extent_logical_end(sbi, &ex))
> +		if (o_ex_end <= extent_logical_end(sbi, &ex))
>  			goto adjust_bex;
>  
>  		ex.fe_logical = ac->ac_o_ex.fe_logical;
> @@ -5179,7 +5180,7 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
>  		ac->ac_b_ex.fe_logical = ex.fe_logical;
>  
>  		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
> -		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
> +		BUG_ON(o_ex_end > extent_logical_end(sbi, &ex));
>  		BUG_ON(extent_logical_end(sbi, &ex) > orig_goal_end);
>  	}
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

