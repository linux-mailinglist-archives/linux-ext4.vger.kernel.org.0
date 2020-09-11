Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93800266392
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Sep 2020 18:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgIKQU1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Sep 2020 12:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgIKQUS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Sep 2020 12:20:18 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E1EC061573
        for <linux-ext4@vger.kernel.org>; Fri, 11 Sep 2020 09:20:17 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n25so12924292ljj.4
        for <linux-ext4@vger.kernel.org>; Fri, 11 Sep 2020 09:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wS+2D5dfLN9QgihIWAla+nKxV9MYjTp5BLkNM4khVjE=;
        b=XbPCLeeMd7dUEDmR8HalrH43Wz+fnWFeYhs/rlnvLr5vCYsgvWReALY9m08mRxarHs
         fstWw9ej/4DgNV+wO7ddIZssg2Kl+GzST6IOWjuodymr5DqtuuVs6l+11effO3QKToXx
         7BWoJU9LkLd7qam10Ppdv/SSsdF+Cs1O6RkK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wS+2D5dfLN9QgihIWAla+nKxV9MYjTp5BLkNM4khVjE=;
        b=BOl8WZ+f3q/WhylAjyJoss1zIpyylOKQRuMKUO+Zrg853ghpFmdf4MSzJnVYwS5bDS
         Xtqy9dcSwBwZ2/Mkrb3HqUpCDNV2Yzy7vK6AocUqE5EV5eixuUb0oLQo16Wre36zGAl+
         Yrud9/7eaJ/NIxv30qRm5emjWY2cEg+SHVvZ/tRBrGLTQqTLZ8b+aY78SN+2RfqTml9u
         zIR04Rzij+b+JAKgBXkeQcLMubp6dBM+kkpCUf6VSuu+ueY7fD84rvm0bCNdpAczKsU1
         7XHqUOUOLMYXt0ct3lCghX3NVYaQVxmx9TbfN18wh7MUEyxoMb3XgHUOPf372jahJfbx
         zTTA==
X-Gm-Message-State: AOAM532AOA3Kv2r3eGQOa0fc8R9f70Q96j6yrJMFx/HaYm/4EN5wnG8O
        r9As40Kz/F2edA3gj7BH8wZr6X/IACVZwQ==
X-Google-Smtp-Source: ABdhPJzeVrHEFxR15VVNG+76r99hCyKvzlBsHMBum6YYdY3PxvAVZ9mgS09X9teOEDGYoKe47BC8kg==
X-Received: by 2002:a2e:89ca:: with SMTP id c10mr1133219ljk.223.1599841215960;
        Fri, 11 Sep 2020 09:20:15 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 82sm136964lfo.173.2020.09.11.09.20.14
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 09:20:14 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id s205so12916372lja.7
        for <linux-ext4@vger.kernel.org>; Fri, 11 Sep 2020 09:20:14 -0700 (PDT)
X-Received: by 2002:a2e:84d6:: with SMTP id q22mr1020283ljh.70.1599841213913;
 Fri, 11 Sep 2020 09:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiZnE409WkTOG6fbF_eV1LgrHBvMtyKkpTqM9zT5hpf9A@mail.gmail.com>
 <CAHk-=wj+Qj=wXByMrAx3T8jmw=soUetioRrbz6dQaECx+zjMtg@mail.gmail.com>
 <CAHk-=wgOPjbJsj-LeLc-JMx9Sz9DjGF66Q+jQFJROt9X9utdBg@mail.gmail.com>
 <CAHk-=wjjK7PTnDZNi039yBxSHtAqusFoRrZzgMNTiYkJYdNopw@mail.gmail.com>
 <aa90f272-1186-f9e1-8fdb-eefd332fdae8@MichaelLarabel.com> <CAHk-=wh_31_XBNHbdF7EUJceLpEpwRxVF+_1TONzyBUym6Pw4w@mail.gmail.com>
 <e24ef34d-7b1d-dd99-082d-28ca285a79ff@MichaelLarabel.com> <CAHk-=wgEE4GuNjcRaaAvaS97tW+239-+tjcPjTq2FGhEuM8HYg@mail.gmail.com>
 <6e1d8740-2594-c58b-ff02-a04df453d53c@MichaelLarabel.com> <CAHk-=wgJ3-cEkU-5zXFPvRCHKkCCuKxVauYWGphjePEhJJgtgQ@mail.gmail.com>
 <d2023f4c-ef14-b877-b5bb-e4f8af332abc@MichaelLarabel.com> <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com> <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
In-Reply-To: <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Sep 2020 09:19:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
Message-ID: <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Michael Larabel <Michael@michaellarabel.com>
Cc:     "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 11, 2020 at 6:42 AM Michael Larabel
<Michael@michaellarabel.com> wrote:
>
> From preliminary testing of the patch on a Threadripper box, the EXT4 locking patch did help with a small improvement at 10 concurrent users for Apache but all the higher counts didn't end up showing any real change with the patch.

Ok, it's probably simply that fairness is really bad for performance
here in general, and that special case is just that - a special case,
not the main issue.

I'll have to think about it. We've certainly seen this before (the
queued spinlocks brought the same fairness issues), but this is much
worse because of how it affects scheduling on a big level.

Some middle ground hybrid model (unfair in the common case, but with
at least _some_ measure of fairness for the worst-case situation to
avoid the worst-case latency spikes) would be best, but I don't see
how to do it.

              Linus

                 Linus

                  Linus
