Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CAF29517A
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Oct 2020 19:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437552AbgJURZ3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 13:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390251AbgJURZ3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Oct 2020 13:25:29 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EA3C0613CE
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 10:25:27 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id bc23so750576edb.5
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 10:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CGl2uGos3BxyKPRHcDYVGvmVI/PJPBJAkWSwmMlobUA=;
        b=AtfsTMO+BMbTWvhmqlhKNgq1ZuTsjRFK8Eue1qKBgU3kXhw1koxaROaNZX31JB+bPL
         OHaSeWxnBZAAXq8qjIPDPpc+uHH2XoUbkleC/J/o+YJXVple82wJZ90KPv+DW6dCJpVZ
         9EBWvAFzDfUgicMGKyeYMk22YGs2dvE8VpacdQmFfuuVPbalZgh+uwp5F4n7ircP8o3Y
         UbKLEHFuzPqXb93cSTsfi5YjN4TcIXQNZd1NyNcVZKdIgzzJaLG6OWmvhVB6ybzv8fYd
         vlAMWprk4sqso1L21/1B9mwJvO/zzqSYQTG+YQp4Xe5nvMPCw+9DkbO71Yqrx+O1Bsau
         Gvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CGl2uGos3BxyKPRHcDYVGvmVI/PJPBJAkWSwmMlobUA=;
        b=mfqsuWeydtxvSLd8Rf7P6dPgyJJSbENc/p1HxwFo81IGlMadFtMQty8+CCC9NF4snn
         mIJ1Z415Z9NzYiNYVm0doECG99k8aG5JGexSu09OoQACVuI+y8Mk+LfM6KnyqtE7PZe3
         mOVAoCRoWgybifwlkX6QrIJ0rIyzS2VzP+V/PyOlsVMSem2rqdmLIhH4tNUgK6mkheUD
         rB3H14CNIhTvQUpv2X9MRuHrt5DfEQsBT43HArx28X0e4bq4H0hXFzYozC8vZdrw8rcw
         eCILZY3ZB5UG+pIj1icI2y2PSGlSaEvPOiNguOizEXRahCq5wvQHkaXy3m8EL6x8SOu5
         2ctw==
X-Gm-Message-State: AOAM530erIKRi11tL4eLXzJI0CljdccQrPTuTAJiyTw0o/dPhJCbm3sU
        5MCb0Q4p9XOy2RqdbBf+EA34B4TXXuIpbfh3VG0=
X-Google-Smtp-Source: ABdhPJz15iD1oEEtnsfjMeL9Qc5sK5JxbqD6obg+NWSntu5a1d3h1kmp3iDp6y0ZKRZZnyqSdV3vQkmPKbTWr1P54HQ=
X-Received: by 2002:a05:6402:1c04:: with SMTP id ck4mr4221338edb.274.1603301126032;
 Wed, 21 Oct 2020 10:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
 <20201015203802.3597742-2-harshadshirwadkar@gmail.com> <20201021160423.GB25702@quack2.suse.cz>
In-Reply-To: <20201021160423.GB25702@quack2.suse.cz>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Wed, 21 Oct 2020 10:25:14 -0700
Message-ID: <CAD+ocbyp1PBS-GeU4r75DBE-r15HT6PJSk_t0zordFv3hH2Fjg@mail.gmail.com>
Subject: Re: [PATCH v10 1/9] doc: update ext4 and journalling docs to include
 fast commit feature
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Jan for taking a look at the patches.

On Wed, Oct 21, 2020 at 9:04 AM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 15-10-20 13:37:53, Harshad Shirwadkar wrote:
> > +   * - EXT4_FC_TAG_CREAT
> > +     - Create directory entry for a newly created file
> > +     - ``struct ext4_fc_dentry_info``
> > +     - Stores the parent inode numer, inode number and directory entry of the
>                                   ^^^ number
Ack
>
> > +       newly created file
> > +   * - EXT4_FC_TAG_LINK
> > +     - Link a directory entry to an inode
> > +     - ``struct ext4_fc_dentry_info``
> > +     - Stores the parent inode numer, inode number and directory entry
>                                   ^^^^ number
Ack
>
> BTW, how is EXT4_FC_TAG_CREAT different from EXT4_FC_TAG_LINK? It seems
> like they describe essentially the same operation?
In the replay path, creat has to do certain things that link doesn't.
For example, "creat" needs to mark the inode as used in the bitmap and
also if it's a directory that's being created, it needs to initialize
the "." and ".." dirents in the directory. That's why we need
different tags.
>
> > +   * - EXT4_FC_TAG_UNLINK
> > +     - Unink a directory entry of an inode
>           ^^^^ Unlink
Ack

Thanks,
Harshad
>
>                                                                         Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
