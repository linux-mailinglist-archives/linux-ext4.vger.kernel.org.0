Return-Path: <linux-ext4+bounces-2833-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48186901203
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Jun 2024 16:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8C1EB219E1
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Jun 2024 14:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0886817A930;
	Sat,  8 Jun 2024 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sR4ReSo3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82BD17BBA
	for <linux-ext4@vger.kernel.org>; Sat,  8 Jun 2024 14:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717856727; cv=none; b=cZqXNlCCtOwJABR4F64Fvk1dKPvk+G8gmY+jYb5sMxQUqkEhKnDf6lUDsO3jGc0HtJJPUCPbqu5fOyUqM1UpN8JbimKWjEKN6pxtPf4XksyBNPPWuqSfXAsNhAXJ2aZcSysdy8Meb7N0PbpeH33dx2XtPiYYgj0KGoFJixhVnKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717856727; c=relaxed/simple;
	bh=4k5sWze8m6UHf9LHaMsluYD5ltzDFYr5w+6tigbMTMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P9+oH5tJvrpu3AurWQ8vhcmi74BB22zb0cSz1keTW7nSbWXT3Hk4OHv3DPedUeZ28FnkcOCA+U9cfNEY6p8J1VzN5FIL6vWOaGgBS32jxIajdU1X/iZYvgTV9XPOgATPElrKKvx1+ngQ2ha0GDSMwd92N3oe/db6YlsQks8CcOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sR4ReSo3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-421798185f0so7406435e9.1
        for <linux-ext4@vger.kernel.org>; Sat, 08 Jun 2024 07:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717856724; x=1718461524; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0SVXTpuD8fGVivwQGkjbKvYu7fP1GUA7xsmobv+jac4=;
        b=sR4ReSo3Waj3wcgMIabVzFfHFkOCsH8xPR67ZMvcRNyJlMJxtzGgDnVq2FZmCdLo04
         rFw7B5n9ODLeI9vpOsnvy1Gl8SJrpPz5jIdLjdyv179WdrzMwdoO1qRaz8g7i+VMFl/e
         7w4MN65LwU/+mofyfA9SEBW/9Loj+HrvUkGstgmzwTzk89oHjlw+bHdONSMv4WLpwEDI
         bGDlNDSAQz3OiBqVIp/rRKCZpSCh4boOLoF/LIXBKgpy+c9xYXwJn1cl9iJGZsvMdw/t
         vqxjWFtO2TZ42bK5RX+O54aqdTAmZ1ZFo/mi+K8VnEPJRItamOR7I/BtAGWh92kZezuR
         EkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717856724; x=1718461524;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0SVXTpuD8fGVivwQGkjbKvYu7fP1GUA7xsmobv+jac4=;
        b=IzA6S+6ApjZ0/DhSf9H5nc85f8NvpuwlPAE2Phou5HwLgoTtv9pb9LwTRv2YSh1nv7
         KEoyjOFTcJvonhtecufCiKQ/Fp6T4BbsClQ1mFbOB7tZtYno7kOX8YuYZL+njp0oHcRY
         3uW3j+thMjGIFB9hzDREdiBv2IQjV6FoyToYf5aUg5P2DdPMZWBi+OjaZQJezS8EuAj4
         eg6a5ZbH4A7vaubPdEyONHFr/y6jwF/hC4a33LZQ3HIEsi3v/7pYHP03EvawMYGeCpoV
         C4oiaHTijkyYREKwOHaLDHdfhmLoICxTsDcEh3wX6cENpZLy5/ROQG6HwZOtHKiQRaVX
         1BGg==
X-Gm-Message-State: AOJu0YyHq1hPM2SrnMVULDd3HeBsWY3pOCuutMFrPggAF1cxLhColHQY
	AHOcLQE1p2HJvjT+K7JNqaLFdOGCJ9Qjh7HX6wXNQoEOUKACzLGEGQL09E0z3H0=
X-Google-Smtp-Source: AGHT+IH1QP5afcE8FMimsxzEIL3LMCR6qmqdqCAMbeXat84NJeqlw2kZxRMQ//rOsxyL5OVZC7oI9g==
X-Received: by 2002:a05:600c:3b10:b0:421:6cd4:b6ed with SMTP id 5b1f17b1804b1-4216cd4be41mr37051935e9.6.1717856724046;
        Sat, 08 Jun 2024 07:25:24 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421725a9bd3sm44947365e9.45.2024.06.08.07.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 07:25:23 -0700 (PDT)
Date: Sat, 8 Jun 2024 17:25:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org
Subject: [bug report] ext4: Convert data=journal writeback to use
 ext4_writepages()
Message-ID: <01c6db4f-eb47-467a-9bb9-3ca6ee4817d7@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Jan Kara,

Commit 3f079114bf52 ("ext4: Convert data=journal writeback to use
ext4_writepages()") from Feb 28, 2023 (linux-next), leads to the
following Smatch static checker warning:

	fs/ext4/inode.c:2478 mpage_prepare_extent_to_map()
	error: we previously assumed 'handle' could be null (see line 2417)

fs/ext4/inode.c
    2362 static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
    2363 {
    2364         struct address_space *mapping = mpd->inode->i_mapping;
    2365         struct folio_batch fbatch;
    2366         unsigned int nr_folios;
    2367         pgoff_t index = mpd->first_page;
    2368         pgoff_t end = mpd->last_page;
    2369         xa_mark_t tag;
    2370         int i, err = 0;
    2371         int blkbits = mpd->inode->i_blkbits;
    2372         ext4_lblk_t lblk;
    2373         struct buffer_head *head;
    2374         handle_t *handle = NULL;
    2375         int bpp = ext4_journal_blocks_per_page(mpd->inode);
    2376 
    2377         if (mpd->wbc->sync_mode == WB_SYNC_ALL || mpd->wbc->tagged_writepages)
    2378                 tag = PAGECACHE_TAG_TOWRITE;
    2379         else
    2380                 tag = PAGECACHE_TAG_DIRTY;
    2381 
    2382         mpd->map.m_len = 0;
    2383         mpd->next_page = index;
    2384         if (ext4_should_journal_data(mpd->inode)) {
    2385                 handle = ext4_journal_start(mpd->inode, EXT4_HT_WRITE_PAGE,
    2386                                             bpp);
    2387                 if (IS_ERR(handle))
    2388                         return PTR_ERR(handle);
    2389         }
    2390         folio_batch_init(&fbatch);
    2391         while (index <= end) {
    2392                 nr_folios = filemap_get_folios_tag(mapping, &index, end,
    2393                                 tag, &fbatch);
    2394                 if (nr_folios == 0)
    2395                         break;
    2396 
    2397                 for (i = 0; i < nr_folios; i++) {
    2398                         struct folio *folio = fbatch.folios[i];
    2399 
    2400                         /*
    2401                          * Accumulated enough dirty pages? This doesn't apply
    2402                          * to WB_SYNC_ALL mode. For integrity sync we have to
    2403                          * keep going because someone may be concurrently
    2404                          * dirtying pages, and we might have synced a lot of
    2405                          * newly appeared dirty pages, but have not synced all
    2406                          * of the old dirty pages.
    2407                          */
    2408                         if (mpd->wbc->sync_mode == WB_SYNC_NONE &&
    2409                             mpd->wbc->nr_to_write <=
    2410                             mpd->map.m_len >> (PAGE_SHIFT - blkbits))
    2411                                 goto out;
    2412 
    2413                         /* If we can't merge this page, we are done. */
    2414                         if (mpd->map.m_len > 0 && mpd->next_page != folio->index)
    2415                                 goto out;
    2416 
    2417                         if (handle) {
                                     ^^^^^^
Checked for NULL

    2418                                 err = ext4_journal_ensure_credits(handle, bpp,
    2419                                                                   0);
    2420                                 if (err < 0)
    2421                                         goto out;
    2422                         }
    2423 
    2424                         folio_lock(folio);
    2425                         /*
    2426                          * If the page is no longer dirty, or its mapping no
    2427                          * longer corresponds to inode we are writing (which
    2428                          * means it has been truncated or invalidated), or the
    2429                          * page is already under writeback and we are not doing
    2430                          * a data integrity writeback, skip the page
    2431                          */
    2432                         if (!folio_test_dirty(folio) ||
    2433                             (folio_test_writeback(folio) &&
    2434                              (mpd->wbc->sync_mode == WB_SYNC_NONE)) ||
    2435                             unlikely(folio->mapping != mapping)) {
    2436                                 folio_unlock(folio);
    2437                                 continue;
    2438                         }
    2439 
    2440                         folio_wait_writeback(folio);
    2441                         BUG_ON(folio_test_writeback(folio));
    2442 
    2443                         /*
    2444                          * Should never happen but for buggy code in
    2445                          * other subsystems that call
    2446                          * set_page_dirty() without properly warning
    2447                          * the file system first.  See [1] for more
    2448                          * information.
    2449                          *
    2450                          * [1] https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
    2451                          */
    2452                         if (!folio_buffers(folio)) {
    2453                                 ext4_warning_inode(mpd->inode, "page %lu does not have buffers attached", folio->index);
    2454                                 folio_clear_dirty(folio);
    2455                                 folio_unlock(folio);
    2456                                 continue;
    2457                         }
    2458 
    2459                         if (mpd->map.m_len == 0)
    2460                                 mpd->first_page = folio->index;
    2461                         mpd->next_page = folio_next_index(folio);
    2462                         /*
    2463                          * Writeout when we cannot modify metadata is simple.
    2464                          * Just submit the page. For data=journal mode we
    2465                          * first handle writeout of the page for checkpoint and
    2466                          * only after that handle delayed page dirtying. This
    2467                          * makes sure current data is checkpointed to the final
    2468                          * location before possibly journalling it again which
    2469                          * is desirable when the page is frequently dirtied
    2470                          * through a pin.
    2471                          */
    2472                         if (!mpd->can_map) {
    2473                                 err = mpage_submit_folio(mpd, folio);
    2474                                 if (err < 0)
    2475                                         goto out;
    2476                                 /* Pending dirtying of journalled data? */
    2477                                 if (folio_test_checked(folio)) {
--> 2478                                         err = mpage_journal_page_buffers(handle,
                                                                                  ^^^^^^
Unchecked dereferenced inside the function.

    2479                                                 mpd, folio);
    2480                                         if (err < 0)
    2481                                                 goto out;
    2482                                         mpd->journalled_more_data = 1;
    2483                                 }
    2484                                 mpage_folio_done(mpd, folio);
    2485                         } else {
    2486                                 /* Add all dirty buffers to mpd */
    2487                                 lblk = ((ext4_lblk_t)folio->index) <<
    2488                                         (PAGE_SHIFT - blkbits);
    2489                                 head = folio_buffers(folio);
    2490                                 err = mpage_process_page_bufs(mpd, head, head,
    2491                                                 lblk);
    2492                                 if (err <= 0)
    2493                                         goto out;
    2494                                 err = 0;
    2495                         }
    2496                 }
    2497                 folio_batch_release(&fbatch);
    2498                 cond_resched();
    2499         }
    2500         mpd->scanned_until_end = 1;
    2501         if (handle)
    2502                 ext4_journal_stop(handle);
    2503         return 0;
    2504 out:
    2505         folio_batch_release(&fbatch);
    2506         if (handle)
    2507                 ext4_journal_stop(handle);
    2508         return err;
    2509 }

regards,
dan carpenter

