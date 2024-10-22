Return-Path: <linux-ext4+bounces-4715-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3399A9DCB
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2024 11:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F3D1F216E4
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2024 09:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD994191F65;
	Tue, 22 Oct 2024 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iUTyeyi3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lJEaoDG5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kNwMrspN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7pQY8885"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C203F13A87E;
	Tue, 22 Oct 2024 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587815; cv=none; b=RFqUYm77QTSg6WuwCMFECkAakWfrkyMgx72hYYpY0Nv1VHTmMY7OqNaNlM0BN5eDGKFjvLy2N7CC4iBpFvpRh0qYwnoc/AnQpbxC1YUHUBlP2NyIqQor/siu1S8HS8FUGEsTexK9iNWi/t7Rm7niW1jTXc5CnfNvTcIEgOaGQ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587815; c=relaxed/simple;
	bh=ioAaxHr2C6kF7QpbXs+mfIXLIHx/vXb70/KqhMgNqNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrfsFHCFkzbF3fv1HldeRgvCwcqp7AKX1rbaATHiZV/ElFoBfuHn26EypESBbK1701t2hs4186pJl66YLWsiAJcZKOEnoi1pveozeud9U/L5jZx33lVVghbl+Og+oUakdN1EFLd7Gaqwjvo5Hat0cXEdyU4fM3Mdin8sP7bTShI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iUTyeyi3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lJEaoDG5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kNwMrspN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7pQY8885; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D2C7B21EA9;
	Tue, 22 Oct 2024 09:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729587812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ge4czd1YagvBRBTmt8lWVR11qX/pmlisX8kozJtR0aI=;
	b=iUTyeyi3SVngXA1CvL1NDanzlS1Oc8rqh3Fgk6Ba9WPRnw9YeqDfC1nE32SzMyjSWDwJug
	dhlKJOV95UdoIRn06cbZQu2vO8G84QAXXhQnDqwk7LI5ieSc7CBUaIoDMf7dL2K+1JuFP9
	fnUqqrcpyC4jscAOPTGX11n9cPpr78Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729587812;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ge4czd1YagvBRBTmt8lWVR11qX/pmlisX8kozJtR0aI=;
	b=lJEaoDG5uXB3GComykDOaC7w0piat9gMBVyKHCDXHiAdR1iHxuboWlBjqtS4Si1ZAza9OQ
	/JzYuoUY2QPs/IBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kNwMrspN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7pQY8885
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729587811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ge4czd1YagvBRBTmt8lWVR11qX/pmlisX8kozJtR0aI=;
	b=kNwMrspN3VhSKFLfTUJtUU85LnAqmCWinaq854ahje1yTaVOefznClzlNakYxNhv13LuyW
	/6MR34wzygSjUlP9PeVGyYpMPwohZQlETP4sUgkNYlSkF8JYNZYtrdBpNfCy9id0OrRIV/
	xR3/w0WMIh2+ihWY8rpp3WpaeOY6diM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729587811;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ge4czd1YagvBRBTmt8lWVR11qX/pmlisX8kozJtR0aI=;
	b=7pQY8885WVrpMLkVgshxnJ5+h6e+v4DoxfYA8fOfNeIxORAf3c4hGenMsjFmimpuIJPP9Q
	Uddikc88kWX94OCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5E6513AC9;
	Tue, 22 Oct 2024 09:03:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1lhLMGNqF2fDBwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 22 Oct 2024 09:03:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8C6D7A086F; Tue, 22 Oct 2024 11:03:27 +0200 (CEST)
Date: Tue, 22 Oct 2024 11:03:27 +0200
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+0dd5b81275fa083055d7@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, brauner@kernel.org,
	clang-built-linux@googlegroups.com, harshadshirwadkar@gmail.com,
	jack@suse.cz, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, nathan@kernel.org,
	ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: Re: [syzbot] [ext4?] INFO: task hung in ext4_stop_mmpd
Message-ID: <20241022090327.qhemczcaheaympct@quack3>
References: <000000000000690606061ce1fe7e@google.com>
 <6716e5a0.050a0220.10f4f4.00d2.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6716e5a0.050a0220.10f4f4.00d2.GAE@google.com>
X-Rspamd-Queue-Id: D2C7B21EA9
X-Spam-Level: 
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=dd14c10ec1b6af25];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[dilger.ca,kernel.org,googlegroups.com,gmail.com,suse.cz,vger.kernel.org,google.com,mit.edu];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[0dd5b81275fa083055d7];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -1.51
X-Spam-Flag: NO

On Mon 21-10-24 16:37:04, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit d3476f3dad4ad68ae5f6b008ea6591d1520da5d8
> Author: Jan Kara <jack@suse.cz>
> Date:   Mon Aug 5 20:12:41 2024 +0000
> 
>     ext4: don't set SB_RDONLY after filesystem errors
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10d04640580000
> start commit:   4a39ac5b7d62 Merge tag 'random-6.12-rc1-for-linus' of git:..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=dd14c10ec1b6af25
> dashboard link: https://syzkaller.appspot.com/bug?extid=0dd5b81275fa083055d7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fbd177980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108ea607980000
> 
> If the result looks correct, please mark the issue as fixed by replying with:

Looks plausible:

#syz fix: ext4: don't set SB_RDONLY after filesystem errors

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

