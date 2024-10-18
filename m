Return-Path: <linux-ext4+bounces-4627-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6829A3E8B
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 14:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 814A6B21B5A
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Oct 2024 12:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C212837B;
	Fri, 18 Oct 2024 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i+e5cMbQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Yh3U2lY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i+e5cMbQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Yh3U2lY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CC726AFA;
	Fri, 18 Oct 2024 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255062; cv=none; b=LpMzpSEGxNKKpvhsc0QS7EkSGm8dab4ey+lRvREwPt+SoV3J5O5mizFgheuo1YaFgMp3sDaCztd2Ttq98qxrEda2JM8eFN5Yfo4YB3Gw2FRh4c5I3YqOQ/ye+DUI0KJnoaFNu07sjRAsou0wNu5TBID0lFWkL2fiZYJ2OUNP2Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255062; c=relaxed/simple;
	bh=OBP+6/pKwJgevyUCN5Xy1X5WcuMORWumP5G7IkoLJL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrikSqBQb4LqnCopkti/Uf390CF4oSlDSfY7NEjn+wINvcC2bWFY3hw8B2AYpu5uSWui5qso25Ror8wyHgSDN7jYNNMYriEBuf/YUF8FnGM7HmVX50eMZvXX5ZWN8sEqJINZNYHpeEBFyuW/ry6Uynjl1HJISKeyiN0wIYMo5DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i+e5cMbQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Yh3U2lY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i+e5cMbQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Yh3U2lY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 126B321BBB;
	Fri, 18 Oct 2024 12:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729255058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DIMiqN9oBvxpzdBSsa5eEnVzHubT0oWk220VGXH5TKc=;
	b=i+e5cMbQLoXe8wmTE+llkJPxu4oHvcmvRT6doQCdXiXqlFPkVwwGqZcgI8/yF3+Amo7817
	FjxT09CtVVQJ8I3S40RvTpXklluI5JvQGEmkoL2zNP94I6ag2R7VlBr4/DsW3ZTjXdKCSN
	nqBYwBFQwIp8R7nf3Kd42nPbm/WKWx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729255058;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DIMiqN9oBvxpzdBSsa5eEnVzHubT0oWk220VGXH5TKc=;
	b=2Yh3U2lYtW32aUetkVmVKIJ0+udGEKTwL9gw12e9nzSzZXC6aD26254G9++8Qx85H8Z1Pf
	jE1XP773VoZyYXBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i+e5cMbQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2Yh3U2lY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729255058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DIMiqN9oBvxpzdBSsa5eEnVzHubT0oWk220VGXH5TKc=;
	b=i+e5cMbQLoXe8wmTE+llkJPxu4oHvcmvRT6doQCdXiXqlFPkVwwGqZcgI8/yF3+Amo7817
	FjxT09CtVVQJ8I3S40RvTpXklluI5JvQGEmkoL2zNP94I6ag2R7VlBr4/DsW3ZTjXdKCSN
	nqBYwBFQwIp8R7nf3Kd42nPbm/WKWx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729255058;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DIMiqN9oBvxpzdBSsa5eEnVzHubT0oWk220VGXH5TKc=;
	b=2Yh3U2lYtW32aUetkVmVKIJ0+udGEKTwL9gw12e9nzSzZXC6aD26254G9++8Qx85H8Z1Pf
	jE1XP773VoZyYXBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0894D13433;
	Fri, 18 Oct 2024 12:37:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MM4VApJWEmeTFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 18 Oct 2024 12:37:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C5DADA080A; Fri, 18 Oct 2024 14:37:33 +0200 (CEST)
Date: Fri, 18 Oct 2024 14:37:33 +0200
From: Jan Kara <jack@suse.cz>
To: liubaolin <liubaolin12138@163.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
	zhangshida@kylinos.cn, longzhi@sangfor.com.cn,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v1] ext4: fix a assertion failure due to ungranted bh
 dirting
Message-ID: <20241018123733.vvdh4mefn4la3zec@quack3>
References: <20241010025855.2632516-1-liubaolin12138@163.com>
 <20241010092923.r53povuflevzhxrw@quack3>
 <5dc22111.4718.19279c3f3b7.Coremail.liubaolin12138@163.com>
 <20241016103301.rl6qngi2fb6yxjin@quack3>
 <908502d6-cb0c-44ae-8c03-9a22c8c7fbf2@163.com>
 <8c14e5b0-5229-4611-b8e6-434c6eb34ee9@163.com>
 <20241018091444.tmzhbj73gvegfmb5@quack3>
 <f5193380-57f8-40c4-b4d6-b8e8cc3d0977@163.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5193380-57f8-40c4-b4d6-b8e8cc3d0977@163.com>
X-Rspamd-Queue-Id: 126B321BBB
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Fri 18-10-24 19:34:31, liubaolin wrote:
> > Sorry, I saw the patch you submitted.
> > I would like to request a modification to the commit message.
> > I use the email 'Baolin Liu liubaolin12138@163.com' for community communication.
> > However, my work email is 'Baolin Liu liubaolin@kylinos.cn'.
> > 
> > So I would like to ask you to modify the commit message as follows:
> > From:
> > Reported-by: Baolin Liu liubaolin12138@163.com
> > Reported-by: Zhi Long longzhi@sangfor.com.cn
> > To:
> > Reported-and-tested-by: Baolin Liu liubaolin@kylinos.cn
> > Reported-and-tested-by: Zhi Long longzhi@sangfor.com.cn
> > 
> > Could you please make the modification? Thank you.

OK, I've sent v2 with updated tags.

								Honza

> 在 2024/10/18 17:14, Jan Kara 写道:
> > On Fri 18-10-24 09:48:17, liubaolin wrote:
> > > > Hello, I am very sorry.
> > > > I did not previously understand the approach of your patch to solve the issue.
> > > > Yesterday, I intentionally injected faults during the quick reproduction
> > > > test, and indeed, after applying your patch, the crash issue was
> > > > resolved and did not occur again.
> > > > I finally understood your approach to solving the problem. Please disregard my previous email.
> > > > Thank you for helping me solve this crash issue in a better way.
> > > > I still need to improve my skills in file systems, and I truly appreciate your guidance.
> > 
> > Great! Thanks for testing. I'll send the patch for inclusion then.
> > 
> > 								Honza
> > 
> > > 在 2024/10/16 21:38, liubaolin 写道:
> > > > > Hello,
> > > > > I reviewed the patch attached in your email. The issue you mentioned
> > > > > about clearing buffer_new(bh) in write_end_fn() is indeed a bug.
> > > > > However, this patch does not resolve the crash issue we encountered.
> > > > > 
> > > > > Let me explain my analysis in detail below.
> > > > > The crash occurs in the function jbd2_journal_dirty_metadata().
> > > > > 
> > > > > ext4_block_write_begin() -> ext4_journalled_zero_new_buffers() ->
> > > > > write_end_fn()
> > > > >   -> ext4_dirty_journalled_data() -> ext4_handle_dirty_metadata() ->
> > > > > __ext4_handle_dirty_metadata()
> > > > >   -> jbd2_journal_dirty_metadata()
> > > > > 
> > > > > In the function jbd2_journal_dirty_metadata(), there is the
> > > > > following condition:
> > > > > —---------------------------------------------------------------------------------------------------
> > > > >          if (data_race(jh->b_transaction != transaction &&
> > > > >              jh->b_next_transaction != transaction)) {
> > > > >                  spin_lock(&jh->b_state_lock);
> > > > >                  J_ASSERT_JH(jh, jh->b_transaction == transaction ||
> > > > >                                  jh->b_next_transaction == transaction);
> > > > >                  spin_unlock(&jh->b_state_lock);
> > > > >          }
> > > > > ----------------------------------------------------------------------------------------------------
> > > > > By analyzing the vmcore, I found that both jh->b_transaction and jh-
> > > > > > b_next_transaction are NULL.
> > > > > Through code analysis, I discovered that the
> > > > > __jbd2_journal_file_buffer() function adds the corresponding
> > > > > transaction of bh to jh->b_transaction.
> > > > > Normally, this is accessed through do_journal_get_write_access(),
> > > > > which can call __jbd2_journal_file_buffer().
> > > > > The detailed function call process is as follows:
> > > > > do_journal_get_write_access() -> ext4_journal_get_write_access() ->
> > > > > __ext4_journal_get_write_access()
> > > > >   -> jbd2_journal_get_write_access() -> do_get_write_access() ->
> > > > > __jbd2_journal_file_buffer()
> > > > > 
> > > > > 
> > > > > Therefore, resolving the crash issue requires obtaining write access
> > > > > before calling the jbd2_journal_dirty_metadata() function.
> > > > > The comment at the definition of the jbd2_journal_dirty_metadata()
> > > > > function also states:     'The buffer must have previously had
> > > > > jbd2_journal_get_write_access().'
> > > > > 
> > > > > In the ext4_block_write_begin() function, if get_block() encounters
> > > > > an error, then neither bh->b_this_page nor the subsequent bh calls
> > > > > do_journal_get_write_access().
> > > > > If bh->b_this_page and the subsequent bh are in the new state, it
> > > > > will lead to a crash when reaching the jbd2_journal_dirty_metadata()
> > > > > function.
> > > > > 
> > > > > So, there are two ways to resolve this crash issue:
> > > > > 1、Call do_journal_get_write_access() on bh that is not handled due
> > > > > to get_block() error.
> > > > >      The patch modification is in the attachment 0001-ext4-fix-a-
> > > > > assertion-failure-due-to-ungranted-bh-dir.patch.
> > > > > 
> > > > > 2、Call clear_buffer_new() on bh that is not handled due to
> > > > > get_block() error.
> > > > >      The patch modification is in the attachment 0001-ext4-fix-a-
> > > > > assertion-failure-due-to-bh-not-clear-new.patch.
> > > > > 
> > > > > Additionally, I have found a method to quickly reproduce this crash
> > > > > issue.
> > > > > For details, please refer to the email I previously sent you:
> > > > > “https://lore.kernel.org/all/bd41c24b-7325-4584-
> > > > > a965-392a32e32c74@163.com/”.
> > > > > I have verified that this quick reproduction method works for both
> > > > > solutions to resolve the issue.
> > > > > 
> > > > > Please continue to consider which method is better to resolve this
> > > > > issue. If you think that using clear_buffer_new() is a better
> > > > > solution, I can resend the patch via git send-mail.
> > > > 
> > > > 
> > > > 
> > > > 在 2024/10/16 18:33, Jan Kara 写道:
> > > > > Hello,
> > > > > 
> > > > > On Fri 11-10-24 12:08:58, Baolin Liu wrote:
> > > > > > Greetings，
> > > > > > 
> > > > > > This problem is reproduced by our customer using their own testing tool
> > > > > > “run_bug”. When I consulted with a client, the testing tool “run_bug”
> > > > > > used a variety of background programs to benchmark (including memory
> > > > > > pressure, cpu pressure, file cycle manipulation, fsstress Stress testing
> > > > > > tool, postmark program，and so on).
> > > > > > 
> > > > > > The recurrence probability is relatively low.
> > > > > 
> > > > > OK, thanks for asking!
> > > > > 
> > > > > > In response to your query, in ext4_block_write_begin, the new state will
> > > > > > be clear before get block, and the bh that failed get_block will not be
> > > > > > set to new. However, when the page size is greater than the
> > > > > > block size, a
> > > > > > page will contain multiple bh.
> > > > > 
> > > > > True. I wanted to argue that the buffer_new bit should be either
> > > > > cleared in
> > > > > ext4_block_write_begin() (in case of error) or in
> > > > > ext4_journalled_write_end() (in case of success) but actually
> > > > > ext4_journalled_write_end() misses the clearing. So I think the better
> > > > > solution is like the attached patch. I'll submit it once testing finishes
> > > > > but it would be great if you could test that it fixes your problems as
> > > > > well. Thanks!
> > > > > 
> > > > >                                  Honza
> > > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

