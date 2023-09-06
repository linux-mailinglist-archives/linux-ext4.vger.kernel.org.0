Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B5B793CD4
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Sep 2023 14:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbjIFMip (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Sep 2023 08:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjIFMip (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Sep 2023 08:38:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121DD19B1;
        Wed,  6 Sep 2023 05:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xzKnxGMihiQTZzTgBY6Hc/r1gngtuD8yL7c68hqDTsU=; b=mXQN4kdJtgWAXG/bePp1hy05vF
        /XQpKHCMy3jJjEHmdHnPjShhRvie+x4kNSFTqNUlJGDjRDY9ThIxoWRKG4QN3AZtEWCLV9V3wMRku
        AMmmtQb79Q0LRYMNrlmGydhszbcedvbhlY04zeDxKakQZ4I1uiGMZ9to0P73MxLB2BxtHrsQfd2b/
        dVnXU6zHohpwrX3w4CftasOOBMQdAsLXEAIGR3SDshVeYLCnl6/FrsVzYnXhyS4rvauDaQlF4o82L
        oBsvjcFRQthXXFHiXMWQEErW4/RFk6wxO4z5MnFzZTqzCnXclUGmN++2rn5UApGbf9aaY89xl8Hn2
        vOGu1JbQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdrnb-002LZ8-Gm; Wed, 06 Sep 2023 12:38:23 +0000
Date:   Wed, 6 Sep 2023 13:38:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Zorro Lang <zlang@kernel.org>,
        linux-ext4@vger.kernel.org, fstests@vger.kernel.org,
        regressions@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [fstests generic/388, 455, 475, 482 ...] Ext4 journal recovery
 test fails
Message-ID: <ZPhyv7cHxO9vbciL@casper.infradead.org>
References: <ZPendrb8gSbAC6fM@casper.infradead.org>
 <87wmx336ns.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmx336ns.fsf@doe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 06, 2023 at 04:33:35PM +0530, Ritesh Harjani wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> 
> > On Mon, Sep 04, 2023 at 02:08:19AM -0400, Theodore Ts'o wrote:
> >> #regzbot introduced: 8147c4c4546f9f05ef03bb839b741473b28bb560 ^
> >> 
> >> OK, I've isolated the regression of generic/455 failing with ext4/1k
> >> to this commit, which came in via the mm tree.  Nothing seems
> >> *obviously* wrong, but I'm not sure if there are any differences in
> >> the semantics of the new folio functions such as kmap_local_folio,
> >> offset_in_folio, set_folio_bh() which might be making a difference.
> >
> > Thanks for the cc,  Let's see what we can do ...
> >
> > virt_to_folio() - For an order-0 page, there is no difference.
> > offset_in_folio() - Ditto
> > bh->b_page vs bh->b_folio - Ditto
> > virt_to_folio() - Ditto
> > folio_set_bh() - Ditto
> >
> > kmap_local_folio() vs kmap_atomic - Here, we have a difference.
> > memcpy_from_folio() - Same difference as above.
> >
> > I suppose it must be this, and yet I cannot understand how it would
> > make a difference.  Perhaps you can help me?
> >
> > static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
> > {
> >         if (IS_ENABLED(CONFIG_PREEMPT_RT))
> >                 migrate_disable();
> >         else
> >                 preempt_disable();
> >
> >         pagefault_disable();
> >         return __kmap_local_page_prot(page, prot);
> > }
> >
> > vs
> >
> > static inline void *kmap_local_folio(struct folio *folio, size_t offset)
> > {
> >         struct page *page = folio_page(folio, offset / PAGE_SIZE);
> >         return __kmap_local_page_prot(page, kmap_prot) + offset % PAGE_SIZE;
> > }
> >
> > I don't believe that returning the address with the offset included
> > is the problem here.  It must be disabling preemption / migration.
> > There's no chace this funcation accesses userspace (... is there?) so
> > it can't be the pagefault_disable().
> >
> > We can try splitting this up into tiny commits and figuring out which
> > of them is the problem.  I'll be back at work tomorrow and can look
> > more deeply then.
> >
> >> Using kvm-xfstests[1] I bisected this via the command:
> >> 
> >> % install-kconfig ; kbuild ; kvm-xfstests -c ext4/1k -C 10 generic/455
> >> 
> >> [1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
> >> 
> >> 
> >> And the bisection pointed me at this commit:
> >> 
> >>     commit 8147c4c4546f9f05ef03bb839b741473b28bb560 (refs/bisect/bad)
> >>     Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> >>     AuthorDate: Thu Jul 13 04:55:11 2023 +0100
> >>     Commit: Andrew Morton <akpm@linux-foundation.org>
> >>     CommitDate: Fri Aug 18 10:12:30 2023 -0700
> >> 
> >>         jbd2: use a folio in jbd2_journal_write_metadata_buffer()
> >>     
> 
> This is inline with my observation too. 
> 
> However, is this log expected with below diff when running with ext4/1k?
> I am finding a folio with order > 0 here.
> 
> <diff>
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 768fa05bcbed..152c08e83fa2 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -369,6 +369,12 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>                 new_offset = offset_in_folio(new_folio, jh2bh(jh_in)->b_data);
>         }
> 
> +       if (folio_size(new_folio) > PAGE_SIZE) {
> +               pr_crit("%s: folio_size=%lu, folio_order=%d, new_offset=%u bh_size=%lu folio_test_large=%d\n",
> +                       __func__, folio_size(new_folio), folio_order(new_folio), new_offset,
> +                       bh_in->b_size, folio_test_large(new_folio));
> +       }
> +
>         mapped_data = kmap_local_folio(new_folio, new_offset);
>         /*
>          * Fire data frozen trigger if data already wasn't frozen.  Do this
> 
> <dmesg log>
> [   40.419772] jbd2_journal_write_metadata_buffer: folio_size=16384, folio_order=2, new_offset=0 bh_size=1024 folio_test_large=1
> [   40.444737] jbd2_journal_write_metadata_buffer: folio_size=16384, folio_order=2, new_offset=2048 bh_size=1024 folio_test_large=1
> [   40.472385] jbd2_journal_write_metadata_buffer: folio_size=16384, folio_order=2, new_offset=3072 bh_size=1024 folio_test_large=1
> [   40.560581] jbd2_journal_write_metadata_buffer: folio_size=16384, folio_order=2, new_offset=8192 bh_size=1024 folio_test_large=1
> [   40.588512] jbd2_journal_write_metadata_buffer: folio_size=16384, folio_order=2, new_offset=10240 bh_size=1024 folio_test_large=1
> [   40.612103] jbd2_journal_write_metadata_buffer: folio_size=16384, folio_order=2, new_offset=7168 bh_size=1024 folio_test_large=1
> [   40.636800] jbd2_journal_write_metadata_buffer: folio_size=16384, folio_order=2, new_offset=9216 bh_size=1024 folio_test_large=1
> [   40.661166] jbd2_journal_write_metadata_buffer: folio_size=16384, folio_order=2, new_offset=10240 bh_size=1024 folio_test_large=1
> 
> 
> Is this code path a possibility, which can cause above logs?
> 
>    ptr = jbd2_alloc() -> kmem_cache_alloc()
>    <..>
>    new_folio = virt_to_folio(ptr)
>    new_offset = offset_in_folio(new_folio, ptr)
> 
> And then I am still not sure what the problem really is? 
> Is it because at the time of checkpointing, the path is still not fully
> converted to folio?

Oh yikes!  I didn't know that the allocation might come from kmalloc!
Yes, slab might use high-order allocations.  I'll have to look through
this and figure out what the problem might be.

Thanks for debugging this.
