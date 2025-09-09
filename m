Return-Path: <linux-ext4+bounces-9875-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B63B4AB02
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 12:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38DD3B9B92
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 10:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C1831CA5D;
	Tue,  9 Sep 2025 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cqeovs+c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rMuoeX5H";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cqeovs+c";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rMuoeX5H"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B2B2248BD
	for <linux-ext4@vger.kernel.org>; Tue,  9 Sep 2025 10:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757415587; cv=none; b=kGZ8QN2nq3xcegzhv2BfLv7LgIF8JWZQ4CVI2URive+C7cNsXu4s2H3F6lAA/su5h6PblR33dItAHjLJCePXwEgv+zaD5dao8nlrfQ1H0YwX/q2EJH58AOAIBzJmkdsc4614fFg15vevYms/Q6FIvqbmTp8qCXSGpcHEba/N/tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757415587; c=relaxed/simple;
	bh=laJCE902r5dS62VzFgnXSPFty0iygO4IscIOU3sHIB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJqFcKxaId5mlnT5Ia9bCCe7GSmdrF/lGtpNItI4313VNTWkWc4ThwrYnkjlb82aeitWYnJIy/tIBpsAEQwhe7vX4ksNzwNfddqJDBIuck1y+f4cOanVv+5LaNCVP7JdCkuibj2XLzS3jrp5wn0ycNX1wB0RIdAYt+pfFwiTd9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cqeovs+c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rMuoeX5H; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cqeovs+c; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rMuoeX5H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B106F5C775;
	Tue,  9 Sep 2025 10:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757415583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vd8wQMlXzXKXcCj++nSUg3MPs3H0+YLW4byTSnUGpN8=;
	b=cqeovs+cpM75eL5RKYMbTIwmrGFq7UkMV0cZNfQoyh4qt+5nXLkOwUbk8JMUtCFj3ZAe+L
	fFBcDudcENjG7iyMHNg237ylHqeUCBNCfoQMyme7qh/g/lf+1ipwXIWroF3b0FU7BKl6f7
	cqxl/rOgpBCVTlZJJBCS6PYcFaMi7nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757415583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vd8wQMlXzXKXcCj++nSUg3MPs3H0+YLW4byTSnUGpN8=;
	b=rMuoeX5Hw6UparPgidr2/Pven6dTbdue7qxyhDzTOOF4Xek8F7mLkYaUOis5sEAXuMwVTf
	dAIuLc7JIq8JIYDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cqeovs+c;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rMuoeX5H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757415583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vd8wQMlXzXKXcCj++nSUg3MPs3H0+YLW4byTSnUGpN8=;
	b=cqeovs+cpM75eL5RKYMbTIwmrGFq7UkMV0cZNfQoyh4qt+5nXLkOwUbk8JMUtCFj3ZAe+L
	fFBcDudcENjG7iyMHNg237ylHqeUCBNCfoQMyme7qh/g/lf+1ipwXIWroF3b0FU7BKl6f7
	cqxl/rOgpBCVTlZJJBCS6PYcFaMi7nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757415583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vd8wQMlXzXKXcCj++nSUg3MPs3H0+YLW4byTSnUGpN8=;
	b=rMuoeX5Hw6UparPgidr2/Pven6dTbdue7qxyhDzTOOF4Xek8F7mLkYaUOis5sEAXuMwVTf
	dAIuLc7JIq8JIYDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93FDD13A56;
	Tue,  9 Sep 2025 10:59:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JgobJJ8IwGgLLAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 09 Sep 2025 10:59:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DE065A0A2D; Tue,  9 Sep 2025 12:59:38 +0200 (CEST)
Date: Tue, 9 Sep 2025 12:59:38 +0200
From: Jan Kara <jack@suse.cz>
To: syzbot <syzbot+0b92850d68d9b12934f5@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, akpm@linux-foundation.org, 
	apopple@nvidia.com, byungchul@sk.com, david@redhat.com, gourry@gourry.net, 
	jack@suse.cz, joshua.hahnjy@gmail.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, matthew.brost@intel.com, rakie.kim@sk.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu, ying.huang@linux.alibaba.com, ziy@nvidia.com
Subject: Re: [syzbot] [mm?] [ext4?] WARNING in ext4_init_orphan_info
Message-ID: <puvp7vzyv427rdfs6jkdfi5qdhfrotxahijtah5wwvlh4s3ykw@tq5ytvrlwnlh>
References: <68bf244a.050a0220.192772.0883.GAE@google.com>
 <68bf33e3.a70a0220.7a912.02c3.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68bf33e3.a70a0220.7a912.02c3.GAE@google.com>
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=429771c55b615e85];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[dilger.ca,linux-foundation.org,nvidia.com,sk.com,redhat.com,gourry.net,suse.cz,gmail.com,vger.kernel.org,kvack.org,intel.com,googlegroups.com,mit.edu,linux.alibaba.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[0b92850d68d9b12934f5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: B106F5C775
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -1.51

On Mon 08-09-25 12:52:03, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit 02f310fcf47fa9311d6ba2946a8d19e7d7d11f37
> Author: Jan Kara <jack@suse.cz>
> Date:   Mon Aug 16 09:57:06 2021 +0000
> 
>     ext4: Speedup ext4 orphan inode handling
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16645562580000
> start commit:   76eeb9b8de98 Linux 6.17-rc5
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15645562580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11645562580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=429771c55b615e85
> dashboard link: https://syzkaller.appspot.com/bug?extid=0b92850d68d9b12934f5
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168d2562580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15869562580000
> 
> Reported-by: syzbot+0b92850d68d9b12934f5@syzkaller.appspotmail.com
> Fixes: 02f310fcf47f ("ext4: Speedup ext4 orphan inode handling")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Hum, yes, we don't verify orphan file size is sane. I'll send a fix.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

