Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592861B83D6
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Apr 2020 07:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgDYFja (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 25 Apr 2020 01:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725909AbgDYFja (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 25 Apr 2020 01:39:30 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC1CC09B049
        for <linux-ext4@vger.kernel.org>; Fri, 24 Apr 2020 22:39:29 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id i2so6303553ybk.2
        for <linux-ext4@vger.kernel.org>; Fri, 24 Apr 2020 22:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nFaqSON5dZJG9mAYSppqyaaBEL4gGnjG3LhPmhB/ZHQ=;
        b=mRVYsPdPlXTX1IZzQSFotf1EehG9OMyfKuiR4uLqrfm8Udpq5X/6E7Hom6/NINw6IF
         75Y9YXir2DCtunJ4rpjjyfs6CWMQUIZThHKRdEkYxOUANwrrFFTQgg1h0I79X9EJ3pAp
         ASq4X/XmG172c6nTt0CJ5KaGqqMHLojBNjBZtZz+LMsSnnJkp1rgNO7+Ok7NlaeUJY6Y
         0PffwG4su7RleaoLf9hEIqWpXCNxJW+5t2gKZcT78nAVQYwPzogrm6guqTVeWo5Dzm3m
         h9R/2f9te51WSn72dJ5Uv6Q/4mFaRh0Uchs1/sl9N1eLeZUczwRsPyAE5mIDqCKB29tZ
         mv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFaqSON5dZJG9mAYSppqyaaBEL4gGnjG3LhPmhB/ZHQ=;
        b=j7dNOh4PtnYDrQAoULSLaW81A/7hNlVaom1ZX/axjJ+AeemLmrDFySBnV0wivLJhmI
         TfO+1NxT1mkShcqdjecGEL67CVbIJa6ZkvDUv3hNLmieCQwOsysE9TVCHsY6qaAWK5gW
         UtMWfpdj8fa16cDEpLUrUxCeGkfzVf8tYltVvp5lJiGXXKLztbr2keX9qzSQN9G5ymBZ
         Klb4TD3ZZSnD8YXe++yLNdG1g+fi56gvQQIFw8gjCRILCU1uid5OvUQ9v2NSMKFqScyi
         8TZZ/g3qB6YpKYGaw6D/RuSGcNl49FkERu+HtLdaBKvln0OkSfP8UoOx+UwyZ9vFxY7y
         oKNQ==
X-Gm-Message-State: AGi0PuZIgCFcDzOwuUs0e0LuSy6C3qgQRIZyLqCLSBOD949gZYMfiIhs
        smw3cukCRYNdakFNzA+uhwb6PvskVlCeEFlIb8xPw3AB
X-Google-Smtp-Source: APiQypL/BbUh0nz/mWTTzj3f3nIgNEvY2hQjP2S0fNd4CKaToFHfW0FhPvhVsU5ZWPEZRHzNgT2ZnJxHu/WvNcUzpqM=
X-Received: by 2002:a5b:ecf:: with SMTP id a15mr21516731ybs.444.1587793168706;
 Fri, 24 Apr 2020 22:39:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAG-6nk-Q16UBbUkWoogut0fYP9s78x0OMf946Dg-tJk1nd+kzA@mail.gmail.com>
 <3F735CCE-F9A8-4743-A6BF-DC2945FBB4B2@dilger.ca>
In-Reply-To: <3F735CCE-F9A8-4743-A6BF-DC2945FBB4B2@dilger.ca>
From:   Alok Jain <jain.alok103@gmail.com>
Date:   Sat, 25 Apr 2020 11:09:17 +0530
Message-ID: <CAG-6nk-ntm56DANOJJKGq9cORYT+3XiL4Wjz-BnFs1XrKc5RXA@mail.gmail.com>
Subject: Re: Need help to understand Ext4 message in /var/log/message file
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Andreas it was helpful

So looks like new device has bad journal, is there a way to find if
device of ext4 FS has bad journal?

One question If I generate new UUID on device and it got corrupted
will it roll back to old UUID i.e. does it keeps info about previous
metdata (superblock)?

Thanks,
Alok

On Sat, Apr 25, 2020 at 3:13 AM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Apr 24, 2020, at 12:56 PM, Alok Jain <jain.alok103@gmail.com> wrote:
> >
> > Hi Guys,
> >
> > I need an help to understand the following messages printed in
> > /var/log/message file
> >
> > Apr 20 17:42:44 mylinux audispd: node=mylinux type=EXECVE
> > msg=audit(1587404564.745:5901346): argc=4 a0="mount" a1="-v"
> > a2="UUID=b1d54239-2b18-44b3-a4bf-5e0ca32b8f78" a3="/tmp/aj/m1"
> > Apr 20 17:42:45 mylinux kernel: [4633324.069180] EXT4-fs (sde1):
> > recovery complete
> > Apr 20 17:42:45 mylinux kernel: [4633324.070157] EXT4-fs (sde1):
> > mounted filesystem with ordered data mode. Opts: (null)
> >
> >
> > Actualy one of the iSCSI device is mounted to /tmp/aj/m1 with UUID
> > (U1) I unmounted this device and mounted new device (UUID
> > b1d54239-2b18-44b3-a4bf-5e0ca32b8f78) after mount I see the UUID of
> > newly mounted device changed to U1 and new device got corrupted. I ran
> > fsck to fix the device but UUID was changed to U1.
>
> It sounds like the iSCSI device is not flushing the block device
> cache between unmounting the old filesystem and mounting the new one?
>
> The new filesystem has a dirty journal, and when it is replayed it
> reads a stale superblock from the old filesystem and overwrites the
> new filesystem.
>
> Cheers, Andreas
>
>
>
>
>
