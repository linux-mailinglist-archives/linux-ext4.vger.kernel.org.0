Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D60B7931D1
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Sep 2023 00:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbjIEWLS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Sep 2023 18:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjIEWLS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Sep 2023 18:11:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B65F4;
        Tue,  5 Sep 2023 15:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GeP4MIuZrBFvrMvcXRvi2QnFxUlFhMKNwjLk6UGDJZ8=; b=kWZNxsuzHVS8No9JHSY0DoVH0c
        kfFSUvNxy9UWj5dWPo0ifDJg42hkAP0pxpJdfgm4WwjQokZWYb3r4DT8KLLqHTJg8BlnejG0DZ5vH
        fSvbHjx+PKkPX+rLYQhILwxPMPUT8HFi2Ue4ul3D8hTFcHdoOsUuIxdURXhEs4VsSVlo3RorKHH70
        jHVRT2bv48jv5BagNKEzq+rbl+nib9isuh8b9Ywcgj+O5Wcd5ZgLiECFD+UGJkt7M7fi8WOmQOlZA
        YZxjnC6smy8l//2I+rnMDAmr7zzJ6j6HI2pZ2X7EU+/642QbZI+aqZUmpJccj28Bb2gj/hOJ7zIcX
        PtVMND6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qdeGE-00DwXa-LY; Tue, 05 Sep 2023 22:11:02 +0000
Date:   Tue, 5 Sep 2023 23:11:02 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Zorro Lang <zlang@kernel.org>, linux-ext4@vger.kernel.org,
        fstests@vger.kernel.org, regressions@lists.linux.dev,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [fstests generic/388, 455, 475, 482 ...] Ext4 journal recovery
 test fails
Message-ID: <ZPendrb8gSbAC6fM@casper.infradead.org>
References: <20230903120001.qjv5uva2zaqthgk2@zlang-mailbox>
 <ZPTvIb6hwIjY7T2M@mit.edu>
 <20230904060819.GB701295@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904060819.GB701295@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 04, 2023 at 02:08:19AM -0400, Theodore Ts'o wrote:
> #regzbot introduced: 8147c4c4546f9f05ef03bb839b741473b28bb560 ^
> 
> OK, I've isolated the regression of generic/455 failing with ext4/1k
> to this commit, which came in via the mm tree.  Nothing seems
> *obviously* wrong, but I'm not sure if there are any differences in
> the semantics of the new folio functions such as kmap_local_folio,
> offset_in_folio, set_folio_bh() which might be making a difference.

Thanks for the cc,  Let's see what we can do ...

virt_to_folio() - For an order-0 page, there is no difference.
offset_in_folio() - Ditto
bh->b_page vs bh->b_folio - Ditto
virt_to_folio() - Ditto
folio_set_bh() - Ditto

kmap_local_folio() vs kmap_atomic - Here, we have a difference.
memcpy_from_folio() - Same difference as above.

I suppose it must be this, and yet I cannot understand how it would
make a difference.  Perhaps you can help me?

static inline void *kmap_atomic_prot(struct page *page, pgprot_t prot)
{
        if (IS_ENABLED(CONFIG_PREEMPT_RT))
                migrate_disable();
        else
                preempt_disable();

        pagefault_disable();
        return __kmap_local_page_prot(page, prot);
}

vs

static inline void *kmap_local_folio(struct folio *folio, size_t offset)
{
        struct page *page = folio_page(folio, offset / PAGE_SIZE);
        return __kmap_local_page_prot(page, kmap_prot) + offset % PAGE_SIZE;
}

I don't believe that returning the address with the offset included
is the problem here.  It must be disabling preemption / migration.
There's no chace this funcation accesses userspace (... is there?) so
it can't be the pagefault_disable().

We can try splitting this up into tiny commits and figuring out which
of them is the problem.  I'll be back at work tomorrow and can look
more deeply then.

> Using kvm-xfstests[1] I bisected this via the command:
> 
> % install-kconfig ; kbuild ; kvm-xfstests -c ext4/1k -C 10 generic/455
> 
> [1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
> 
> 
> And the bisection pointed me at this commit:
> 
>     commit 8147c4c4546f9f05ef03bb839b741473b28bb560 (refs/bisect/bad)
>     Author: Matthew Wilcox (Oracle) <willy@infradead.org>
>     AuthorDate: Thu Jul 13 04:55:11 2023 +0100
>     Commit: Andrew Morton <akpm@linux-foundation.org>
>     CommitDate: Fri Aug 18 10:12:30 2023 -0700
> 
>         jbd2: use a folio in jbd2_journal_write_metadata_buffer()
>     
> During the bisection, I treated a commit with 3+ failures as "bad",
> and 0-2 commits as "good".  Running generic/455 50 times to get a
> sense of the failure, with the first bad commit (8147c4c4546f), I got:
> 
>     ext4/1k: 50 tests, 21 failures, 223 seconds
>       Flaky: generic/455: 42% (21/50)
>     Totals: 50 tests, 0 skipped, 21 failures, 0 errors, 223s
> 
> While with the immediately preceding commit (07811230c3cd), I got:
> 
>     ext4/1k: 50 tests, 4 failures, 235 seconds
>       Flaky: generic/455:  8% (4/50)
>     Totals: 50 tests, 0 skipped, 4 failures, 0 errors, 235s
> 
> 
> 
> Comparing these two commits (8147c4c4546f vs 07811230c3cd) using the
> ext4 with a 4k block size, I get:
> 
>     ext4/4k: 50 tests, 2 failures, 365 seconds
>       Flaky: generic/455:  4% (2/50)
>     Totals: 50 tests, 0 skipped, 2 failures, 0 errors, 365s
> 
> vs
> 
>     ext4/4k: 50 tests, 2 failures, 349 seconds
>       Flaky: generic/455:  4% (2/50)
>     Totals: 50 tests, 0 skipped, 2 failures, 0 errors, 349s
> 
> So issue seems to be specifically with a sub-page size block size,
> since ext4/4k doesn't show any issues, while ext4/1k does.

I doubt I tried it with a 1kB block size, so I'll focus on that too.
