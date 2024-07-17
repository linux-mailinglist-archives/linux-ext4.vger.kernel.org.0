Return-Path: <linux-ext4+bounces-3309-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F273933D5B
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jul 2024 15:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C92F3283806
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jul 2024 13:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55869180058;
	Wed, 17 Jul 2024 13:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QcmQEern";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5ewloc//";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QcmQEern";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5ewloc//"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F941802A3
	for <linux-ext4@vger.kernel.org>; Wed, 17 Jul 2024 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721221633; cv=none; b=n78AMvCypYO5TDCI5xcFVizFO8zhGFf+iITDBR7/+yU3yhEZ+XwjUZ3Y/zwQ35kcrP3YFVBPYJ5oicufOiWZRNfj0qY6d08pbrkqfZMos5ODKvNzdl0mUzjT1o9pWI6BRRmGbpwyi++dywzldjpD0olDkwZBbC1kgXMZuXo2txw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721221633; c=relaxed/simple;
	bh=YjNnrQrK7I69tVblKy3suY4lV755DjdIGMN1MKFCt/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WufhZPEOBIm3wKM9ysS4Vh66uL7rJwquSo9/stR+LJEBLYAFrODn370cVh2/Y3f+72nlaUcuGgx5KTAN5V8qo25YbwWcFEy/2ZmJIaCbkOJjrvzckU0bEK4+Xdkn7YotP4EA/4sDf6TbQkPRx1lLBkmLp5jgJ9kbBUQxcv79bKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QcmQEern; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5ewloc//; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QcmQEern; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5ewloc//; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3070221C21;
	Wed, 17 Jul 2024 13:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721221630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8Ij/dW2A1WFNo2WsU1FYFEkQzQWbRi5ghj4wwPbLP4=;
	b=QcmQEernxePImxaLDkoRxxUHwpjR8jYwI1MNJIeLKld0M2IeC7Gbqfw/gJEEtxGiK9R6KR
	Hc1CawroCk5rUeOeoK2gYBXExzjk0ro4pQv+SKoDOrBIb2XBK/1g7CYz/UKHm8CDBobv2Q
	z4yi5mjGbbpVf+axRwcPekGykFZszZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721221630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8Ij/dW2A1WFNo2WsU1FYFEkQzQWbRi5ghj4wwPbLP4=;
	b=5ewloc//dgEBLtdkS6y1jW62VMsE1kUT/J4PSUH/kDx4HIb93srCxqyTQ/o7aF5Ni/yaa3
	ECmv4XgU/g6yemCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721221630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8Ij/dW2A1WFNo2WsU1FYFEkQzQWbRi5ghj4wwPbLP4=;
	b=QcmQEernxePImxaLDkoRxxUHwpjR8jYwI1MNJIeLKld0M2IeC7Gbqfw/gJEEtxGiK9R6KR
	Hc1CawroCk5rUeOeoK2gYBXExzjk0ro4pQv+SKoDOrBIb2XBK/1g7CYz/UKHm8CDBobv2Q
	z4yi5mjGbbpVf+axRwcPekGykFZszZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721221630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8Ij/dW2A1WFNo2WsU1FYFEkQzQWbRi5ghj4wwPbLP4=;
	b=5ewloc//dgEBLtdkS6y1jW62VMsE1kUT/J4PSUH/kDx4HIb93srCxqyTQ/o7aF5Ni/yaa3
	ECmv4XgU/g6yemCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26F0E136E5;
	Wed, 17 Jul 2024 13:07:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Mjl7Cf7Bl2a1agAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jul 2024 13:07:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DA67DA0987; Wed, 17 Jul 2024 15:07:09 +0200 (CEST)
Date: Wed, 17 Jul 2024 15:07:09 +0200
From: Jan Kara <jack@suse.cz>
To: harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
	saukad@google.com, harshads@google.com
Subject: Re: [PATCH v6 07/10] ext4: add nolock mode to ext4_map_blocks()
Message-ID: <20240717130709.ji7lnashqaxhnjf6@quack3>
References: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
 <20240529012003.4006535-8-harshadshirwadkar@gmail.com>
 <20240628141837.iu3knuvzb7kc7qag@quack3>
 <CAD+ocbzeAM=0_k=TBTHb3HA6tg6QKUfnd1Cw7235VHDFMsZVaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD+ocbzeAM=0_k=TBTHb3HA6tg6QKUfnd1Cw7235VHDFMsZVaQ@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: 0.20
X-Spamd-Result: default: False [0.20 / 50.00];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Fri 12-07-24 19:01:25, harshad shirwadkar wrote:
> On Fri, Jun 28, 2024 at 7:18 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 29-05-24 01:20:00, Harshad Shirwadkar wrote:
> > > Add nolock flag to ext4_map_blocks() which skips grabbing
> > > i_data_sem in ext4_map_blocks. In FC commit path, we first
> > > mark the inode as committing and thereby prevent any mutations
> > > on it. Thus, it should be safe to call ext4_map_blocks()
> > > without i_data_sem in this case. This is a workaround to
> > > the problem mentioned in RFC V4 version cover letter[1] of this
> > > patch series which pointed out that there is in incosistency between
> > > ext4_map_blocks() behavior when EXT4_GET_BLOCKS_CACHED_NOWAIT is
> > > passed. This patch gets rid of the need to call ext4_map_blocks()
> > > with EXT4_GET_BLOCKS_CACHED_NOWAIT and instead call it with
> > > EXT4_GET_BLOCKS_NOLOCK. I verified that generic/311 which failed
> > > in cached_nowait mode passes with nolock mode.
> > >
> > > [1] https://lwn.net/Articles/902022/
> > >
> > > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> >
> > I'm sorry I forgot since last time - can you remind me why we cannot we
> > grab i_data_sem from ext4_fc_write_inode_data()? Because as you write
> > above, nobody should really be holding that lock while inode is
> > EXT4_STATE_FC_COMMITTING anyway...
> >
> The original reason was that the commit path calls ext4_map_blocks()
> which needs i_data_sem. But other places might grab i_data_sem and
> then call ext4_mark_inode_dirty(). Ext4_mark_inode_dirty() can block
> for a fast commit to finish, causing a deadlock.
> 
> In this patchset I'm attacking this problem 2 ways:
> (1) Ensure i_data_sem is always grabbed before ext4_mark_inode_dirty()

I think this rather should be: Make sure the inode is properly tracked with
fastcommit code (which waits for EXT4_STATE_FC_COMMITTING) before grabbing
i_data_sem, shouldn't it?

> (2) (This patch) Remove the need of grabbing i_data_sem in
> ext4_map_blocks() when in the commit path.
> 
> I am now realizing either (1) or (2) is sufficient -- both are not
> needed.

Yes, this is what was confusing me somewhat.

> (2) is more maintainable. (1) seems fragile and future code
> paths can potentially break that rule which can cause hard to debug
> failures. So, how about just keeping this patch and dropping the need
> to remove grab i_data_sem before ext4_mark_inode_dirty()? If no
> concerns, I'll handle this in V7.

Well, you have added assertions into ext4_mark_inode_dirty() exactly to
catch possible problems with inode not being tracked with fastcommit code.
I agree 1) needs changes in more places but long term, it actually seems
*less* fragile with the assertions added. Because adding conditional
locking to our core block mapping function and relying on the fact that
nobody can modify the mapping structures while EXT4_STATE_FC_COMMITTING is
set is quite hard to assert for and the failures are going to be hard to
debug as they will result in random memory corruptions, oopses etc. So I
believe you should rather remove 2).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

