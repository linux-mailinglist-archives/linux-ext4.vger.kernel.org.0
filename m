Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDFD343560
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Mar 2021 23:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhCUWX5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 21 Mar 2021 18:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhCUWXf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 21 Mar 2021 18:23:35 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA9CC061574
        for <linux-ext4@vger.kernel.org>; Sun, 21 Mar 2021 15:23:35 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id a198so18317404lfd.7
        for <linux-ext4@vger.kernel.org>; Sun, 21 Mar 2021 15:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i7OJny7/V4yyN/9dZgPTdsmWzXvmlB1MW2uAwUkn2+s=;
        b=B/10k1C91cCh8kg0GCGhNkTzShrZ5dExD69Lo83DjznVBnM26bOjhTQX6KFKpcZQvH
         ukWoMudn/nOrhi+B9rap0AqKvpSacrhZSZgxsY4tslHKjR62aTQsbfsBPrs7ZoQ1D7vz
         K2ZXmL9FHG+I9Zfcj95YMMDTnukP2SXN7ViwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i7OJny7/V4yyN/9dZgPTdsmWzXvmlB1MW2uAwUkn2+s=;
        b=JX6aKQG2ovOyhZSN8MqjgYmno8C4H2H3fOgdvZhyjR3yEIHmy1NY3rFtMiPUx8jhD3
         ATJI3AevCglC4Xh8/GsKqiB+Jk/VcV2NuOCZroLmGOUVp/P/5dfiMrIRAhrwQZ+POFF4
         eOaJ8HbVteXLi09XinpAeIX1ZY8kOAPjxtUPHqbfIGG90J83rgkjv+zxM+ei9fZ72MXE
         Vgar6O9qKWv+ST877TC6Nd9fEagrIbkD+4augMyYCW0iT43nsasuJua/C9yEDInVWBrC
         20egL4WUopfa/sFvws2wpoY8ZZnM/rzmPi+5EhegU1jKNCeACsIqMb6mdhPbOUCebPjl
         MjRA==
X-Gm-Message-State: AOAM533Rj8aeByBL27sHRBVXFtiKBx8u2VUQ9nUSng3HwvEnyuHqHoN/
        6wc58jO3fMVmxf+yioMhRWZmB3s6MppCug==
X-Google-Smtp-Source: ABdhPJwFij35lHrxS734BffIcykvOMVok6pnLytmiLvQywdoGnxMVIwfInR1urfTTUszhXul14NIDg==
X-Received: by 2002:ac2:4acf:: with SMTP id m15mr7432064lfp.290.1616365413489;
        Sun, 21 Mar 2021 15:23:33 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id k6sm1685973ljb.110.2021.03.21.15.23.33
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Mar 2021 15:23:33 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id a1so18770305ljp.2
        for <linux-ext4@vger.kernel.org>; Sun, 21 Mar 2021 15:23:33 -0700 (PDT)
X-Received: by 2002:a2e:9bd0:: with SMTP id w16mr7593653ljj.465.1616365412814;
 Sun, 21 Mar 2021 15:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <YFeQ9eBFn5JELyYo@mit.edu>
In-Reply-To: <YFeQ9eBFn5JELyYo@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Mar 2021 15:23:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjahvxdYmEgZEOqSSOVdTP-Njqbh6e8=PDVtt4Md7qHNg@mail.gmail.com>
Message-ID: <CAHk-=wjahvxdYmEgZEOqSSOVdTP-Njqbh6e8=PDVtt4Md7qHNg@mail.gmail.com>
Subject: Re: [GIT PULL] ext4 fixes for v5.12
To:     "Theodore Ts'o" <tytso@mit.edu>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Mar 21, 2021 at 11:31 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> zhangyi (F) (3):
>       ext4: find old entry again if failed to rename whiteout
>       ext4: do not iput inode under running transaction in ext4_rename()
>       ext4: do not try to set xattr into ea_inode if value is empty

Side note: this is obviously entirely up to the author, but I think it
would be nice if we would encourage people to use their native names
if/when they want to.

Maybe this "zhangyi (F)" is how they _want_ to write their name in the
kernel, and that's obviously fine if so.

But at the same time, coming from Finland, I remember how people who
had the "odd" characters (=C3=A5=C3=A4=C3=B6) in their name ended up replac=
ing them
with the US-ASCII version (generally "aa" "ae" and "oe"), and it
always just looked bad to a native speaker. Particularly annoying in
public contexts.

At the same time, for the same reason, I can also understand people
not wanting to even expose those characters at all, because then
non-native speakers invariably messed it up even worse...

Anyway, I think and hope that we have the infrastructure to do it
right not just for Latin1, but the more complex non-Western character
sets too.

And as a result should possibly encourage people to use their native
names if they want to. At least make people aware that it _should_
work.

Again, maybe I'm barking up the wrong tree, and in this case "zhangyi
(F) <yi.zhang@huawei.com>" is just what zhangyi prefers simply because
it's easier/more convenient.

But I just wanted to mention it, because we _do_ have examples of it
working. Not many, but some:

    git log --pretty=3D"%an" --since=3D2.years | sort -u | tail

including examples of having the Westernized name in parenthesis for
the "use that one if you can't do the real one" case..

            Linus
