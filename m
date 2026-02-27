Return-Path: <linux-ext4+bounces-14202-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CInEBDF9oWkUtgQAu9opvQ
	(envelope-from <linux-ext4+bounces-14202-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 12:17:05 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F181B66F3
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 12:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3A683017799
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 11:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB563ED114;
	Fri, 27 Feb 2026 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DO/Nla72";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pa2ZJQH/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DO/Nla72";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pa2ZJQH/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D526938551E
	for <linux-ext4@vger.kernel.org>; Fri, 27 Feb 2026 11:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772191020; cv=none; b=SjpUffO55cVldFAuCIDuRo0gTu8kM0bK5KvHvOE/VwbNRcLAsxWkh/XJ2qSOTwZUkp1UX37DGptJpASLQGTvUNVJURnqY3eXNltQXrPpMsphZ2fxqapYtDjp/IUprrEF4/Ge9No6D1/QCkA+Um9MY92Q3kxkhnCr/CR9AR1odwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772191020; c=relaxed/simple;
	bh=n1Xu347xygdKAw3NHKTb3CotpLi6YY8enqT3zj9JyHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBLZYs/pj64nnxmX6h+8b+H7ZHmTZK/95bEo/J8qeZ4mZJ4PwbYoUKXpEPpYv6RzGcUhBPQOW30pCTFk0Yy6++SrJw8drzd/+r+oq4njGzB2rg9wqwxQgsYVAxbc8cmxOLfmA2Q3PDmrjPINSh0MmLz8rTH6PFe5v9OXKVHnFFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DO/Nla72; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pa2ZJQH/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DO/Nla72; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pa2ZJQH/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3D74F5BEEC;
	Fri, 27 Feb 2026 11:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772191017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xxRVURvKaI9yP++jTq9vFOkAoID/sSueb2UA8M8ioUg=;
	b=DO/Nla72dul/Xw+s+ofkjQ/H0PODom/WHJsC+XdTUgsDkwMcWlVBbPoj32PBukwBQN0/x8
	tcLxvOtIdW9dUINCDfST0iM8lECtuOewdgxXFJGj7w3FlKGwk0crZlFxDJO2TG1M+5pYND
	/uCZC0m/zOc2QCtplUQ6dBho1Dl0uwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772191017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xxRVURvKaI9yP++jTq9vFOkAoID/sSueb2UA8M8ioUg=;
	b=pa2ZJQH/9f2xEwwRWHXQYWccHU94/taSDIAtQclUDKPg6gl+EQahqp+BTK1eRIeOqjdC9H
	56W+Dfk7lI3tyMAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="DO/Nla72";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="pa2ZJQH/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772191017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xxRVURvKaI9yP++jTq9vFOkAoID/sSueb2UA8M8ioUg=;
	b=DO/Nla72dul/Xw+s+ofkjQ/H0PODom/WHJsC+XdTUgsDkwMcWlVBbPoj32PBukwBQN0/x8
	tcLxvOtIdW9dUINCDfST0iM8lECtuOewdgxXFJGj7w3FlKGwk0crZlFxDJO2TG1M+5pYND
	/uCZC0m/zOc2QCtplUQ6dBho1Dl0uwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772191017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xxRVURvKaI9yP++jTq9vFOkAoID/sSueb2UA8M8ioUg=;
	b=pa2ZJQH/9f2xEwwRWHXQYWccHU94/taSDIAtQclUDKPg6gl+EQahqp+BTK1eRIeOqjdC9H
	56W+Dfk7lI3tyMAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 344D23EA69;
	Fri, 27 Feb 2026 11:16:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 22bCDCl9oWnBHAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 11:16:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 00B25A06D4; Fri, 27 Feb 2026 12:16:56 +0100 (CET)
Date: Fri, 27 Feb 2026 12:16:56 +0100
From: Jan Kara <jack@suse.cz>
To: Milos Nikic <nikic.milos@gmail.com>
Cc: jack@suse.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2: guard reservation window dump with EXT2FS_DEBUG
Message-ID: <ndcwgcmnlkzb26msratj5lpq6dl7443wkvgxee5esr35hnkfjt@ir3sg454qbjj>
References: <20260207022920.258247-1-nikic.milos@gmail.com>
 <20260227050657.13451-1-nikic.milos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227050657.13451-1-nikic.milos@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14202-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.cz:dkim,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 37F181B66F3
X-Rspamd-Action: no action

On Thu 26-02-26 21:06:57, Milos Nikic wrote:
> Hi Jan,
> 
> Just a friendly ping on this patch now that a few weeks have passed.
> Let me know if you need any changes!

Thanks, merged now.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

