Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD192C4A4F
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Nov 2020 23:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732793AbgKYWBf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Nov 2020 17:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732790AbgKYWBf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Nov 2020 17:01:35 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2027EC0617A7
        for <linux-ext4@vger.kernel.org>; Wed, 25 Nov 2020 14:01:25 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id b17so33512ljf.12
        for <linux-ext4@vger.kernel.org>; Wed, 25 Nov 2020 14:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AHzxZjopdvwPb49v26gZFbNssQM0UPZ06yGo+z/tU6c=;
        b=K6cXzXGOWYp0YH8Ec/Cd6PHGW9EpUSbmb9ZLhiSPBPTgyeTuwWtAay+X+GE1FcohAq
         hcJeoMobg7GDcznqwyVEvp6b40v9HTHCqQ0yBJT4GDTt9n9UsIf+QJAhwPLCQk+aWHsg
         V4KTpIAvGlGRiVee5Cm69yvIVM2IWQyahDf98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AHzxZjopdvwPb49v26gZFbNssQM0UPZ06yGo+z/tU6c=;
        b=rZbC56IyVc6AwIy93QHpPlLJTGvuyc0fg6pfT6brYwJN2ljjogz8Bl6c/LTAXMTKT5
         b2N3qvvcpF5XsR0grZLcK9HqiHahLCVReYb3KP1fEBb/k3lSfKJiX1otDOZhT7MqEmjf
         N/gXKKnGlDWUTHGBIea+yvI3clVLhFhEgnFs/bQtteqmw9vGH6t+IG/c+iDMLGSQ2q4h
         PBVwBIUxYuetmR+T/eNRgMfpCZg1tjv0zXLTbZZ6Fii5LYYAHgjI6/meRXzsjPWFPAwZ
         D7HAER/xhWMdrq0g0VdMPDg9I5inPyH46eYJAOnhKtOMw1WKYQd4O6pld76/2a6WAbfG
         mbhw==
X-Gm-Message-State: AOAM530mJ2K8M/W7Upby4CMqCKdH5ELH1DKtIPeUImpOIeBLxTMIKCs1
        hz2PHFFAls7FBKCreNO7M3Mtwr16nyxDoA==
X-Google-Smtp-Source: ABdhPJztMswaEFYrIR7P8o1mQlVImfiYnXIB26mlnkCsz/Ddd6+uBGEpPKXYaCoROyQeyFYa64kcgQ==
X-Received: by 2002:a2e:985a:: with SMTP id e26mr49683ljj.157.1606341682004;
        Wed, 25 Nov 2020 14:01:22 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 15sm70575lfo.75.2020.11.25.14.01.19
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 14:01:20 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id d8so5291136lfa.1
        for <linux-ext4@vger.kernel.org>; Wed, 25 Nov 2020 14:01:19 -0800 (PST)
X-Received: by 2002:a19:ed0f:: with SMTP id y15mr92782lfy.352.1606341679142;
 Wed, 25 Nov 2020 14:01:19 -0800 (PST)
MIME-Version: 1.0
References: <000000000000d3a33205add2f7b2@google.com> <20200828100755.GG7072@quack2.suse.cz>
 <20200831100340.GA26519@quack2.suse.cz> <CAHk-=wivRS_1uy326sLqKuwerbL0APyKYKwa+vWVGsQg8sxhLw@mail.gmail.com>
 <alpine.LSU.2.11.2011231928140.4305@eggly.anvils> <20201124121912.GZ4327@casper.infradead.org>
 <alpine.LSU.2.11.2011240810470.1029@eggly.anvils> <20201124183351.GD4327@casper.infradead.org>
 <CAHk-=wjtGAUP5fydxR8iWbzB65p2XvM0BrHE=PkPLQcJ=kq_8A@mail.gmail.com>
 <20201124201552.GE4327@casper.infradead.org> <CAHk-=wj9n5y7pu=SVVGwd5-FbjMGS6uoFU4RpzVLbuOfwBifUA@mail.gmail.com>
 <alpine.LSU.2.11.2011241322540.1777@eggly.anvils> <CAHk-=wjiVtroOvNkuptH0GofVUvOMw4wmmaXdnGPPT8y8+MbyQ@mail.gmail.com>
 <CAHk-=wix0YNq1U8iroRLpx+fCUGE8RG3asY8Zm4vyH-g4UhbPg@mail.gmail.com>
In-Reply-To: <CAHk-=wix0YNq1U8iroRLpx+fCUGE8RG3asY8Zm4vyH-g4UhbPg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 Nov 2020 14:01:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiavm+uTti1SmuwvBQyu-0OC_6c3Y1v7kpunmPnjVRsSQ@mail.gmail.com>
Message-ID: <CAHk-=wiavm+uTti1SmuwvBQyu-0OC_6c3Y1v7kpunmPnjVRsSQ@mail.gmail.com>
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

On Wed, Nov 25, 2020 at 1:30 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm not sure I'm willing to write and test the real patch, but it
> doesn't look _too_ nasty from just looking at the code. The bookmark
> thing makes it important to only actually clear the bit at the end (as
> does the handoff case anyway), but the way wake_up_page_bit() is
> written, that's actually very straightforward - just after the
> while-loop. That's when we've woken up everybody.

Actually, there's a problem. We don't know if we've done the hand-off
or not, so we don't know if we should clear the bit after waking
everybody up or not.

We set that WQ_FLAG_DONE bit for the hand-0off case, but only the
woken party sees that - the waker itself doesn't know about it (and we
have no good way to return it in that call chain: wake_up_page_bit ->
__wake_up_locked_key_bookmark -> __wake_up_common ->
wake_page_function().

We could easily hide the flag in the "bookmark" wait queue entry, but
that smells a bit hacky to me.

So I don't think it's worth it, unless somebody really wants to give it a try.

But if it turns out that the page ref change from Hugh causes some
unexpected problem, we do have this model as a backup.

            Linus
