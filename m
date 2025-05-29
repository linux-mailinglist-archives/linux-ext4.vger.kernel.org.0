Return-Path: <linux-ext4+bounces-8231-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF97AC7E38
	for <lists+linux-ext4@lfdr.de>; Thu, 29 May 2025 14:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31A987A224D
	for <lists+linux-ext4@lfdr.de>; Thu, 29 May 2025 12:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73D92253A8;
	Thu, 29 May 2025 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1BFfFMSN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5rrmFCEh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1BFfFMSN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5rrmFCEh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494E0224AFE
	for <linux-ext4@vger.kernel.org>; Thu, 29 May 2025 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748523472; cv=none; b=qrFS8JgGmeYIQ9d7hYmqiUaiJ8o3qftIQzrdQjQLVgy3v9T7FwcLFLQclWutER9SPjZAhh0Pkm3PzDv8YZ1gGcYOtcrPxKRpk3Xb3PDp4dYfypWoQly0J/aWHa3C1+lQ2G+YQHX1/h8nFevKsX29h3aLaTqFpY99aV0GEq1Wlp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748523472; c=relaxed/simple;
	bh=SNVfLnkhqe+5aias+lajVGdi34+U45lwrIkCHQ8+J+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEPDpmZpgP44eH+Ybq1N0KKVOgx+SEVtKxGrGnK1EURazcl5OxGOcY2wo9VJFBcXZtkt6GTCyaoBpbG5/21S8rvFEgNVyErnwcGtKLAYcyq5pS1mioivXSupU+NhFuxB0R6KKJozEEWfCsnrTxFW4mW10inf+muDXn/SAOfHRJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1BFfFMSN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5rrmFCEh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1BFfFMSN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5rrmFCEh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5CBEB1FE7D;
	Thu, 29 May 2025 12:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748523468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f9sLSwcDi8igU/OUAboXfHstZSxXknrnUDLiYXKqoo8=;
	b=1BFfFMSNfMZefABx7F9ggaHr/fFV2ZOLgx49umq9G3NAbi+xuju4ovyLUFg3G9SqFKQMdv
	339k1zPM2rv4ndzxP5zLtzGDDUo8D4zQlPNQgOXka2G27IBltYYbyUcHVcf1Wm2/0bAOii
	KLyn6+7o8hDc8IPGZl7orAQbRBHILdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748523468;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f9sLSwcDi8igU/OUAboXfHstZSxXknrnUDLiYXKqoo8=;
	b=5rrmFCEhGOdDAtN7g/gq2djuqO3v3jTOtDmwrxxz2vhjhv9YQdH0EficHz2xW+E3/5vBfM
	xuiXZZCJPLOhg/DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1BFfFMSN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5rrmFCEh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748523468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f9sLSwcDi8igU/OUAboXfHstZSxXknrnUDLiYXKqoo8=;
	b=1BFfFMSNfMZefABx7F9ggaHr/fFV2ZOLgx49umq9G3NAbi+xuju4ovyLUFg3G9SqFKQMdv
	339k1zPM2rv4ndzxP5zLtzGDDUo8D4zQlPNQgOXka2G27IBltYYbyUcHVcf1Wm2/0bAOii
	KLyn6+7o8hDc8IPGZl7orAQbRBHILdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748523468;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f9sLSwcDi8igU/OUAboXfHstZSxXknrnUDLiYXKqoo8=;
	b=5rrmFCEhGOdDAtN7g/gq2djuqO3v3jTOtDmwrxxz2vhjhv9YQdH0EficHz2xW+E3/5vBfM
	xuiXZZCJPLOhg/DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 508C7136E0;
	Thu, 29 May 2025 12:57:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6/CnE8xZOGjhLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 May 2025 12:57:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0E3A6A09B5; Thu, 29 May 2025 14:57:44 +0200 (CEST)
Date: Thu, 29 May 2025 14:57:44 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH 4/4] ext4: fix typo in CR_GOAL_LEN_SLOW comment
Message-ID: <xg4ck2ukc4x3glewq2zh7pdiviudehkdhkgkaofzbeabmi7kn3@rnf6piy3pbfs>
References: <20250523085821.1329392-1-libaokun@huaweicloud.com>
 <20250523085821.1329392-5-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523085821.1329392-5-libaokun@huaweicloud.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email,huaweicloud.com:email,suse.cz:dkim,suse.cz:email];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5CBEB1FE7D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Fri 23-05-25 16:58:21, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Remove the superfluous "find_".
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index f6d01702423d..1182700901cc 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -157,7 +157,7 @@ enum criteria {
>  
>  	/*
>  	 * Reads each block group sequentially, performing disk IO if
> -	 * necessary, to find find_suitable block group. Tries to
> +	 * necessary, to find suitable block group. Tries to
>  	 * allocate goal length but might trim the request if nothing
>  	 * is found after enough tries.
>  	 */
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

