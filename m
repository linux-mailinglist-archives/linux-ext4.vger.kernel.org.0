Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E221826C501
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Sep 2020 18:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIPQTC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Sep 2020 12:19:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:34194 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgIPQQZ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Sep 2020 12:16:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 604CCB2A1;
        Wed, 16 Sep 2020 16:15:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A4E951E12E1; Wed, 16 Sep 2020 18:15:38 +0200 (CEST)
Date:   Wed, 16 Sep 2020 18:15:38 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>
Subject: Re: [RFC PATCH v3 0/3] ext4/jbd2: data=journal: write-protect pages
 on transaction commit
Message-ID: <20200916161538.GK3607@quack2.suse.cz>
References: <20200910193127.276214-1-mfo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910193127.276214-1-mfo@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Mauricio!

On Thu 10-09-20 16:31:24, Mauricio Faria de Oliveira wrote:
> This series implements your suggestions for the RFC PATCH v2 set,
> which we mostly talked about in cover letter [1] and PATCH 3 [2].
> (I added Suggested-by: tags, by the way, for due credit.)
> 
> It looks almost good on fstests: zero regressions on data=ordered,
> and only one regression in data=journal (generic/347); I'll check.
> (That's with ext4; I'll check ocfs2, but it's only a minor change.)

Glad to hear that!

> Testing with 'stress-ng --mmap <N> --mmap-file' runs well for days,
> but it occasionally hits:
> 
>   JBD2: Spotted dirty metadata buffer (dev = vdc, blocknr = 74775).
>   There's a risk of filesystem corruption in case of system crash.
> 
> I added dump_stack() in warn_dirty_buffer(), and it usually comes
> from jbd2_journal_file_buffer(, BJ_Forget) in the commit function.
> When filing from BJ_Shadow to BJ_Forget.. so it possibly happened
> while BH_Shadow was still set!
> 
> So I instrumented [test_]set_buffer_dirty() macros to dump_stack()
> if BH_Shadow is set (i.e. buffer being set dirty during write-out.)
> 
> This showed that the occasional BH_Dirty setter with BH_Shadow set
> is block_page_mkwrite() in ext4_page_mkwrite(). And it seems right,
> because it's called before do_journal_get_write_access() (where we
> check for/wait on BH_Shadow.)
> 
> ext4_page_mkwrite():
> 
>         err = block_page_mkwrite(vma, vmf, get_block);
>         if (!err && ext4_should_journal_data(inode)) {
>                 if (ext4_walk_page_buffers(handle, page_buffers(page), 0,
>                           PAGE_SIZE, NULL, do_journal_get_write_access)) {
> 
> The patches didn't directly break this, they only allow this code
> to run more often as we disabled an early-return optimization for
> the case 'all buffers mapped' in data=journal (question 2 in [1]):
> 
> ext4_page_mkwrite():
> 
>          * Return if we have all the buffers mapped.
> 	...
> -       if (page_has_buffers(page)) {
> +       if (page_has_buffers(page) && !ext4_should_journal_data(inode)) {
> 
> 
> In order to confirm it, I built the unpatched v5.9-rc4 kernel, with
> just the change to disable that optimization in data=journal -- and
> it hit that occasionally too ("JBD2: Spotted dirty metadata buffer".)
> 
> I was naive enough to mindlessly try to swap the order of those two
> statements, in hopes that do_journal_get_write_access() should wait
> for BH_Shadow to clear, and then we just call block_page_mkwrite().
> BUT it trips into the BUG() check in page_buffers() in the former.

Yeah, you're right that code is wrong for data=journal case. We cannot
really use block_page_mkwrite() for it - we rather need to use there
something like:

	__block_write_begin(page, pos, len, ext4_get_block);
	ext4_walk_page_buffers(handle, page_buffers(page),
                                             from, to, NULL,
                                             do_journal_get_write_access);
	ext4_walk_page_buffers(handle, page_buffers(page), from, to, NULL,
				write_end_fn);

or something like that, I guess you get the idea...

Actually, I think data=journal mode should get it's own .page_mkwrite
handler because the sharing between data=journal handling and the other
cases is pretty minimal.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
