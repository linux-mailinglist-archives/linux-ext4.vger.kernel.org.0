Return-Path: <linux-ext4+bounces-5539-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FBE9EB1AF
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 14:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C95F167E60
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 13:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA3E1A76DD;
	Tue, 10 Dec 2024 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T98VLWaN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HEGR6d0Y";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T98VLWaN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HEGR6d0Y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F55B78F44;
	Tue, 10 Dec 2024 13:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733836404; cv=none; b=d61SxWU5CsYPXGfYgUI6xLwiemSJSdyzgWShckznjTA4Wi6xUBbkcecHM4ifzbsiymRoEJ2cC4Bw06iZ9vnEIdN0vYg2eRawWfc/6OmNFThy2vEJnNgfIosyK+dJ1laDeX2CrcYPSc6Cg/Zhgo5SD2ECSZYXh4AUi3JmV37fhR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733836404; c=relaxed/simple;
	bh=PZnOzf39t6gaH7sQKoanicdhg7iUQ6WsyQ3IGnfGlFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BP608CjB+jKNC+mdq1XpQu8+4EIa2zfyn4Zso23NqdzN8hvxyXjhaPN0d/ZeoNjF+QCZXy+OH0eWbC/IEZFT8F5NMIksDYf7QeiMjyB4Sc4pXh++AXR98cuYb8zlqi3UjhyJtIeVE8Y/97A7Yab6HpsXBOM3R5a9F+6bfHPPtnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T98VLWaN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HEGR6d0Y; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T98VLWaN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HEGR6d0Y; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 32521210F3;
	Tue, 10 Dec 2024 13:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733836400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CwqILbbF2BW+BlzMAtFgF56DCQYa22CbfGustZGHHIA=;
	b=T98VLWaNlc8/nU7EkLIzaD4VYdkltpnA+pOqJZ+uln3hDYRMZo+bi7nmhEPWVS22K8gDas
	xoqJIjwh3xlO8ZpCyEhbQJ1aG6YrhdPk0dLmVKeVeBGowJ3oJ2ZHxgETSD2rqUIYtJvkbb
	ZSGwfzmg/c9R5BsldjDp9a5nnQ5KvWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733836400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CwqILbbF2BW+BlzMAtFgF56DCQYa22CbfGustZGHHIA=;
	b=HEGR6d0Y5q3z4o9TQvI3bNLqz5zoNsRxEEe2G0+42UCCU1FTtr3YUfu94NUhkO5Jd3jNAg
	0HMD8cSIvqwS3gBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733836400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CwqILbbF2BW+BlzMAtFgF56DCQYa22CbfGustZGHHIA=;
	b=T98VLWaNlc8/nU7EkLIzaD4VYdkltpnA+pOqJZ+uln3hDYRMZo+bi7nmhEPWVS22K8gDas
	xoqJIjwh3xlO8ZpCyEhbQJ1aG6YrhdPk0dLmVKeVeBGowJ3oJ2ZHxgETSD2rqUIYtJvkbb
	ZSGwfzmg/c9R5BsldjDp9a5nnQ5KvWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733836400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CwqILbbF2BW+BlzMAtFgF56DCQYa22CbfGustZGHHIA=;
	b=HEGR6d0Y5q3z4o9TQvI3bNLqz5zoNsRxEEe2G0+42UCCU1FTtr3YUfu94NUhkO5Jd3jNAg
	0HMD8cSIvqwS3gBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D323138D2;
	Tue, 10 Dec 2024 13:13:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oCWJBnA+WGc2ewAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 10 Dec 2024 13:13:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B9A61A0B0D; Tue, 10 Dec 2024 14:13:19 +0100 (CET)
Date: Tue, 10 Dec 2024 14:13:19 +0100
From: Jan Kara <jack@suse.cz>
To: Gou Hao <gouhao@uniontech.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	wenqing.lz@taobao.com, jack@suse.cz, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	gouhaojake@163.com, wangyuli@uniontech.com
Subject: Re: [PATCH] ext4: make trace_ext4_ext_load_extent print-format
 correctly
Message-ID: <20241210131319.ckytlh7djftuesmr@quack3>
References: <20241210071948.12636-1-gouhao@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210071948.12636-1-gouhao@uniontech.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,goodmis.org,kernel.org,efficios.com,taobao.com,suse.cz,vger.kernel.org,163.com,uniontech.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 10-12-24 15:19:48, Gou Hao wrote:
> In commit '7d7ea89e756e', pass the 3rd param of trace_ext4_ext_load_extent
> to _RET_IP, without modifying the print-format of it.
> 
> before this:
> 147.827896: ext4_ext_load_extent: dev 8,35 ino 272218 lblk 1135807 pblk 18446744072651077338
> 
> after this:
> 35.118227: ext4_ext_load_extent: dev 8,35 ino 272218 pblk 1135807 caller ext4_find_extent+0x17a/0x320 [ext4]
> 
> Fixes: 7d7ea89e756e ("ext4: refactor code to read the extent tree block")
> Signed-off-by: Gou Hao <gouhao@uniontech.com>

Curious nobody notice earlier. Anyway, feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/trace/events/ext4.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index 156908641..55061c36a 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -1707,28 +1707,28 @@ DEFINE_EVENT(ext4__map_blocks_exit, ext4_ind_map_blocks_exit,
>  );
>  
>  TRACE_EVENT(ext4_ext_load_extent,
> -	TP_PROTO(struct inode *inode, ext4_lblk_t lblk, ext4_fsblk_t pblk),
> +	TP_PROTO(struct inode *inode, ext4_fsblk_t pblk, unsigned long IP),
>  
> -	TP_ARGS(inode, lblk, pblk),
> +	TP_ARGS(inode, pblk, IP),
>  
>  	TP_STRUCT__entry(
>  		__field(	dev_t,		dev		)
>  		__field(	ino_t,		ino		)
>  		__field(	ext4_fsblk_t,	pblk		)
> -		__field(	ext4_lblk_t,	lblk		)
> +		__field(	unsigned long,	ip		)
>  	),
>  
>  	TP_fast_assign(
>  		__entry->dev    = inode->i_sb->s_dev;
>  		__entry->ino    = inode->i_ino;
>  		__entry->pblk	= pblk;
> -		__entry->lblk	= lblk;
> +		__entry->ip	= IP;
>  	),
>  
> -	TP_printk("dev %d,%d ino %lu lblk %u pblk %llu",
> +	TP_printk("dev %d,%d ino %lu pblk %llu caller %pS",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  (unsigned long) __entry->ino,
> -		  __entry->lblk, __entry->pblk)
> +		  __entry->pblk, (void *)__entry->ip)
>  );
>  
>  TRACE_EVENT(ext4_load_inode,
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

