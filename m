Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAA33C7AA5
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jul 2021 02:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbhGNAkj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jul 2021 20:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbhGNAkj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jul 2021 20:40:39 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C37C0613DD
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jul 2021 17:37:47 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id k184so280924ybf.12
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jul 2021 17:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xs16PK6dJE5JT2uZIx4UUd9LON9Tnv4D7l4CW1ryNYc=;
        b=rA+lC9kAKlZzNNibE5Nx5cBmKmRWQKJAWQ+IeWDQcZaXw244Vh/3k9q9CxO0Oa8E75
         qpIamkVfHv7l7o8r2TV2VnDVoEHSzXf+HXYyF1Lm3artp2TwCgYpaGqjNuqj98QRKPm2
         ZYRTi2oCN7TaMiAFFJJxmiLZWff2Wxqx21A5G6pX234yJKhiXRkx6hD0tMUQwQdwrG5c
         COv7ALZGJd6P0P6bG0uDkPea0vEoTxtYjYor1+26feQEsBO803cbxczLWNULDKi7qw2R
         GltqmoS/WjqovBKpNJmSUyAI7bj43HHGvdbsZpL9MKJmlA2mWdSB6cDlp5SR4iC9ehsT
         DhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xs16PK6dJE5JT2uZIx4UUd9LON9Tnv4D7l4CW1ryNYc=;
        b=rDOWOBfBcHcJlJ2gDyqCVGDtLhC2rdTe8fwiMDj3yrVJt+KiEFFHh6iZekGtDvU8ad
         q2L9lqtnYrvhx+qWvxOxqGulVRNbeaT00CNklJ+ZaTxpAaCkEWhd9VI4Axcdjf9HEVeQ
         RRIXuHnIgpp1U9JYny3qo0VrEJjTa35rsw43qnrahs5If9vpmYV7OJgOHKKbZw0SgD9B
         rIsYQdmtTHMdtslG9sOsUAp+u+fFV/gPD1ZuQsgcoQ0WBqA6aarj7KyxE2RruUIofrMA
         t8uC1g6YSApP+fnRN++J4Ma//+1BvzxkwAVS0mcSCWCZRZEuOnd7vaGqf83zPm5mqzkJ
         iMyw==
X-Gm-Message-State: AOAM53239wUGaAfzsKZpZhV19epP4huhD1U2aUm54QOD54l9OyWnwtMN
        L1sJLsU7INRZxRZbazbYQRXxk94g8TWLopjWb/Q=
X-Google-Smtp-Source: ABdhPJwW6ATOD5g9hgfCoJG1FwE8E20XEi8ca/zIOEPbWe9Z5GvLRJSDsDntKKP2GvCtacEvePzWfPVwHdhEb7wvsUY=
X-Received: by 2002:a25:ce92:: with SMTP id x140mr9994118ybe.131.1626223067120;
 Tue, 13 Jul 2021 17:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <CANT5p=o3i4kWQuMFF5zKQp04JnWEQnYuo+cvyH8asGMvTVBBkw@mail.gmail.com>
 <YO17ZNOcq+9PajfQ@mit.edu> <CANT5p=qi8-9iZa0XE70ZaCUdqscKufovjcUAZZPDRmN9W5_uQA@mail.gmail.com>
 <YO30+XRGAYnME+vy@mit.edu>
In-Reply-To: <YO30+XRGAYnME+vy@mit.edu>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Wed, 14 Jul 2021 06:07:36 +0530
Message-ID: <CANT5p=pGsU+rgyd-2m+ODOwkxDvdbZKi81DthuuQgzDUXZ9UAQ@mail.gmail.com>
Subject: Re: Regarding ext4 extent allocation strategy
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     David Howells <dhowells@redhat.com>,
        Steve French <smfrench@gmail.com>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 14, 2021 at 1:48 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Jul 13, 2021 at 06:27:37PM +0530, Shyam Prasad N wrote:
> >
> > Also, is this parameter also respected when a hole is punched in the
> > middle of an allocated data extent? i.e. is there still a possibility
> > that a punched hole does not translate to splitting the data extent,
> > even when extent_max_zeroout_kb is set to 0?
>
> Ext4 doesn't ever try to zero blocks as part of a punch operation.
> It's true a file system is allowed to do it, but I would guess most
> wouldn't, since the presumption is that userspace is actually trying
> to free up disk space, and so you would want to release the disk
> blocks in the punch hole case.
>
> The more interesting one is the FALLOC_FL_ZERO_RANGE_FL operation,
> which *should* work by transitioning the extent to be uninitialized,
> but there might be cases where writing a few zero blocks might be
> faster in some cases.  That should use the same code path which
> resepects the max_zeroout configuration parameter for ext4.
>
> Cheers,
>
>                                         - Ted

Thanks a lot for your replies, Ted. This was useful.

-- 
Regards,
Shyam
