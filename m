Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83781278F86
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Sep 2020 19:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgIYRWn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Sep 2020 13:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgIYRWn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Sep 2020 13:22:43 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075ACC0613CE
        for <linux-ext4@vger.kernel.org>; Fri, 25 Sep 2020 10:22:43 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id d15so3629364lfq.11
        for <linux-ext4@vger.kernel.org>; Fri, 25 Sep 2020 10:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ya/RZuQwonP8PPud7lCm2bOa/ougNTh1IMJmg7koWQI=;
        b=PyvHoBQgWuYhvQNjE7NE5hs89M+9kEHdGV2j/seaL5Gg0MlWI0M3tX0IFbaWMqXj1s
         ai1ySoBUH/pJJp9+Lt2njZA4fNnlVMdXvTFeaxT+0cvhcpS5izHZbaGSst5DxJjEc5+F
         ZNPMI630ovQTocKSg89ZIXTt+gZgkoXsInN7B4nwsREzwGBafMSTTG+JS9MTkAyGvpeJ
         mCTvE0+H1iacOG6BiB+OHTPMGuSJTKbL5nQyKWU76nXzqmqxP14mG4SPDaUIbo/sWOT3
         kHrrT9YpdO3/IyFVoOp7L4bIBGWhB2qRiwq60yvM/lIcXa4y+Kzx96H4AT/v99RIvuPA
         QMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ya/RZuQwonP8PPud7lCm2bOa/ougNTh1IMJmg7koWQI=;
        b=hWApi5eIgvYiVb1z+AYylRyopsdTVtOWP7wutt7F9pSPBwA9W/4PLqErOm70sgVc9G
         59v/2on/bNP4NEExqGpV+Q6rlQDIVavfkiWJ6XoomscIVooyco7cVeBFKaSEM/2tbFpw
         UObykfhGRogR6Wiyht+oYVO5yjdIh/jomiDbPPInsCz8EXzCewlSBnuW6VGTpaTSuGZh
         gO+oxXUuuVc0XzYSLzsVwmPLNqC1FrZRzS8r179DX7ggkKtld/8iput6D2inhAxh8WaR
         6na3sOBmCnChcDhql7SSnYE6NGZ/CBUZUY+R35ICxsfj03UIpUQYCzayMKx8VT7/y8Ln
         gvrg==
X-Gm-Message-State: AOAM532KFWTFs7M+9Thdfls96A8FEUxN/pMF2l26ZLmt+uJWCiR+v4Gs
        imZfTX3tTGuugSegfIeAHJM2dIqsxmcy1sv4YeFfgw==
X-Google-Smtp-Source: ABdhPJzcMlw0fOZLTa8UbxvxQ9K/MTDBtFoXm/rCC3pf0zAylKLPns8FI3+ijZEzImVWcIGbkPhF3RsHOU2PbQ6BiUI=
X-Received: by 2002:a19:4084:: with SMTP id n126mr1581229lfa.54.1601054561128;
 Fri, 25 Sep 2020 10:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200915073303.GA754106@T590> <20200915224541.GB38283@mit.edu>
 <20200915230941.GA791425@T590> <20200916202026.GC38283@mit.edu>
 <20200917022051.GA1004828@T590> <20200917143012.GF38283@mit.edu>
 <20200924005901.GB1806978@T590> <20200924143345.GD482521@mit.edu>
 <20200925011311.GJ482521@mit.edu> <20200925073145.GC2388140@T590>
 <20200925161918.GD2388140@T590> <CAHk-=whAe_n6JDyu40A15vnWs5PTU0QYX6t6-TbNeefanau6MA@mail.gmail.com>
In-Reply-To: <CAHk-=whAe_n6JDyu40A15vnWs5PTU0QYX6t6-TbNeefanau6MA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 25 Sep 2020 10:22:29 -0700
Message-ID: <CALvZod4+ucJfr4gR60mM1gRoc7NKWydPY-JQ757q+n8hOdmrvA@mail.gmail.com>
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ming Lei <ming.lei@redhat.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jens Axboe <axboe@kernel.dk>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 25, 2020 at 10:17 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Sep 25, 2020 at 9:19 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > git bisect shows the first bad commit:
> >
> >         [10befea91b61c4e2c2d1df06a2e978d182fcf792] mm: memcg/slab: use a single set of
> >                 kmem_caches for all allocations
> >
> > And I have double checked that the above commit is really the first bad
> > commit for the list corruption issue of 'list_del corruption, ffffe1c241b00408->next
> > is LIST_POISON1 (dead000000000100)',
>
> Thet commit doesn't revert cleanly, but I think that's purely because
> we'd also need to revert
>
>   849504809f86 ("mm: memcg/slab: remove unused argument by charge_slab_page()")
>   74d555bed5d0 ("mm: slab: rename (un)charge_slab_page() to
> (un)account_slab_page()")
>
> too.
>
> Can you verify that a
>
>     git revert 74d555bed5d0 849504809f86 10befea91b61
>
> on top of current -git makes things work for you again?
>
> I'm going to do an rc8 this release simply because we have another VM
> issue that I hope to get fixed - but there we know what the problem
> and the fix _is_, it just needs some care.
>
> So if Roman (or somebody else) can see what's wrong and we can fix
> this quickly, we don't need to go down the revert path, but ..
>

I think I have a theory. The issue is happening due to the potential
infinite recursion:

[ 5060.124412]  ___cache_free+0x488/0x6b0
*****Second recursion
[ 5060.128666]  kfree+0xc9/0x1d0
[ 5060.131947]  kmem_freepages+0xa0/0xf0
[ 5060.135746]  slab_destroy+0x19/0x50
[ 5060.139577]  slabs_destroy+0x6d/0x90
[ 5060.143379]  ___cache_free+0x4a3/0x6b0
*****First recursion
[ 5060.147896]  kfree+0xc9/0x1d0
[ 5060.151082]  kmem_freepages+0xa0/0xf0
[ 5060.155121]  slab_destroy+0x19/0x50
[ 5060.159028]  slabs_destroy+0x6d/0x90
[ 5060.162920]  ___cache_free+0x4a3/0x6b0
[ 5060.167097]  kfree+0xc9/0x1d0

___cache_free() is calling cache_flusharray() to flush the local cpu
array_cache if the cache has more elements than the limit (ac->avail
>= ac->limit).

cache_flusharray() is removing batchcount number of element from local
cpu array_cache and pass it slabs_destroy (if the node shared cache is
also full).

Note that we have not updated local cpu array_cache size yet and
called slabs_destroy() which can call kfree() through
unaccount_slab_page().

We are on the same CPU and this recursive kfree again check the
(ac->avail >= ac->limit) and call cache_flusharray() again and recurse
indefinitely.
