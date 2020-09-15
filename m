Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89350269A8F
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Sep 2020 02:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgIOAms (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Sep 2020 20:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIOAmj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Sep 2020 20:42:39 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C4AC06174A
        for <linux-ext4@vger.kernel.org>; Mon, 14 Sep 2020 17:42:38 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y4so1239225ljk.8
        for <linux-ext4@vger.kernel.org>; Mon, 14 Sep 2020 17:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATHwcW6LeBolsSmQRf1n5otymPUivLo7weJoK55YMQ0=;
        b=L3jP3fpL6qkMWaIPqY0+H0/1FuyKQ5yoyw7GLTjvRKty6/6v5NPUTny/UzVB/w8OCr
         4/YCnPjjsk3j6dbhCaPM4zMVOcd/psYkveNin6exfkrrGCbtWAXZuJDTY8J8ZNCLNrFu
         zZQqxFq9o9G4oplkuVIEvbo3TJLnbu6GPeteM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATHwcW6LeBolsSmQRf1n5otymPUivLo7weJoK55YMQ0=;
        b=lmokEbeD8s3FZcKmarj71AFsCmrRdgCw6ikIajWUco9S4XdCRTGljtmpD9Z+BtNNit
         9/IwK4itH7oQ6exMnhwQqB1MeAlVEsXvKbSXYLwgJAVtSPHp3849XQ0Vsaa4WvmZqL4W
         xUnpCaqzPU3gXB83fXukIkEegJTmOq3Mh5BXeG/tTN/KW+nfdebLdQ0FjXjvGAw/mC+/
         la7p4tfbPWL3uyHS2puCHKoDikvRd5gfPqYExBAF9hWwSsSe5u+PkMsAj6gWoo5QrXIA
         VIUGai5eYObbtoXZupOexEar1bL2oEh5tfHp0hAHTfNvF+x2vKGTJVTc0rKPCvImySzF
         kGQA==
X-Gm-Message-State: AOAM5308e39jVIfp9UwbEr6p9NckbbXlppmypUGI4GiHCNEM74KIYFzm
        oUtc0G2ulPtLpZBWvAm8BgMywEpH+lmBcw==
X-Google-Smtp-Source: ABdhPJxKi6w7n8NVyRNVpAAspTK5tmyO1N8zrHktUs/GVC3VKQjiLHWxf9LbXlcNIdaefUFJHcgn0g==
X-Received: by 2002:a2e:a202:: with SMTP id h2mr6401377ljm.282.1600130556722;
        Mon, 14 Sep 2020 17:42:36 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 201sm4307293ljf.75.2020.09.14.17.42.34
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 17:42:35 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id x77so1275746lfa.0
        for <linux-ext4@vger.kernel.org>; Mon, 14 Sep 2020 17:42:34 -0700 (PDT)
X-Received: by 2002:ac2:5594:: with SMTP id v20mr5487901lfg.344.1600130554524;
 Mon, 14 Sep 2020 17:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com> <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com> <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com> <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <c560a38d-8313-51fb-b1ec-e904bd8836bc@tessares.net> <CAHk-=wgZEUoiGoKh92stUh3sBA-7D24i6XqQN2UMm3u4=XkQkg@mail.gmail.com>
In-Reply-To: <CAHk-=wgZEUoiGoKh92stUh3sBA-7D24i6XqQN2UMm3u4=XkQkg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Sep 2020 17:42:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsUtTRWT6kXxw6f2xpS4W=7iO6k2rJfhpLa6yFZ-b_1w@mail.gmail.com>
Message-ID: <CAHk-=wgsUtTRWT6kXxw6f2xpS4W=7iO6k2rJfhpLa6yFZ-b_1w@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 14, 2020 at 1:53 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> One way I can see that happening (with the fair page locking) is to do
> something like this

Note that the "lock_page()" cases in that deadlock example sequence of
mine is not necessarily at all an explicit lock_page(). It is more
likely to be something that indirectly causes it - like a user access
that faults in the page and causes lock_page() as part of that.

                    Linus
