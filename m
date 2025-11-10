Return-Path: <linux-ext4+bounces-11709-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E11FEC45AB4
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 10:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6486D34497D
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 09:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8A32FFFA3;
	Mon, 10 Nov 2025 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z7E6IiOQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uy/0Mz+L";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z7E6IiOQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uy/0Mz+L"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC4F1AC44D
	for <linux-ext4@vger.kernel.org>; Mon, 10 Nov 2025 09:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767424; cv=none; b=iLgQvity40/Eany92gXcZPslrt0YHVxERrmJ8yphAIbAR6Py0wv8Fqur1r6PmtpxeXH27K37gEYdd9pu/M8++G6YLtKkmy1dlNSQRocmY058rKfL7KLxNF8Jer7CbqzybI6/5mTvgXxMVHPatCAtolmvZFiMtJiRxkibehKzeiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767424; c=relaxed/simple;
	bh=vB+Q+BHhj/Z6hryQK8gACDZLLKkopamOHoW+Ns1zJF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJsyFwrEv2qVdHQxtNpGGCq/2QLPiYfQKw50uEw7uvZ0fi+by6QXs0wzffSBnJ6DMB6oqZw4g58WkNi1YFaUznbAWYhFb27Cr6ls/jP5aNkvpMjv+1k6MgLGLqwohTiQRjoU4TLTqcOCiHTm84v5huRZRIyROpx2qYfzUnhiSAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z7E6IiOQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uy/0Mz+L; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z7E6IiOQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uy/0Mz+L; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1CEE033737;
	Mon, 10 Nov 2025 09:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762767417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHw1/+OQrmgN6YAuggZPnMRiQfpFXxdjwZIl0TyUaNU=;
	b=z7E6IiOQLeUmMF4iceAhgdZvQ2d/4jsFNCNWuQV6U6EdOT0BX7M85MfVnX279Woa11XMWr
	CU6js023IO80PXaasAC+9LA0kTv9ciq+q6pFsOHifCAmb6Gy4LWZWqwxcsfdg/rlwlWJPF
	ZUosR0Xt+MQaeApsVZGZlx+LgqRsWKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762767417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHw1/+OQrmgN6YAuggZPnMRiQfpFXxdjwZIl0TyUaNU=;
	b=uy/0Mz+L2DKqq1iOerNTvzSbuO3fKqZGo5cSrEQ2P5T7X1ppiLy35wgBH085eI+QK8Txtp
	QaQHJUKSsHYIpzBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762767417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHw1/+OQrmgN6YAuggZPnMRiQfpFXxdjwZIl0TyUaNU=;
	b=z7E6IiOQLeUmMF4iceAhgdZvQ2d/4jsFNCNWuQV6U6EdOT0BX7M85MfVnX279Woa11XMWr
	CU6js023IO80PXaasAC+9LA0kTv9ciq+q6pFsOHifCAmb6Gy4LWZWqwxcsfdg/rlwlWJPF
	ZUosR0Xt+MQaeApsVZGZlx+LgqRsWKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762767417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHw1/+OQrmgN6YAuggZPnMRiQfpFXxdjwZIl0TyUaNU=;
	b=uy/0Mz+L2DKqq1iOerNTvzSbuO3fKqZGo5cSrEQ2P5T7X1ppiLy35wgBH085eI+QK8Txtp
	QaQHJUKSsHYIpzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1076313BF8;
	Mon, 10 Nov 2025 09:36:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HhYDBDmyEWlFcQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Nov 2025 09:36:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BC6A7A28B1; Mon, 10 Nov 2025 10:36:56 +0100 (CET)
Date: Mon, 10 Nov 2025 10:36:56 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, ebiggers@kernel.org, willy@infradead.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, chengzhihao1@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH v2 07/24] ext4: support large block size in
 ext4_calculate_overhead()
Message-ID: <e7yz7a2l4v55ppatbhlezg4wrrvhmlqwbvkm7xctajuzmxd7mj@vmcfscarjnbf>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
 <20251107144249.435029-8-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107144249.435029-8-libaokun@huaweicloud.com>
X-Spamd-Result: default: False [-0.30 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -0.30
X-Spam-Level: 

On Fri 07-11-25 22:42:32, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> ext4_calculate_overhead() used a single page for its bitmap buffer, which
> worked fine when PAGE_SIZE >= block size. However, with block size greater
> than page size (BS > PS) support, the bitmap can exceed a single page.
> 
> To address this, we now use kvmalloc() to allocate memory of the filesystem
> block size, to properly support BS > PS.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index a6314a3de51d..0d32370a459a 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4189,7 +4189,7 @@ int ext4_calculate_overhead(struct super_block *sb)
>  	unsigned int j_blocks, j_inum = le32_to_cpu(es->s_journal_inum);
>  	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
>  	ext4_fsblk_t overhead = 0;
> -	char *buf = (char *) get_zeroed_page(GFP_NOFS);
> +	char *buf = kvmalloc(sb->s_blocksize, GFP_NOFS | __GFP_ZERO);
>  
>  	if (!buf)
>  		return -ENOMEM;
> @@ -4214,7 +4214,7 @@ int ext4_calculate_overhead(struct super_block *sb)
>  		blks = count_overhead(sb, i, buf);
>  		overhead += blks;
>  		if (blks)
> -			memset(buf, 0, PAGE_SIZE);
> +			memset(buf, 0, sb->s_blocksize);
>  		cond_resched();
>  	}
>  
> @@ -4237,7 +4237,7 @@ int ext4_calculate_overhead(struct super_block *sb)
>  	}
>  	sbi->s_overhead = overhead;
>  	smp_wmb();
> -	free_page((unsigned long) buf);
> +	kvfree(buf);
>  	return 0;
>  }
>  
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

