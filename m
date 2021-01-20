Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C472FCCEB
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Jan 2021 09:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbhATInU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Jan 2021 03:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730935AbhATInI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Jan 2021 03:43:08 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB79C061757
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jan 2021 00:42:27 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id g13so142172uaw.5
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jan 2021 00:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LcErNgQLVWOD8ZTCaEhXK6vs+u411+l0rmQgZ6zam9o=;
        b=cncXbFMLNFZZMMMPVG/Cxaj4sOUIGJCzaSgMLUBQhIL3ueXk6g/Gd8aMHXGs1uDMcq
         4tDdt48TteXTHB+MtkDISORE7UViRflrovrpIxP4OVXR3f26526nNL9SsIeio/venNVd
         wXT9ExhAd4o0/EYvX1vgXZ9ek36X3Xu6woq1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LcErNgQLVWOD8ZTCaEhXK6vs+u411+l0rmQgZ6zam9o=;
        b=L1neE07byQAnOE0Z7q0WfqRUaaEnXde4j6KoBnsX0xxMariPmGt4P0S4qRDa1TMc//
         ESYSTRkrReMKDhKTtW8QH1c9U4/cfjXZDkQdxKdCCGwmz97itQUfiEkBA565E+QzOdtt
         Q1nSb+PC5Cl+w9yqGNyuyKMWpIkC8ZDD8k0Bjk07Xah5R/msUAkfurh7GdwvqGaGQGut
         WrDQXyVPkhbNzCP8u6l2WB6Gm0Njx8cahAF4j1ta+33xNMOWc5oj36ziD2pGC3xQibSA
         AbOFLp9xCtTNc22HsZ/UfTJTnjcFY5JAxxsT1GQOGRIDx+TxvarIRtCVDrpeIpwfLig2
         GfFQ==
X-Gm-Message-State: AOAM532nDN6OdwXGrxENGcvrKdUAehhdYO74HOU1D0afxkd+GwLRJKbG
        HAcUd5X2PzDDbCI0Q3DezLBK6C4AIaOcIt4Bpv57hA==
X-Google-Smtp-Source: ABdhPJyy86YCbwJ30iHzrIqN/bFimmSQ170g2aYsvj/+hAIdoZXcX4F74dLLSy2wdJwNOFd63TcqdINnFzqydo36OKQ=
X-Received: by 2002:ab0:3c91:: with SMTP id a17mr5484553uax.9.1611132147206;
 Wed, 20 Jan 2021 00:42:27 -0800 (PST)
MIME-Version: 1.0
References: <20210105062857.3566-1-yangerkun@huawei.com> <X/+/3ui/TQ9LjtNZ@mit.edu>
 <CAOQ4uxh2V6LF_t8ZaAOr=CbDrY3A5d0qSR7XWVX8dStR9mME5w@mail.gmail.com>
In-Reply-To: <CAOQ4uxh2V6LF_t8ZaAOr=CbDrY3A5d0qSR7XWVX8dStR9mME5w@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 20 Jan 2021 09:42:16 +0100
Message-ID: <CAJfpegsVYF2wCiMKfRUzS_MpH9UKPh8g7ucG6w9uOcQodAzRAQ@mail.gmail.com>
Subject: Re: [PATCH v3] ext4: fix bug for rename with RENAME_WHITEOUT
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        harshad shirwadkar <harshadshirwadkar@gmail.com>,
        yangerkun <yangerkun@huawei.com>,
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

On Wed, Jan 20, 2021 at 7:57 AM Amir Goldstein <amir73il@gmail.com> wrote:

> And as long as I am ranting, I'd like to point out that it is a shame
> that whiteout
> was not implemented as a special (constant) inode whose nlink is irrelevant
> (or a special dirent with d_ino 0 and d_type DT_WHT for that matter).
> It would have been a rather small RO_COMPAT on-disk change for ext4.
> It could also be implemented in slightly more backward compat manner by
> maintaining a valid nlink and postpone setting the RO_COMPAT flag until
> EXT4_LINK_MAX is reached.
>
> As things stand now, overlayfs makes an effort to maintain a singleton
> hardlinked whiteout inode, without being able to use it with RENAME_WHITEOUT
> and filesystems have to take special care to journal the metadata of all
> individual whiteout inodes, without any added value to the only user
> (overlayfs).
>
> But I guess that train has left the station long ago...

Not so, I believe.  Kernel internal interfaces are easy to change, and
adding support for DT_WHT to overlayfs would mostly be a trivial
undertaking.

The big issue (as always) is userspace API's and not introducing
DT_WHT there was a very deliberate choice.  Adding a translation layer
from an internal whiteout representation to the userspace API also
does not seem to be a very complex problem, but I haven't looked into
that deeply.

So AFAICS there's really nothing preventing the addition of whiteout
objects to filesystems, other than developer dedication.

Thanks,
Miklos
