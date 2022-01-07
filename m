Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D4B487D92
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jan 2022 21:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiAGUPw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Jan 2022 15:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiAGUPv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Jan 2022 15:15:51 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B73DC061574;
        Fri,  7 Jan 2022 12:15:51 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id 202so7028701qkg.13;
        Fri, 07 Jan 2022 12:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+ervhEtk2/VUJhtWYnjc/XyqwP9Jz7z2lWi8LVkv9LU=;
        b=AMSXazvCKdTVrubzG3xFVjxGmG4WoBry9cUCQDqiej0zUzk1RPoD/1YE+cx8UP/Rdt
         aaLIlFAKxqi8hGaO6v7qmumQJy+mG9czc54DuYjUHzjPe9O3RyQnpvcM4mFsTlV9GImZ
         SJHy577mcFeyVHNGkmK2C/AV6iyV3kBGv8WeKRoN5MQT4G0kAZPp4I146a6BeVIo3q7w
         QfkJf7c1Bw50vN4dRxmVf+iOeh1m3TUoCEsuoKgfB0bQrdSIhn/l8XQ+RfrNGaPaQw9G
         gnoEvFdxCo+C3SfiRfvDLbI3FW/gLmptwHWLvJ7hnwmifIfZlsYWYCyRRbqzpGwQb0Ks
         UWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+ervhEtk2/VUJhtWYnjc/XyqwP9Jz7z2lWi8LVkv9LU=;
        b=lDDGW5ODpGY+Up5tfr6W5UEswc8wQMREEmwPOBKdm02s5EVnahCdwSA25ZU7CDvqWN
         x/dI4kRa4Q1XQYoDPvyVzfDS47J17S98dlBQDUwnTxvG4dM5UWnanjk6yMtYmk5HTUeN
         yeJ63yiaYcVElxK5iXW24lDWkAwwQ2ftgzYbdN0GG4Zlgi5QOjcFRrA4hszOGYvd13eQ
         BINV61ZfBLycn+M/OZAa34Z9MG8zlo9R2FQZzyZhSmJdYrd1yR7i+bjsjhT0bYe17s+F
         +dGA+oBsCY6wxe+6z/IcMCaJ7V4NKEazXirlPwZXXHTlsFTUU8fel4MgWqA+uY2bOkEZ
         husw==
X-Gm-Message-State: AOAM532CAtlDM1v0CSc/zyx8aapXMcoZ+6QN90aF9tIWt4aFvHRhZQNo
        MFwaRwaKB0Wi6zhJ+DRIG4coHTItt2eZKYIw32ESKjXD
X-Google-Smtp-Source: ABdhPJykInENa/FBT0YRnEYjMQeWitHPVoD8A1Foesuk9Ar6IiYlLBZfNTyiK1OKhKRRVFvgKf5m25qhzMHv2xABh/I=
X-Received: by 2002:a37:2707:: with SMTP id n7mr10164448qkn.235.1641586550698;
 Fri, 07 Jan 2022 12:15:50 -0800 (PST)
MIME-Version: 1.0
References: <20220107121215.1912-1-yinxin.x@bytedance.com>
In-Reply-To: <20220107121215.1912-1-yinxin.x@bytedance.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 7 Jan 2022 12:15:39 -0800
Message-ID: <CAD+ocbzgHUi4PCW3fU7+U3CLZT_N93fyCxzU8V3h0MEMK2bYiQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] ext4: fix issues when fast commit work with jbd
To:     Xin Yin <yinxin.x@bytedance.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch series looks good to me. Also, it's great to know that
generic/455 now passes! :)

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

On Fri, Jan 7, 2022 at 4:12 AM Xin Yin <yinxin.x@bytedance.com> wrote:
>
> When test fast commit with xfstests generic/455, some logic issues were
> found. When a full commit is ongonig, the logic of fast commit tracking seems
> not correct. The first patch fix the ineligible commit case , and the
> second patch fix the common fast commit case.
>
> After testing this patch set with xfstests log and quick group, no
> regressions were found, and the generic/455 can pass now.
>
> Xin Yin (2):
>   ext4: fast commit may not fallback for ineligible commit
>   ext4: fast commit may miss file actions
>
>  fs/ext4/ext4.h        |  3 ++-
>  fs/ext4/extents.c     |  4 ++--
>  fs/ext4/fast_commit.c | 28 +++++++++++++++++++---------
>  fs/ext4/inode.c       |  4 ++--
>  fs/ext4/ioctl.c       |  4 ++--
>  fs/ext4/namei.c       |  4 ++--
>  fs/ext4/super.c       |  1 +
>  fs/ext4/xattr.c       |  6 +++---
>  fs/jbd2/commit.c      |  2 +-
>  fs/jbd2/journal.c     |  2 +-
>  include/linux/jbd2.h  |  2 +-
>  11 files changed, 36 insertions(+), 24 deletions(-)
>
> --
> 2.20.1
>
