Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8C4B33BC
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Sep 2019 05:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfIPDbt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Sep 2019 23:31:49 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33045 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbfIPDbt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Sep 2019 23:31:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id a22so32297064ljd.0
        for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2019 20:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fabntbPdTHBLY+J8GfOMAsjCxQ98iy3fvtylDOTNtXY=;
        b=Rb7ndPRvbfKdFFSW7cp++vq1VHLPlokFSVp6Zh7QLtyhVbwCBEx8Psy7stGdetXSto
         hxKA0uoLhVq+46CqKsFhgvJDUuHcQrcmaa8RyM4+9k0D1SHM3VJxKW8jGMfrDA0XIVTc
         6v1yUfy1cZjQdxtKTGusEupfiPawMV3IOSOvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fabntbPdTHBLY+J8GfOMAsjCxQ98iy3fvtylDOTNtXY=;
        b=nXJZYGh4Itw/i0D8EIiu1aXAHMTXDv1XNOAME5EOwNeL8F7fLAL7gk6tokU/rBvz5T
         Z51qlAbb9yXWa/q0TGqPzpyWwObpm+bLSgiHPiHXBAMKbKD+if6in5BQ2zomYTBpaX6Q
         l7ixn6DFV9HXeDX9wwf3l18bOH46ExE9entbh0j/wAFwmuNykx74+kCCSMDDCrJ78LCk
         bu361XulsPD9qPBVX51qqgy9XQdE9hf14h/3zUwwYM2rJJENGKc5OJHq8DOKiCXOEHno
         PMwPj+N77cZ9xmlAdKfbiueNWLF9OV+SEKYk/pfJ1I0ukoXtfx4Y63kguRCMqW6Q55eh
         QQVA==
X-Gm-Message-State: APjAAAXFF3ZXstYu6KjvXt2DeT+aAYDNdPlF/VY4Z7ni54vR488h8/XC
        YJ4OTKIKk9/QyWQ6XagYxf1xjBmb2WQ=
X-Google-Smtp-Source: APXvYqwrKyTpzH6kJnBSrrnyia1NBloR+LjXkYOwRP5erw3Cv+7ascu49z12PvacdDEv+nC1zP77kw==
X-Received: by 2002:a2e:9881:: with SMTP id b1mr18418691ljj.134.1568604706408;
        Sun, 15 Sep 2019 20:31:46 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id c69sm8343923ljf.32.2019.09.15.20.31.45
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2019 20:31:45 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id d17so8374853lfa.7
        for <linux-ext4@vger.kernel.org>; Sun, 15 Sep 2019 20:31:45 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr11957567lfn.52.1568604704963;
 Sun, 15 Sep 2019 20:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whW_AB0pZ0u6P9uVSWpqeb5t2NCX_sMpZNGy8shPDyDNg@mail.gmail.com>
 <CAHk-=wi_yXK5KSmRhgNRSmJSD55x+2-pRdZZPOT8Fm1B8w6jUw@mail.gmail.com>
 <20190911173624.GI2740@mit.edu> <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu> <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914150206.GA2270@darwi-home-pc> <CAHk-=wjuVT+2oj_U2V94MBVaJdWsbo1RWzy0qXQSMAUnSaQzxw@mail.gmail.com>
 <20190915065142.GA29681@gardel-login> <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
 <20190916014050.GA7002@darwi-home-pc>
In-Reply-To: <20190916014050.GA7002@darwi-home-pc>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Sep 2019 20:31:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whzFdN3hg0H56qYQfXVbV2pXo=uAVXoFF+KOsQguqgfMg@mail.gmail.com>
Message-ID: <CAHk-=whzFdN3hg0H56qYQfXVbV2pXo=uAVXoFF+KOsQguqgfMg@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 15, 2019 at 6:41 PM Ahmed S. Darwish <darwish.07@gmail.com> wrote:
>
> Yes, the systemd-random-seed(8) process blocks, but this is an
> isolated process, and it's only there as a synchronization point and
> to load/restore random seeds from disk across reboots.
>
> What blocked the system boot was GDM/gnome-session implicitly calling
> getrandom() for the Xorg MIT cookie.

Aahh. I saw that email, but then in the discussion the systemd case
always ended up coming up first, and I never made the connection.

What a complete crock that silly MIT random cookie is, and what a sad
sad reason for blocking.

              Linus
