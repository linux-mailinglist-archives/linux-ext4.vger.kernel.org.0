Return-Path: <linux-ext4+bounces-2907-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBD69100F4
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2024 11:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952F61C21149
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2024 09:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284701A4F37;
	Thu, 20 Jun 2024 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="di3po7sz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+owO/IZr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JTDltsJX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wxPRfNuG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11431A4F2B
	for <linux-ext4@vger.kernel.org>; Thu, 20 Jun 2024 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877552; cv=none; b=CN1ADXMIVVoQvpNggoNZl8FzfJmg3eM7TAxTrd/TCGIXGqIjDO6soshEVqgdirdQ1vgL9KblrsMhbaqplpSu/BgYIJQ/ituMT6e3Nzj821030Zfc6KuDofGid3rXdjgw7O1jLIFNiNy65z2/53oULMjUhgRIjCMnES4SoJAH60A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877552; c=relaxed/simple;
	bh=b3gWZK5MNfdg2a7psQs0NA1IDTDa+R3ZzMDqTsKxLFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fg5QKZnBRnwXMuNGMas+EYBEmgIX3oyxnSgfovxoshAk3Vc+ju55kH4/Ca2Tcz3Su/cm2T+CXFnKRCP1hdMf0sf8O5fNN0RqOREMnnjzaG9gqG2qXBqZQAry9OCZgObtreZ66n5ZKlONV1TyBUrLuzrG/mLuwGrukG65j0E/A6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=di3po7sz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+owO/IZr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JTDltsJX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wxPRfNuG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D45A321AAF;
	Thu, 20 Jun 2024 09:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718877549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rm55fNppXTeOpg1NCmBfj/ZZVx57E1fV7PwrxJbVU08=;
	b=di3po7szTqy2M5I92qQSQlcnGUbA3mq+64DC+wycojJ2eHHsokWwLMbAmRweaPZQdtzTYQ
	ln3NDEfsQb0SRtMZp1q5wC6q3L37xQRYXdmyWe/9p/woxZZuJX/fnHZHcsaBGQHFcmmkP6
	parRhFJAlUqf/1NSlLq05RpC40v4I0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718877549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rm55fNppXTeOpg1NCmBfj/ZZVx57E1fV7PwrxJbVU08=;
	b=+owO/IZrXYEwbqNc7BAs4BfN4eJTxRgYyxDS950fRXjNd2EHa6+HXWoPJGwmWGaECIQAWJ
	yhhQ+BU5vi1KAlCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JTDltsJX;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wxPRfNuG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718877548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rm55fNppXTeOpg1NCmBfj/ZZVx57E1fV7PwrxJbVU08=;
	b=JTDltsJX95cX0G9tjmWuHD4HlcWdNR9dSYGXp6gr4Iu/4dh+NTO5kjIvfSi/kruJeUFo5m
	tcqEklG7hcsvneO6G6XhlyPutpGBtf+y6j+d98q4Rsm//aJfCTrB1psEfuAL8rPrCaxeEy
	iz0lUArONWGAk7EYiJBER1TxBwExveg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718877548;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rm55fNppXTeOpg1NCmBfj/ZZVx57E1fV7PwrxJbVU08=;
	b=wxPRfNuGjMgjMWNZU2BvJ2ggas3ycTNMiehS/dU20Mo8RK+DvIjJdE03lnz6PgjjD22DnH
	745+IDbBXVo/5VBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C94D313AC1;
	Thu, 20 Jun 2024 09:59:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xGchMWz9c2bgAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 20 Jun 2024 09:59:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 81568A0881; Thu, 20 Jun 2024 11:59:04 +0200 (CEST)
Date: Thu, 20 Jun 2024 11:59:04 +0200
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v4] jbd2: avoid mount failed when commit block is partial
 submitted
Message-ID: <20240620095904.65hwldqex4y4a266@quack3>
References: <20240620072405.3533701-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620072405.3533701-1-yebin@huaweicloud.com>
X-Rspamd-Queue-Id: D45A321AAF
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu 20-06-24 15:24:05, Ye Bin wrote:
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
> it is considered that the block is partially committed, Then continue to replay
> journal.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/recovery.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 1f7664984d6e..0d14b5f39be6 100644
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
> @@ -810,6 +831,13 @@ static int do_one_pass(journal_t *journal,
>  			if (pass == PASS_SCAN &&
>  			    !jbd2_commit_block_csum_verify(journal,
>  							   bh->b_data)) {
> +				if (jbd2_commit_block_csum_verify_partial(
> +								  journal,
> +								  bh->b_data)) {
> +					pr_notice("JBD2: Find incomplete commit block in transaction %u block %lu\n",
> +						  next_commit_ID, next_log_block);
> +					goto chksum_ok;
> +				}
>  			chksum_error:
>  				if (commit_time < last_trans_commit_time)
>  					goto ignore_crc_mismatch;
> @@ -824,6 +852,7 @@ static int do_one_pass(journal_t *journal,
>  				}
>  			}
>  			if (pass == PASS_SCAN) {
> +			chksum_ok:
>  				last_trans_commit_time = commit_time;
>  				head_block = next_log_block;
>  			}
> @@ -843,6 +872,7 @@ static int do_one_pass(journal_t *journal,
>  					  next_log_block);
>  				need_check_commit_time = true;
>  			}
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

