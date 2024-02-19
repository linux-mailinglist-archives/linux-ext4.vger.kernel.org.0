Return-Path: <linux-ext4+bounces-1280-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D2C85A29C
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Feb 2024 12:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F9B1F225F4
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Feb 2024 11:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D352CCB3;
	Mon, 19 Feb 2024 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cucpj10I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aIxMf67X";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cucpj10I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aIxMf67X"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FF22C69E;
	Mon, 19 Feb 2024 11:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343899; cv=none; b=vCbZMVFrxMfLfGIZrt0BdPcDAnviy0y9fS/KrhU16W1FJbBWUgn/jFuVavvKB6FonQUw7AwQF1IRpPESa6CwLn3dyWYp0GCQScz/QP1HrUqWerlCdpe5GJsRBDD/Q89R5+xlHp97gHbEfo4uut+NuiSUHgFm09e8zgld8TTYGK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343899; c=relaxed/simple;
	bh=n5uTa+BduwSpbD1YYIqxWnviQAffhqcFxkzQFfHSOq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MmdAjpDvFj+Yurqyz5NsHvnnbfleM394QYbXTqY00OLl6ejlE37oWcKRsuACPz08mPpHLRgMRsa72KgTxprMTlq/qX5OvuLO4xOF21JtdZtst7jqeQkibAiqhWY97CERZcY9d3H3k2+oOxZckMIcGzio0K4k4gfiNluNsLfX1+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cucpj10I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aIxMf67X; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cucpj10I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aIxMf67X; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B30041F7F4;
	Mon, 19 Feb 2024 11:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708343895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tEzUm7JuwF7O1+VqTvm8wmWsVV7oAQ74jH+4YvJcC6s=;
	b=cucpj10I6QFqCRq/ZVoqjMlddwhAEKWlk+uu1v7OIMH7SkloOn5ekN4B71iGtyoFcRPr6n
	CGg46FUqfJvlDTVzbnLHtuQCOIe1+TNQQ5C4rZ8WGLvc4MmPMG3UfRIz3bYrTGi56eR5Tl
	9IQmhjdnkPiPgoR42JV+4Zbg6x5zUz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708343895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tEzUm7JuwF7O1+VqTvm8wmWsVV7oAQ74jH+4YvJcC6s=;
	b=aIxMf67XRm2PymfqPH63R7LsdXMZeTxAsG7YYle36j2HvVYo5MwBfenjCAPDbduiabPINF
	cbWF+bAu02L7q0Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708343895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tEzUm7JuwF7O1+VqTvm8wmWsVV7oAQ74jH+4YvJcC6s=;
	b=cucpj10I6QFqCRq/ZVoqjMlddwhAEKWlk+uu1v7OIMH7SkloOn5ekN4B71iGtyoFcRPr6n
	CGg46FUqfJvlDTVzbnLHtuQCOIe1+TNQQ5C4rZ8WGLvc4MmPMG3UfRIz3bYrTGi56eR5Tl
	9IQmhjdnkPiPgoR42JV+4Zbg6x5zUz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708343895;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tEzUm7JuwF7O1+VqTvm8wmWsVV7oAQ74jH+4YvJcC6s=;
	b=aIxMf67XRm2PymfqPH63R7LsdXMZeTxAsG7YYle36j2HvVYo5MwBfenjCAPDbduiabPINF
	cbWF+bAu02L7q0Cg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A184813585;
	Mon, 19 Feb 2024 11:58:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id nRMHJ1dC02WbcAAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 19 Feb 2024 11:58:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 58EA7A0806; Mon, 19 Feb 2024 12:58:15 +0100 (CET)
Date: Mon, 19 Feb 2024 12:58:15 +0100
From: Jan Kara <jack@suse.cz>
To: Chao Yu <chao@kernel.org>
Cc: jack@suse.com, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add missing git address for ext2 entry
Message-ID: <20240219115815.7a5dan5dotiwcjo4@quack3>
References: <20240219063718.3682824-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219063718.3682824-1-chao@kernel.org>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.15 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.55)[80.94%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -0.15

On Mon 19-02-24 14:37:18, Chao Yu wrote:
> ext2 git address is missing, add it.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>

Thanks. Added to my tree.

								Honza

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 960512bec428..1c72a1301771 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7984,6 +7984,7 @@ M:	Jan Kara <jack@suse.com>
>  L:	linux-ext4@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/filesystems/ext2.rst
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
>  F:	fs/ext2/
>  F:	include/linux/ext2*
>  
> -- 
> 2.40.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

