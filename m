Return-Path: <linux-ext4+bounces-4325-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DE0986E50
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2024 09:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A0ED1C23F90
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Sep 2024 07:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541311A08BA;
	Thu, 26 Sep 2024 07:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dpx7Jckg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gACMJ7yA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m03piI0X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TeRo0D/l"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3651925A5;
	Thu, 26 Sep 2024 07:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727337345; cv=none; b=iL/S615Jh6B2CWPeWG5VBlSBNCNLWN7BZFrf7tnSazq9/02E9sHacfD+fUqtZqAz7xGlg+tkP+MxyNzewXkmDPp49NsFocg+A6uNHQWrLLBTREWegDEbQiJMrTF85hu+7mT/PF6UGXqfBG80fxYjhousS0WiK+AAk5APYDQzuHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727337345; c=relaxed/simple;
	bh=CoPFVAh+iM/jV+NO9XwQ5+mtWkk6T8HZv+jemjMjxNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSTn4Kfis2XULeDCyu+HTtQH8gb16lYcvoui5TIk0nN5IND+L8JjFaXzi0FKZSgSES3oKZkdzjzGjtCrHFIquvIVKpX5Q83sQ9o0IvprC9IkovLO6VZxRlti1cWt899oOGFAkor7lNnmq2F4DYiWJep7XlzXSDgwN8Vg5F3w+2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dpx7Jckg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gACMJ7yA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m03piI0X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TeRo0D/l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0F0721B38;
	Thu, 26 Sep 2024 07:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727337335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VXAGy78NSXOUNt0RGY9b5Z0UPCygJpEgJEPKtTj124w=;
	b=dpx7JckgNSl5f9xjEPSfEUba4+aCxn5O6c4iGGGmW3FZ2kPlW8yscvpSqrLvGEFQbT5RD1
	MjIzhg+jTI7ejhEMO2hh5H/5ItzLchR2wn0lxJGV5//1QjlUtlWG/u/EwXBCuYnGjT8TnW
	3c3xAW/589mMkcPX12IcU7gqidzVCwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727337335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VXAGy78NSXOUNt0RGY9b5Z0UPCygJpEgJEPKtTj124w=;
	b=gACMJ7yAhG4bAV8ofDMAR6Fjl3rXPi2jXF3CFELPNqom5m/5e2wG0YbI/IcX9RFqIZXAKD
	vk0uEgpRW6Pnx1Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m03piI0X;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="TeRo0D/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727337334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VXAGy78NSXOUNt0RGY9b5Z0UPCygJpEgJEPKtTj124w=;
	b=m03piI0Xq8YRFhVJtcIWUJM301kMdPx33hhyd5bi/SB7O9mwNybrwaHiw1GU4gIbQhiciV
	5DeCAuRZOxweSN0DlciRlRP8EaLlUIYoNkhmxYew+db1iQxGOH4YvB/Z/u2eQtvh6ilV1I
	2R4mgJZzSShX1CysMJQMCKrdC3aPrQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727337334;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VXAGy78NSXOUNt0RGY9b5Z0UPCygJpEgJEPKtTj124w=;
	b=TeRo0D/l/AEYWs3ZKQKUsVMOfpy1idAVCXhqloXeQ/qkhweKspqVK5S7RLdk7Sr8VtBoJc
	sCJ0rR9GV5znwLBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E614C13793;
	Thu, 26 Sep 2024 07:55:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zp4lOHYT9WY2fwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Sep 2024 07:55:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8EF1EA0881; Thu, 26 Sep 2024 09:55:34 +0200 (CEST)
Date: Thu, 26 Sep 2024 09:55:34 +0200
From: Jan Kara <jack@suse.cz>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-ext4@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Matthew Bobrowski <mbobrowski@mbobrowski.org>,
	Ritesh Harjani <riteshh@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ext4: Call ext4_journal_stop(handle) only once in
 ext4_dio_write_iter()
Message-ID: <20240926075534.s3bzoqcpyd6u7zhx@quack3>
References: <cf895072-43cf-412c-bced-8268498ad13e@web.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf895072-43cf-412c-bced-8268498ad13e@web.de>
X-Rspamd-Queue-Id: F0F0721B38
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[web.de];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[web.de];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 25-09-24 21:54:18, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 25 Sep 2024 21:47:39 +0200
> 
> An ext4_journal_stop(handle) call was immediately used after a return value
> check for a ext4_orphan_add() call in this function implementation.
> Thus call such a function only once instead directly before the check.
> 
> This issue was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/file.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index f14aed14b9cf..23005f1345a8 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -564,12 +564,9 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		}
> 
>  		ret = ext4_orphan_add(handle, inode);
> -		if (ret) {
> -			ext4_journal_stop(handle);
> -			goto out;
> -		}
> -
>  		ext4_journal_stop(handle);
> +		if (ret)
> +			goto out;
>  	}
> 
>  	if (ilock_shared && !unwritten)
> --
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

