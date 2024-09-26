Return-Path: <linux-ext4+bounces-4335-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E380987410
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2024 15:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC0DEB28FE1
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2024 13:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E034B5C1;
	Thu, 26 Sep 2024 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pg8NQPKG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0iXP0Rz/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pg8NQPKG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0iXP0Rz/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD583F9C5
	for <linux-ext4@vger.kernel.org>; Thu, 26 Sep 2024 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355690; cv=none; b=CdXAREC6+KyTr46z13RfeadPdTxB8MompPzxnVzU7PGaX1ZzPYk3hdJ0ocnIriqX/kQB9VrNsbSn85fuHCX3ikWlrAYriYgRn1S/F+hsyuXKI0t23HzJ5W7v6FBQ2etq2+tq8harv0b992hqAsBOJzyh1HmUTM1Ao5VJr0H3LMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355690; c=relaxed/simple;
	bh=LAICD3eBuRkcBCHBwxqr04WuBhWa5rbeBvBHTTYMFvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkRt0F57Iu67x23qk3N42HBDlueUdUr90oxALWdGEH6zE9W6YfXq53McgPd6k7axQozCPzMRzu+LxnPZ9b7EM5E0oPzaOfoG+Q/y77f/e0vtGcjmoqXkQ09c/WGIBgbnWXYcC19O8RThDMZf/bcbE98grarpCx+Q2XftGAKMZIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pg8NQPKG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0iXP0Rz/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pg8NQPKG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0iXP0Rz/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B78021B2C;
	Thu, 26 Sep 2024 13:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727355686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ngcskl/Pt1cdEo3cbrPSL4vLn16CpOMmsdC003rILhI=;
	b=pg8NQPKG6kBmC9eaCwnlkCO10/m8NRVXmgTRFm29DsPDtw31JXgyY69LFfGdd/5emouryz
	AfOP+AJQMBuZPk8nMVKARMxlbay8nGdYvxOXQXiKi5qipor5w3pJIfdWgW8zxJlWBoH2JI
	d2x7aOMEHUkI7rJGMlxbypLXFpqV7QI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727355686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ngcskl/Pt1cdEo3cbrPSL4vLn16CpOMmsdC003rILhI=;
	b=0iXP0Rz/7BlWII000O1353XISqnKY9sZGrp6+UJTpZ5R0U+0JuDte2zu6whGphWNX1yDeq
	Om3uMrNiFE40XGDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pg8NQPKG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="0iXP0Rz/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727355686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ngcskl/Pt1cdEo3cbrPSL4vLn16CpOMmsdC003rILhI=;
	b=pg8NQPKG6kBmC9eaCwnlkCO10/m8NRVXmgTRFm29DsPDtw31JXgyY69LFfGdd/5emouryz
	AfOP+AJQMBuZPk8nMVKARMxlbay8nGdYvxOXQXiKi5qipor5w3pJIfdWgW8zxJlWBoH2JI
	d2x7aOMEHUkI7rJGMlxbypLXFpqV7QI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727355686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ngcskl/Pt1cdEo3cbrPSL4vLn16CpOMmsdC003rILhI=;
	b=0iXP0Rz/7BlWII000O1353XISqnKY9sZGrp6+UJTpZ5R0U+0JuDte2zu6whGphWNX1yDeq
	Om3uMrNiFE40XGDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8327613793;
	Thu, 26 Sep 2024 13:01:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s1AEICZb9WZFXQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Sep 2024 13:01:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 404F0A0845; Thu, 26 Sep 2024 15:01:26 +0200 (CEST)
Date: Thu, 26 Sep 2024 15:01:26 +0200
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	jack@suse.cz, zhangxiaoxu5@huawei.com
Subject: Re: [PATCH 3/5] jbd2: refactor JBD2_COMMIT_BLOCK process in
 do_one_pass()
Message-ID: <20240926130126.okrdm37lef33xg2a@quack3>
References: <20240918113604.660640-1-yebin@huaweicloud.com>
 <20240918113604.660640-4-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918113604.660640-4-yebin@huaweicloud.com>
X-Rspamd-Queue-Id: 8B78021B2C
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 18-09-24 19:36:02, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> To make JBD2_COMMIT_BLOCK process more clean, no functional change.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/recovery.c | 55 ++++++++++++++++++++++++----------------------
>  1 file changed, 29 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 0adf0cb31a03..0d697979d83e 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -728,6 +728,11 @@ static int do_one_pass(journal_t *journal,
>  			continue;
>  
>  		case JBD2_COMMIT_BLOCK:
> +			if (pass != PASS_SCAN) {
> +				next_commit_ID++;
> +				continue;
> +			}
> +
>  			/*     How to differentiate between interrupted commit
>  			 *               and journal corruption ?
>  			 *
> @@ -790,8 +795,7 @@ static int do_one_pass(journal_t *journal,
>  			 * much to do other than move on to the next sequence
>  			 * number.
>  			 */
> -			if (pass == PASS_SCAN &&
> -			    jbd2_has_feature_checksum(journal)) {
> +			if (jbd2_has_feature_checksum(journal)) {
>  				struct commit_header *cbh =
>  					(struct commit_header *)bh->b_data;
>  				unsigned found_chksum =
> @@ -815,34 +819,33 @@ static int do_one_pass(journal_t *journal,
>  					goto chksum_error;
>  
>  				crc32_sum = ~0;
> +				goto chksum_ok;
>  			}
> -			if (pass == PASS_SCAN &&
> -			    !jbd2_commit_block_csum_verify(journal,
> -							   bh->b_data)) {
> -				if (jbd2_commit_block_csum_verify_partial(
> -								  journal,
> -								  bh->b_data)) {
> -					pr_notice("JBD2: Find incomplete commit block in transaction %u block %lu\n",
> -						  next_commit_ID, next_log_block);
> -					goto chksum_ok;
> -				}
> -			chksum_error:
> -				if (commit_time < last_trans_commit_time)
> -					goto ignore_crc_mismatch;
> -				info->end_transaction = next_commit_ID;
> -				info->head_block = head_block;
>  
> -				if (!jbd2_has_feature_async_commit(journal)) {
> -					journal->j_failed_commit =
> -						next_commit_ID;
> -					break;
> -				}
> +			if (jbd2_commit_block_csum_verify(journal, bh->b_data))
> +				goto chksum_ok;
> +
> +			if (jbd2_commit_block_csum_verify_partial(journal,
> +								  bh->b_data)) {
> +				pr_notice("JBD2: Find incomplete commit block in transaction %u block %lu\n",
> +					  next_commit_ID, next_log_block);
> +				goto chksum_ok;
>  			}
> -			if (pass == PASS_SCAN) {
> -			chksum_ok:
> -				last_trans_commit_time = commit_time;
> -				head_block = next_log_block;
> +
> +chksum_error:
> +			if (commit_time < last_trans_commit_time)
> +				goto ignore_crc_mismatch;
> +			info->end_transaction = next_commit_ID;
> +			info->head_block = head_block;
> +
> +			if (!jbd2_has_feature_async_commit(journal)) {
> +				journal->j_failed_commit = next_commit_ID;
> +				break;
>  			}
> +
> +chksum_ok:
> +			last_trans_commit_time = commit_time;
> +			head_block = next_log_block;
>  			next_commit_ID++;
>  			continue;
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

