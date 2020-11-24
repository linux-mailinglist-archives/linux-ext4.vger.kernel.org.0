Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053322C34B0
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Nov 2020 00:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388761AbgKXXbs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Nov 2020 18:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388294AbgKXXbs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Nov 2020 18:31:48 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1BEC0613D6
        for <linux-ext4@vger.kernel.org>; Tue, 24 Nov 2020 15:31:47 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id y10so305444ljc.7
        for <linux-ext4@vger.kernel.org>; Tue, 24 Nov 2020 15:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZpDzZfRGW5JQ+z/SLaL70l0Y+Id271dyPmoJFXV3Yg=;
        b=eMtd8miSV5Q4HzVm9lx1snZ252JU2LUG08CXEG9MZekZ6i7RMmkka/lMY+IPVuJ23L
         PqhYtLLZg6ffJmiv3yaDYTznuv3dIQ4YBw1pOJz9r2vKjiack1bfddd/lir5cfbryUH+
         /Jt2/UYsF/gTRVYdgZmuNAbHMgKvTDtyzGHaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZpDzZfRGW5JQ+z/SLaL70l0Y+Id271dyPmoJFXV3Yg=;
        b=oBOWYgB8h6HH8Gs4RKNmjq0ngrR8aQHdM8Lf3dMmJ5uNw6REYSnOwxcmmFTxGw3Y9i
         UO88FY571rZ3zdNCMIQ6/Ktjn+KeBVWeHje5iUj1BU5NgMrk7pC4/H/Zs7zIRMBVs18B
         Rr4k+P29RxXjN7RnH7WiNfKMEVsLl69aCKNGq/phS5AKJppfErBJ5jPWE+PkL5Jr1gfm
         x1j+ZrrPFiCXktMN3ucR5XB8R+LxH//G3x8pZ4Byrg1X64E31dyvjQXjnZk2TON3BKyt
         +WZEM3vu41PyG6SqijzaKwMypAyZN1Befl2ObT7cZiIt7b2yzeNyujbH3G5EjVD9i+wQ
         ZFZw==
X-Gm-Message-State: AOAM533MhhuxbWriIYvA2tTg8E+1kLRYe0QgVC0sq1OAA+LGFibO2wq3
        tZyJt24D4InOGI5uFWCG3XSq6Z6USeDH5A==
X-Google-Smtp-Source: ABdhPJyETX8R10+tFAsNSph7UgtsDqtbaAS1IK+7KgBuHibDKGGY5eAM9qsPsMJOyXyI6ZB0+vrkzg==
X-Received: by 2002:a2e:b4d0:: with SMTP id r16mr244564ljm.24.1606260705994;
        Tue, 24 Nov 2020 15:31:45 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id l18sm53000ljj.60.2020.11.24.15.31.45
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 15:31:45 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id d17so494305lfq.10
        for <linux-ext4@vger.kernel.org>; Tue, 24 Nov 2020 15:31:45 -0800 (PST)
X-Received: by 2002:a19:ed0f:: with SMTP id y15mr172684lfy.352.1606260312243;
 Tue, 24 Nov 2020 15:25:12 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d3a33205add2f7b2@google.com> <20200828100755.GG7072@quack2.suse.cz>
 <20200831100340.GA26519@quack2.suse.cz> <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
 <alpine.LSU.2.11.2011231928140.4305@eggly.anvils> <20201124121912.GZ4327@casper.infradead.org>
 <alpine.LSU.2.11.2011240810470.1029@eggly.anvils> <20201124183351.GD4327@casper.infradead.org>
 <CAHk-=wjtGAUP5fydxR8iWbzB65p2XvM0BrHE=PkPLQcJ=kq_8A@mail.gmail.com>
 <20201124201552.GE4327@casper.infradead.org> <CAHk-=wj9n5y7pu=SVVGwd5-FbjMGS6uoFU4RpzVLbuOfwBifUA@mail.gmail.com>
 <alpine.LSU.2.11.2011241322540.1777@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2011241322540.1777@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Nov 2020 15:24:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjiVtroOvNkuptH0GofVUvOMw4wmmaXdnGPPT8y8+MbyQ@mail.gmail.com>
Message-ID: <CAHk-=wjiVtroOvNkuptH0GofVUvOMw4wmmaXdnGPPT8y8+MbyQ@mail.gmail.com>
Subject: Re: kernel BUG at fs/ext4/inode.c:LINE!
To:     Hugh Dickins <hughd@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        syzbot <syzbot+3622cea378100f45d59f@syzkaller.appspotmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Linux-MM <linux-mm@kvack.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>, Qian Cai <cai@lca.pw>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 24, 2020 at 1:47 PM Hugh Dickins <hughd@google.com> wrote:
>
> I think the unreferenced struct page asks for trouble.

I do agree.

I've applied your second patch (the smaller one that just takes a ref
around the critical section). If somebody comes up with some great
alternative, we can always revisit this.

            Linus
