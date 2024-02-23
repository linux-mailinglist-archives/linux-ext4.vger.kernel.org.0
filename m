Return-Path: <linux-ext4+bounces-1376-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 074CE8610FC
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Feb 2024 13:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0801F25DB3
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Feb 2024 12:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472017AE78;
	Fri, 23 Feb 2024 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mcJfWEPi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iapIi0NM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mcJfWEPi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iapIi0NM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0876576911;
	Fri, 23 Feb 2024 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689955; cv=none; b=pzaWjFJQ9e3WwmsEndbVaZPFpv2FzHPseFSbzci86a9XXmebpeTce4gsFWgV0r0iHNY7zLAxQTfrGyjtRq0Pg53G2/FeuBfQ7GGPItD5XVgIQqxXmhu9LqOJlvNiA0bkDJksEEjbXzgiSUKq72KBVZ0pQ/Jm/l2uZkwkLX5IZmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689955; c=relaxed/simple;
	bh=LxF02MxBvElqLAXQXoh2lLPVWCY4GC4g+MqRuLP11Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fedhYCQH1a15KCNILGn0EZUl7KmreOKWKLXWli1885aPNSz6m+zIN7TcKh6y0u0HW9saRAKtwSagUDV9TmyXpvRbEkbD+SEq5jk8T1Z/DwnmMwhBviF9Ue4/J/wQD1wFKG0gkcuJVsbPu90uw27m+8XfbUx3ZNsD0dTYjEZp7Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mcJfWEPi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iapIi0NM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mcJfWEPi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iapIi0NM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 01FBA1FBDE;
	Fri, 23 Feb 2024 12:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708689952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLhNAwr1dv81yHeZN1C7tmYQH/LBtZA4FtP8mootK6c=;
	b=mcJfWEPiRB9FIyNi7Dae3CyA1gqyxPpdu7Aw955h+j3mgK2jyYLB4/iVb85JXO+DPBW9PT
	wzwtxSuSFC2MJoPu+1ssYVPG4CQtb5F4KAycWb1wiyvKo1oSS/57AqTMFbuKJ0UxbfUSXF
	suyiYFRQEyzugNW4j1RT8SC6Ma/ordU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708689952;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLhNAwr1dv81yHeZN1C7tmYQH/LBtZA4FtP8mootK6c=;
	b=iapIi0NMPjT1r/YUEq2Wd6uHQ2zV4blLY8pHn7HRIRMTP+a8hz33paRYYTDH3u9grF5tOZ
	I1MoG6ZRBoe4LIBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708689952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLhNAwr1dv81yHeZN1C7tmYQH/LBtZA4FtP8mootK6c=;
	b=mcJfWEPiRB9FIyNi7Dae3CyA1gqyxPpdu7Aw955h+j3mgK2jyYLB4/iVb85JXO+DPBW9PT
	wzwtxSuSFC2MJoPu+1ssYVPG4CQtb5F4KAycWb1wiyvKo1oSS/57AqTMFbuKJ0UxbfUSXF
	suyiYFRQEyzugNW4j1RT8SC6Ma/ordU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708689952;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DLhNAwr1dv81yHeZN1C7tmYQH/LBtZA4FtP8mootK6c=;
	b=iapIi0NMPjT1r/YUEq2Wd6uHQ2zV4blLY8pHn7HRIRMTP+a8hz33paRYYTDH3u9grF5tOZ
	I1MoG6ZRBoe4LIBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D30E113419;
	Fri, 23 Feb 2024 12:05:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id x1yCMx+K2GXIZgAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 23 Feb 2024 12:05:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 754EFA07D1; Fri, 23 Feb 2024 13:05:47 +0100 (CET)
Date: Fri, 23 Feb 2024 13:05:47 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, ritesh.list@gmail.com,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, chengzhihao1@huawei.com, yukuai3@huawei.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/7] ext4: add positive int attr pointer to avoid sysfs
 variables overflow
Message-ID: <20240223120547.lojc4ccfewi6iotw@quack3>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
 <20240126085716.1363019-5-libaokun1@huawei.com>
 <20240213165810.3k4lnxaqzdwrdj35@quack3>
 <83c16b1a-832d-2ffd-6100-1f2b80ca2f35@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83c16b1a-832d-2ffd-6100-1f2b80ca2f35@huawei.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mcJfWEPi;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iapIi0NM
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
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
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 01FBA1FBDE
X-Spam-Flag: NO

On Sat 17-02-24 15:41:43, Baokun Li wrote:
> On 2024/2/14 0:58, Jan Kara wrote:
> > On Fri 26-01-24 16:57:13, Baokun Li wrote:
> > > We can easily trigger a BUG_ON by using the following commands:
> > > 
> > >      mount /dev/$disk /tmp/test
> > >      echo 2147483650 > /sys/fs/ext4/$disk/mb_group_prealloc
> > >      echo test > /tmp/test/file && sync
> > > 
> > > ==================================================================
> > > kernel BUG at fs/ext4/mballoc.c:2029!
> > > invalid opcode: 0000 [#1] PREEMPT SMP PTI
> > > CPU: 3 PID: 320 Comm: kworker/u36:1 Not tainted 6.8.0-rc1 #462
> > > RIP: 0010:mb_mark_used+0x358/0x370
> > > [...]
> > > Call Trace:
> > >   ext4_mb_use_best_found+0x56/0x140
> > >   ext4_mb_complex_scan_group+0x196/0x2f0
> > >   ext4_mb_regular_allocator+0xa92/0xf00
> > >   ext4_mb_new_blocks+0x302/0xbc0
> > >   ext4_ext_map_blocks+0x95a/0xef0
> > >   ext4_map_blocks+0x2b1/0x680
> > >   ext4_do_writepages+0x733/0xbd0
> > > [...]
> > > ==================================================================
> > > 
> > > In ext4_mb_normalize_group_request():
> > >      ac->ac_g_ex.fe_len = EXT4_SB(sb)->s_mb_group_prealloc;
> > > 
> > > Here fe_len is of type int, but s_mb_group_prealloc is of type unsigned
> > > int, so setting s_mb_group_prealloc to 2147483650 overflows fe_len to a
> > > negative number, which ultimately triggers a BUG_ON() in mb_mark_used().
> > > 
> > > Therefore, we add attr_pointer_pi (aka positive int attr pointer) with a
> > > value range of 0-INT_MAX to avoid the above problem. In addition to the
> > > mb_group_prealloc sysfs interface, the following interfaces also have uint
> > > to int conversions that result in overflows, and are also fixed.
> > > 
> > >    err_ratelimit_burst
> > >    msg_ratelimit_burst
> > >    warning_ratelimit_burst
> > >    err_ratelimit_interval_ms
> > >    msg_ratelimit_interval_ms
> > >    warning_ratelimit_interval_ms
> > >    mb_best_avail_max_trim_order
> > > 
> > > CC: stable@vger.kernel.org
> > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > I don't think you need to change s_mb_group_prealloc here and then restrict
> > it even further in the next patch. I'd just leave it alone here.
> Yes, we could put the next patch before this one, but using
> s_mb_group_prealloc as an example makes it easier to understand
> why the attr_pointer_pi case is added here.There are several other
> variables that don't have more convincing examples.

Yes, I think reordering would be good. Because I've read the convertion and
started wondering: "is this enough?"

> > Also I think that limiting mb_best_avail_max_trim_order to 64 instead of
> > INT_MAX will make us more resilient to surprises in the future :) But I
> > don't really insist.
> > 
> > 								Honza
> I think it's enough here to make sure that mb_best_avail_max_trim_order
> is a positive number, since we always make sure that min_order
> is not less than 0, as follows:
> 
>          order = fls(ac->ac_g_ex.fe_len) - 1;
>          min_order = order - sbi->s_mb_best_avail_max_trim_order;
>          if (min_order < 0)
>                  min_order = 0;
> 
> An oversized mb_best_avail_max_trim_order can be interpreted as
> always being CR_ANY_FREE. 😄

Well, s_mb_best_avail_max_trim_order is not about allocation passes but
about how many times are we willing to shorten the goal extent to half and
still use the advanced free blocks search. And I agree that the mballoc
code is careful enough that large numbers don't matter there but still why
allowing storing garbage values? It is nicer to tell sysadmin he did
something wrong right away.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

