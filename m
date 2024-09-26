Return-Path: <linux-ext4+bounces-4334-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 029DF9873F0
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2024 14:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25D921C229F9
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2024 12:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D8118B1A;
	Thu, 26 Sep 2024 12:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s2GwJykq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GdRSyFeP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s2GwJykq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GdRSyFeP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74B4EEB7
	for <linux-ext4@vger.kernel.org>; Thu, 26 Sep 2024 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355463; cv=none; b=rjcnxKcy5C7MnkI4d89YDMPOdwvzAWxk7Mp6ENIpVSWLftBEaEXoBm9DrLAVswQIhDFzdq8zM6qBt8iAy143VjeFB5bnEHzGcjSmyC7j6Dm8tb5QrTjws8Yig38hfwy2HQSYLmkEv9seJoSFCXeec4j5V/12J6qjWS2TpkGX/Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355463; c=relaxed/simple;
	bh=fig9j+Kc6TqTFJwepZ6sWUDvD1oSS7aGLoHwStd9+38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srbb08h6icbKTnC1oExrIkbkwK5LQR8zkzjJW5IY/+AWc0tgGPBxyj3Np1vOfyBNRlB13SM04LjYPszkvzhb8Bw+4Bi6GhPIREULMudxNRLhJSPqvJcU3l6MpQWUHJeP7FoYuNOYhlJbFFjWBxiTK4FT312feJ/a0oIFHtfPrCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s2GwJykq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GdRSyFeP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s2GwJykq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GdRSyFeP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C6D6A1F897;
	Thu, 26 Sep 2024 12:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727355459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wEejdJZUvrR1j6Bq5DtPR28fhrlit7qa16dXBEBmS/s=;
	b=s2GwJykq+eKTln40Nqz6cThUScpKcQvOSmgdaC/W2ZzJ3aphyLObrVlMMN1JN3yxPMbxKm
	yfJ3hzooMSEHkzIh8eB45WxnNqdo8hCUW7xuBeETaL5SwtFoeDbFdi7w3YQ1jBq15IGvuf
	VXqQXxaRN7OGYdWwuW3650wbf6UjjdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727355459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wEejdJZUvrR1j6Bq5DtPR28fhrlit7qa16dXBEBmS/s=;
	b=GdRSyFePHVsKZS7CVKOqRT1JnX73/zay93Gpf6RQO2Ig6FvS4b99bpRGekIioUM7o/+o/q
	xrntOEvfeH5Ey9CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727355459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wEejdJZUvrR1j6Bq5DtPR28fhrlit7qa16dXBEBmS/s=;
	b=s2GwJykq+eKTln40Nqz6cThUScpKcQvOSmgdaC/W2ZzJ3aphyLObrVlMMN1JN3yxPMbxKm
	yfJ3hzooMSEHkzIh8eB45WxnNqdo8hCUW7xuBeETaL5SwtFoeDbFdi7w3YQ1jBq15IGvuf
	VXqQXxaRN7OGYdWwuW3650wbf6UjjdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727355459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wEejdJZUvrR1j6Bq5DtPR28fhrlit7qa16dXBEBmS/s=;
	b=GdRSyFePHVsKZS7CVKOqRT1JnX73/zay93Gpf6RQO2Ig6FvS4b99bpRGekIioUM7o/+o/q
	xrntOEvfeH5Ey9CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCD8513318;
	Thu, 26 Sep 2024 12:57:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +PgVLkNa9Wb4WwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Sep 2024 12:57:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7EE0DA0845; Thu, 26 Sep 2024 14:57:39 +0200 (CEST)
Date: Thu, 26 Sep 2024 14:57:39 +0200
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jack@suse.cz, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 2/5] jbd2: unified release of buffer_head in do_one_pass()
Message-ID: <20240926125739.b3kpwcvwb75mjo4e@quack3>
References: <20240918113604.660640-1-yebin@huaweicloud.com>
 <20240918113604.660640-3-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918113604.660640-3-yebin@huaweicloud.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 18-09-24 19:36:01, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Now buffer_head free is very fragmented in do_one_pass(), unified release
> of buffer_head in do_one_pass()
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Indeed there are many places releasing bh. The patch looks good. Feel free
to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/recovery.c | 34 +++++++++-------------------------
>  1 file changed, 9 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 5efbca6a98c4..0adf0cb31a03 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -493,7 +493,7 @@ static int do_one_pass(journal_t *journal,
>  	int			err, success = 0;
>  	journal_superblock_t *	sb;
>  	journal_header_t *	tmp;
> -	struct buffer_head *	bh;
> +	struct buffer_head	*bh = NULL;
>  	unsigned int		sequence;
>  	int			blocktype;
>  	int			tag_bytes = journal_tag_bytes(journal);
> @@ -552,6 +552,8 @@ static int do_one_pass(journal_t *journal,
>  		 * record. */
>  
>  		jbd2_debug(3, "JBD2: checking block %ld\n", next_log_block);
> +		brelse(bh);
> +		bh = NULL;
>  		err = jread(&bh, journal, next_log_block);
>  		if (err)
>  			goto failed;
> @@ -567,20 +569,16 @@ static int do_one_pass(journal_t *journal,
>  
>  		tmp = (journal_header_t *)bh->b_data;
>  
> -		if (tmp->h_magic != cpu_to_be32(JBD2_MAGIC_NUMBER)) {
> -			brelse(bh);
> +		if (tmp->h_magic != cpu_to_be32(JBD2_MAGIC_NUMBER))
>  			break;
> -		}
>  
>  		blocktype = be32_to_cpu(tmp->h_blocktype);
>  		sequence = be32_to_cpu(tmp->h_sequence);
>  		jbd2_debug(3, "Found magic %d, sequence %d\n",
>  			  blocktype, sequence);
>  
> -		if (sequence != next_commit_ID) {
> -			brelse(bh);
> +		if (sequence != next_commit_ID)
>  			break;
> -		}
>  
>  		/* OK, we have a valid descriptor block which matches
>  		 * all of the sequence number checks.  What are we going
> @@ -603,7 +601,6 @@ static int do_one_pass(journal_t *journal,
>  					pr_err("JBD2: Invalid checksum recovering block %lu in log\n",
>  					       next_log_block);
>  					err = -EFSBADCRC;
> -					brelse(bh);
>  					goto failed;
>  				}
>  				need_check_commit_time = true;
> @@ -622,16 +619,12 @@ static int do_one_pass(journal_t *journal,
>  				    !info->end_transaction) {
>  					if (calc_chksums(journal, bh,
>  							&next_log_block,
> -							&crc32_sum)) {
> -						put_bh(bh);
> +							&crc32_sum))
>  						break;
> -					}
> -					put_bh(bh);
>  					continue;
>  				}
>  				next_log_block += count_tags(journal, bh);
>  				wrap(journal, next_log_block);
> -				put_bh(bh);
>  				continue;
>  			}
>  
> @@ -701,7 +694,6 @@ static int do_one_pass(journal_t *journal,
>  						       "JBD2: Out of memory "
>  						       "during recovery.\n");
>  						err = -ENOMEM;
> -						brelse(bh);
>  						brelse(obh);
>  						goto failed;
>  					}
> @@ -733,7 +725,6 @@ static int do_one_pass(journal_t *journal,
>  					break;
>  			}
>  
> -			brelse(bh);
>  			continue;
>  
>  		case JBD2_COMMIT_BLOCK:
> @@ -781,7 +772,6 @@ static int do_one_pass(journal_t *journal,
>  					pr_err("JBD2: Invalid checksum found in transaction %u\n",
>  					       next_commit_ID);
>  					err = -EFSBADCRC;
> -					brelse(bh);
>  					goto failed;
>  				}
>  			ignore_crc_mismatch:
> @@ -791,7 +781,6 @@ static int do_one_pass(journal_t *journal,
>  				 */
>  				jbd2_debug(1, "JBD2: Invalid checksum ignored in transaction %u, likely stale data\n",
>  					  next_commit_ID);
> -				brelse(bh);
>  				goto done;
>  			}
>  
> @@ -811,7 +800,6 @@ static int do_one_pass(journal_t *journal,
>  				if (info->end_transaction) {
>  					journal->j_failed_commit =
>  						info->end_transaction;
> -					brelse(bh);
>  					break;
>  				}
>  
> @@ -847,7 +835,6 @@ static int do_one_pass(journal_t *journal,
>  				if (!jbd2_has_feature_async_commit(journal)) {
>  					journal->j_failed_commit =
>  						next_commit_ID;
> -					brelse(bh);
>  					break;
>  				}
>  			}
> @@ -856,7 +843,6 @@ static int do_one_pass(journal_t *journal,
>  				last_trans_commit_time = commit_time;
>  				head_block = next_log_block;
>  			}
> -			brelse(bh);
>  			next_commit_ID++;
>  			continue;
>  
> @@ -875,14 +861,11 @@ static int do_one_pass(journal_t *journal,
>  
>  			/* If we aren't in the REVOKE pass, then we can
>  			 * just skip over this block. */
> -			if (pass != PASS_REVOKE) {
> -				brelse(bh);
> +			if (pass != PASS_REVOKE)
>  				continue;
> -			}
>  
>  			err = scan_revoke_records(journal, bh,
>  						  next_commit_ID, info);
> -			brelse(bh);
>  			if (err)
>  				goto failed;
>  			continue;
> @@ -890,12 +873,12 @@ static int do_one_pass(journal_t *journal,
>  		default:
>  			jbd2_debug(3, "Unrecognised magic %d, end of scan.\n",
>  				  blocktype);
> -			brelse(bh);
>  			goto done;
>  		}
>  	}
>  
>   done:
> +	brelse(bh);
>  	/*
>  	 * We broke out of the log scan loop: either we came to the
>  	 * known end of the log or we found an unexpected block in the
> @@ -931,6 +914,7 @@ static int do_one_pass(journal_t *journal,
>  	return success;
>  
>   failed:
> +	brelse(bh);
>  	return err;
>  }
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

