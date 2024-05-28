Return-Path: <linux-ext4+bounces-2665-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5061D8D18EC
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2024 12:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F7A2882CE
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2024 10:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A14216C697;
	Tue, 28 May 2024 10:52:07 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA6D16B737;
	Tue, 28 May 2024 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893527; cv=none; b=SXbhkeWxShM1XozDeIdVQCwTWhv9TGVOhnkKysUh7ByRhENLhUy98JMM7BRLAxf3fM3iIz0u2I/6oxIbYcAW7tsqonjqbxLUeINAB1U8LPhUHHhnrNaVekYo79oWUnNj3kYxkj3ZixYgTNEA9x+1/tiWIwJrIvm27fVEziDPJGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893527; c=relaxed/simple;
	bh=08vd2eLerUdZhiSa/ZoUOZwTuS+LDw+HGnQiO9EVyh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFKp0pOARVntqXxfWfdc0OaCxtSfpmVgHPTrOl0V2pgGsByrtVa+MtdjFHR8+JVpbh8AF4JJ/f4RHZxERZuPAz9SGzefjlA5y0qnTvZjKOY0TU5vhgikaCU+Jy+hc/QccCGY1BrRrKNcTQ4a3ydi6r/eVUiP91ud4ipKtHfc0hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E87BD22788;
	Tue, 28 May 2024 10:52:03 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD2E613A6B;
	Tue, 28 May 2024 10:52:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XUb2NVO3VWa2XgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 28 May 2024 10:52:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 815E2A07D0; Tue, 28 May 2024 12:52:03 +0200 (CEST)
Date: Tue, 28 May 2024 12:52:03 +0200
From: Jan Kara <jack@suse.cz>
To: Luis Henriques <luis.henriques@linux.dev>
Cc: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix fast commit inode enqueueing during a full
 journal commit
Message-ID: <20240528105203.2q4gxqz6amgvud4l@quack3>
References: <20240523111618.17012-1-luis.henriques@linux.dev>
 <20240524162231.l5r4niz7awjgfju6@quack3>
 <87h6ej64jv.fsf@brahms.olymp>
 <87msob45o7.fsf@brahms.olymp>
 <20240528103602.akx2gui5ownj25l3@quack3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528103602.akx2gui5ownj25l3@quack3>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: E87BD22788

On Tue 28-05-24 12:36:02, Jan Kara wrote:
> On Mon 27-05-24 16:48:24, Luis Henriques wrote:
> > On Mon 27 May 2024 09:29:40 AM +01, Luis Henriques wrote;
> > >>> +	/*
> > >>> +	 * Used to flag an inode as part of the next fast commit; will be
> > >>> +	 * reset during fast commit clean-up
> > >>> +	 */
> > >>> +	tid_t i_fc_next;
> > >>> +
> > >>
> > >> Do we really need new tid in the inode? I'd be kind of hoping we could use
> > >> EXT4_I(inode)->i_sync_tid for this - I can see we even already set it in
> > >> ext4_fc_track_template() and used for similar comparisons in fast commit
> > >> code.
> > >
> > > Ah, true.  It looks like it could be used indeed.  We'll still need a flag
> > > here, but a simple bool should be enough for that.
> > 
> > After looking again at the code, I'm not 100% sure that this is actually
> > doable.  For example, if I replace the above by
> > 
> > 	bool i_fc_next;
> > 
> > and set to to 'true' below:

Forgot to comment on this one: I don't think you even need 'bool i_fc_next'
- simply whenever i_sync_tid is greater than committing transaction's tid,
you move the inode to FC_Q_STAGING list in ext4_fc_cleanup().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

