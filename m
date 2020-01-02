Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37A0D12E5DE
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Jan 2020 12:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgABLzQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Jan 2020 06:55:16 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:33906 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgABLzP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Jan 2020 06:55:15 -0500
Received: by mail-io1-f54.google.com with SMTP id z193so38036293iof.1;
        Thu, 02 Jan 2020 03:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2CXjiD6I6yu4Kt+bNv5ua4qYRJXTqkhhK9Mk3VAAT5o=;
        b=SWA0CVMogxKPxm++1rmBHfuZa55b+UVfciSwp8DsCtA3j5SN3mqto1KwV0V5hQPq/G
         yXsSlbivzwTAMOsVfAJTh44YmduFyn1GsF9GTNFBP8cSSYzmi46w9EeIOJJT1ok3CgYV
         lPs9VjXcDQvh1bQsUDa0tza0QL3ebsDcwq73H4DANns17EV1H7iixalQmLBcsV9mJkKS
         r0nHKnCHxmzJSGE98Hx8Z3EmmVjyxfytJeQCvUx0K0QjpMES0V8EWTttXiE8nzWDr5l8
         XgNKjrRSC9QSycmOxfp1cC9m3bh7G0Cgm+Nc3dScpsnxrXabDz1WzHvi/q1xlXaCSW35
         65ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2CXjiD6I6yu4Kt+bNv5ua4qYRJXTqkhhK9Mk3VAAT5o=;
        b=Kv12h6w/exzQ/VVtCfqiP8KKElZz4M3g669yHSIGJ4DFs88Mh5XPD2l+ZHWDZvjkV0
         Cs0+nU/dsDQDjBploxqMGEFpg9eXDTmlGEFDXtl7Alj3SPyfaiLGhmFmZKbvqSz3J+Qk
         pksvisSbH4OESKRRAhh6N1BsyekzjoIwkJre8FdmbxHlVCeTfV4RCQSi3Lc7UKMnYRJB
         ujIb5BLsTXgVRBjtMRIFfKnyNG3pAdb4TDAXf7cgOEwc1sOH1wSMVwCIqmNFG7eocDRz
         h0eDa00Cgl3pGZPyGjaLgIWn0eWY5k3J7FKU1X/Pbr44rPqmC+7FQP2Au/VKmZiqYyUQ
         EZ9A==
X-Gm-Message-State: APjAAAX26aX/FeXz97unmJVLo4kZbyyfJwPUUmTcFoZIBS9jQSzWxXdJ
        Yr0/Ur0vFWLykfATbcJucuhFAV8KOGA/Rkov52c=
X-Google-Smtp-Source: APXvYqyejzGqQWvLQeFSNQMfcz/wgffqePxVKa45wWJfRXPGcLv+AYWkEKG6OwAE9vSojmxQ4R3v5qgInCIzI+4J8/I=
X-Received: by 2002:a02:b385:: with SMTP id p5mr62780350jan.43.1577966114673;
 Thu, 02 Jan 2020 03:55:14 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsODr3tMpQxJ_nhWQQg5WGakFt4Yu5B8ev6ErOkc+zv9kA@mail.gmail.com>
 <20200101141748.GA191637@mit.edu> <CABXGCsOv26W6aqB5WPMe-mEynmwy55DTfTeL5Dg9vRq6+Y6WvA@mail.gmail.com>
 <CABXGCsNkzPrjqMRaWpssorxzhMLWBvLeSw9BpKYr_DW4LJQECQ@mail.gmail.com> <20200102110817.ahqaqidw3ztw3kax@10.255.255.10>
In-Reply-To: <20200102110817.ahqaqidw3ztw3kax@10.255.255.10>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 2 Jan 2020 16:55:32 +0500
Message-ID: <CABXGCsNkm3VuzO60WBCi4VJmDnO=DmprQ1P=dd0FcW2-+dGc0w@mail.gmail.com>
Subject: Re: [bugreport] "hwclock -w" reset time instead of setting the right time
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 2 Jan 2020 at 16:08, Karel Zak <kzak@redhat.com> wrote:
>
>  Can you try "hwclock -w -v" to get more details?
>
>  For example on my workstation:
>
>         # ./hwclock -w -v
>         hwclock from util-linux 2.35-rc1-20-63f8
>         System Time: 1577963091.683987
>         Trying to open: /dev/rtc0
>         Using the rtc interface to the clock.
>         Last drift adjustment done at 1531914946 seconds after 1969
>         Last calibration done at 1531914946 seconds after 1969
>         Hardware clock is on UTC time
>         Assuming hardware clock is kept in UTC time.
>         RTC type: 'rtc_cmos'
>         Using delay: 0.500000 seconds
>         missed it - 1577963091.684767 is too far past 1577963091.500000 (0.184767 > 0.001000)
>         1577963092.500000 is close enough to 1577963092.500000 (0.000000 < 0.002000)
>         Set RTC to 1577963092 (1577963091 + 1; refsystime = 1577963091.000000)
>         Setting Hardware Clock to 11:04:52 = 1577963092 seconds since 1969
>         ioctl(RTC_SET_TIME) was successful.
>         Not adjusting drift factor because the --update-drift option was not used.
>         New /etc/adjtime data:
>         0.000000 1577963091 0.000000
>         1577963091
>         UTC
>

# hwclock -w -v
hwclock from util-linux 2.35-rc1-20-63f8
System Time: 1577964536.796672
Trying to open: /dev/rtc0
Using the rtc interface to the clock.
Last drift adjustment done at 1577950892 seconds after 1969
Last calibration done at 1577950892 seconds after 1969
Hardware clock is on UTC time
Assuming hardware clock is kept in UTC time.
RTC type: 'rtc_cmos'
Using delay: 0.500000 seconds
missed it - 1577964536.797135 is too far past 1577964536.500000
(0.297135 > 0.001000)
1577964537.500000 is close enough to 1577964537.500000 (0.000000 < 0.002000)
Set RTC to 1577964537 (1577964536 + 1; refsystime = 1577964536.000000)
Setting Hardware Clock to 11:28:57 = 1577964537 seconds since 1969
ioctl(RTC_SET_TIME) was successful.
Not adjusting drift factor because the --update-drift option was not used.
New /etc/adjtime data:
0.000000 1577964536 0.000000
1577964536
UTC

Demonstration: https://youtu.be/Yx27IH2opEc

--
Best Regards,
Mike Gavrilov.
