Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DBDB479F2C
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Dec 2021 05:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhLSEpX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 18 Dec 2021 23:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhLSEpW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 18 Dec 2021 23:45:22 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43BEC061574
        for <linux-ext4@vger.kernel.org>; Sat, 18 Dec 2021 20:45:21 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id d10so13776441lfg.6
        for <linux-ext4@vger.kernel.org>; Sat, 18 Dec 2021 20:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1pPOMMvduWoVZ1x6QZaT1lS85BSiYsSZopsDBMCE+MU=;
        b=UgVQJPbEoyq0YTpXGuX7+LPKkOMV72Nj0Z9QINOsv3cuc+OL1v5LxYYt/zwy18FaSI
         v2vo5TnYr5O/TLLBnVkLCux9S/qLikLkdMKMwa0+fDZuEIBid+8pBIhonHzkmnL55O77
         gChM9C0dvYBHWyZ6ZlUfd6ua97dg0UFH302UXUnpomf1iFY0OTdk0LddW3pckb02Vu56
         kAc1bliZ73w248ROBA0CfWS2iZUoUEiCJtNq5K/XRWkxJ46Dleq5/EVT3HilGWTpX3fW
         Oppja7b+LAg7CSE0fik3cLhfI3p9d+CE49uitAX2zScqDXNSp7gjT5qfjFPpsWTMXMe/
         ra4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1pPOMMvduWoVZ1x6QZaT1lS85BSiYsSZopsDBMCE+MU=;
        b=rsUXCZAoAVH6LuFqTElfLRmfvF+XoXldT/m8uWJebD0bdj2vJOvaui5rMoOyARXYCK
         UYKtNrzE+049Zuue7hAWoc9F8q2qO3K/X3EgnxHQq0FEiAKCgRNCicL/YCmtaVEKPeNF
         XLC1En3m+IlQdsVRVOD4fiWtFL95eauxZT7UjI5cywR4pF7O0z630o1xO8N/KYeP2v16
         AJylFKtgckyON7ZEBq/E425MJT92SFJUc9IGxijYnrwbG9WdO3tU8n/EZY+CUMT7WPP0
         rq1bTXAfeU6OfgIjsSiqZ0gEx+6OREyhqTbaRrLN8ojTTtErJw7LBWMcOYKtjvKC2U0A
         1QjA==
X-Gm-Message-State: AOAM531y6IE7bhS0JHmqIBlVTrC9Q5K07ykkp6uAZs/ClIowS4wdR/IQ
        OVg07wMHIlwCOemxAalZZzE2Dt9x2jK6qF1O76AXc5rQCp0=
X-Google-Smtp-Source: ABdhPJz/X0Ow9UwZklUaAvNQYPK/mRj3sS5CSXlWSXKbrPXeahYtYnKguOqnj8eNwISZIv0oL9t6VeCvOIIlT7UfAas=
X-Received: by 2002:a05:6512:22d0:: with SMTP id g16mr10014855lfu.404.1639889119990;
 Sat, 18 Dec 2021 20:45:19 -0800 (PST)
MIME-Version: 1.0
References: <20211201095258.1966-1-yinxin.x@bytedance.com> <20211217204322.1000035-1-harshads@google.com>
In-Reply-To: <20211217204322.1000035-1-harshads@google.com>
From:   Xin Yin <yinxin.x@bytedance.com>
Date:   Sun, 19 Dec 2021 12:45:09 +0800
Message-ID: <CAK896s6_kfs9AoDSq=Wfgb9Rx4zKmvoC-YYBr5gnwBCAejL7xA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] ext4: fix fast commit may miss tracking
 range for FALLOC_FL_ZERO_RANGE
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Dec 18, 2021 at 4:43 AM Harshad Shirwadkar
<harshadshirwadkar@gmail.com> wrote:
>
> > fs/ext4/extents.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> >index 9229ab1f99c5..4108896d471b 100644
> >--- a/fs/ext4/extents.c
> >+++ b/fs/ext4/extents.c
> >@@ -4433,6 +4433,8 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
> >                       ret2 = ext4_journal_stop(handle);
> >                       break;
> >               }
> >+              ext4_fc_track_range(handle, inode, map.m_lblk,
> >+                                      map.m_lblk + map.m_len - 1);
>
> ext4_alloc_file_blocks() calls ext4_map_blocks(), inside which we do
> call ext4_fc_track_range(). However, we are doing that only if
> map.m_flags & EXT4_MAP_MAPPED is true. So, unwritten flag is set we
> are not calling track_range there. Perhaps the right fix is to call
> ext4_fc_track_range() from ext4_map_blocks() if MAPPED or UNWRITTEN
> flag is set?

Thanks, you are right, this should be better. I will test this way and
resend a v2 patch for this issue.

>
> >               map.m_lblk += ret;
> >               map.m_len = len = len - ret;
> >               epos = (loff_t)map.m_lblk << inode->i_blkbits;
> >@@ -4599,8 +4601,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
> >       ret = ext4_mark_inode_dirty(handle, inode);
> >       if (unlikely(ret))
> >               goto out_handle;
> >-      ext4_fc_track_range(handle, inode, offset >> inode->i_sb->s_blocksize_bits,
> >-                      (offset + len - 1) >> inode->i_sb->s_blocksize_bits);
> >       /* Zero out partial block at the edges of the range */
> >       ret = ext4_zero_partial_blocks(handle, inode, offset, len);
> >       if (ret >= 0)
> >--
