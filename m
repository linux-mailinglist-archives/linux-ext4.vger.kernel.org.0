Return-Path: <linux-ext4+bounces-5163-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063C09C8DE5
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 16:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94D6286F48
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2024 15:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9236D28E0F;
	Thu, 14 Nov 2024 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jOwmGtrl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QKS5hQTO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jOwmGtrl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QKS5hQTO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A8A13AD29
	for <linux-ext4@vger.kernel.org>; Thu, 14 Nov 2024 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731597972; cv=none; b=hsJ054y5tj69RuqXImc5dkcLj/tQhVD9SfMBzfR9KTh9H4YfCWSOzOYWDC2AT1rVjHsVsmUGjbfk7OjS2ID722N4B3ByXQfWz42C+j963F4MAT2xnaMqBUIX85LI/fN7xMUXEzTVahMwewTeNBxLrTGvTdMuUm3TOlZ9qh4a83U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731597972; c=relaxed/simple;
	bh=pYg0ZEq7YZCEsjJ7S9H6welbOuiHD+tza1hO1fDPFIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMJJRfSBxSJGJ9lxG0O6L+NTmxQwQu0TosS9t7POXfxPr9GF2Tip2thlPeUH7HpUb7fRNJ57vibZ1ZriePfBPhWJAQxLKBN6sH8S8bK/x+R83LoPfwLWbApZ763Zm67SYIZ+t4EAjOlOdLNG5QsZX9JdEShFrhDAoaV3/IINWwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jOwmGtrl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QKS5hQTO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jOwmGtrl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QKS5hQTO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0769521134;
	Thu, 14 Nov 2024 15:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731597968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M9TQOyctTx3F+55/OuInl1ZLq7Wuycr0F4jqoyjW/Lg=;
	b=jOwmGtrlj3NceiVAmrWlc4lTrpNYLGoi1BdxPTsmfXQzXgerChboFKafZGYaGZHMJBj55N
	IahBiLIoH1bI1DMAsYhL8mgzjB98iprxiUUm6fODKL2Un5SjdareB3m8/K89CDkIvturRi
	Q2fF0/5l/1QOxwMTAl6Kazq14JTtaL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731597968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M9TQOyctTx3F+55/OuInl1ZLq7Wuycr0F4jqoyjW/Lg=;
	b=QKS5hQTOBf9AHbwBn0m+lU4OKEISdGWrILiWbMyAQnjLofFXA3V7+iZpDloJuwE1lLxc7E
	DfrPMU0Sn0i9x3Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731597968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M9TQOyctTx3F+55/OuInl1ZLq7Wuycr0F4jqoyjW/Lg=;
	b=jOwmGtrlj3NceiVAmrWlc4lTrpNYLGoi1BdxPTsmfXQzXgerChboFKafZGYaGZHMJBj55N
	IahBiLIoH1bI1DMAsYhL8mgzjB98iprxiUUm6fODKL2Un5SjdareB3m8/K89CDkIvturRi
	Q2fF0/5l/1QOxwMTAl6Kazq14JTtaL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731597968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M9TQOyctTx3F+55/OuInl1ZLq7Wuycr0F4jqoyjW/Lg=;
	b=QKS5hQTOBf9AHbwBn0m+lU4OKEISdGWrILiWbMyAQnjLofFXA3V7+iZpDloJuwE1lLxc7E
	DfrPMU0Sn0i9x3Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF50B13794;
	Thu, 14 Nov 2024 15:26:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XulmOo8WNmdXCQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 14 Nov 2024 15:26:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A3604A0962; Thu, 14 Nov 2024 16:26:07 +0100 (CET)
Date: Thu, 14 Nov 2024 16:26:07 +0100
From: Jan Kara <jack@suse.cz>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>,
	Zhi Long <longzhi@sangfor.com.cn>
Subject: Re: [PATCH v3] ext4: Make sure BH_New bit is cleared in ->write_end
 handler
Message-ID: <20241114152607.v3bdfpu2sgayztdr@quack3>
References: <20241018145901.2086-1-jack@suse.cz>
 <20241113175550.GA462442@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113175550.GA462442@mit.edu>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 13-11-24 12:55:50, Theodore Ts'o wrote:
> On Fri, Oct 18, 2024 at 04:59:01PM +0200, Jan Kara wrote:
> > Currently we clear BH_New bit in case of error and also in the standard
> > ext4_write_end() handler (in block_commit_write()). However
> > ext4_journalled_write_end() misses this clearing and thus we are leaving
> > stale BH_New bits behind. Generally ext4_block_write_begin() clears
> > these bits before any harm can be done but in case blocksize < pagesize
> > and we hit some error when processing a page with these stale bits,
> > we'll try to zero buffers with these stale BH_New bits and jbd2 will
> > complain (as buffers were not prepared for writing in this transaction).
> > Fix the problem by clearing BH_New bits in ext4_journalled_write_end()
> > and WARN if ext4_block_write_begin() sees stale BH_New bits.
> > 
> > Reported-and-tested-by: Baolin Liu <liubaolin@kylinos.cn>
> > Reported-and-tested-by: Zhi Long <longzhi@sangfor.com.cn>
> > Fixes: 3910b513fcdf ("ext4: persist the new uptodate buffers in ext4_journalled_zero_new_buffers")
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> This patch is causing quite a lot of regressions:
> 
> ext4/adv: 569 tests, 36 failures, 61 skipped, 6510 seconds
>   Failures: ext4/307 generic/069 generic/079 generic/082 generic/130 
>     generic/131 generic/219 generic/230 generic/231 generic/232 
>     generic/233 generic/234 generic/235 generic/241 generic/244 
>     generic/270 generic/280 generic/355 generic/379 generic/381 
>     generic/382 generic/400 generic/422 generic/464 generic/566 
>     generic/571 generic/572 generic/587 generic/600 generic/601 
>     generic/681 generic/682 generic/691
> 
> This appears to be caused by inline data, so a quick reproducer for
> bisection purposes was:
> 
>    kvm-xfststs -c ext4/inline ext4/307
> 
> Attached below please find the warning which is triggering the
> "_check_dmesg: something found in dmesg" test failure.
> 
> I suspect this should be fairly easy to fix, but I'm going to drop it
> from my tree for now.

Yeah, sure. I didn't test with inline data so I didn't notice. I'll check
what's going wrong and sorry for the annoyance.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

