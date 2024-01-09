Return-Path: <linux-ext4+bounces-754-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D4C8285CB
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 13:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D0D1C23F46
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 12:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C56374CB;
	Tue,  9 Jan 2024 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kS/qtGTb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yl7gqtIB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b48W5F9y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wDSNqbtG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB62374C4
	for <linux-ext4@vger.kernel.org>; Tue,  9 Jan 2024 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D61911F7FC;
	Tue,  9 Jan 2024 12:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704802133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQLCODWjpstTG+MD7J6eD1GVdZKrxCyZg9toIs3NURU=;
	b=kS/qtGTb1s45voWzkg6cohTIEwowATrB6JOGRF9GTSYV82Lu0Qoz1GS8x87tdQ/VYa7e8U
	wBOo+HAOXMQhd8u3A7et41CK4ZJDycxMZMLwdPse5hWEyorKSWKIgS/btQHDibESB70Y9V
	qOK1IVBQZHXND55nUN7YwLEfYrhYfmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704802133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQLCODWjpstTG+MD7J6eD1GVdZKrxCyZg9toIs3NURU=;
	b=yl7gqtIBcG237fV/b8aO0c8ahpyT6RmuaM8xov0xG0AP594mZvLqFyZsEmxPx5xqdeu3l0
	f7BRmAxC/5EammDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704802132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQLCODWjpstTG+MD7J6eD1GVdZKrxCyZg9toIs3NURU=;
	b=b48W5F9yCUkpvDMkFTKrl4jOAVjPPweaxzICMcNrWVJaSwz0e+fL5D11zW8PINUawrwuA4
	L0tFmH2UwjteT4cYB1LR1ytKNJDeFNBkZBXWdL3+dMnwo25SoO7eBV0zmodCvNQTw8E+qw
	Fb2PH7m+r51Ak8jC/w4gn5ONcTfmolk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704802132;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQLCODWjpstTG+MD7J6eD1GVdZKrxCyZg9toIs3NURU=;
	b=wDSNqbtGHI0hioBz9IC5W7b8lY7zOFXQKMCa6engIub9D5umfhbhtNZcfbtbQIrwHK437g
	vceTak3uHz2BwKAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBA80134E8;
	Tue,  9 Jan 2024 12:08:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oNCzMVQ3nWUbHQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 09 Jan 2024 12:08:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 62ED2A07EB; Tue,  9 Jan 2024 13:08:52 +0100 (CET)
Date: Tue, 9 Jan 2024 13:08:52 +0100
From: Jan Kara <jack@suse.cz>
To: Fengnan Chang <changfengnan@bytedance.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: Re: [External] Re: [PATCH v6] ext4: improve trim efficiency
Message-ID: <20240109120852.jospfnxmeeusbxnm@quack3>
References: <20230901092820.33757-1-changfengnan@bytedance.com>
 <20240108171506.k47t4qztbbhulsp3@quack3>
 <CAPFOzZtz2VzFcTDrvz_kWPSuUWgOb-Dcf66S+5nxUf66+-9Lww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPFOzZtz2VzFcTDrvz_kWPSuUWgOb-Dcf66S+5nxUf66+-9Lww@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

On Tue 09-01-24 19:28:07, Fengnan Chang wrote:
> Jan Kara <jack@suse.cz> 于2024年1月9日周二 01:15写道：
> >
> > On Fri 01-09-23 17:28:20, Fengnan Chang wrote:
> > > In commit a015434480dc("ext4: send parallel discards on commit
> > > completions"), issue all discard commands in parallel make all
> > > bios could merged into one request, so lowlevel drive can issue
> > > multi segments in one time which is more efficiency, but commit
> > > 55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread contex")
> > > seems broke this way, let's fix it.
> > >
> > > In my test:
> > > 1. create 10 normal files, each file size is 10G.
> > > 2. deallocate file, punch a 16k holes every 32k.
> > > 3. trim all fs.
> > > the time of fstrim fs reduce from 6.7s to 1.3s.
> > >
> > > Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
> >
> > This seems to have fallen through the cracks... I'm sorry for that.
> >
> > >  static int ext4_try_to_trim_range(struct super_block *sb,
> > >               struct ext4_buddy *e4b, ext4_grpblk_t start,
> > >               ext4_grpblk_t max, ext4_grpblk_t minblocks)
> > >  __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
> > >  __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
> > >  {
> > > -     ext4_grpblk_t next, count, free_count;
> > > +     ext4_grpblk_t next, count, free_count, bak;
> > >       void *bitmap;
> > > +     struct ext4_free_data *entry = NULL, *fd, *nfd;
> > > +     struct list_head discard_data_list;
> > > +     struct bio *discard_bio = NULL;
> > > +     struct blk_plug plug;
> > > +     ext4_group_t group = e4b->bd_group;
> > > +     struct ext4_free_extent ex;
> > > +     bool noalloc = false;
> > > +     int ret = 0;
> > > +
> > > +     INIT_LIST_HEAD(&discard_data_list);
> > >
> > >       bitmap = e4b->bd_bitmap;
> > >       start = max(e4b->bd_info->bb_first_free, start);
> > >       count = 0;
> > >       free_count = 0;
> > >
> > > +     blk_start_plug(&plug);
> > >       while (start <= max) {
> > >               start = mb_find_next_zero_bit(bitmap, max + 1, start);
> > >               if (start > max)
> > >                       break;
> > > +             bak = start;
> > >               next = mb_find_next_bit(bitmap, max + 1, start);
> > > -
> > >               if ((next - start) >= minblocks) {
> > > -                     int ret = ext4_trim_extent(sb, start, next - start, e4b);
> > > +                     /* when only one segment, there is no need to alloc entry */
> > > +                     noalloc = (free_count == 0) && (next >= max);
> >
> > Is the single extent case really worth the complications to save one
> > allocation? I don't think it is but maybe I'm missing something. Otherwise
> > the patch looks good to me!
> yeah, it's necessary, if there is only one segment, alloc memory may cause
> performance regression.
> Refer to this https://lore.kernel.org/linux-ext4/CALWNXx-6y0=ZDBMicv2qng9pKHWcpJbCvUm9TaRBwg81WzWkWQ@mail.gmail.com/

Ah, thanks for the reference! Then what I'd suggest is something like:

	struct ext4_free_data first_entry;
	/*
	 * We preallocate the first entry on stack to optimize for the common
	 * case of trimming single extent in each group. It has measurable
	 * performance impact.
	 */
	struct ext4_free_data *entry = &first_entry;

then when we allocate we do:

		if (!entry)
			entry = kmem_cache_alloc(...)
		entry->efd_start_cluster = start;
		entry->efd_count = next - start;
		list_add_tail(&entry->efd_list, &discard_data_list);
		entry = NULL;

and then when freeing we can have:

	list_for_each_entry_safe(fd, nfd, &discard_data_list, efd_list) {
		mb_free_blocks(NULL, e4b, fd->efd_start_cluster, fd->efd_count);
		if (fd != &first_entry)
			kmem_cache_free(ext4_free_data_cachep, fd);
	}

Then it is more understandable what's going on...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

