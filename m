Return-Path: <linux-ext4+bounces-4622-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC5B9A39B5
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 11:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 415BCB26477
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 09:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C40B19067A;
	Fri, 18 Oct 2024 09:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ivV2SjfZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A3L9GHrD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ivV2SjfZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A3L9GHrD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A0218452C;
	Fri, 18 Oct 2024 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242888; cv=none; b=oSXvkNN+UL40spK5dELE3D3syYYnTk+F63fRYGNC4ZC4YRq3uLv/SEHmCiyBGa5h8bLdEW7Apx4mxKnXk7gs1aXRSKv8fJDJ+jBtlnGHYUEO06irsOg0rjpWf41ZuGJfN5UuEbNWJfnyILWt6EVoIpF/jnZ+pw3RzxEgn6qFuoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242888; c=relaxed/simple;
	bh=ROT6zgqFBK0eEpukVeMYyhv6nDJFhYHhH/w9THABMnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0XD7luW28uYDbr8qzA21tX8QkVacItBANqKoW5q6hElBuGeurvnfkFQNwe62vPmcnFYc63I7FlX31V0FNcXGC3EcyVSmlZj9zUzXtZQSGGiuXAaIXVE10wele4FSD4t1swGgmtQ/gAXVY1bkC2dLcRrkNYN/GX27Opj+cHadms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ivV2SjfZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A3L9GHrD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ivV2SjfZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A3L9GHrD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8E2F521BEE;
	Fri, 18 Oct 2024 09:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729242884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28oYwiLkgCTjda/f5xfuImC4kUT6suMS2m+hSr7C38s=;
	b=ivV2SjfZXfKEoWnnVYmA3Zp/xEP37gYuVhZBnY8VB3Cm+S94IDvb5izFWoBLr/vNDNxrW2
	+z/WSwOM/QI4XEPXNz9ZRBVW3m9HW/t/a+Mq+aQGp+nK+8EpbDhzmM7wYrt3sIFntTtAX0
	xZ+Cvhg1KR3a0ENiElOG7a8H3NMCdck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729242884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28oYwiLkgCTjda/f5xfuImC4kUT6suMS2m+hSr7C38s=;
	b=A3L9GHrDa/4RJjj9d4SyHLz5C1fW8UDkwjPZx8ShECUS4yaM0V1Doe6UFaBsVvsjN0/0b2
	XD2a72rZHlSGCiDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729242884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28oYwiLkgCTjda/f5xfuImC4kUT6suMS2m+hSr7C38s=;
	b=ivV2SjfZXfKEoWnnVYmA3Zp/xEP37gYuVhZBnY8VB3Cm+S94IDvb5izFWoBLr/vNDNxrW2
	+z/WSwOM/QI4XEPXNz9ZRBVW3m9HW/t/a+Mq+aQGp+nK+8EpbDhzmM7wYrt3sIFntTtAX0
	xZ+Cvhg1KR3a0ENiElOG7a8H3NMCdck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729242884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=28oYwiLkgCTjda/f5xfuImC4kUT6suMS2m+hSr7C38s=;
	b=A3L9GHrDa/4RJjj9d4SyHLz5C1fW8UDkwjPZx8ShECUS4yaM0V1Doe6UFaBsVvsjN0/0b2
	XD2a72rZHlSGCiDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8317913680;
	Fri, 18 Oct 2024 09:14:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ubMIIAQnEme9VgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 18 Oct 2024 09:14:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 51B0DA080A; Fri, 18 Oct 2024 11:14:44 +0200 (CEST)
Date: Fri, 18 Oct 2024 11:14:44 +0200
From: Jan Kara <jack@suse.cz>
To: liubaolin <liubaolin12138@163.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
	zhangshida@kylinos.cn, longzhi@sangfor.com.cn,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v1] ext4: fix a assertion failure due to ungranted bh
 dirting
Message-ID: <20241018091444.tmzhbj73gvegfmb5@quack3>
References: <20241010025855.2632516-1-liubaolin12138@163.com>
 <20241010092923.r53povuflevzhxrw@quack3>
 <5dc22111.4718.19279c3f3b7.Coremail.liubaolin12138@163.com>
 <20241016103301.rl6qngi2fb6yxjin@quack3>
 <908502d6-cb0c-44ae-8c03-9a22c8c7fbf2@163.com>
 <8c14e5b0-5229-4611-b8e6-434c6eb34ee9@163.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c14e5b0-5229-4611-b8e6-434c6eb34ee9@163.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 18-10-24 09:48:17, liubaolin wrote:
> > Hello, I am very sorry.
> > I did not previously understand the approach of your patch to solve the issue.
> > Yesterday, I intentionally injected faults during the quick reproduction
> > test, and indeed, after applying your patch, the crash issue was
> > resolved and did not occur again.
> > I finally understood your approach to solving the problem. Please disregard my previous email.
> > Thank you for helping me solve this crash issue in a better way.
> > I still need to improve my skills in file systems, and I truly appreciate your guidance.

Great! Thanks for testing. I'll send the patch for inclusion then.

								Honza

> 在 2024/10/16 21:38, liubaolin 写道:
> > > Hello,
> > > I reviewed the patch attached in your email. The issue you mentioned
> > > about clearing buffer_new(bh) in write_end_fn() is indeed a bug.
> > > However, this patch does not resolve the crash issue we encountered.
> > > 
> > > Let me explain my analysis in detail below.
> > > The crash occurs in the function jbd2_journal_dirty_metadata().
> > > 
> > > ext4_block_write_begin() -> ext4_journalled_zero_new_buffers() ->
> > > write_end_fn()
> > >  -> ext4_dirty_journalled_data() -> ext4_handle_dirty_metadata() ->
> > > __ext4_handle_dirty_metadata()
> > >  -> jbd2_journal_dirty_metadata()
> > > 
> > > In the function jbd2_journal_dirty_metadata(), there is the
> > > following condition:
> > > —---------------------------------------------------------------------------------------------------
> > >         if (data_race(jh->b_transaction != transaction &&
> > >             jh->b_next_transaction != transaction)) {
> > >                 spin_lock(&jh->b_state_lock);
> > >                 J_ASSERT_JH(jh, jh->b_transaction == transaction ||
> > >                                 jh->b_next_transaction == transaction);
> > >                 spin_unlock(&jh->b_state_lock);
> > >         }
> > > ----------------------------------------------------------------------------------------------------
> > > By analyzing the vmcore, I found that both jh->b_transaction and jh-
> > > >b_next_transaction are NULL.
> > > Through code analysis, I discovered that the
> > > __jbd2_journal_file_buffer() function adds the corresponding
> > > transaction of bh to jh->b_transaction.
> > > Normally, this is accessed through do_journal_get_write_access(),
> > > which can call __jbd2_journal_file_buffer().
> > > The detailed function call process is as follows:
> > > do_journal_get_write_access() -> ext4_journal_get_write_access() ->
> > > __ext4_journal_get_write_access()
> > >  -> jbd2_journal_get_write_access() -> do_get_write_access() ->
> > > __jbd2_journal_file_buffer()
> > > 
> > > 
> > > Therefore, resolving the crash issue requires obtaining write access
> > > before calling the jbd2_journal_dirty_metadata() function.
> > > The comment at the definition of the jbd2_journal_dirty_metadata()
> > > function also states:     'The buffer must have previously had
> > > jbd2_journal_get_write_access().'
> > > 
> > > In the ext4_block_write_begin() function, if get_block() encounters
> > > an error, then neither bh->b_this_page nor the subsequent bh calls
> > > do_journal_get_write_access().
> > > If bh->b_this_page and the subsequent bh are in the new state, it
> > > will lead to a crash when reaching the jbd2_journal_dirty_metadata()
> > > function.
> > > 
> > > So, there are two ways to resolve this crash issue:
> > > 1、Call do_journal_get_write_access() on bh that is not handled due
> > > to get_block() error.
> > >     The patch modification is in the attachment 0001-ext4-fix-a-
> > > assertion-failure-due-to-ungranted-bh-dir.patch.
> > > 
> > > 2、Call clear_buffer_new() on bh that is not handled due to
> > > get_block() error.
> > >     The patch modification is in the attachment 0001-ext4-fix-a-
> > > assertion-failure-due-to-bh-not-clear-new.patch.
> > > 
> > > Additionally, I have found a method to quickly reproduce this crash
> > > issue.
> > > For details, please refer to the email I previously sent you:
> > > “https://lore.kernel.org/all/bd41c24b-7325-4584-
> > > a965-392a32e32c74@163.com/”.
> > > I have verified that this quick reproduction method works for both
> > > solutions to resolve the issue.
> > > 
> > > Please continue to consider which method is better to resolve this
> > > issue. If you think that using clear_buffer_new() is a better
> > > solution, I can resend the patch via git send-mail.
> > 
> > 
> > 
> > 在 2024/10/16 18:33, Jan Kara 写道:
> > > Hello,
> > > 
> > > On Fri 11-10-24 12:08:58, Baolin Liu wrote:
> > > > Greetings，
> > > > 
> > > > This problem is reproduced by our customer using their own testing tool
> > > > “run_bug”. When I consulted with a client, the testing tool “run_bug”
> > > > used a variety of background programs to benchmark (including memory
> > > > pressure, cpu pressure, file cycle manipulation, fsstress Stress testing
> > > > tool, postmark program，and so on).
> > > > 
> > > > The recurrence probability is relatively low.
> > > 
> > > OK, thanks for asking!
> > > 
> > > > In response to your query, in ext4_block_write_begin, the new state will
> > > > be clear before get block, and the bh that failed get_block will not be
> > > > set to new. However, when the page size is greater than the
> > > > block size, a
> > > > page will contain multiple bh.
> > > 
> > > True. I wanted to argue that the buffer_new bit should be either
> > > cleared in
> > > ext4_block_write_begin() (in case of error) or in
> > > ext4_journalled_write_end() (in case of success) but actually
> > > ext4_journalled_write_end() misses the clearing. So I think the better
> > > solution is like the attached patch. I'll submit it once testing finishes
> > > but it would be great if you could test that it fixes your problems as
> > > well. Thanks!
> > > 
> > >                                 Honza
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

