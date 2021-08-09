Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4B03E499F
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Aug 2021 18:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhHIQVI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Aug 2021 12:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbhHIQTd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Aug 2021 12:19:33 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C02C0613D3
        for <linux-ext4@vger.kernel.org>; Mon,  9 Aug 2021 09:19:00 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id cf5so25452637edb.2
        for <linux-ext4@vger.kernel.org>; Mon, 09 Aug 2021 09:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d3PYvLEv+sU2zhd0L15SpWaRodeiHTy+UoMA6DwtR3I=;
        b=VMD5ZTSfJCZnXxnwd6ru2jBt4S8hspI2L6OaT00igRa1RiV01peD17ag9t/sfyfc47
         pdtZg7sCDI2M4rroIgia6669WL1dO4BUntl2T+Jo6gLPb6qTOOF1LTabrXd8JKTcMrlM
         5HGzMB8oaoH43sAIIDWCdOubtjipRx6Xmlpxi/vjavrkKKp+Ukm+vjuRGTejwIyF8Ie+
         BGSR5zeL+Ffnp1uebUi7n8H2tLOcuOVofOYbsGNfDWqhSVSeh2rkmW9ieOlmkRYeeQw6
         dD1VTkZuDqSQTZFRJJ+iLjEsISnYs2kUdEMKZAs6BPpilEZXjPL5F6L9a4vKIqBXs+xo
         PC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d3PYvLEv+sU2zhd0L15SpWaRodeiHTy+UoMA6DwtR3I=;
        b=nLVjbt3MKuHRwxPlcOlqcJApLnbUJEqV6DKh3eZmgvtVnwXR0we8lN2qFLgj5nPUFH
         U7UGl018SKwu3D0ZaE9XTBXCJGWDOXveKxyNuu7YnpIlZzPnYwaVVYpr2aMUYsZsK9Ht
         hvqtX/pVp7ahgUDJiEkjEb992YJ8xIH5pQE4BgVCXWvQh4PTG0baubAu3c+R7CL+OwZF
         7RLoDdaZ7y+6exKThUmWaeVk5sBKqj0yIXhCkaRnXDtq1F1mxzYJGg9Zw0AlZIzbOM0w
         lH/L4RUTQnZExgZ4T+2GFpyyCDlCBpRSUhga40o/DTFzMmenFpQ5z719fIB1FaDYcSXT
         IbZw==
X-Gm-Message-State: AOAM530ylZ9Xij0VKpSew/JKPOnwwNAX/TnkK6t9/lwpsqP6fJfcQ736
        1Swt8lpOpJ1AIQ0EGXmY6dE8lRLverQPt9l9uT9m0AgoFDk=
X-Google-Smtp-Source: ABdhPJz+CRzBag5YtR5zHJF41MaBxo7kcCgmOHLUVW/onzB9PVtGOKaRAFgwb2isYLoSNupMkMEr335zjzYNnsgE14w=
X-Received: by 2002:a05:6402:3588:: with SMTP id y8mr30475855edc.362.1628525938878;
 Mon, 09 Aug 2021 09:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <015c7506-7f33-3967-772a-1285b0f1052f@valdikss.org.ru>
 <YRCKG1V/OBuble40@mit.edu> <c984528b-03ce-f9e5-2cf2-4ae92e812367@valdikss.org.ru>
In-Reply-To: <c984528b-03ce-f9e5-2cf2-4ae92e812367@valdikss.org.ru>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 9 Aug 2021 09:18:47 -0700
Message-ID: <CAD+ocbzuKDhXJpGD6utTyZqVzFV4BSA4GXmvKO6OjRf3F0FWTw@mail.gmail.com>
Subject: Re: ext4lazyinit reads HDD data on mount since 5.13
To:     ValdikSS <iam@valdikss.org.ru>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 9, 2021 at 2:51 AM ValdikSS <iam@valdikss.org.ru> wrote:
>
> On 09.08.2021 04:51, Theodore Ts'o wrote:
> > It's a new feature which optimizes block allocations for very large
> > file systems.  The work being done by ext4lazyinit is to read the
> > block allocation bitmaps so we can cache the buddy bitmaps and how
> > fragmented (or not) various block groups are, which is used to
> > optimize the block allocator.
>
> Thanks for the info. To revert old behavior, the filesystem should be
> mounted with -o no_prefetch_block_bitmaps
>
> Is it safe to use this option with new optimizations? Should I expect
> only less optimal filesystem speed and no other issues?
It is perfectly safe to use "no_prefetch_block_bitmaps" with new
optimizations. In fact file system throughput also will NOT be
affected if you mount the file system with this option. The only
impact of mounting with this mount option would be that the file
system can potentially make sub-optimal decisions for allocation
requests in certain scenarios. For example, let's say the allocator
gets a request to allocate 10 contiguous blocks and only the last
group in the file system has 10 contiguous blocks. If you mount the
file system with "no_prefetch_block_bitmaps", Ext4 will not have
cached the last group's buddy bitmap because of which it might not
know that the last group has 10 contiguous blocks available. At this
point, Ext4 will satisfy the request for 10 blocks by allocating
fragments instead of allocating a contiguous region. This might
increase the fragmentation levels of the file system. However, note
that this is not a regression. If you were not using
"prefetch_block_bitmaps" before 5.13, then this is the allocator
behavior that you would have seen anyway. So, mounting with
"no_prefetch_block_bitmaps" in your setup, would not cause any
regressions whatsoever.

Thanks,
Harshad
