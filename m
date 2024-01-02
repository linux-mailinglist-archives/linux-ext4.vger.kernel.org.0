Return-Path: <linux-ext4+bounces-627-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1169E821C45
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 14:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45FB2824D2
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jan 2024 13:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931E4F9EA;
	Tue,  2 Jan 2024 13:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AqoAD0/X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6LeTzK6+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3NAA7Elk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wj0yvUrD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF019F9D6;
	Tue,  2 Jan 2024 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0BFD1FCFA;
	Tue,  2 Jan 2024 13:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704201059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ewOagNDatWoGcLk4sHCd4WMmPbxbCyW84Y0Oe5vxbh8=;
	b=AqoAD0/XtGHHD1ttzdpii3VJOQjFFURgPWyvtRMoCNytCGQpOzWta0Kwg4yipRwG4jlLRE
	2nN9mLe5OcaAUGKeao5wXmoyO+WU1nin7+oMICY3lDxUlMGSCBFIJbhp5UrMDR5MGuDF0W
	qQS6GkeSJ/0XbxP0FWr3WpxCCGW/+kM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704201059;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ewOagNDatWoGcLk4sHCd4WMmPbxbCyW84Y0Oe5vxbh8=;
	b=6LeTzK6+5PJmKAk5IbKjxzs9zbX4klIOA9knYjt6WnhBbZBg/c0tYiBDqFIZNcuY8QM5FX
	baDhaZAZvLWFgEAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704201058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ewOagNDatWoGcLk4sHCd4WMmPbxbCyW84Y0Oe5vxbh8=;
	b=3NAA7ElkfkvzRKGYWeEVWgtQOkp1oTuAlyECSeeCfqhpSUdGNdLgSpMCgP5k6y8RKokzXj
	TvBb1AozTmsyEa5BM6jpkUnL6nYfNKl+zaLH/ykKG6JniTQWR/3O04P5yvNZ7KvX65ta1B
	4BFZkGZQtjQT1gimps0aU/xhgKym+9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704201058;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ewOagNDatWoGcLk4sHCd4WMmPbxbCyW84Y0Oe5vxbh8=;
	b=wj0yvUrDjCoo8w8zi3CydzQsB5lYANagpLlJaguN3/0dsZ6cY3u+s18woiXVGhLk2eymrf
	Mj9xPTgIvD2EflCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1C1713AC6;
	Tue,  2 Jan 2024 13:10:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dCtiK2ILlGVCSwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Jan 2024 13:10:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3ADC3A07EF; Tue,  2 Jan 2024 14:10:58 +0100 (CET)
Date: Tue, 2 Jan 2024 14:10:58 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] ext4: remove unnecessary parameter "needed" in
 ext4_discard_preallocations
Message-ID: <20240102131058.3ue6phafczjezlic@quack3>
References: <20231125161143.3945726-1-shikemeng@huaweicloud.com>
 <20231125161143.3945726-9-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125161143.3945726-9-shikemeng@huaweicloud.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.08 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,huaweicloud.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.11)[65.92%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3NAA7Elk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wj0yvUrD
X-Spam-Score: 0.08
X-Rspamd-Queue-Id: C0BFD1FCFA

On Sun 26-11-23 00:11:43, Kemeng Shi wrote:
> The "needed" controls the number of ext4_prealloc_space to discard in
> ext4_discard_preallocations. Function ext4_discard_preallocations is
> supposed to discard all non-used preallocated blocks when "needed"
> is 0 and now ext4_discard_preallocations is always called with "needed"
> = 0. Remove unnecessary parameter "needed" and remove all non-used
> preallocated spaces in ext4_discard_preallocations to simplify the
> code.
> 
> Note: If count of non-used preallocated spaces could be more than
> UINT_MAX, there was a memory leak as some non-used preallocated
> spaces are left unused and this commit will fix it. Otherwise,
> there is no behavior change.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good, just one nit:

> @@ -5491,15 +5491,12 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
>  	mb_debug(sb, "discard preallocation for inode %lu\n",
>  		 inode->i_ino);
>  	trace_ext4_discard_preallocations(inode,
> -			atomic_read(&ei->i_prealloc_active), needed);
> -
> -	if (needed == 0)
> -		needed = UINT_MAX;
> +			atomic_read(&ei->i_prealloc_active), 0);

There's no point in always returning 0 in the tracepoint so I'd just update
it to not print the 'needed' value as well.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

