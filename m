Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7F5278F78
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Sep 2020 19:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgIYRSB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Sep 2020 13:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbgIYRSB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Sep 2020 13:18:01 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C97CC0613CE
        for <linux-ext4@vger.kernel.org>; Fri, 25 Sep 2020 10:18:01 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d15so3613448lfq.11
        for <linux-ext4@vger.kernel.org>; Fri, 25 Sep 2020 10:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N+ANB8ObSSZ0LIy221HtUSCjieyuyM53ewN5x3+3DVE=;
        b=ViM6tNtjnjXKy+aig7vGCrWABYQxrnX2HtkZcN4CBEWw59xq/lePN1F/rj4bBZKD9U
         Ciyu/pPnZh+e6dHKrJngZsreQbcFBMQz0XY6cDFZ6Hru4Bqj/AL8F4fhKruS2mt+CqNQ
         pTRiIMYwAshLcNOYleRDc/4QZ26uCT/Hm942Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+ANB8ObSSZ0LIy221HtUSCjieyuyM53ewN5x3+3DVE=;
        b=GQwNjh5D6uqr7KYALJV73M9hMvCxa70m6XRdzcrL8jt2Vl0QtNWHAbp04HTrO1K+8k
         bH5WryRXD2pa8P6XMk8YMiNclE7C1EZlkuppuvcOC6BVpH2gs4AGeqXqDU0mGV9vQRYq
         hGyAffW3hYaIsrJYSFyIFk5ZadLYTw1ydnQ4KMwTUO+XkVYu2J/4FlHeV0xUQYeLBXUn
         8clka3g3w4N3NjXrCH/KwDB2LkZFF/a79Hbookv1bvqtBGHlPft6ADKNqPrMW3GIupIT
         Bs3ZlPBnyFiG1AMkm+68RM7ZQfe8nMeLe71oAR9k0tPBt7b1mYFpp3SzfEkDYtvsjQqq
         +9fQ==
X-Gm-Message-State: AOAM531eglqBqKTmDdzLyclphEfxnJCJD/kvO0NkQ2pggsJQoxKvo/on
        iz+o3g70y9plDHf7bLvhhNZkP5qlI2yxgg==
X-Google-Smtp-Source: ABdhPJzcR4fr1leMpQqu79JPQCaAwAzKbbyyCtEkcQ4UiAG8SlOdWoT6mOjyTJZGMlB6XBmToFGoAA==
X-Received: by 2002:a19:711d:: with SMTP id m29mr1641906lfc.442.1601054278291;
        Fri, 25 Sep 2020 10:17:58 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 64sm2741590lfk.227.2020.09.25.10.17.52
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 10:17:53 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id z19so3647403lfr.4
        for <linux-ext4@vger.kernel.org>; Fri, 25 Sep 2020 10:17:52 -0700 (PDT)
X-Received: by 2002:ac2:5594:: with SMTP id v20mr1832306lfg.344.1601054272350;
 Fri, 25 Sep 2020 10:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200915073303.GA754106@T590> <20200915224541.GB38283@mit.edu>
 <20200915230941.GA791425@T590> <20200916202026.GC38283@mit.edu>
 <20200917022051.GA1004828@T590> <20200917143012.GF38283@mit.edu>
 <20200924005901.GB1806978@T590> <20200924143345.GD482521@mit.edu>
 <20200925011311.GJ482521@mit.edu> <20200925073145.GC2388140@T590> <20200925161918.GD2388140@T590>
In-Reply-To: <20200925161918.GD2388140@T590>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Sep 2020 10:17:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whAe_n6JDyu40A15vnWs5PTU0QYX6t6-TbNeefanau6MA@mail.gmail.com>
Message-ID: <CAHk-=whAe_n6JDyu40A15vnWs5PTU0QYX6t6-TbNeefanau6MA@mail.gmail.com>
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 25, 2020 at 9:19 AM Ming Lei <ming.lei@redhat.com> wrote:
>
> git bisect shows the first bad commit:
>
>         [10befea91b61c4e2c2d1df06a2e978d182fcf792] mm: memcg/slab: use a single set of
>                 kmem_caches for all allocations
>
> And I have double checked that the above commit is really the first bad
> commit for the list corruption issue of 'list_del corruption, ffffe1c241b00408->next
> is LIST_POISON1 (dead000000000100)',

Thet commit doesn't revert cleanly, but I think that's purely because
we'd also need to revert

  849504809f86 ("mm: memcg/slab: remove unused argument by charge_slab_page()")
  74d555bed5d0 ("mm: slab: rename (un)charge_slab_page() to
(un)account_slab_page()")

too.

Can you verify that a

    git revert 74d555bed5d0 849504809f86 10befea91b61

on top of current -git makes things work for you again?

I'm going to do an rc8 this release simply because we have another VM
issue that I hope to get fixed - but there we know what the problem
and the fix _is_, it just needs some care.

So if Roman (or somebody else) can see what's wrong and we can fix
this quickly, we don't need to go down the revert path, but ..

                  Linus
