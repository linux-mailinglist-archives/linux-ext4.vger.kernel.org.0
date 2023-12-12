Return-Path: <linux-ext4+bounces-399-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9A880EDC7
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 14:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8111C20C94
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 13:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF0661FC1;
	Tue, 12 Dec 2023 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hxLgSf6z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OmCjxUsg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hxLgSf6z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OmCjxUsg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FBE83;
	Tue, 12 Dec 2023 05:37:15 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9BD922248E;
	Tue, 12 Dec 2023 13:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702388233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZ6pOwRrMHenyPDok7NGALB2vm7XSV6U4tFzrBw6360=;
	b=hxLgSf6z9h03jZvvO7PR0YOlc/x5zRZLcup41syXR35KbI/psXfjhuzxBcOgmVOm2EMBU2
	wNWZwCYha1hwtNypYDb+pEhbm89sGZzkbbDRynSKt9MhG1bGAhejuaiJRRcB7heZKDRs/y
	jIVnG2tGaWcKJCtLp2lqIIdMBe0Peg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702388233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZ6pOwRrMHenyPDok7NGALB2vm7XSV6U4tFzrBw6360=;
	b=OmCjxUsgNAsjgrn3nr82EDbRsVuV61dMw5NAcSASRxwjgp/szboPm2CM4vBSxpxIA6ZHxh
	vzRXh4OznlZE2fBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702388233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZ6pOwRrMHenyPDok7NGALB2vm7XSV6U4tFzrBw6360=;
	b=hxLgSf6z9h03jZvvO7PR0YOlc/x5zRZLcup41syXR35KbI/psXfjhuzxBcOgmVOm2EMBU2
	wNWZwCYha1hwtNypYDb+pEhbm89sGZzkbbDRynSKt9MhG1bGAhejuaiJRRcB7heZKDRs/y
	jIVnG2tGaWcKJCtLp2lqIIdMBe0Peg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702388233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IZ6pOwRrMHenyPDok7NGALB2vm7XSV6U4tFzrBw6360=;
	b=OmCjxUsgNAsjgrn3nr82EDbRsVuV61dMw5NAcSASRxwjgp/szboPm2CM4vBSxpxIA6ZHxh
	vzRXh4OznlZE2fBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F3E6139E9;
	Tue, 12 Dec 2023 13:37:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ODP2IglieGXcQwAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 12 Dec 2023 13:37:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3C652A06E5; Tue, 12 Dec 2023 14:37:13 +0100 (CET)
Date: Tue, 12 Dec 2023 14:37:13 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: Jan Kara <jack@suse.cz>, linux-mm@kvack.org, linux-ext4@vger.kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, willy@infradead.org,
	akpm@linux-foundation.org, david@fromorbit.com, hch@infradead.org,
	ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
	stable@kernel.org
Subject: Re: [RFC PATCH] mm/filemap: avoid buffered read/write race to read
 inconsistent data
Message-ID: <20231212133713.bihojdsnccmadcpg@quack3>
References: <20231212093634.2464108-1-libaokun1@huawei.com>
 <20231212124157.ew6q6jp2wsezvqzd@quack3>
 <9fdebd0a-ac10-e193-b245-7678fa708c82@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9fdebd0a-ac10-e193-b245-7678fa708c82@huawei.com>
X-Spam-Level: 
X-Spam-Score: 0.70
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-0.00)[33.88%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RL9mptuuj8f371ag1nhgyt86ac)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[16];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[suse.cz,kvack.org,vger.kernel.org,mit.edu,dilger.ca,infradead.org,linux-foundation.org,fromorbit.com,gmail.com,huawei.com,kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Tue 12-12-23 21:16:16, Baokun Li wrote:
> On 2023/12/12 20:41, Jan Kara wrote:
> > On Tue 12-12-23 17:36:34, Baokun Li wrote:
> > > The following concurrency may cause the data read to be inconsistent with
> > > the data on disk:
> > > 
> > >               cpu1                           cpu2
> > > ------------------------------|------------------------------
> > >                                 // Buffered write 2048 from 0
> > >                                 ext4_buffered_write_iter
> > >                                  generic_perform_write
> > >                                   copy_page_from_iter_atomic
> > >                                   ext4_da_write_end
> > >                                    ext4_da_do_write_end
> > >                                     block_write_end
> > >                                      __block_commit_write
> > >                                       folio_mark_uptodate
> > > // Buffered read 4096 from 0          smp_wmb()
> > > ext4_file_read_iter                   set_bit(PG_uptodate, folio_flags)
> > >   generic_file_read_iter            i_size_write // 2048
> > >    filemap_read                     unlock_page(page)
> > >     filemap_get_pages
> > >      filemap_get_read_batch
> > >      folio_test_uptodate(folio)
> > >       ret = test_bit(PG_uptodate, folio_flags)
> > >       if (ret)
> > >        smp_rmb();
> > >        // Ensure that the data in page 0-2048 is up-to-date.
> > > 
> > >                                 // New buffered write 2048 from 2048
> > >                                 ext4_buffered_write_iter
> > >                                  generic_perform_write
> > >                                   copy_page_from_iter_atomic
> > >                                   ext4_da_write_end
> > >                                    ext4_da_do_write_end
> > >                                     block_write_end
> > >                                      __block_commit_write
> > >                                       folio_mark_uptodate
> > >                                        smp_wmb()
> > >                                        set_bit(PG_uptodate, folio_flags)
> > >                                     i_size_write // 4096
> > >                                     unlock_page(page)
> > > 
> > >     isize = i_size_read(inode) // 4096
> > >     // Read the latest isize 4096, but without smp_rmb(), there may be
> > >     // Load-Load disorder resulting in the data in the 2048-4096 range
> > >     // in the page is not up-to-date.
> > >     copy_page_to_iter
> > >     // copyout 4096
> > > 
> > > In the concurrency above, we read the updated i_size, but there is no read
> > > barrier to ensure that the data in the page is the same as the i_size at
> > > this point, so we may copy the unsynchronized page out. Hence adding the
> > > missing read memory barrier to fix this.
> > > 
> > > This is a Load-Load reordering issue, which only occurs on some weak
> > > mem-ordering architectures (e.g. ARM64, ALPHA), but not on strong
> > > mem-ordering architectures (e.g. X86). And theoretically the problem
> > AFAIK x86 can also reorder loads vs loads so the problem can in theory
> > happen on x86 as well.
> 
> According to what I read in the /perfbook /at the link below,
> 
>  Loads Reordered After Loads does not happen on x86.
> 
> pdf sheet 562 corresponds to page 550,
> 
>    Table 15.5: Summary of Memory Ordering
> 
> https://mirrors.edge.kernel.org/pub/linux/kernel/people/paulmck/perfbook/perfbook-1c.2023.06.11a.pdf

Indeed. I stand corrected! Thanks for the link.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

