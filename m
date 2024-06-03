Return-Path: <linux-ext4+bounces-2757-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B7B8D85F7
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2024 17:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A96DFB2368C
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2024 15:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B234612EBD3;
	Mon,  3 Jun 2024 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G4Lp8mWy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cLr6S7Ej";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G4Lp8mWy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cLr6S7Ej"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7871436127
	for <linux-ext4@vger.kernel.org>; Mon,  3 Jun 2024 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717428264; cv=none; b=G+qo7xgisUP6r6CVp5efg1oxZMuCYg2UWcoJGEyV/HuBJB8c236wG8LUUFoO3F0xrMj3Kgr2X5sfuExWnKSAM+vouMaLmcFEH1IvKXoIKYjekaejHphKEwGG5Bdmk2F57F9GD6VXVJkQSJItrIjduV9raCSJtIQkiSoJHl+O48M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717428264; c=relaxed/simple;
	bh=WOC1wdmXJgJf6OqAbJyyWLjZ7AciypYDcEYTw3yewjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsVhWsSCXaIkrDMcJko+gIMskzF7iGW5sSOIekb5Cls894WcTxALsvOzlePkOF+zfnGV3NeBcKHaGhHwwcPegwq/sb+CT1HNf0Fa9jZgvxU6DiDXKUtAt3EapJ8Of0lVKh/ftssJXq1DsYRtUQPqdJwW1L3UOuMWxgTHHGduqLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G4Lp8mWy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cLr6S7Ej; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G4Lp8mWy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cLr6S7Ej; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6805420041;
	Mon,  3 Jun 2024 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717428259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9SFUuT4DwQ3HvO+rosjLB0uVWsK2pN+NkdTD8HmCxM=;
	b=G4Lp8mWyOUEv6OsWYl5Xn25OH6WHa6FTDBbht8Zc30td7vI1MiT2Be9T4GRwqHcHxRNg2U
	INIpafQGWqw7uOKkwUdLuPJ89ztYOWTEjIMpoj/fKKyan0MpEglbqJz6w2vyo/K9hhsKLI
	BmE4v8J5HZCv4PY27Uy373dr4LXnl14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717428259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9SFUuT4DwQ3HvO+rosjLB0uVWsK2pN+NkdTD8HmCxM=;
	b=cLr6S7Ej+gEFwyjCuEVURAP7ztENuA3NcD0DYegEg5h9eE+4NaXTeDFiSnq8OCjo63EL7Z
	zkETyiJhkRN5WCBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717428259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9SFUuT4DwQ3HvO+rosjLB0uVWsK2pN+NkdTD8HmCxM=;
	b=G4Lp8mWyOUEv6OsWYl5Xn25OH6WHa6FTDBbht8Zc30td7vI1MiT2Be9T4GRwqHcHxRNg2U
	INIpafQGWqw7uOKkwUdLuPJ89ztYOWTEjIMpoj/fKKyan0MpEglbqJz6w2vyo/K9hhsKLI
	BmE4v8J5HZCv4PY27Uy373dr4LXnl14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717428259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9SFUuT4DwQ3HvO+rosjLB0uVWsK2pN+NkdTD8HmCxM=;
	b=cLr6S7Ej+gEFwyjCuEVURAP7ztENuA3NcD0DYegEg5h9eE+4NaXTeDFiSnq8OCjo63EL7Z
	zkETyiJhkRN5WCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 587B413A93;
	Mon,  3 Jun 2024 15:24:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KDmIFSPgXWZJeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Jun 2024 15:24:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0DA6FA0881; Mon,  3 Jun 2024 17:24:19 +0200 (CEST)
Date: Mon, 3 Jun 2024 17:24:19 +0200
From: Jan Kara <jack@suse.cz>
To: JunChao Sun <sunjunchao2870@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca
Subject: Re: [PATCH] ext4: Adjust the layout of the ext4_inode_info structure
 to save memory.
Message-ID: <20240603152419.dklvgmf6m4akdyzf@quack3>
References: <20240603131524.324224-1-sunjunchao2870@gmail.com>
 <20240603140705.vfpdrbyljw6yfxpd@quack3>
 <CAHB1NagapRk62L9vn0uSKYJMMSq=9kNiB+jdaxA3JBY16f9jig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHB1NagapRk62L9vn0uSKYJMMSq=9kNiB+jdaxA3JBY16f9jig@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Mon 03-06-24 22:43:16, JunChao Sun wrote:
> Jan Kara <jack@suse.cz> 于2024年6月3日周一 22:07写道：
> >
> > On Mon 03-06-24 21:15:24, Junchao Sun wrote:
> > > Using pahole, we can see that there are some padding holes
> > > in the current ext4_inode_info structure. Adjusting the
> > > layout of ext4_inode_info can reduce these holes,
> > > resulting in the size of the structure decreasing
> > > from 2424 bytes to 2408 bytes.
> >
> >
> > > But AFAICT this will save two holes 4 bytes each so only 8 bytes in total?
> > > Not 16?
> 
> Indeed it's 16.
> Consider the layout int a; hole 0; int b; hole 1; And then move int b
> to hole 0 position, this adjustment resulted in saving 8 bytes. There
> are two adjustments like this, so it's 16. And GDB confirmed this.

Aha, OK. Thanks for clarification!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

