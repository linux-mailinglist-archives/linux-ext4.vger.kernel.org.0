Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C4F2C199E
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Nov 2020 00:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgKWXwo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 18:52:44 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:33870 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgKWXwn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Nov 2020 18:52:43 -0500
Received: from mail-wm1-f70.google.com ([209.85.128.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mauricio.oliveira@canonical.com>)
        id 1khLdR-0000w3-57
        for linux-ext4@vger.kernel.org; Mon, 23 Nov 2020 23:52:41 +0000
Received: by mail-wm1-f70.google.com with SMTP id o19so378089wme.2
        for <linux-ext4@vger.kernel.org>; Mon, 23 Nov 2020 15:52:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c64NyqTCnvrBK+xjUSShmTDrw5qordk6yMy8mqtfcwg=;
        b=Y2YaCYo6sOMHpRGI2l69xW7liAPxZSN/YxDnQFimV1fHdGv4qcRKFwidAqbaLuffO4
         2kPoy1QCZE3CbwbR6xFxXkbhqLMZwxcL/nvOei5yKGf8IwrcKqs5cqbEUSmNLOVbYJ3F
         xpvJVFB+cT4DfcqkHc8DCxRe/pLFY1EXz18Epz/i7kZvJC53ug6/qze7KEqC3uvISzWY
         LCLd7oA7Sf4ODAMX1lnDOfYuymKC6m9Ks++UvcktdLTmVPq/E/DrKCf37WAewMT3LtQn
         NbW7qXNuQq6famGJ8FsgVOnn7t/dzTMZjosZrlhgd2jy8In7EKQTbavQs2o/4g7jAQr+
         Bmxw==
X-Gm-Message-State: AOAM531Iv+MGZLDa0juzrRdZ9JIkdSYRQPNxAXNLWCRvCjfcUWJeg+mR
        5Ame2ErVMk5Z1FoS2+nTKrRpfWJIEyXI2m94lftAY4KYQyUW8tZhC3fQrGi4N2WbnJeyeaWVSQr
        745CdGouGyn1iwaJQ9rLUSUan7IeK8s+2xn0gb6gr5Ng5eMx4+J3qsnE=
X-Received: by 2002:adf:f146:: with SMTP id y6mr2137750wro.298.1606175560704;
        Mon, 23 Nov 2020 15:52:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpR2qQErFxzYP0vFxAFilT/+mAjE3jKoFnHyYszokfOJ5KgsOJoHUfpDrMWo21RH6WTavCagzQSOf6yInDaJw=
X-Received: by 2002:adf:f146:: with SMTP id y6mr2137738wro.298.1606175560517;
 Mon, 23 Nov 2020 15:52:40 -0800 (PST)
MIME-Version: 1.0
References: <20201027132751.29858-1-jack@suse.cz> <CAO9xwp0AtCLG77g6fWgu9un9XPD3d5U6ZtjWc3FRJrB8NK44SQ@mail.gmail.com>
 <CAO9xwp3sSjzy9W8pMjV6vYitfZ9BmZE-9bLwcLg1uz3CFBHUcQ@mail.gmail.com> <20201120181030.GF609857@mit.edu>
In-Reply-To: <20201120181030.GF609857@mit.edu>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Mon, 23 Nov 2020 20:52:29 -0300
Message-ID: <CAO9xwp1zQ6PD9u4sD-8Vbns8NNWG-x-8JodG-wwERjnct4_4wQ@mail.gmail.com>
Subject: Re: [PATCH] ext4: Fix mmap write protection for data=journal mode
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hey Ted,

On Fri, Nov 20, 2020 at 3:10 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> Mauricio,
>
> Thanks for your work in finding the corner cases for data=journal.  If

Thank you and Jan for your suggestions and guidance to fix them.

> you don't mind me asking, however --- what are the use cases for you
> where data=journal is the preferred mode for ext4?  There are a lot of
> advanced features for data=journal mode which don't work.  This
> includes things like dioread_nolock (now the default), delayed
> allocation, and other optimizations.
>
> It used to be that data=journal pretty nicely fell out of how ext4
> worked in "normally".  These days, data=journal is becoming more and
> more an exception case that requires special handling.  And to be
> honest, every so often there has been discussion about whether the
> maintenance overhead of data=journal has been worth keeping it.  So
> far, we just don't bother making data=journal work with things like
> delayed allocation, and one of ther reasons why we've kept it around
> is because it's a unique mode that none of the Linux file systems
> have.
>
> It would be useful, though, to understand what are the use cases where
> you (or your customers) are finding data=journal useful, so we can
> better optimize for their use case.  And if there are enough people
> who care about it --- and clearly, you've invested so much effort that
> you definitely fall into that category :-) --- then maybe there's a
> business case for investing more into data=journal and trying to make
> it something which is easier to maintain and can work with things like
> delayed allocation.
>

The main reason a customer used data=journal in some cases
is it provided them more consistency w/ data on power loss.

Specifically, it prevented some consistency check errors on
applications in which it's unfortunately not always possible
to request/guarantee that sync() is called (not ext4's fault.)

We've previously exposed the disadvantages with data=journal,
including the discussion about its future/maintenance upstream
and associated risks with less exposure/testing (eg, this bug! :)
in order to assist them with decision-making and maybe switching.

It seems that data=ordered with nodelalloc and a smaller commit=
interval could help them, but that's going on experiment stages.

So, it seems this use case is more about data integrity than features,
and data=journal does seem to help with that despite the applications.

Glad that ext4 still provides such mode; but it's understandable that
maintenance and features and special handling leads to the discussion
about no longer keeping it.

Thanks for reaching out to understand the use cases from users,
and being willing to consider that into development/maintenance.

There's also a few bits about it from Andreas in the v1 series [1].

Hope this helps!
Mauricio

[1] https://lore.kernel.org/linux-ext4/C9FEDED5-CDEE-449F-AE11-64BB56A42277@dilger.ca/

> Thanks,
>
>                                         - Ted



-- 
Mauricio Faria de Oliveira
