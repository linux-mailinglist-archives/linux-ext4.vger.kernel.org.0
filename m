Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE855B5439
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 19:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbfIQR20 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 13:28:26 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:40752 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731150AbfIQR20 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 13:28:26 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 91A53E80FFC;
        Tue, 17 Sep 2019 19:28:24 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 44361160ADC; Tue, 17 Sep 2019 19:28:24 +0200 (CEST)
Date:   Tue, 17 Sep 2019 19:28:24 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Willy Tarreau <w@1wt.eu>, Matthew Garrett <mjg59@srcf.ucam.org>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        zhangjs <zachary@baishancloud.com>, linux-ext4@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.3-rc8
Message-ID: <20190917172824.GB31798@gardel-login>
References: <CAHk-=wgs65hez6ctK7J2k46BdQzvKU5avExPOTTJsZu6iqA-ow@mail.gmail.com>
 <C4F7DC65-50B9-4D70-8E9B-0A6FF5C1070A@srcf.ucam.org>
 <20190917052438.GA26923@1wt.eu>
 <2508489.jOnZlRuxVn@merkaba>
 <CAHk-=wiGg-G8JFJ=R7qf0B+UtqA_Weouk6v+McmfsLJLRq6AKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiGg-G8JFJ=R7qf0B+UtqA_Weouk6v+McmfsLJLRq6AKA@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Di, 17.09.19 09:27, Linus Torvalds (torvalds@linux-foundation.org) wrote:

> But look at what gnome-shell and gnome-session-b does:
>
>     https://lore.kernel.org/linux-ext4/20190912034421.GA2085@darwi-home-pc/
>
> and most of them already set GRND_NONBLOCK, but look at the
> problematic one that actually causes the boot problem:
>
>     gnome-session-b-327   4.400620: getrandom(16 bytes, flags = 0)
>
> and here the big clue is: "Hey, it only asks for 128 bits of
> randomness".

I don't think this is a good check to make.

In fact most cryptography folks say taking out more than 256bit is
never going to make sense, that's why BSD getentropy() even returns an
error if you ask for more than 256bit. (and glibc's getentropy()
wrapper around getrandom() enforces the same size limit btw)

On the BSDs the kernel's getentropy() call is primarily used to seed
their libc's arc4random() every now and then, and userspace is
supposed to use only arc4random(). I am pretty sure we should do the
same on Linux in the long run. i.e. the idea that everyone uses the
kernel syscall directly sounds wrong to me, and designing the syscall
so that everyone calls it is hence wrong too.

On the BSDs getentropy() is hence unconditionally blocking, without
any flags or so, which makes sense since it's not supposed to be
user-facing really so much, but more a basic primitive for low-level
userspace infrastructure only, that is supposed to be wrapped
non-trivially to be useful. (that's at least how I understood their
APIs)

> Does anybody believe that 128 bits of randomness is a good basis for a
> long-term secure key? Even if the key itself contains than that, if
> you are generating a long-term secure key in this day and age, you had
> better be asking for more than 128 bits of actual unpredictable base
> data. So just based on the size of the request we can determine that
> this is not hugely important.

aes128 is very common today. It's what baseline security is.

I have the suspicion crypto folks would argue that 128…256 is the only
sane range for cryptographic keys...

Lennart

--
Lennart Poettering, Berlin
