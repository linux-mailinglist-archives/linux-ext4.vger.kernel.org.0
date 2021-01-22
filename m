Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4359300DD1
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jan 2021 21:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbhAVUfa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jan 2021 15:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbhAVUdl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jan 2021 15:33:41 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE468C0613D6;
        Fri, 22 Jan 2021 12:33:00 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id d81so13858713iof.3;
        Fri, 22 Jan 2021 12:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2BF/+WC1bYp0JjVV6KmxdUfvQ/+TryiQiWRjN6NPCsg=;
        b=a4Rqc5gNXuqXv3OZEdcHe5M5XEF4OPKXq4GWyXZJoyk5kpZXdyTql7wlpohSYpe24k
         B7/M3v1xmcZPyYarCeKbEc+R/cwbgV2zLjRnwXsyOSGL/7JQk59YwZD4TOttBbSll0bL
         CWSUyUy98as3tyKxDWrR8trmkgZ/1jnK8yzjU6Guo5I/OGLR9zVItOhYtQpL2GreZa79
         JqjjbLUGF41DR+VqjVeYWQdkUBL4ZxvcsWAK0Fvc5C78RtLlZpasKg4mZRzsxdXpV5F2
         dmBha86UwJcppPaxx7JZfb3lqUlNYhQxt8cLqsBYSDahbLHYbYZLdMVFsBgRnxmd4OmA
         7NvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2BF/+WC1bYp0JjVV6KmxdUfvQ/+TryiQiWRjN6NPCsg=;
        b=TEwbPxIc0rkuvH5Q2XUnJxM5GkbYzzQCoZNMBt/N7gFvBP1nH7a22HRkYcxHBYJBrG
         O4X/gQPaDcnVuMm1T2ZReYMVDn+3EfLaKBGBzRb8U/WzTfVkM0YXM116pSNkRQsMMorh
         yuFk6h6clmPFSEGwbTkwtpjDZ4qnljh29XA0C1M5bjHSBFK92QSjZ9xaGaWpO4LutS8v
         yGKbxQW+OqwIisfdZqJixy9TM37UipceBppT82c1YdmCXf5vI2jQMQao2LKz5GvAO0o+
         orwpGrDxYbyZSbDNaZjxa9al3c9KPMEzSHlScAS9tVi0rSoGB/llqGMPDTnW3CPKzZLh
         G+Kw==
X-Gm-Message-State: AOAM5332hFi1tDyBRA8oN2C1517S6knveD8qsoBXzI4QsZvV/9I+ZPN+
        bLErNTtyy8dH2cjgYAXn/vzRX6WJ38joGZ9SHZg=
X-Google-Smtp-Source: ABdhPJyYn8ObdOTN41iMF20fviR6EuLXOPVPOviwV3WyzBfkM/0Mh5zpPxagnsV4Tfv+edbVaCfrDAKEaxJSbTDb0rI=
X-Received: by 2002:a5d:938f:: with SMTP id c15mr3006042iol.72.1611347580230;
 Fri, 22 Jan 2021 12:33:00 -0800 (PST)
MIME-Version: 1.0
References: <20210105062857.3566-1-yangerkun@huawei.com> <X/+/3ui/TQ9LjtNZ@mit.edu>
 <CAOQ4uxh2V6LF_t8ZaAOr=CbDrY3A5d0qSR7XWVX8dStR9mME5w@mail.gmail.com>
 <CAJfpegsVYF2wCiMKfRUzS_MpH9UKPh8g7ucG6w9uOcQodAzRAQ@mail.gmail.com> <CAD+ocbyEyeAbH1vqKieK9ENmM5k3K-WF1jMuqAzRwPfPC2Np8A@mail.gmail.com>
In-Reply-To: <CAD+ocbyEyeAbH1vqKieK9ENmM5k3K-WF1jMuqAzRwPfPC2Np8A@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 22 Jan 2021 22:32:48 +0200
Message-ID: <CAOQ4uxiDk6t+pNwm31L6eoj5+kq1E8-oX1zL9HzQE4fMjPK4yQ@mail.gmail.com>
Subject: Re: [PATCH v3] ext4: fix bug for rename with RENAME_WHITEOUT
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Theodore Ts'o" <tytso@mit.edu>, yangerkun <yangerkun@huawei.com>,
        Ext4 <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, "zhangyi (F)" <yi.zhang@huawei.com>,
        lihaotian <lihaotian9@huawei.com>, lutianxiong@huawei.com,
        linfeilong <linfeilong@huawei.com>,
        fstests <fstests@vger.kernel.org>,
        Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jan 22, 2021 at 9:21 PM harshad shirwadkar
<harshadshirwadkar@gmail.com> wrote:
>
> Thanks Amir for pointing that out. Yes we are missing fast commit
> tracking in whiteout. I'll send out a fix for that.
>
> > But I must say it would have been very hard to catch missing ext4_fc_track_*
> > without specialized fs fuzzer such as the CrashMonkey generated tests.
>
> I agree, it's been on my to-do list to run CrashMonkey tests with fast
> commits. I'm curious what kind of CrashMonkey tests you ran that
> helped you catch this? Were you running Overlayfs on top of Ext4 with
> fast commits?
>

Neither. I just guessed RENAME_WHITEOUT might be missed as
developers are rarely aware of it.
I never ran CrashMonkey tests myself.
I found a few crash consistency bugs using xfstest generic/455.
I suggest that you run it with fast commits
and try using NUM_OPS and NUM_FILES larger than the test defaults
to let the test run for a longer time.

Thanks,
Amir.
