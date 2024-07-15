Return-Path: <linux-ext4+bounces-3265-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D435C9312F6
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 13:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 653561F211A2
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 11:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7925218732B;
	Mon, 15 Jul 2024 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fXMDpN4z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="drGXUNLw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fXMDpN4z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="drGXUNLw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049F413A3E0
	for <linux-ext4@vger.kernel.org>; Mon, 15 Jul 2024 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042457; cv=none; b=CVwuX7x5Zl2yl2o+44PD6rAkieNttcTc6CpVYyBA/8OCQ77rrzOqn4fPEaF2ZgWg2zBRBXFQ9bbdPAlun7tBdm49b552lO3ZpyZ52GSgsDPv+xTrtGCLSK9IZBLOQD62PijUgqNO+G1vhQLvkm0x5bRLfyJnTSs3k7Dfmv8Qi5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042457; c=relaxed/simple;
	bh=4FoyPHp/V+C/eDEil8RlwjdGHpS9a8wRrys5m7ZUdCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBF8tC98A/9xkIK1IhjTXPjAZBSf+EazXKBQONqIqqch2pct7jTaBos09x2xcdbaEWTaT2NV4F26oIJ3+sDPkABl0znhAMzV+EXp1JDLZC9l5hTKitOcQGJWPj4A3sEDMYdgbjSMtFhNApDZI45FLC/2nZGuEIL+gGavVA+OVco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fXMDpN4z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=drGXUNLw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fXMDpN4z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=drGXUNLw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 14D2421BA4;
	Mon, 15 Jul 2024 11:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721042453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQXioquYd4iscwzPorKn1RhgAdOcj+H05ef7JBzFtXU=;
	b=fXMDpN4zQVEMzohtgdG1meiPcV9cV9x6D2+NFPfwJhj8lYAInnLLtBVDiXMvk5IBxMnrkj
	5DZqO8PU2I9+cAyVmtZz7UoCmGf5Sc/NhTmHTb2VvEtG/CN09Qxsfi/bT04K7H9rWHFH+Y
	wcUEva5ITNdyn1Icg17EqiCBKmheoSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721042453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQXioquYd4iscwzPorKn1RhgAdOcj+H05ef7JBzFtXU=;
	b=drGXUNLwIoVTNtC9LxzHQ2yMqXjEkUJ6dsG8q/Xoqfy0xPYAIJchEMYrX03y9e0DJRWOCW
	Xl+BxCmzNETsdtAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fXMDpN4z;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=drGXUNLw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721042453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQXioquYd4iscwzPorKn1RhgAdOcj+H05ef7JBzFtXU=;
	b=fXMDpN4zQVEMzohtgdG1meiPcV9cV9x6D2+NFPfwJhj8lYAInnLLtBVDiXMvk5IBxMnrkj
	5DZqO8PU2I9+cAyVmtZz7UoCmGf5Sc/NhTmHTb2VvEtG/CN09Qxsfi/bT04K7H9rWHFH+Y
	wcUEva5ITNdyn1Icg17EqiCBKmheoSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721042453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iQXioquYd4iscwzPorKn1RhgAdOcj+H05ef7JBzFtXU=;
	b=drGXUNLwIoVTNtC9LxzHQ2yMqXjEkUJ6dsG8q/Xoqfy0xPYAIJchEMYrX03y9e0DJRWOCW
	Xl+BxCmzNETsdtAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09389134AB;
	Mon, 15 Jul 2024 11:20:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Uoo7AhUGlWb8LwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Jul 2024 11:20:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7D9D8A0987; Mon, 15 Jul 2024 13:20:48 +0200 (CEST)
Date: Mon, 15 Jul 2024 13:20:48 +0200
From: Jan Kara <jack@suse.cz>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [bug report] ext4: Convert data=journal writeback to use
 ext4_writepages()
Message-ID: <20240715112048.2pap6psmbb5f6urg@quack3>
References: <01c6db4f-eb47-467a-9bb9-3ca6ee4817d7@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01c6db4f-eb47-467a-9bb9-3ca6ee4817d7@moroto.mountain>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 14D2421BA4

On Sat 08-06-24 17:25:20, Dan Carpenter wrote:
> Hello Jan Kara,
> 
> Commit 3f079114bf52 ("ext4: Convert data=journal writeback to use
> ext4_writepages()") from Feb 28, 2023 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	fs/ext4/inode.c:2478 mpage_prepare_extent_to_map()
> 	error: we previously assumed 'handle' could be null (see line 2417)

Found this in my inbox :). Yeah, Smatch is getting confused by different
ways how we can test for journalled data. At the beginning of
mpage_prepare_extent_to_map() we have:

        if (ext4_should_journal_data(mpd->inode)) {
                handle = ext4_journal_start(mpd->inode, EXT4_HT_WRITE_PAGE,
                                            bpp);
		...
	}

so 'handle' is set only if we are journalling data. Later in the function
we have:

                        if (handle) {
                                err = ext4_journal_ensure_credits(handle, bpp,
                                                                  0);
				...
			}

So if we are journalling data, make sure we have enough credits in the
handle for the next page. And then we have:

                                if (folio_test_checked(folio)) {
                                        err = mpage_journal_page_buffers(handle,
                                                mpd, folio);
					...
				}

which uses the handle. Here the trick is that ext4 sets the 'Checked' folio
flag only for inodes with data journalling. So if Checked flags is set, we
should have started the handle at the beginning of
mpage_prepare_extent_to_map().

								Honza

> fs/ext4/inode.c
>     2362 static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>     2363 {
>     2364         struct address_space *mapping = mpd->inode->i_mapping;
>     2365         struct folio_batch fbatch;
>     2366         unsigned int nr_folios;
>     2367         pgoff_t index = mpd->first_page;
>     2368         pgoff_t end = mpd->last_page;
>     2369         xa_mark_t tag;
>     2370         int i, err = 0;
>     2371         int blkbits = mpd->inode->i_blkbits;
>     2372         ext4_lblk_t lblk;
>     2373         struct buffer_head *head;
>     2374         handle_t *handle = NULL;
>     2375         int bpp = ext4_journal_blocks_per_page(mpd->inode);
>     2376 
>     2377         if (mpd->wbc->sync_mode == WB_SYNC_ALL || mpd->wbc->tagged_writepages)
>     2378                 tag = PAGECACHE_TAG_TOWRITE;
>     2379         else
>     2380                 tag = PAGECACHE_TAG_DIRTY;
>     2381 
>     2382         mpd->map.m_len = 0;
>     2383         mpd->next_page = index;
>     2384         if (ext4_should_journal_data(mpd->inode)) {
>     2385                 handle = ext4_journal_start(mpd->inode, EXT4_HT_WRITE_PAGE,
>     2386                                             bpp);
>     2387                 if (IS_ERR(handle))
>     2388                         return PTR_ERR(handle);
>     2389         }
>     2390         folio_batch_init(&fbatch);
>     2391         while (index <= end) {
>     2392                 nr_folios = filemap_get_folios_tag(mapping, &index, end,
>     2393                                 tag, &fbatch);
>     2394                 if (nr_folios == 0)
>     2395                         break;
>     2396 
>     2397                 for (i = 0; i < nr_folios; i++) {
>     2398                         struct folio *folio = fbatch.folios[i];
>     2399 
>     2400                         /*
>     2401                          * Accumulated enough dirty pages? This doesn't apply
>     2402                          * to WB_SYNC_ALL mode. For integrity sync we have to
>     2403                          * keep going because someone may be concurrently
>     2404                          * dirtying pages, and we might have synced a lot of
>     2405                          * newly appeared dirty pages, but have not synced all
>     2406                          * of the old dirty pages.
>     2407                          */
>     2408                         if (mpd->wbc->sync_mode == WB_SYNC_NONE &&
>     2409                             mpd->wbc->nr_to_write <=
>     2410                             mpd->map.m_len >> (PAGE_SHIFT - blkbits))
>     2411                                 goto out;
>     2412 
>     2413                         /* If we can't merge this page, we are done. */
>     2414                         if (mpd->map.m_len > 0 && mpd->next_page != folio->index)
>     2415                                 goto out;
>     2416 
>     2417                         if (handle) {
>                                      ^^^^^^
> Checked for NULL
> 
>     2418                                 err = ext4_journal_ensure_credits(handle, bpp,
>     2419                                                                   0);
>     2420                                 if (err < 0)
>     2421                                         goto out;
>     2422                         }
>     2423 
>     2424                         folio_lock(folio);
>     2425                         /*
>     2426                          * If the page is no longer dirty, or its mapping no
>     2427                          * longer corresponds to inode we are writing (which
>     2428                          * means it has been truncated or invalidated), or the
>     2429                          * page is already under writeback and we are not doing
>     2430                          * a data integrity writeback, skip the page
>     2431                          */
>     2432                         if (!folio_test_dirty(folio) ||
>     2433                             (folio_test_writeback(folio) &&
>     2434                              (mpd->wbc->sync_mode == WB_SYNC_NONE)) ||
>     2435                             unlikely(folio->mapping != mapping)) {
>     2436                                 folio_unlock(folio);
>     2437                                 continue;
>     2438                         }
>     2439 
>     2440                         folio_wait_writeback(folio);
>     2441                         BUG_ON(folio_test_writeback(folio));
>     2442 
>     2443                         /*
>     2444                          * Should never happen but for buggy code in
>     2445                          * other subsystems that call
>     2446                          * set_page_dirty() without properly warning
>     2447                          * the file system first.  See [1] for more
>     2448                          * information.
>     2449                          *
>     2450                          * [1] https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
>     2451                          */
>     2452                         if (!folio_buffers(folio)) {
>     2453                                 ext4_warning_inode(mpd->inode, "page %lu does not have buffers attached", folio->index);
>     2454                                 folio_clear_dirty(folio);
>     2455                                 folio_unlock(folio);
>     2456                                 continue;
>     2457                         }
>     2458 
>     2459                         if (mpd->map.m_len == 0)
>     2460                                 mpd->first_page = folio->index;
>     2461                         mpd->next_page = folio_next_index(folio);
>     2462                         /*
>     2463                          * Writeout when we cannot modify metadata is simple.
>     2464                          * Just submit the page. For data=journal mode we
>     2465                          * first handle writeout of the page for checkpoint and
>     2466                          * only after that handle delayed page dirtying. This
>     2467                          * makes sure current data is checkpointed to the final
>     2468                          * location before possibly journalling it again which
>     2469                          * is desirable when the page is frequently dirtied
>     2470                          * through a pin.
>     2471                          */
>     2472                         if (!mpd->can_map) {
>     2473                                 err = mpage_submit_folio(mpd, folio);
>     2474                                 if (err < 0)
>     2475                                         goto out;
>     2476                                 /* Pending dirtying of journalled data? */
>     2477                                 if (folio_test_checked(folio)) {
> --> 2478                                         err = mpage_journal_page_buffers(handle,
>                                                                                   ^^^^^^
> Unchecked dereferenced inside the function.
> 
>     2479                                                 mpd, folio);
>     2480                                         if (err < 0)
>     2481                                                 goto out;
>     2482                                         mpd->journalled_more_data = 1;
>     2483                                 }
>     2484                                 mpage_folio_done(mpd, folio);
>     2485                         } else {
>     2486                                 /* Add all dirty buffers to mpd */
>     2487                                 lblk = ((ext4_lblk_t)folio->index) <<
>     2488                                         (PAGE_SHIFT - blkbits);
>     2489                                 head = folio_buffers(folio);
>     2490                                 err = mpage_process_page_bufs(mpd, head, head,
>     2491                                                 lblk);
>     2492                                 if (err <= 0)
>     2493                                         goto out;
>     2494                                 err = 0;
>     2495                         }
>     2496                 }
>     2497                 folio_batch_release(&fbatch);
>     2498                 cond_resched();
>     2499         }
>     2500         mpd->scanned_until_end = 1;
>     2501         if (handle)
>     2502                 ext4_journal_stop(handle);
>     2503         return 0;
>     2504 out:
>     2505         folio_batch_release(&fbatch);
>     2506         if (handle)
>     2507                 ext4_journal_stop(handle);
>     2508         return err;
>     2509 }
> 
> regards,
> dan carpenter
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

