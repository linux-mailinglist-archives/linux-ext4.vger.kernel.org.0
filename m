Return-Path: <linux-ext4+bounces-2913-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C2D912AF8
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jun 2024 18:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE74528B7E0
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jun 2024 16:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6D115F40C;
	Fri, 21 Jun 2024 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pmhTRG3f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tSz5wRLo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pmhTRG3f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tSz5wRLo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6EC364AB;
	Fri, 21 Jun 2024 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986186; cv=none; b=hYkAey1B03qeApvCzuX/kA3r96itvsX+2LpPWbWgyPMrEfnKeAcsLN8DzpS6TvlsEL1p3IomTQ7exk9/dGKcy/E4fkH+IZDk+8KehfHr0RusZi5YBtxlQD/IxW7n13fSjaJnb7b807ZVydYMHBWz91PWXqkqPIie0cpXev1Hc4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986186; c=relaxed/simple;
	bh=av5Jto4LDaJc6D+9N0wwF0CYpBxq7KfS7SjVpvm88fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzQHbPuHC33iQE0SWEVYKrwnVhExyUd+jvT2jizFcbTA9X+XeiHOwizszPey7oXwY2fki2+xhk61WzaZUQb/qRXQpIapJUlz6umgUGuhLmwZSJlERAUKRrY4Pi4rjJmNsVlp4Q7rSxTvaBqARK86g6GLBCh5+COszXKL7HMrbpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pmhTRG3f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tSz5wRLo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pmhTRG3f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tSz5wRLo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B07891FB89;
	Fri, 21 Jun 2024 16:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718986182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EwtQk9tLIu3pAbGuLBfd9oqp0JcfGbaoZTN/hou026M=;
	b=pmhTRG3fnu9xeVzxTx6yrWJ86bZHfxBXwrpn+lfPU8ChH/TXmpP6cDo+ArzKsQt04rop85
	exR3Bi2sMMeWS1pZV1uwa+Q7ZEUcsXOrYx52Hq+ipQ9vphgkX54K97xFhlVU4pm/hRBmcu
	rqYjoHjQRRNV5NgM7KUC3tq6Fe2KXtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718986182;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EwtQk9tLIu3pAbGuLBfd9oqp0JcfGbaoZTN/hou026M=;
	b=tSz5wRLoGdinDPTRHBJZxXyt5kUM/SO+vj5p+3mhbYag0CtgFUyRXtEg6VWZ45nj5jtGdQ
	eKjrNUF2f9CHk5CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718986182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EwtQk9tLIu3pAbGuLBfd9oqp0JcfGbaoZTN/hou026M=;
	b=pmhTRG3fnu9xeVzxTx6yrWJ86bZHfxBXwrpn+lfPU8ChH/TXmpP6cDo+ArzKsQt04rop85
	exR3Bi2sMMeWS1pZV1uwa+Q7ZEUcsXOrYx52Hq+ipQ9vphgkX54K97xFhlVU4pm/hRBmcu
	rqYjoHjQRRNV5NgM7KUC3tq6Fe2KXtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718986182;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EwtQk9tLIu3pAbGuLBfd9oqp0JcfGbaoZTN/hou026M=;
	b=tSz5wRLoGdinDPTRHBJZxXyt5kUM/SO+vj5p+3mhbYag0CtgFUyRXtEg6VWZ45nj5jtGdQ
	eKjrNUF2f9CHk5CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A406D13ABD;
	Fri, 21 Jun 2024 16:09:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2LUGKMaldWYfTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 21 Jun 2024 16:09:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4433EA085C; Fri, 21 Jun 2024 18:09:42 +0200 (CEST)
Date: Fri, 21 Jun 2024 18:09:42 +0200
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
Message-ID: <20240621160942.4bfi56fgy6ycvtl4@quack3>
References: <0000000000006fd14305f00bdc84@google.com>
 <0000000000000b3e69061b5b5762@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000000b3e69061b5b5762@google.com>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[d1da16f03614058fdc48];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Thu 20-06-24 17:16:16, syzbot wrote:
> This bug is marked as fixed by commit:
> ext4: fix race condition between buffer write and page_mkwrite
> 
> But I can't find it in the tested trees[1] for more than 90 days.
> Is it a correct commit? Please update it by replying:
> 
> #syz fix: exact-commit-title
> 
> Until then the bug is still considered open and new crashes with
> the same signature are ignored.
> 
> Kernel: Linux
> Dashboard link: https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48

This bug is still unfixed AFAIK as we realized the fixing commit is buggy
and there's no easy fix (inline_data feature has some difficult to address
problems). So can we 'syz unfix' this? :)

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

