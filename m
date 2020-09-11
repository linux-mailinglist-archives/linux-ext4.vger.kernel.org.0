Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81812675B3
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Sep 2020 00:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgIKWIT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Sep 2020 18:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgIKWIQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Sep 2020 18:08:16 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB930C061573
        for <linux-ext4@vger.kernel.org>; Fri, 11 Sep 2020 15:08:15 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k25so13710671ljk.0
        for <linux-ext4@vger.kernel.org>; Fri, 11 Sep 2020 15:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qu6MCfDlRYKxrR/vfuTQ50/WJTKiqfQQnOD9pL2C3tM=;
        b=DA6pe19QlEr23vCJmTAgseMe6w22nNKZ4BE6V0AyyMJf/C2KiQQqsIvb1uSxjpnciV
         wxltQPgqamMX2mIuBJjpX6vSnfhJ/1thqjuoxtJnoO8f/HrxQIVuHr3PdldR6ZvErGHl
         G9Jdr67GlxhX9Vis56S+vXWLLtvZpAMIaTJn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qu6MCfDlRYKxrR/vfuTQ50/WJTKiqfQQnOD9pL2C3tM=;
        b=r05idGOXPElqmeRf6gY9WeQO/f3ZnJrVAEwAql4oPAzf6wntDDsJ5HpjGyMc6f4gXQ
         ioSMZTS42t6BxjyWctw5TufShR5mx8SwQ1eMVm9vEpcqBQHYwHxThzB/eWclESfW7A7J
         ekhU4pHVQQBIx3S/hyc0EkW9c57XYkLnAvgFnrqry9PJJZ3T0ctiIXpCC2LdxFxPBOWf
         cVHOZImlmSLr+PcmAlw0nP8GyDRypEeC97oK7YfQi+Ur2LB8NKB3wmlj1Wv4L9TAA/TH
         wGEHVxr8lQQR1Tzx68JiUGHhs4tOMMae4F3KeatxNMUUqG35NGhz840VrZBiKkg6fwEL
         x9Ag==
X-Gm-Message-State: AOAM533QyKTBuGTgRAqNCBo7ByLTlzYVNegMPoLGvO7ok247WK2LznmU
        71kmPHnRm746QzR9FlAWFRrTHp8/Y0bhxQ==
X-Google-Smtp-Source: ABdhPJwwg/wNV2eoMlCSzG6TOVyrykWFmQzhdsUCEVv/zJWakUaD4XfQgQ+VzZsXs0zYDH+YGRH1dw==
X-Received: by 2002:a2e:8e30:: with SMTP id r16mr1630872ljk.304.1599862093422;
        Fri, 11 Sep 2020 15:08:13 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id x17sm237152lfa.303.2020.09.11.15.08.12
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 15:08:12 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id u4so13661092ljd.10
        for <linux-ext4@vger.kernel.org>; Fri, 11 Sep 2020 15:08:12 -0700 (PDT)
X-Received: by 2002:a05:651c:514:: with SMTP id o20mr1607752ljp.312.1599862091757;
 Fri, 11 Sep 2020 15:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiZnE409WkTOG6fbF_eV1LgrHBvMtyKkpTqM9zT5hpf9A@mail.gmail.com>
 <CAHk-=wj+Qj=wXByMrAx3T8jmw=soUetioRrbz6dQaECx+zjMtg@mail.gmail.com>
 <CAHk-=wgOPjbJsj-LeLc-JMx9Sz9DjGF66Q+jQFJROt9X9utdBg@mail.gmail.com>
 <CAHk-=wjjK7PTnDZNi039yBxSHtAqusFoRrZzgMNTiYkJYdNopw@mail.gmail.com>
 <aa90f272-1186-f9e1-8fdb-eefd332fdae8@MichaelLarabel.com> <CAHk-=wh_31_XBNHbdF7EUJceLpEpwRxVF+_1TONzyBUym6Pw4w@mail.gmail.com>
 <e24ef34d-7b1d-dd99-082d-28ca285a79ff@MichaelLarabel.com> <CAHk-=wgEE4GuNjcRaaAvaS97tW+239-+tjcPjTq2FGhEuM8HYg@mail.gmail.com>
 <6e1d8740-2594-c58b-ff02-a04df453d53c@MichaelLarabel.com> <CAHk-=wgJ3-cEkU-5zXFPvRCHKkCCuKxVauYWGphjePEhJJgtgQ@mail.gmail.com>
 <d2023f4c-ef14-b877-b5bb-e4f8af332abc@MichaelLarabel.com> <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com> <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com> <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
In-Reply-To: <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Sep 2020 15:07:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
Message-ID: <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Michael Larabel <Michael@michaellarabel.com>
Cc:     "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 11, 2020 at 9:19 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok, it's probably simply that fairness is really bad for performance
> here in general, and that special case is just that - a special case,
> not the main issue.

Ahh. It turns out that I should have looked more at the fault path
after all. It was higher up in the profile, but I ignored it because I
found that lock-unlock-lock pattern lower down.

The main contention point is actually filemap_fault(). Your apache
test accesses the 'test.html' file that is mmap'ed into memory, and
all the threads hammer on that one single file concurrently and that
seems to be the main page lock contention.

Which is really sad - the page lock there isn't really all that
interesting, and the normal "read()" path doesn't even take it. But
faulting the page in does so because the page will have a long-term
existence in the page tables, and so there's a worry about racing with
truncate.

Interesting, but also very annoying.

Anyway, I don't have a solution for it, but thought I'd let you know
that I'm still looking at this.

                Linus
