Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365703281F9
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Mar 2021 16:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236958AbhCAPN7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Mar 2021 10:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236962AbhCAPNV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Mar 2021 10:13:21 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C467C06178B
        for <linux-ext4@vger.kernel.org>; Mon,  1 Mar 2021 07:12:40 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e2so14929027ilu.0
        for <linux-ext4@vger.kernel.org>; Mon, 01 Mar 2021 07:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ImBj1pMOmvUEX/iwx/8PVH76K5ZWCjQ7qaa76m84U8E=;
        b=Q0u20hbCLy1eMbvZVEGdefF/Nc4XnF6NMeSedleAEZ460TjvHLa8Xdbfzb6bmEFiIM
         MLP8Pl+/5Efg7DjPw2woC9w/6uavkyJ96tKqfxXnO0ey7o5wuaKIxjXVBGN4nmGgRylh
         wZsv5PzoRHWsGY4iZVdpob5B7Tu2hT1J73NtAQWXX3i+QkDCTtt7ES9d5dy24tBYGVaU
         7fjwmMZu2nnb8wmseciMRntSIgO26kx++8DQ1H2ocWvr95OZC5OJXtmKEeAzzUJrbSJ5
         I75zqiSy+mhYmfCQ1kUvCfKsV7AAiVTQ+U5QJTGS0onFdhJ9qZQRXYOA+tm8jVshckxx
         +6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ImBj1pMOmvUEX/iwx/8PVH76K5ZWCjQ7qaa76m84U8E=;
        b=aB/XB0v82GLkJoZAfKvpn3OO057y/0h9LAhXGXwCSJFFQhMnrMINzr/TkNz6bLOFdc
         +72cm1gFwHc3y4hrdoQoPQqJhnQnPxTO94B6LJMBlJ346zNPR2r0IFbCAdLMmNDabJFy
         6ulGKakmWFNRybc1TNctsZ3NLqXyLQsdBh59/3+NXBI7XvuLb/qFArFV/wP5vJla9ARG
         5DqgHFU96hqunKCqhY3SzdbE0tDE2wYwERcFywjE1EaRTg2F8V9n+hfNKWWrLcW02rRM
         6DlNCUD1SAhNCIUT08Bl2JJyPrVEarzl32qiERZOvhdJmm4Alwf/oY+nalxEtIfk6UD4
         d+5g==
X-Gm-Message-State: AOAM533eCVODuZ7plxsT3aJm1G8rdo6bdcRuLrHCTPgQuPVZIDTeZWNt
        I0K55sv5MCPkd1Z0JtpsA2JKav21aN8r0ul4IfQMhYChXg4=
X-Google-Smtp-Source: ABdhPJyzY30ehIrIAiqsuSp5hp1PCRmTR5oemyMa6TgpjPFp1NOo2QZzXuzVCKQydj2fcD+g8t4vXXzQ6fH8P90c4j8=
X-Received: by 2002:a92:c7c2:: with SMTP id g2mr13811524ilk.209.1614611559746;
 Mon, 01 Mar 2021 07:12:39 -0800 (PST)
MIME-Version: 1.0
References: <CA+icZUXzjAniVZMzS5ePNa6HrjWL6ZrpAgzWufy74zHSyN+urQ@mail.gmail.com>
 <YD0DaqIbAf0T2tw2@mit.edu>
In-Reply-To: <YD0DaqIbAf0T2tw2@mit.edu>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 1 Mar 2021 16:12:03 +0100
Message-ID: <CA+icZUXJpEEO4GS1fy9ANXCXJ2BtD_rd1tAtXLun++i0taZwSA@mail.gmail.com>
Subject: Re: badblocks from e2fsprogs
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 1, 2021 at 4:08 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Mar 01, 2021 at 10:20:36AM +0100, Sedat Dilek wrote:
> >
> > root@iniza:~/DISK-HEALTH# LC_ALL=C badblocks -v -p 1 -s /dev/sdc -o
> > badblocks-v-p-1-s_dev-sdc_$(uname -r).txt
> > Checking blocks 0 to 976762583
> > Checking for bad blocks (read-only test): done
> > Pass completed, 0 bad blocks found. (0/0/0 errors)
> >
> > root@iniza:~/DISK-HEALTH# ll
> > badblocks-v-p-1-s_dev-sdc_5.11.0-11646.1-amd64-clang13-cfi.txt
> > -rw-r--r-- 1 root root 0 28. Feb 19:33
> > badblocks-v-p-1-s_dev-sdc_5.11.0-11646.1-amd64-clang13-cfi.txt
> >
> > Unfortunately, the output-file is empty.
> > Do I miss something (order of options for example)?
>
> Nope; the output file is a list of block numbers for which badblocks
> found problems.
>
> > The whole single-pass badblocks run took approx. 3 hours - last I
> > looked 50% was 01:26 [hh:mm].
> > On stdout (and in output-file) - no summary of the total-time.
> >
> > Is that possible to have:
> >
> > Pass completed, 0 bad blocks found. (0/0/0 errors) + <total-time_of_run>
>
> The output file was designed for use to be fed into mke2fs (via the -l
> option) or e2fsck (via the -l or -L options).  So we can't change the
> format of the output file without breaking those programs.
>
> You will note that the output is in the badblocks standard output:
>
> Pass completed, 0 bad blocks found. (0/0/0 errors)
>
> So there should be no confusion in the mind of the person running the
> badblocks program.
>

OK, I see.
So I misunderstood the -o option.

Use time or linux-perf to see the used total-time.

- Sedat -
