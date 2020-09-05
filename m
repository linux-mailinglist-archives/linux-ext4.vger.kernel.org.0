Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B2425E922
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Sep 2020 18:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgIEQsU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 5 Sep 2020 12:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbgIEQsP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 5 Sep 2020 12:48:15 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F80C061244
        for <linux-ext4@vger.kernel.org>; Sat,  5 Sep 2020 09:48:14 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n25so506982ljj.4
        for <linux-ext4@vger.kernel.org>; Sat, 05 Sep 2020 09:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WiPzQYToprkedvPvy23+d8Sogck/PPDXaDM0aINUTxs=;
        b=IbD/06LcWNINiD1qQx76yuC4NnGDIsm3+GWIOtgRCjshaVtDI/A02DI5qKetncQ5Eq
         ETJ/AP0MURo4tMxU2BWA9ZqY9wz8byBe5Nb/ZFb/npAfuJhH/nO2eJvqX1EnmPNcLt9a
         /DIWjA8HitbuHHT5Zgo8zabEuZouEGY3xlN9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WiPzQYToprkedvPvy23+d8Sogck/PPDXaDM0aINUTxs=;
        b=HTHdUXkzonzyqZk4Q8lIBIgrmRgmT+T7sw3PvPZZ/dMCk+hrXZ4hkNpDM2+Oyc3ur6
         T7toe7WJNMAiBLKMMpblobdlpPBSD4yoDfee+LhZ1OhywiC49pIvdQ3npJkGBwPiQD+w
         Lnsrq2/d2BTsuj9PSXIW0QC5TEiospibutaPBhbq6KOcyPt0IV9Em+5YoAB+Jea2feNa
         RxDVZkVYMfZgZT8bI4FJaC0LHR/207hEZP/yyEFSRG7TJ1yQlINMHwNkeLY0PtML+bN9
         v/jBmoabu9Isd4/rJPaed/Ad62KWIX3/dJWvbC+1NoElP+6+CDWdxS3XydLV0MHigZ+6
         m+GQ==
X-Gm-Message-State: AOAM530iUIlZ3GSnG/zfN5z3RsyB6Ap/C4dy5yfDm+ZbXQ7CSl3FOpql
        ERQPbYJEepZp/Cl4wYU7d4R6YEJfQk999w==
X-Google-Smtp-Source: ABdhPJwrWWRFdsFIolk62SNiZW2i1xHswE/3F54iTelESQmCTLYU93jlHQQoINOa3KNbRSiqYhOzXQ==
X-Received: by 2002:a05:651c:32b:: with SMTP id b11mr923175ljp.99.1599324492101;
        Sat, 05 Sep 2020 09:48:12 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id i12sm2545188lfi.48.2020.09.05.09.48.09
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2020 09:48:10 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id y17so5446867lfa.8
        for <linux-ext4@vger.kernel.org>; Sat, 05 Sep 2020 09:48:09 -0700 (PDT)
X-Received: by 2002:a19:c8c6:: with SMTP id y189mr6480035lff.125.1599324489251;
 Sat, 05 Sep 2020 09:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009041200570.27312@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009050805250.12419@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009050812060.12419@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2009050812060.12419@file01.intranet.prod.int.rdu2.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Sep 2020 09:47:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=0V27kdRkBAOkCDXSeFYmB=VzC0hMQVbmaiFV_1ZaCA@mail.gmail.com>
Message-ID: <CAHk-=wh=0V27kdRkBAOkCDXSeFYmB=VzC0hMQVbmaiFV_1ZaCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] xfs: don't update mtime on COW faults
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Sep 5, 2020 at 5:13 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
> When running in a dax mode, if the user maps a page with MAP_PRIVATE and
> PROT_WRITE, the xfs filesystem would incorrectly update ctime and mtime
> when the user hits a COW fault.

So your patch is obviously correct,  but at the same time I look at
the (buggy) ext2/xfs code you fixed, and I go "well, that was a really
natural mistake to make".

So I get the feeling that "yes, this was an ext2 and xfs bug, but we
kind of set those filesystems up to fail".

Could this possibly have been avoided by having nicer interfaces?

Grepping around, and doing a bit of "git blame", I note that ext4 used
to have this exact same bug too, but it was fixed three years ago in
commit fd96b8da68d3 ("ext4: fix fault handling when mounted with -o
dax,ro") and nobody at the time clearly realized it might be a
pattern.

And honestly, it's possible that the pattern came from cut-and-paste
errors, but it's equally likely that the pattern was there simply
because it was such a natural pattern and such an easy and natural
mistake to make.

Maybe it's inevitable. Some people do want (and need) the information
whether it was a write just because they care about the page table
issues (ie marking the pte dirty etc). To that kind of situation,
whether it's shared or not might not matter all that much. But to a
filesystem, a private write vs a shared write are quite different
things.

So I don't really have any suggestions, and maybe it's just what it
is, but maybe somebody has an idea for how to make it slightly less
natural to make this mistake..

But maybe just a test-case is all it takes, like Darrick suggests.

                  Linus
