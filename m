Return-Path: <linux-ext4+bounces-1229-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A40B85368E
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Feb 2024 17:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC7A1C217F5
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Feb 2024 16:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BEF5FF17;
	Tue, 13 Feb 2024 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bZGOzY/U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OKyzF7I2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bZGOzY/U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OKyzF7I2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D645FEF6;
	Tue, 13 Feb 2024 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842844; cv=none; b=hqiR8hMLFjay8ntEZnIxPfkstn4ZKcswRtlG9PTN0cvBWnPwgaXmnWr/UKcCRwp2Y19zjO/suk6fEppKUfPN2IWMfoicJ4oVsyfj0jrsbXRLsaLjUVIwzCDgJGWPcLITpNV92hCoFX8kNz5xAWtapw4flGpNw4tMrh2enLBSm6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842844; c=relaxed/simple;
	bh=lMuuoAlD9aAlJ2tMUAOTkGkO745CkEARAiifW3gVgLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ECLmHKUF6U7WVp27t86Wg8XDkmxvwBxf1LdNHbirwNx74dBWReJ/26SVr1tIEkGrAReFMeNcK+c+AfTA7YmrgWHQIhKCME12/CcOukpiT/RDhf/IDkcHaObm04lxtTIQN2aH/S+AIjfaCxfRAbCAs4dRubQEsTgorwd0YFzn1MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bZGOzY/U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OKyzF7I2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bZGOzY/U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OKyzF7I2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B8EB21FCEA;
	Tue, 13 Feb 2024 16:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707842839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y47o/y5NIvk4vOfnPZ2qEDutF6P7mev6M9MfWBPW2uk=;
	b=bZGOzY/UIbjRAREUz1NSzrhOM5R3yIO8T4PFGpl7GPBecM5XgHdDXv4zmEkfShOQ9iGrfO
	QQa2P3PIAR22BEFlTZUC33shLVUG49psKzqLkTx7adsaFNA4p2TzT5O0jp+Sa6Y1amrAxv
	za97fneNFhOJo1PaIEDW9DPi721xV/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707842839;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y47o/y5NIvk4vOfnPZ2qEDutF6P7mev6M9MfWBPW2uk=;
	b=OKyzF7I2xqaBySBJh//PoWUHCl0f2DsplS3XEzdcSgdn3qpUqRQWPQpLYj8cpLe0wOgvyE
	v8eKesUc1a/j+TAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707842839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y47o/y5NIvk4vOfnPZ2qEDutF6P7mev6M9MfWBPW2uk=;
	b=bZGOzY/UIbjRAREUz1NSzrhOM5R3yIO8T4PFGpl7GPBecM5XgHdDXv4zmEkfShOQ9iGrfO
	QQa2P3PIAR22BEFlTZUC33shLVUG49psKzqLkTx7adsaFNA4p2TzT5O0jp+Sa6Y1amrAxv
	za97fneNFhOJo1PaIEDW9DPi721xV/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707842839;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y47o/y5NIvk4vOfnPZ2qEDutF6P7mev6M9MfWBPW2uk=;
	b=OKyzF7I2xqaBySBJh//PoWUHCl0f2DsplS3XEzdcSgdn3qpUqRQWPQpLYj8cpLe0wOgvyE
	v8eKesUc1a/j+TAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AB90F1329E;
	Tue, 13 Feb 2024 16:47:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id jrvbKRedy2XnDwAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 13 Feb 2024 16:47:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 61CF8A0809; Tue, 13 Feb 2024 17:47:19 +0100 (CET)
Date: Tue, 13 Feb 2024 17:47:19 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH 2/7] ext4: refactor out ext4_generic_attr_store()
Message-ID: <20240213164719.w4pwobwndkfvupgi@quack3>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
 <20240126085716.1363019-3-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126085716.1363019-3-libaokun1@huawei.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="bZGOzY/U";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OKyzF7I2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: B8EB21FCEA
X-Spam-Flag: NO

On Fri 26-01-24 16:57:11, Baokun Li wrote:
> Refactor out the function ext4_generic_attr_store() to handle the setting
> of values of various common types, with no functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
...
> -static ssize_t ext4_attr_store(struct kobject *kobj,
> -			       struct attribute *attr,
> -			       const char *buf, size_t len)
> +static ssize_t ext4_generic_attr_store(struct ext4_attr *a,
> +				       struct ext4_sb_info *sbi,
> +				       const char *buf, size_t len)
>  {
> -	struct ext4_sb_info *sbi = container_of(kobj, struct ext4_sb_info,
> -						s_kobj);
> -	struct ext4_attr *a = container_of(attr, struct ext4_attr, attr);
> -	void *ptr = calc_ptr(a, sbi);
> -	unsigned long t;
>  	int ret;
> +	unsigned long t;
> +	void *ptr = calc_ptr(a, sbi);
> +
> +	if (!ptr)
> +		return 0;
> +	ret = kstrtoul(skip_spaces(buf), 0, &t);

The refactorization is nice but I'd keep the string to number conversion
inside the switch so that we can distinguish uint and ulong cases.

								Honza

> +	if (ret)
> +		return ret;
>  
>  	switch (a->attr_id) {
> -	case attr_reserved_clusters:
> -		return reserved_clusters_store(sbi, buf, len);
>  	case attr_pointer_ui:
> -		if (!ptr)
> -			return 0;
> -		ret = kstrtoul(skip_spaces(buf), 0, &t);
> -		if (ret)
> -			return ret;
>  		if (t != (unsigned int)t)
>  			return -EINVAL;
>  		if (a->attr_ptr == ptr_ext4_super_block_offset)
> @@ -471,19 +467,30 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
>  			*((unsigned int *) ptr) = t;
>  		return len;
>  	case attr_pointer_ul:
> -		if (!ptr)
> -			return 0;
> -		ret = kstrtoul(skip_spaces(buf), 0, &t);
> -		if (ret)
> -			return ret;
>  		*((unsigned long *) ptr) = t;
>  		return len;
> +	}
> +	return 0;
> +}
> +
> +static ssize_t ext4_attr_store(struct kobject *kobj,
> +			       struct attribute *attr,
> +			       const char *buf, size_t len)
> +{
> +	struct ext4_sb_info *sbi = container_of(kobj, struct ext4_sb_info,
> +						s_kobj);
> +	struct ext4_attr *a = container_of(attr, struct ext4_attr, attr);
> +
> +	switch (a->attr_id) {
> +	case attr_reserved_clusters:
> +		return reserved_clusters_store(sbi, buf, len);
>  	case attr_inode_readahead:
>  		return inode_readahead_blks_store(sbi, buf, len);
>  	case attr_trigger_test_error:
>  		return trigger_test_error(sbi, buf, len);
> +	default:
> +		return ext4_generic_attr_store(a, sbi, buf, len);
>  	}
> -	return 0;
>  }
>  
>  static void ext4_sb_release(struct kobject *kobj)
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

