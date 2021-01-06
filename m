Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD25B2EC576
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Jan 2021 22:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbhAFVFv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Jan 2021 16:05:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbhAFVFv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 6 Jan 2021 16:05:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4A882313F;
        Wed,  6 Jan 2021 21:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609967110;
        bh=VWIt9mxHh+1O8YrPaZvQBjkmRhxAdVAUkyWUCugEtu4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=umv81nRlQfkJEJgnIionOHth1kbhM1WucDJtqvaFyCHFBVQy/rK0fhpSESqcmVoa4
         ZbIlrVfZJvU/ZxO0LOQI3i6DAW4vbqpCbpaxpSSr6ehmw4hbk9WUYPA5BJgEe4LGjA
         +z8Qq2wPs7pj6x+af5Ov6MSVMLG8XnVit9xeaAtJ+MV7HNqNvjTILEXhJNIxkvUChQ
         PEfXDFfGpsYDqOcwc5A3p3SIIwjQxynMN0ASIhfsjha12BYlFnBV9CXqvf9g0kcf2k
         70co1Am8U/8wlS5/sSKRx88UB0BuU44p6H0MyfdMY3fbl3LlUL5dBDLDhdAbu5es7c
         u8t1ntBtzkWbA==
Received: by mail-ot1-f49.google.com with SMTP id 11so4311080oty.9;
        Wed, 06 Jan 2021 13:05:10 -0800 (PST)
X-Gm-Message-State: AOAM532o0SwZfVDjBFKWvkj/84S2GCAPWU4gTCj7ai1Z0tAj0vKwwUvE
        Ida1aQDzfKQ5gQkofxfnsJ6fij1ok9dprIf6Gzc=
X-Google-Smtp-Source: ABdhPJwEF2XLuGgrvp5IlNBbBpYgVrfgrMFZjZhVcXuUwn7FhUss+I9V2lAAPWca/5+Q7QzttNxk10KRmxUOpwwlXlc=
X-Received: by 2002:a05:6830:1e14:: with SMTP id s20mr4598178otr.210.1609967109975;
 Wed, 06 Jan 2021 13:05:09 -0800 (PST)
MIME-Version: 1.0
References: <20210105154726.GD1551@shell.armlinux.org.uk> <20210106115359.GB26994@C02TD0UTHF1T.local>
 <20210106135253.GJ1551@shell.armlinux.org.uk> <20210106172033.GA2165@willie-the-truck>
In-Reply-To: <20210106172033.GA2165@willie-the-truck>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 6 Jan 2021 22:04:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2u=WtQ_98F2934QEZM19YaDPkfzQzHoiCgnaBYi3Qw3g@mail.gmail.com>
Message-ID: <CAK8P3a2u=WtQ_98F2934QEZM19YaDPkfzQzHoiCgnaBYi3Qw3g@mail.gmail.com>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
To:     Will Deacon <will@kernel.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 6, 2021 at 6:22 PM Will Deacon <will@kernel.org> wrote:
> On Wed, Jan 06, 2021 at 01:52:53PM +0000, Russell King - ARM Linux admin wrote:

>
>    and the resulting Image is here:
>
>    https://mirrors.edge.kernel.org/pub/linux/kernel/people/will/bugs/rmk/Image-5.9.0
>
> 3. Using that kernel, I boot into a 64-bit Debian 10 filesystem and open a
>    couple of terminals over SSH.
>
> 4. In one terminal, I run:
>
>    $ while (true); do find /var /usr /bin /sbin -type f -print0 | xargs -0
>      md5sum > /dev/null; echo 2 | sudo tee /proc/sys/vm/drop_caches; done
>
>    (note that sudo will prompt you for a password on the first iteration)
>
> 5. In the other terminal, I run:
>
>    $ while (true); do ./hackbench ; sleep 1; done
>
>    where hackbench is built from:
>
>    https://people.redhat.com/mingo/cfs-scheduler/tools/hackbench.c
>
>    and compiled according to comment in the source code.

I tried the Image-5.9.0 on a virtual machine with seven CPUs (two clusters)
running in an M1 mac mini and ran these commands inside.

> With that, I see the following after ten seconds or so:
>
>   EXT4-fs error (device sda2): ext4_lookup:1707: inode #674497: comm md5sum: iget: checksum invalid
>
> Russell, Mark -- does this recipe explode reliably for you too?

Negative unfortunately -- no checksum mismatch so far, with 10 minutes
elapsed. I'll keep it running a bit longer.

        arnd
