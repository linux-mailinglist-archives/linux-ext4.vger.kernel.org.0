Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C34B446F
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 01:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390472AbfIPXGI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Sep 2019 19:06:08 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39981 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390458AbfIPXGH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Sep 2019 19:06:07 -0400
Received: by mail-lf1-f68.google.com with SMTP id d17so1274703lfa.7
        for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2019 16:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vGY772lMZRO+RxPe3yiKJ2HFEo5jrkt8czVBRCefa98=;
        b=Q7JCqBOjFHRpAm3IIWECi7V0+z1iWHaDOFZaCm6UHZvTzYhkaHhwj14043bgrTO5+M
         irDuUsnCTLlLSkR5eaTGatxvVbFnXqaZCYAJkoMxi8+1pB0mDlKmdUInEOq+UcizHb9i
         e+qtbtq9xxZIz3FByFamlLpdLYhAncsgzI69k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vGY772lMZRO+RxPe3yiKJ2HFEo5jrkt8czVBRCefa98=;
        b=P7a8Tu40BWHC3CCXLy0u/s9y9il+YXA8CtOcjah3rePNAaGMozXHOVR/0narWTkQ89
         K8C0P30W4ukZWjShDXeL5tmVIfMuqJ5x2clgTZvFY9jIqxZ/VRfE5DTTyMC9QMJHNJxT
         wv8G2ZQ96dB1U9SQjxX/sZeewXGgy9/SeMu5nX9XKpsccDv13vpX+RA3qeBPeDgTqV6P
         ukGir8q3JODIB47CqFrD4kgjfYwQ0LPuVJ6S+igBrlFpg9i93pieGyljg9r4zcNqG2jh
         wJ+NcX9YVlozykpBzyBeEjKylwpL0/VMVLTpVNED1OObhqFhp2nIwqQjT0cYaTsgr7lJ
         3F/g==
X-Gm-Message-State: APjAAAX8TMELU4brCgL6695A3OYWO5mf7L0+swqpWPEcsqGH91ecKsn5
        hX6kUb8szg34R50rPot1uie+dzZvEKo=
X-Google-Smtp-Source: APXvYqz/0ePnC7FWdnzeosX7zyK/SvuVgpftT6xSiYZLoivK00P033QGhkxS6y5UCaT1vN4xOJIp9w==
X-Received: by 2002:a19:f111:: with SMTP id p17mr308489lfh.187.1568675164974;
        Mon, 16 Sep 2019 16:06:04 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id n12sm38369lfh.86.2019.09.16.16.06.04
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 16:06:04 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id q11so1249244lfc.11
        for <linux-ext4@vger.kernel.org>; Mon, 16 Sep 2019 16:06:04 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr319536lfp.61.1568675164042;
 Mon, 16 Sep 2019 16:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiDNRPzuNE-eXs7QOpgPVLXsZOXEMQE9RmAWABiiZrSAQ@mail.gmail.com>
 <20190916014050.GA7002@darwi-home-pc> <20190916014833.cbetw4sqm3lq4x6m@shells.gnugeneration.com>
 <20190916024904.GA22035@mit.edu> <20190916042952.GB23719@1wt.eu>
 <CAHk-=wg4cONuiN32Tne28Cg2kEx6gsJCoOVroqgPFT7_Kg18Hg@mail.gmail.com>
 <20190916061252.GA24002@1wt.eu> <CAHk-=wjWSRzTjwN9F5gQcxtPkAgaRHJOOOTUjVakqP-Nzg9BXA@mail.gmail.com>
 <20190916172117.GB15263@mit.edu> <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <20190916230217.vmgvsm6o2o4uq5j7@srcf.ucam.org>
In-Reply-To: <20190916230217.vmgvsm6o2o4uq5j7@srcf.ucam.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 16 Sep 2019 16:05:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwSt4RqzqM7cA5SAhj+wkORfr1bG=+yydTJPtayQ0JwQ@mail.gmail.com>
Message-ID: <CAHk-=whwSt4RqzqM7cA5SAhj+wkORfr1bG=+yydTJPtayQ0JwQ@mail.gmail.com>
Subject: Re: Linux 5.3-rc8
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Vito Caputo <vcaputo@pengaru.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
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

On Mon, Sep 16, 2019 at 4:02 PM Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> The semantics many people want for secure key generation is urandom, but
> with a guarantee that it's seeded.

And that is exactly what I'd suggest GRND_SECURE should do.

The problem with:

> getrandom()'s default behaviour at present provides that

is that exactly because it's the "default" (ie when you don't pass any
flags at all), that behavior is what all the random people get who do
*not* really intentionally want it, they just don't think about it.

> Changing the default (even with kernel warnings) seems like
> it risks people generating keys from an unseeded prng, and that seems
> like a bad thing?

I agree that it's a horrible thing, but the fact that the default 0
behavior had that "wait for entropy" is what now causes boot problems
for people.

             Linus
