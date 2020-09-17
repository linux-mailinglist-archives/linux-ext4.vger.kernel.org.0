Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0D226E4E9
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Sep 2020 21:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgIQTCf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Sep 2020 15:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgIQTA3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Sep 2020 15:00:29 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E75C06174A
        for <linux-ext4@vger.kernel.org>; Thu, 17 Sep 2020 12:00:28 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b22so3327098lfs.13
        for <linux-ext4@vger.kernel.org>; Thu, 17 Sep 2020 12:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QaNy7skFdocpIi7yXUk0cvyZ61htoWtJGhoFEfuldNs=;
        b=NbAnzyB2Mzc30Bxhxt2G/fphVVd0HhTHio6XwB2c+aD3xh1gYYDxBMBwfzTwVjgO1y
         2U/0SPniX5eHV7f8q+a1tgEHnXXLTpFyJIRbU1hQyswRasCEIfdyPNwxrAhx/TtmWgNp
         D9gNAm/JHCes0tuZjojw2IFaa40CTEvGQa+Q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QaNy7skFdocpIi7yXUk0cvyZ61htoWtJGhoFEfuldNs=;
        b=KsNyWcMBsEsu/zsKhF/+dzot5J4iYvFvU40c/xKstYxd+aFkNJ6p23Jmdq2NgmXm5X
         L/ueAKoCpjA0lXbNkgn5wWt8339NQSl28bMDhbnqDEWAUxaYnwKM1+CIvNd5phBvkrVv
         bW9scFYmfXV7RO8+4aawXkLtlZ/xri0zgptI0BkJOBHgmYqkoacvMYbbZAb3vQwBVEbM
         IlpUyqTCepKyfSIAN9BpfDBiIRh+Oam80PwRj+CtJ1vCYOoci4Ll/ceB7t3oeqCEFA8A
         WHz/1spkvfEt6iMvykEDqibWl1ErHF3LjKCofpYKszE7+0RgbRyNLTyzDI5OmfunkQOH
         pG0w==
X-Gm-Message-State: AOAM533+fihJYkSpnjrwZzy2Nmkk7NVFzEPZ/LgEk9vVSozdEkKQYDyk
        QSMq13elQ7R9RJYyB8uNCNxYB3kbNEkZyQ==
X-Google-Smtp-Source: ABdhPJxwD/771qyuARTrpeAajjLJ/iTHCz98BxyjXFAXglv1LAAU1Fl5DmgPWHb/pQgunzfxlN6WTQ==
X-Received: by 2002:a19:7b14:: with SMTP id w20mr10556522lfc.563.1600369226729;
        Thu, 17 Sep 2020 12:00:26 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id c11sm84234lff.3.2020.09.17.12.00.25
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 12:00:25 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id y11so3365523lfl.5
        for <linux-ext4@vger.kernel.org>; Thu, 17 Sep 2020 12:00:25 -0700 (PDT)
X-Received: by 2002:ac2:5594:: with SMTP id v20mr10423309lfg.344.1600369225145;
 Thu, 17 Sep 2020 12:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com> <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <CAHk-=whc5CnTUWoeeCDj640Rng4nH8HdLsHgEdnz3NtPSRqqhQ@mail.gmail.com>
 <20200917182314.GU5449@casper.infradead.org> <CAHk-=wj6g2y2Z3cGzHBMoeLx-mfG0Md_2wMVwx=+g_e-xDNTbw@mail.gmail.com>
 <20200917185049.GV5449@casper.infradead.org>
In-Reply-To: <20200917185049.GV5449@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Sep 2020 12:00:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6Ha=cNU4kL3z661CV+c2x2=DKzPrfH=XujMa378NhWQ@mail.gmail.com>
Message-ID: <CAHk-=wj6Ha=cNU4kL3z661CV+c2x2=DKzPrfH=XujMa378NhWQ@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Amir Goldstein <amir73il@gmail.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 17, 2020 at 11:50 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> Ahh.  Here's a race this doesn't close:
>
> int truncate_inode_page(struct address_space *mapping, struct page *page)

I think this one currently depends on the page lock, doesn't it?

And I think the point would be to get rid of that dependency, and just
make the rule be that it's done with the i_mmap_rwsem held for
writing.

But it might be one of those cases where taking it for writing might
add way too much serialization and might not be acceptable.

Again, I do get the feeling that a spinlock would be much better here.
Generally the areas we want to protect are truly just the trivial
"check that mapping is valid". That's a spinlock kind of thing, not a
semaphore kind of thing.

Doing a blocking semaphore that might need to serialize IO with page
faulting for the whole mapping is horrible and completely
unacceptable. Truncation events might be rare, but they aren't unheard
of!

But doing a spinlock that does the same is likely a complete non-issue.

              Linus
