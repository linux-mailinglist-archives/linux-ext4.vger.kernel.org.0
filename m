Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00B5912E0FB
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Jan 2020 00:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgAAXTW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Jan 2020 18:19:22 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:36972 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgAAXTW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Jan 2020 18:19:22 -0500
Received: by mail-il1-f170.google.com with SMTP id t8so32916486iln.4
        for <linux-ext4@vger.kernel.org>; Wed, 01 Jan 2020 15:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V7fM8wJLsdkRbqSTtr1bCPRdkXWe4JNUEFnPU4bzcoY=;
        b=gU/tbS5EAjJ4UzdcrTJluc/f800wh3L7mBgQN7WPu+Bv91gDRhRLn3DrcXPcSmS5GW
         4+c5krN0wE7PuVosdLdRn0BysQMmbba1ixmgxWSstwaB/9vlcOTOdMQTFL5dxOaIhYEe
         A0KJAMisePJsqnJRc88C9zOa/ObJ7Agk26kryOl19oFllH9HCSdN8dE+jKWz4V15LGgc
         h7WUN+cG2/5c7Miq1i+sXvxIsgBs5LEzb96KInFUd3SvdM2OXkvNVOoaIxwOUFEKgA07
         PfVfqnygGoqi7+3xwXG4S9qVHPgipzZvfpJJW3gGLfAyFu5CWFug/wymkC7R/F5+lKgy
         2CaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V7fM8wJLsdkRbqSTtr1bCPRdkXWe4JNUEFnPU4bzcoY=;
        b=ENqlGpHca4MPVJ/jSfnYVvC+yRTUXRFtUXNtPCcmJVskpwkJFD90of8A57fnR29fqT
         m8V76CmhAWo0+s+WZ4RcS6nlfv2A4zM9NmCr7E+1mBZqG8hWMNy9kOdX/ohiB3YRD4zy
         MiNq2oWVT/HlcCZx4/PwduQFximY6jHmtcFaje9FIAZeCiFYdJ9jgwALrBsMu4ujCUXA
         WkAkA2M3rmRLgBoSM1FjtOctLUQ3XAsesh5+Nk/a8ThAjBAu0ZV+aXVuN0NwQmtE/OVy
         mRi1ncWgfVaqNRbb8LtkJe/hAkF0AbmPqv/CFv/5u0i2f3iCvmzZljxSiWaZ6ElcvmFv
         ihzg==
X-Gm-Message-State: APjAAAU6T1jC6jDwmOSv9LuA8gDdsmOefxoaDCrA1yctvA/JjewjLxQ8
        6M0ullh6pDF0BOYW2qINf/ciBvNoIqDrTCxoPKMvrEnpzm1jfw==
X-Google-Smtp-Source: APXvYqwxahDCQ3GMDSwwTwwkUq/w/a04J4kOPQBnT/RHGNmvjQO/mtCZ68VJrPyp50R8sKdrGeYGZU8VrBtA6g5CEU8=
X-Received: by 2002:a92:58d7:: with SMTP id z84mr64767351ilf.179.1577920761050;
 Wed, 01 Jan 2020 15:19:21 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsODr3tMpQxJ_nhWQQg5WGakFt4Yu5B8ev6ErOkc+zv9kA@mail.gmail.com>
 <20200101141748.GA191637@mit.edu>
In-Reply-To: <20200101141748.GA191637@mit.edu>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 2 Jan 2020 04:19:10 +0500
Message-ID: <CABXGCsOv26W6aqB5WPMe-mEynmwy55DTfTeL5Dg9vRq6+Y6WvA@mail.gmail.com>
Subject: Re: [bugreport] Ext4 automatically checked at each boot
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 1 Jan 2020 at 19:17, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> The problem is casued by the fact that the mount time is incorrect,
> which indicates that the system time was incorrect at the time when
> the file system was mounted and when it fsck was run.  Since the last
> write time was in the future, this triggered "time is insane" check.
>
> This is inconsistent with your report that started happening when you
> switched to a new motherboard.  That's because the real time clock is
> not reporting the correct time when the system is booted.  Later on,
> in the boot cycle, after the root file system is checked and remounted
> read-write, the system time is getting set from an internet time
> server.  This then causes the last write time to be ahead of the last
> mount time, and "in the future" with respect to the real time clock.
>
> Normally, the hardware clock's time gets set to match system time when
> it is set from network time, or when the system is getting shut down
> cleanly, but your init scripts aren't doing this properly --- or you
> normally shut down your system by just flipping the power switch, and
> not letting the shutdown sequence run correctly.  The other possibilty
> is the real time clock on your system is just completly busted
> (although normally when that happens, the last mount time would be in
> the 1970's.)
>
> Running "/sbin/hwclock -w" as root may fix things; as is figuring out
> why this isn't run automatically by your boot scripts.  Another
> workaround is to add to /etc/e2fsck.conf the following:
>
> [options]
>         broken_system_lock = true
>
> This will disable e2fsck's time checks.
>

Thank you very much for the tip, I would never have guessed that the
cause of this issue in hwclock.
I started to watch hwclock through the motherboard BIOS and found that
hwclock resets every time after booting Linux.
Demonstration: https://youtu.be/TBrLNFbBaPo
Apparently for this reason, "hwclock -w" did not help me, workaround
with "broken_system_clock = true" is working, but I would like to fix
the root of the cause.
Who can help with this?


--
Best Regards,
Mike Gavrilov.
