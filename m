Return-Path: <linux-ext4+bounces-1223-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 554AF8535A0
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Feb 2024 17:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422C81C2103E
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Feb 2024 16:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FEF60243;
	Tue, 13 Feb 2024 16:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IOrx63uV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kmvH+est";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mZm9Vi3Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MomgODCR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127CF5FF09;
	Tue, 13 Feb 2024 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840360; cv=none; b=LmrLCCgbBtW8mCw3O1B1MJjUgo14HMlAWLOfy9oZOmt7T804y/RIYJqv7lrgFro+wk/4bhhBxSD1epNdvvZ34fIuJbSXyL2qBpBpokJJyEwopKZl6yjMotm8RrJmfujlGmhc5FTgTWI99aM5iDdHi2gSzPZehsbzpx0pDsSgMmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840360; c=relaxed/simple;
	bh=RSfgWvK3PUkWv6IYeIUP4jd95r0kAZpMfmZQzwkXJMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0HHbCl39CkFmc1Rz44+Qqg5Nc7FqGFuUGr0OU9OJtB9EzOpzrdZN1C83x2JZp8z1HiquYvAP3ju5tog82XWbfYW+AOOelh/7pcVUaY0ZXDTJ/ng8JvKkqqYpwMwXxYFWj4qZbTlFr14N2u2CJwoOCwAQgw7hy66HC+8RyjeVCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IOrx63uV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kmvH+est; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mZm9Vi3Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MomgODCR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2566221B5D;
	Tue, 13 Feb 2024 16:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707840356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gb3KHU7wx9iO7ZIvkAPLliWDZuFR1RA9JAptAreeXbE=;
	b=IOrx63uVQVWyK4sTh72r+QBXSUlKnXvRLBQTYUZxwsPVIng+KnPht+hdxH74ZevHk2i+Hq
	poZP1BPxvKr6pmMDuRZa0QLE4CCzarVS1MCMTY4xI9HMLwJUgb5UHhEyowNcjiwSdB4tjw
	c75NBOheKXJ9OmNDn0yfhjSP9UFPyuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707840356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gb3KHU7wx9iO7ZIvkAPLliWDZuFR1RA9JAptAreeXbE=;
	b=kmvH+estBDgz5BZMOHOABGKjgQ1cXJkW60GByBv+gYp7aZlsM94d7V3VUr/cNvJkPiF5A7
	whtLDu11y2jgiPAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707840355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gb3KHU7wx9iO7ZIvkAPLliWDZuFR1RA9JAptAreeXbE=;
	b=mZm9Vi3YU97Ie0hXf31KuZp1xOvi+KPptoKthnUd14EAqLZk2KaQ/BnS5hnQ1dQGVaTjW6
	m/AbrCd90lCCwt0GGjKyC3H7SFl4QT4FL+6n8Uh+Jg6teU3t68XNrIk0nEm99Z1or62Pyq
	oFABIe2rRV+C6XypO7bQpFwdGdJMXF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707840355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gb3KHU7wx9iO7ZIvkAPLliWDZuFR1RA9JAptAreeXbE=;
	b=MomgODCRjmGnifLMGtardNXqbYGmusZGiFdI/SyIuwMn/y6ZjPoB4eYT7qD8JbSw0nQNcw
	+5gHIMOwEhrtfEAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 16DF81329E;
	Tue, 13 Feb 2024 16:05:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id SjqPBWOTy2XqBQAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 13 Feb 2024 16:05:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B09B2A0809; Tue, 13 Feb 2024 17:05:54 +0100 (CET)
Date: Tue, 13 Feb 2024 17:05:54 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH 1/7] ext4: avoid overflow when setting values via sysfs
Message-ID: <20240213160554.35cpsfqqeqpgtux2@quack3>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
 <20240126085716.1363019-2-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126085716.1363019-2-libaokun1@huawei.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Fri 26-01-24 16:57:10, Baokun Li wrote:
> When setting values of type unsigned int through sysfs, we use kstrtoul()
> to parse it and then truncate part of it as the final set value, when the
> set value is greater than UINT_MAX, the set value will not match what we
> see because of the truncation. As follows:
> 
>   $ echo 4294967296 > /sys/fs/ext4/sda/mb_max_linear_groups
>   $ cat /sys/fs/ext4/sda/mb_max_linear_groups
>     0
> 
> So when the value set is outside the variable type range, -EINVAL is
> returned to avoid the inconsistency described above. In addition, a
> judgment is added to avoid setting s_resv_clusters less than 0.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/sysfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 6d332dff79dd..3671a8aaf4af 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -104,7 +104,7 @@ static ssize_t reserved_clusters_store(struct ext4_sb_info *sbi,
>  	int ret;
>  
>  	ret = kstrtoull(skip_spaces(buf), 0, &val);
> -	if (ret || val >= clusters)
> +	if (ret || val >= clusters || (s64)val < 0)
>  		return -EINVAL;

This looks a bit pointless, doesn't it? 'val' is u64, clusters is u64. We
know that val < clusters so how could (s64)val be < 0?

> @@ -463,6 +463,8 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
>  		ret = kstrtoul(skip_spaces(buf), 0, &t);
>  		if (ret)
>  			return ret;
> +		if (t != (unsigned int)t)
> +			return -EINVAL;
>  		if (a->attr_ptr == ptr_ext4_super_block_offset)
>  			*((__le32 *) ptr) = cpu_to_le32(t);
>  		else

I kind of agree with Alexey that using kstrtouint() here instead would look
nicer. And it isn't like you have to define many new variables. You just
need unsigned long for attr_pointer_ul and unsigned int for
attr_pointer_ui.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

