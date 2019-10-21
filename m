Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A334DF6E2
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Oct 2019 22:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfJUUl1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Oct 2019 16:41:27 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39918 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUUl1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Oct 2019 16:41:27 -0400
Received: by mail-ot1-f67.google.com with SMTP id s22so12221546otr.6
        for <linux-ext4@vger.kernel.org>; Mon, 21 Oct 2019 13:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2A3f3eR0usajIWv7ygDfgHp0FE7soF64v7si14VMt8=;
        b=jCnq3ew4BHM7CigcT9fR4xtMwX4ujwBTp4aW5d6dYlIQrUWu0NFc8U+JLH9MxRcNiD
         /SatjX3cjA9E7/FWipkIopT1UKofPnvFt7Oe0flTtNZq8YduWw9OAB6NJaXbSQZSLY0e
         PpehSCBvSTevTNOVzGzk4MU9npHj+LgNejp5z+eHbI9ifvHBg/T410/059Mnxaj34nAd
         jCpgdrCjo1hHXbYthCOd8zQuUmew1u/QRlq84Zut9nZ9LMdLrBRu6PbmSjI+PVFi9dxi
         B/pJLVlAbd51zhACPN+urWpRWgI8YdhhS2LDmeJJYa8++46T4UojsIRfmiVwnG3Sob51
         37gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2A3f3eR0usajIWv7ygDfgHp0FE7soF64v7si14VMt8=;
        b=b5HFsZaU5ZfhhQQVfhjuT24NtcxbKErpdzNJz3T+Vh++voY5KLJl4xUvezwwh6c6vS
         lhfvlr2iBh3oeW4Hw61R72UP77SO0dnjI+tkfeZ5WsHOrXncXHsb9CjQJLJSphc8w0OZ
         0lNTJfFM4IX9AY+HmL/k6Qx3SltJbdotJk0uGrGEQ6O5/NOYZ1TCwLi9wF8PLLTNGWwp
         xPMBSUt3X9y+L4QtiSL7D5YAJzWES4VbkuflEdCeg1fzDIFMa3L5OSotKOHVM8saSxQI
         olDcyYWptWxta4Be4tbR/wXnCnQ20lb3e8wfz5fJAOZ1nltr3MY7HmfUIf9M1sh3Nvby
         AKLQ==
X-Gm-Message-State: APjAAAUsXGkBB8dr45EU2SgMMU/w2DffQ15lJdlxGxcr24+caLdzX7b1
        H55a7rUQKy7VSjcWCRFKIPwp22poViq+Dl+a0hunc5wy
X-Google-Smtp-Source: APXvYqy01nqHHj4/bS55F0Ma1ybXoMwD2ci6BZx4qaBI7Q3QPiMVjJxHWXSwE4tHlrNbGKPx/kcDyzXekBZZc5e54bg=
X-Received: by 2002:a9d:6a0c:: with SMTP id g12mr19089932otn.141.1571690486165;
 Mon, 21 Oct 2019 13:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
 <20191001074101.256523-2-harshadshirwadkar@gmail.com> <20191016021427.GA31394@mit.edu>
In-Reply-To: <20191016021427.GA31394@mit.edu>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 21 Oct 2019 13:41:14 -0700
Message-ID: <CAD+ocbyMyfp8gF7Q2=c7_w-=p5BPdsPmCFaCS_4iKb=8r=Rrxg@mail.gmail.com>
Subject: Re: [PATCH v3 01/13] ext4: add handling for extended mount options
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 15, 2019 at 7:14 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Oct 01, 2019 at 12:40:50AM -0700, Harshad Shirwadkar wrote:
> > @@ -1858,8 +1863,9 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
> >                       set_opt2(sb, EXPLICIT_DELALLOC);
> >               } else if (m->mount_opt & EXT4_MOUNT_JOURNAL_CHECKSUM) {
> >                       set_opt2(sb, EXPLICIT_JOURNAL_CHECKSUM);
> > -             } else
> > +             } else if (m->mount_opt) {
> >                       return -1;
> > +             }
> >       }
> >       if (m->flags & MOPT_CLEAR_ERR)
> >               clear_opt(sb, ERRORS_MASK);
>
> Why is this change needed?  This is in the handling of options that
> have MOPT_EXPLICIT, and it doesn't seem relevant to this commit?
You are right, this change is an irrelevant change. I'll remove it in
next version. Thanks!
>
>                                                  - Ted
