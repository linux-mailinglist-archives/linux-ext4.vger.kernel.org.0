Return-Path: <linux-ext4+bounces-6171-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C5EA17D7F
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 13:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 013AA1887369
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jan 2025 12:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AC01F1902;
	Tue, 21 Jan 2025 12:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dRWzuspO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UqUiunas";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ifEbtX2E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JlZyLt/O"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B81219E0;
	Tue, 21 Jan 2025 12:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737461229; cv=none; b=gVQMtRkHG8Q4Gg4kXLT6fGhdzXw3XD1SBsn3bjcSbtVU5Z8Qwo43oEoc+nuJOxgUZ4jKhdtnWsnbpXxcUUPCyhnDORVzmvvBl+eC9WRwHFEtJuWmnHbGq6I1gAfiUj64DiZaqn/ffrIC/VMY9o8tJgOzh9v9GGcdk3Qeh2WD9+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737461229; c=relaxed/simple;
	bh=TjpgU1/9JR5wBO15OMb12B91ZRIhyzNx7xv4jeU+r4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITI1WceUt+mN35jwfpQSc14TMEEd6sViOmfT8TzmI3llA4UjAre2bh/HMJ6F3zlWaudFQq/9WvERBxcPPz1ZkiNltWi5IEeqCski0nrN+7WTBnYZ0b3gyCNXSN20xOAf/plMJififQSs7Q+EUfR90yErNCs1Izg4Mggy4//JMBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dRWzuspO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UqUiunas; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ifEbtX2E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JlZyLt/O; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC39A2116E;
	Tue, 21 Jan 2025 12:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737461226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8gsqJWydLXmfqkIFMxq+dRkqn3Vj1K5PUA7tTUhAVV0=;
	b=dRWzuspORiJifUUFPtVt/dtap6T3OgwIyC8VL3ql1s+RGmtTLT1v8r5AGBx0yCi/7n9+1A
	Fsa0evZxxfrlPBCK1ufMjLkdGTxrbtOKqG/+N9hLlUQl4S0pTg0K0obp26512jUbXKHgh3
	OAaOdPTu6a/euxH63mO77IGyXtOmWao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737461226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8gsqJWydLXmfqkIFMxq+dRkqn3Vj1K5PUA7tTUhAVV0=;
	b=UqUiunasWwFhLb7F8T9rMbjwSfkqNOZDtG1dR3RGDd0ghBlxBD+v0B3BYsRyVzI5hY1qxu
	Vj7udlixe8PvRcDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ifEbtX2E;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="JlZyLt/O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737461225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8gsqJWydLXmfqkIFMxq+dRkqn3Vj1K5PUA7tTUhAVV0=;
	b=ifEbtX2Epocwl5iYSTdSj/65OtNQF019533WqRnwd9hW5qR1vXFSUr+epFS2bgNryVrZ4r
	j7CMdL7T6lGo0VixlMj4IzVReJKG44zNdafOpuaWqRaeUJmiqHazG36uLVfSL8MVlXJ+T0
	LSsigkwniR6Pu7nyuCCUux15Ox1VfyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737461225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8gsqJWydLXmfqkIFMxq+dRkqn3Vj1K5PUA7tTUhAVV0=;
	b=JlZyLt/OEkihLhXo2RpU73xe7WWi5eXGJJR5JTECEl3Kphd/sSmt0TVO7d3DzEC5PR5/is
	SaEiD3GCXd3o9wCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1A1D13963;
	Tue, 21 Jan 2025 12:07:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e007L+mNj2dzSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 21 Jan 2025 12:07:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7E9D1A0889; Tue, 21 Jan 2025 13:07:01 +0100 (CET)
Date: Tue, 21 Jan 2025 13:07:01 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 1/7] ext4: convert EXT4_FLAGS_* defines to enum
Message-ID: <qrvjasx2ggnmtdet62fyi4xig5as25d2stpb7eowzovpzgqxxh@7fvccxntqqyq>
References: <20250117082315.2869996-1-libaokun@huaweicloud.com>
 <20250117082315.2869996-2-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117082315.2869996-2-libaokun@huaweicloud.com>
X-Rspamd-Queue-Id: CC39A2116E
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,huawei.com:email,suse.cz:email,suse.cz:dkim,huaweicloud.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 17-01-25 16:23:09, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Do away with the defines and use an enum as it's cleaner.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Yeah, why not. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 4e7de7eaa374..612208527512 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2232,9 +2232,11 @@ extern int ext4_feature_set_ok(struct super_block *sb, int readonly);
>  /*
>   * Superblock flags
>   */
> -#define EXT4_FLAGS_RESIZING	0
> -#define EXT4_FLAGS_SHUTDOWN	1
> -#define EXT4_FLAGS_BDEV_IS_DAX	2
> +enum {
> +	EXT4_FLAGS_RESIZING,	/* Avoid superblock update and resize race */
> +	EXT4_FLAGS_SHUTDOWN,	/* Prevent access to the file system */
> +	EXT4_FLAGS_BDEV_IS_DAX	/* Current block device support DAX */
			      ^^ we usually put comma here so that future
additions doesn't need to modify this line.

> +};
>  
>  static inline int ext4_forced_shutdown(struct super_block *sb)
>  {
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

