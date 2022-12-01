Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A693463EFB6
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 12:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiLALmP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 06:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiLALmN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 06:42:13 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F2B29368
        for <linux-ext4@vger.kernel.org>; Thu,  1 Dec 2022 03:42:11 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o12so1598590pjo.4
        for <linux-ext4@vger.kernel.org>; Thu, 01 Dec 2022 03:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iNBN5XIxc+PY8h6AlBQnd/icHI7IW1N+64b+FwAglJc=;
        b=GUQiQr5uXeUq8xN/BzgkmEGhYlrZHHxUNQ4IfSsCG+tdoAhFSoRCj76jGIZ0uLA8m0
         NDsMktEi6F7XzTg+UaGLJ4TyRZmz9Yw4M5qrC7+m32Rx8Z/CA6fZt+nwiNn2NELHo14+
         iHLxbuP1zd0NkIG68e4GDMVObWaC5H5xg02bVJ7MvgByoGw5C8wYrhPaRi5YBcwPIEli
         BhCVSWrJxzsX9FrCh72H7lc3q5nW/VLqc8p8h6fRDWeq2Zb3K+Ulz4SoYlGWS3PEOgXv
         274DXYf7qMMQA1qt/GzZvA2IHApmb4KmOUAuuFJfUEB/RwiEehBJr6GOJb46MHDL0P+j
         jH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNBN5XIxc+PY8h6AlBQnd/icHI7IW1N+64b+FwAglJc=;
        b=jujMJ7ifAPn/1eU9BskTgsYHKrWI95/lt7LUZCF4/34SL2L3tBMsWtxOx6Z9EJGpnz
         IMeu9vC91xvAFDx1NYlM6T3i6PHxeonYGIElZtxbHuFJa5DRiLEplnxCvrb8GUh7Qi6T
         Oxk7I6I4+hOoGRvV+Zuk+jySB2t07gSn8uWuXtzBhvPiSW1tEXb8tqrPFfKT3XGqAOvm
         Rvfh045H0NEx+9wP6hj5L3xIVvBWoWc2xBHVierCKf48N5h8iD5HH0xiVJCOmk8e1uCe
         9tzEu6ZXnWgcn2Q4NB9042EnpnR1VQwQuDToyPCVIQwmpNi1Fpl4PR45skdS8aVDu/7O
         Zz5g==
X-Gm-Message-State: ANoB5plHNj7Hyp4NUCyNxb+7yMK3qUZv9M8gkDhzqUWI9vkJpZhMK2Te
        8w9mECfcXMKcXQN36omhWFQ=
X-Google-Smtp-Source: AA0mqf62zYsK+gU8rS+8QOtZZrob9wVCf+c58FS9ErJkwmCF7JgWhJPSIDXO2CJOahRJjQR2nF6dzw==
X-Received: by 2002:a17:902:d4c5:b0:189:5e92:d457 with SMTP id o5-20020a170902d4c500b001895e92d457mr33287662plg.166.1669894931323;
        Thu, 01 Dec 2022 03:42:11 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090311cf00b00176b63535adsm3427702plh.260.2022.12.01.03.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 03:42:10 -0800 (PST)
Date:   Thu, 1 Dec 2022 17:12:05 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/9] ext4: Stop using ext4_writepage() for writeout of
 ordered data
Message-ID: <20221201114205.mg6song3ulrqvt54@riteshh-domain>
References: <20221130162435.2324-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130162435.2324-1-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/11/30 05:35PM, Jan Kara wrote:
> Hello,
>
> this patch series modifies ext4 so that we stop using ext4_writepage() for
> writeout of ordered data during transaction commit (through
> generic_writepages() from jbd2_journal_submit_inode_data_buffers()). Instead we
> directly call ext4_writepages() from the
> ext4_journal_submit_inode_data_buffers().

Hello Jan,

Do you think we should add a WARN_ON_ONCE() or something in
ext4_do_writepages() function where we might try to start a transaction
at [J]. Since we can now enter into ext4_do_writepages() from two places:
1. writeback
2. jbd2_journal_commit_transaction()
	mpage_submit_page
	mpage_prepare_extent_to_map
	ext4_do_writepages
	ext4_normal_submit_inode_data_buffers
	ext4_journal_submit_inode_data_buffers
	journal_submit_data_buffers
	jbd2_journal_commit_transaction
	kjournald2

So IIUC, we will call mpage_submit_page() in the first call to
mpage_prepare_extent_to_map() [1] itself. That may set mpd->scanned_until_end = 1
at the end of it. So then we should never enter into the while loop where we
start a journal txn.

But can it ever happen that we ever into this while loop for writing out
pages for journal_submit_data_buffers()?

ext4_do_writepages()
{
<...>
	mpd->do_map = 0;
	mpd->scanned_until_end = 0;
	mpd->io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
<...>
[1]	ret = mpage_prepare_extent_to_map(mpd);
	/* Unlock pages we didn't use */
	mpage_release_unused_pages(mpd, false);
	/* Submit prepared bio */
	ext4_io_submit(&mpd->io_submit);
	ext4_put_io_end_defer(mpd->io_submit.io_end);
	mpd->io_submit.io_end = NULL;
<...>
	while (!mpd->scanned_until_end && wbc->nr_to_write > 0) {
		/* For each extent of pages we use new io_end */
		mpd->io_submit.io_end = ext4_init_io_end(inode, GFP_KERNEL);
<....>
		BUG_ON(ext4_should_journal_data(inode));
		needed_blocks = ext4_da_writepages_trans_blocks(inode);

		/* start a new transaction */
[J]		handle = ext4_journal_start_with_reserve(inode,
				EXT4_HT_WRITE_PAGE, needed_blocks, rsv_blocks);
<...>
		mpd->do_map = 1;

		trace_ext4_da_write_pages(inode, mpd->first_page, wbc);
[2]		ret = mpage_prepare_extent_to_map(mpd);
		if (!ret && mpd->map.m_len)
			ret = mpage_map_and_submit_extent(handle, mpd,
					&give_up_on_write);
<...>
	}
<...>
}

-ritesh
