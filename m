Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24F5235105
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Aug 2020 09:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgHAHdG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 1 Aug 2020 03:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgHAHdF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 1 Aug 2020 03:33:05 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6982AC06174A
        for <linux-ext4@vger.kernel.org>; Sat,  1 Aug 2020 00:33:05 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id l1so33847422ioh.5
        for <linux-ext4@vger.kernel.org>; Sat, 01 Aug 2020 00:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aBmpngCF4EWK8MIB+B2v9lWPVVH0Qiwgwv2YKPUONzY=;
        b=IYOS2EDg25FROX9XIOjSkixgxThWERQ7oh1GuFqJdycbxoTaojad3NQjZJVfAQcvvZ
         bLrqnBN3qGNnjmC2f6b62bxtLaQ0hnfnhrKI+zRsgU4odCMlM6Vvi7uzQ8hRon08gz76
         6WgtO+cds8lnR73kDJTGHsddjX5NoAqTm7X+6Y9TpzovB135AL53LZI0Xe9vZ6+x2U3m
         GDfB4RMeOKuMLveHKTtvoBHPuDL4mLiqhFxZM/eBgG3wcX5aTJh3WvWSO3q1jov9gAIO
         grgRxFVyr6GKsj3t0Px2UmWtthjVk0B7UZkF6RFxd4XMmywTfqTI9EBN2OmjPJwkq2Am
         1OiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aBmpngCF4EWK8MIB+B2v9lWPVVH0Qiwgwv2YKPUONzY=;
        b=Z6JLVTetXCYIOTo7wgUEgwSpjiB7xCDuFt5WJcHxevQo7LbzaN/WwAvjGYwo9PLbEm
         4CheuPUmoCmS93VfPtPjDzpaEHce38oCUEIIaq68fzW6etDBU85bzhYthT+NTyNmglIx
         L0F3EXqbVVayjB+ZVfYsWr6y3bakCTyFfwI7Q+NgGNM6UyWAsVVdqkeLvOZPPBFYuLbF
         0BM7nPvy5+qsT46bIcRWfgSZeiqjXretBfSZyhq/ufKi85Y5CBHw43og6j9KWVM7aiE2
         1oy2qcrYzrM3AyRf/bvWxdKZcay0V98x1j17k2aEGcvfbqVz7REnLBeQ3yFvXf+pbUtd
         9p0Q==
X-Gm-Message-State: AOAM532RmAhtgcw+3hNAtYkliThVW2NxDrn91Urk19BKT/UNWyjVf1Cc
        PVvI54uzYfGmvAA4x6fPAFUAheZ+B+o9vNx3vv0oLetx
X-Google-Smtp-Source: ABdhPJzhENGKtgJB2d9uUsdYxKyaQ3yVYatmh/K7PCgnECDlzmdifFgt7iAN9Xu6M9lddSuQh7veTgAqvCMOz2YRabc=
X-Received: by 2002:a6b:be81:: with SMTP id o123mr7260081iof.64.1596267184627;
 Sat, 01 Aug 2020 00:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200731225621.GA7126@quack2.suse.cz>
In-Reply-To: <20200731225621.GA7126@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 1 Aug 2020 10:32:53 +0300
Message-ID: <CAOQ4uxgovoBjs5BnYdPyV6K9AP17fCaeVgZ=wQMfx4hAuAf5RQ@mail.gmail.com>
Subject: Re: Data exposure on IO error
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 <linux-ext4@vger.kernel.org>, rebello.anthony@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Aug 1, 2020 at 1:59 AM Jan Kara <jack@suse.cz> wrote:
>
> Hello!
>
> In bug 207729, Anthony reported a bug that can actually lead to a stale
> data exposure on IO error. The problem is relatively simple: Suppose we
> do:
>
>   fd = open("file", O_WRONLY | O_CREAT | O_TRUNC, 0644);
>   write(fd, buf, 4096);
>   fsync(fd);
>
> And IO error happens when fsync writes the block of "file". The IO error
> gets properly reported to userspace but otherwise the filesystem keeps
> running. So the transaction creating "file" and allocating block to it can
> commit. Then when page cache of "file" gets evicted, the user can read
> stale block contents (provided the IO error was just temporary or involving
> only writes).
>
> Now I understand in face of IO errors the behavior is really undefined but
> potential exposure of stale data seems worse than strictly necessary. Also
> if we run in data=ordered mode, especially if also data_err=abort is set,
> user would rightfully expect that the filesystem gets aborted when such IO
> error happens but that's not the case. Generally data_err=abort seems a bit
> misnamed (and the manpage is wrong about this mount option) since what it
> really does is that if jbd2 thread encounters error when writing back
> ordered data, the filesystem is aborted. However the ordered data can be
> written back by other processes as well and in that case the error is just
> lost / reported to userspace but the filesystem doesn't get aborted.
>
> As I was thinking about it, it seems to me that in data=ordered mode, we
> should just always abort the filesystem when writeback of newly allocated
> block fails to avoid the stale data exposure mentioned above. And then, we
> could just deprecate data_err= mount option because it wouldn't be any
> useful anymore... What do people think?
>

It sounds worse than strictly necessary.

In what way is that use case different from writing into a punched hole
in the middle of the file and getting an IO error on writeback?

It looks like ext4 already goes into a great deal of trouble to handle
extent conversion to init at io end.

So couldn't the described case be handled as a private case of
filling a hole at the end of the file?

Am I missing something beyond the fact that traditionally, extending
a file enjoyed the protection of i_disksize, so did not need to worry
about unwritten extents?

Thanks,
Amir.
