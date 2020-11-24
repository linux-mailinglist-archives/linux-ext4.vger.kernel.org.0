Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EFE2C1CBB
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Nov 2020 05:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgKXEd0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 23:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbgKXEdZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Nov 2020 23:33:25 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62211C0613CF
        for <linux-ext4@vger.kernel.org>; Mon, 23 Nov 2020 20:33:25 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d17so26952135lfq.10
        for <linux-ext4@vger.kernel.org>; Mon, 23 Nov 2020 20:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=24cszGpR4ywO4s4bnLwJTzF6tXtNEZ3Sx4FvfUI5fRM=;
        b=Qo/w8pRweB3KyHg3F/WpjXkumwlz+D/AvIsfhGajTbc5rxWuFX6axMRr2JB4kSL4pA
         hIBC4OqrP3RwB25oHrD6ZaKBqVFGtNoYL6Y4nSMoCfYeCeQOINqE3jTOyTbnWeWoHLiI
         UkFQ9R+vhIKbEe6WKzj2zXtFUjc557jUOVygU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24cszGpR4ywO4s4bnLwJTzF6tXtNEZ3Sx4FvfUI5fRM=;
        b=UIAKno/IV4Znas/RKYdyl1GwbqQgYWHn1bwOLKD0hbijdwkHkPd0RNhaV5QxlybVZw
         mxUt+AGKp69vK3+HiGHePLBMRUPuK5D8VzmdJWaR9dcyks6tzFuqKU9GGgw4nsQvxw3L
         rV8mVj6Fon/8j2V9Q1io7DAoPNtRRypjrsmsqNpYPThbOX3+KkZllKnsp2rJDoXCyopH
         DF63MZgFvq8Ab+nRgAIix+Y76dGwAqJvHq2nqBnkB7GRfPxnrHuYCZE08+2mRClqEVo+
         m/NMnaGy7ZiKqaQHVA5GeNu1DhKPLDBCIEkGXAhziG5+5Y984TYv/wAURWUw6lUIz1Du
         9MGg==
X-Gm-Message-State: AOAM532kucA9F29zQplJgBLSTRaq0iEPUTG1dqcy2UnOkvQLCwX3zcQh
        aaBwljhnIvItZ0+UpdvQpMIyka+Ng2nRsA==
X-Google-Smtp-Source: ABdhPJycPVFHuw0J9pgftfZRT8Hfz2b1+nyYEC3qVICGTvH5n0gHgsXyGHvqIOeFo9HKCoyOmmkbrg==
X-Received: by 2002:a19:ccd5:: with SMTP id c204mr1005477lfg.469.1606192403619;
        Mon, 23 Nov 2020 20:33:23 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id f27sm547074lfq.188.2020.11.23.20.33.23
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 20:33:23 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id r18so5731725ljc.2
        for <linux-ext4@vger.kernel.org>; Mon, 23 Nov 2020 20:33:23 -0800 (PST)
X-Received: by 2002:a19:3f55:: with SMTP id m82mr1019862lfa.344.1606192024162;
 Mon, 23 Nov 2020 20:27:04 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d3a33205add2f7b2@google.com> <20200828100755.GG7072@quack2.suse.cz>
 <20200831100340.GA26519@quack2.suse.cz> <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
 <alpine.LSU.2.11.2011231928140.4305@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2011231928140.4305@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Nov 2020 20:26:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjcSFM+aqLnh7ucx3_tHpc1+9sJ+FfhSgVFH316uX2FZQ@mail.gmail.com>
Message-ID: <CAHk-=wjcSFM+aqLnh7ucx3_tHpc1+9sJ+FfhSgVFH316uX2FZQ@mail.gmail.com>
Subject: Re: kernel BUG at fs/ext4/inode.c:LINE!
To:     Hugh Dickins <hughd@google.com>
Cc:     Jan Kara <jack@suse.cz>,
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
        Matthew Wilcox <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 23, 2020 at 8:07 PM Hugh Dickins <hughd@google.com> wrote:
>
> The problem is that PageWriteback is not accompanied by a page reference
> (as the NOTE at the end of test_clear_page_writeback() acknowledges): as
> soon as TestClearPageWriteback has been done, that page could be removed
> from page cache, freed, and reused for something else by the time that
> wake_up_page() is reached.

Ugh.

Would it be possible to instead just make PageWriteback take the ref?

I don't hate your patch per se, but looking at that long explanation,
and looking at the gyrations end_page_writeback() does, I go "why
don't we do that?"

IOW, why couldn't we just make the __test_set_page_writeback()
increment the page count if the writeback flag wasn't already set, and
then make the end_page_writeback() do a put_page() after it all?

            Linus
