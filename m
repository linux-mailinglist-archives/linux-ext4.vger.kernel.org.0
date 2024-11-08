Return-Path: <linux-ext4+bounces-5006-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B449C1BD8
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Nov 2024 12:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49611C214E9
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Nov 2024 11:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E1C1E32D5;
	Fri,  8 Nov 2024 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Q1rak/8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FC2rI/Ln";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Q1rak/8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FC2rI/Ln"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732021E1A14
	for <linux-ext4@vger.kernel.org>; Fri,  8 Nov 2024 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731064003; cv=none; b=mh27q9ieRWnwXYdWzBq4Oep0Rt/4rr1yBdkMVEJx8YkIGBoEvjSrnpDjdoXeUW/88bV5XUFCjO1TtqwbpjOGY9wJhlTCQoVy1CV4jkzgVbPGMGw/NjjTuVrilGJmkRCa4J8IYHrS5QsJddku0wuFsctbMUpbuGcqUwLTphJpwCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731064003; c=relaxed/simple;
	bh=eZ3dozD0KLjXCNQr+GgeQX2jQ21VvzETZsF0+TI29ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3THZhAOFjvwZAsDmlqSZBBo2xubDjlLv6rPFyYn97DnEdRnvMnEooWxJcOyFvKL+5dAC3Prm+EC4JuJ5MK2hrCZQmBvOPWBKOVLxftfgF1o1FoBEaIMl1D7vZT91jMfjVqhPgsVCMO2HfBxLLVMehCs8fRqMRnVKBUPYpAT5so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Q1rak/8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FC2rI/Ln; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Q1rak/8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FC2rI/Ln; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A2ED1F79E;
	Fri,  8 Nov 2024 11:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731063998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hYgpYR2E32QpCPl2sF+w/1THFJcGyihZy+9Ocy3pKrw=;
	b=2Q1rak/8wXOZl3xqF3B/COFi185C2q9OihG8EBnKgZgV+gahuJ2iT67AAPwyGw0nkTK42s
	oTurdpUwfYq2+gvS9t/8tvWJiQV9c9f1NfDu8jxpnZ7AGWjzqk+O4qL4HmexMpvqEgVNQV
	aFdqr4bGVI2EQJgRM59odlfinelBcHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731063998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hYgpYR2E32QpCPl2sF+w/1THFJcGyihZy+9Ocy3pKrw=;
	b=FC2rI/Lns1ii4i5M8ifItSKbw8T6nM87uO2RkLf80BXyblRZm8b670nyDmk652b1sgaBu0
	Lf+t4TwOR0z8IICw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="2Q1rak/8";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="FC2rI/Ln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731063998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hYgpYR2E32QpCPl2sF+w/1THFJcGyihZy+9Ocy3pKrw=;
	b=2Q1rak/8wXOZl3xqF3B/COFi185C2q9OihG8EBnKgZgV+gahuJ2iT67AAPwyGw0nkTK42s
	oTurdpUwfYq2+gvS9t/8tvWJiQV9c9f1NfDu8jxpnZ7AGWjzqk+O4qL4HmexMpvqEgVNQV
	aFdqr4bGVI2EQJgRM59odlfinelBcHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731063998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hYgpYR2E32QpCPl2sF+w/1THFJcGyihZy+9Ocy3pKrw=;
	b=FC2rI/Lns1ii4i5M8ifItSKbw8T6nM87uO2RkLf80BXyblRZm8b670nyDmk652b1sgaBu0
	Lf+t4TwOR0z8IICw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FC7E1394A;
	Fri,  8 Nov 2024 11:06:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F2ssH77wLWdyQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 08 Nov 2024 11:06:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3DE8EA0AF4; Fri,  8 Nov 2024 12:06:34 +0100 (CET)
Date: Fri, 8 Nov 2024 12:06:34 +0100
From: Jan Kara <jack@suse.cz>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Li Zetao <lizetao1@huawei.com>, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH -next 0/3] ext4: Using scope-based resource management
 function
Message-ID: <20241108110634.e2sqy4nzncfs7in4@quack3>
References: <20240823061824.3323522-1-lizetao1@huawei.com>
 <20241107041644.GE172001@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107041644.GE172001@mit.edu>
X-Rspamd-Queue-Id: 8A2ED1F79E
X-Spam-Level: 
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
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Wed 06-11-24 23:16:44, Theodore Ts'o wrote:
> On Fri, Aug 23, 2024 at 02:18:21PM +0800, Li Zetao wrote:
> > Hi all,
> > 
> > This patch set is dedicated to using scope-based resource management
> > functions to replace the direct use of lock/unlock methods, so that
> > developers can focus more on using resources in a certain scope and
> > avoid overly focusing on resource leakage issues.
> > 
> > At the same time, some functions can remove the controversial goto
> > label(eg: patch 3), which usually only releases resources and then
> > exits the function. After replacement, these functions can exit
> > directly without worrying about resources not being released.
> > 
> > This patch set has been tested by fsstress for a long time and no
> > problems were found.
> 
> Hmm, I'm torn.  I do like the simplification that these patches can
> offer.
> 
> The potential downsides/problems that are worrying me:
> 
> 1) The zero day test bot has flagged a number of warnings[1]
> 
> [1] https://lore.kernel.org/r/202408290407.XQuWf1oH-lkp@intel.com
> 
> 2) The documentation for guard() and scoped_guard() is pretty sparse,
>     and the comments in include/linux/cleanup.h are positively
>     confusing.  There is a real need for a tutorial which explains how
>     they should be used in the Documentation directory, or maybe a
>     LWN.net article.  Still, after staring that the implementation, I
>     was able to figure it out, but I'm bit worried that people who
>     aren't familiar with this construt which appears to have laned in
>     August 2023, might find the code less readable.
> 
> 3)  Once this this lands, I could see potential problems when bug fixes
>     are backported to stable kernels older than 6.6, since this changes
>     how lock and unlock calls in the ext4 code.  So unless
>     include/linux/cleanup.h is backported to all of the LTS kernels, as
>     well as these ext4 patches, there is a ris that a future (possibly
>     security) bug fix will result in a missing unlock leading to
>     hilarity and/or sadness.
> 
>     I'm reminded of the story of XFS changing the error return
>     semantics from errno to -errno, and resulting bugs when patches
>     were automatically backported to the stable kernels leading to
>     real problems, which is why XFS opted out of LTS backports.  This
>     patch series could have the same problem.... and I haven't been
>     able to recruit someone to be the ext4 stable kernel maintainers
>     who could monitor xfstests resullts with lockdep enabled to catch
>     potential problems.
> 
> That being said, I do see the value of the change
> 
> What do other ext4 developers think?

So overall I consider guards a useful feature. That being said I find
changes as:

-		rcu_read_lock();
+		guard(rcu)();
 		rcu_dereference(sbi->s_group_desc)[i] = bh;
-		rcu_read_unlock();

actively harmful because they make you go "Eww, so when *does* the RCU get
released now?" If this was modified to:

-		rcu_read_lock();
+		guard(rcu)() {
	 		rcu_dereference(sbi->s_group_desc)[i] = bh;
		}
-		rcu_read_unlock();

then I wouldn't mind *that* much but I see such change mostly as a
pointless churn.

OTOH if we managed to successfully convert e.g. ext4_fill_super() into
using guards, then I would absolutely love that and in principle I think
that is possible. The unwinding code there is not pretty with various
#ifdef blocks, __maybe_unused annotations to silence warnings etc. But it
would take more than just a quick replacement of obvious blocks to do that
conversion.

So to sum it up, I'm not against using guards but as I've glanced over the
posted patches I find them to do more harm than good.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

