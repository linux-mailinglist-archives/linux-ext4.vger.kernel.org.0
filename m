Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1AC2E7A3B
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Dec 2020 16:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgL3PSB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Dec 2020 10:18:01 -0500
Received: from linux.microsoft.com ([13.77.154.182]:38748 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgL3PSA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Dec 2020 10:18:00 -0500
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8270720B6C41
        for <linux-ext4@vger.kernel.org>; Wed, 30 Dec 2020 07:17:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8270720B6C41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1609341439;
        bh=veaHwhtnGcj7k1ybWPhJvPoFZx5cJBkNSei1U33a99M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UNdoyIzwIdVAxtQimRc59bAb1HuNWikYvBVCYn5kLOBgoE8kvFn75sHLnHHQWDk9c
         3MBcKTjH571uAikOU5v3ROf0rzlmL3F7x7hLLOW6VIqKCpyVT7W7MacOuwSPef4e6T
         KJdJJblL/Lkcv5d1HnjTI11Vaq5cvD6Wd8kshdJ0=
Received: by mail-pg1-f170.google.com with SMTP id c132so194080pga.3
        for <linux-ext4@vger.kernel.org>; Wed, 30 Dec 2020 07:17:19 -0800 (PST)
X-Gm-Message-State: AOAM531dWE/Uwiep8BNz5miFMOPlC2RC+zn9Cf/dKQq5/oX5lzG+WhAO
        imldPCJu3+ZsJgxJ9hlja/i1fcrdTr7pykFfwJg=
X-Google-Smtp-Source: ABdhPJyxI1EHQYt3h7wAhBHPIIL4uNaWkPtE61RiZJRiqDusEOTLBg0qr+GcdxsmmaTDakRloM5I+iqmKauyG2MmDBM=
X-Received: by 2002:a05:6a00:a88:b029:19e:4ba8:bbe4 with SMTP id
 b8-20020a056a000a88b029019e4ba8bbe4mr49891757pfl.41.1609341438819; Wed, 30
 Dec 2020 07:17:18 -0800 (PST)
MIME-Version: 1.0
References: <20201229054143epcms2p15ae3cce43bb3c503adf94528f354ba78@epcms2p1>
 <CGME20201229054143epcms2p15ae3cce43bb3c503adf94528f354ba78@epcms2p5>
 <CAFnufp39qXBtOfETsYz5LSoPZWik70uB=czmfpwiA8Hdwpi+dA@mail.gmail.com> <20201230052139epcms2p5d4b8d41625ebd7ea677500d1c05153ef@epcms2p5>
In-Reply-To: <20201230052139epcms2p5d4b8d41625ebd7ea677500d1c05153ef@epcms2p5>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Wed, 30 Dec 2020 16:16:42 +0100
X-Gmail-Original-Message-ID: <CAFnufp0zZL04L5UF_TY7+n91FjktG6Bb0J2j0f3eomXdnHGQ4A@mail.gmail.com>
Message-ID: <CAFnufp0zZL04L5UF_TY7+n91FjktG6Bb0J2j0f3eomXdnHGQ4A@mail.gmail.com>
Subject: Re: Re: discard and data=writeback
To:     daejun7.park@samsung.com
Cc:     "tytso@mit.edu" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 30, 2020 at 6:21 AM Daejun Park <daejun7.park@samsung.com> wrote:
>
> > Hi,
> > >
> > > > # dmesg |grep EXT4-fs |tail -1
> > > > [ 1594.829833] EXT4-fs (nvme0n1p1): mounted filesystem with ordered
> > > > data mode. Opts: data=ordered,discard
> > > > # blktrace /dev/nvme0n1 & sleep 1 ; time rm -rf /media/linux-5.10/ ; kill $!
> > > > [1] 3032
> > > >
> > > > real    0m1.328s
> > > > user    0m0.063s
> > > > sys     0m1.231s
> > > > # === nvme0n1 ===
> > > >   CPU  0:                    0 events,        0 KiB data
> > > >   CPU  1:                    0 events,        0 KiB data
> > > >   CPU  2:                    0 events,        0 KiB data
> > > >   CPU  3:                 1461 events,       69 KiB data
> > > >   CPU  4:                    1 events,        1 KiB data
> > > >   CPU  5:                    0 events,        0 KiB data
> > > >   CPU  6:                    0 events,        0 KiB data
> > > >   CPU  7:                    0 events,        0 KiB data
> > > >   Total:                  1462 events (dropped 0),       69 KiB data
> > > >
> > > >
> > > > # dmesg |grep EXT4-fs |tail -1
> > > > [ 1734.837651] EXT4-fs (nvme0n1p1): mounted filesystem with writeback
> > > > data mode. Opts: data=writeback,discard
> > > > # blktrace /dev/nvme0n1 & sleep 1 ; time rm -rf /media/linux-5.10/ ; kill $!
> > > > [1] 3069
> > > >
> > > > real    1m30.273s
> > > > user    0m0.139s
> > > > sys     0m3.084s
> > > > # === nvme0n1 ===
> > > >   CPU  0:               133830 events,     6274 KiB data
> > > >   CPU  1:                21878 events,     1026 KiB data
> > > >   CPU  2:                46365 events,     2174 KiB data
> > > >   CPU  3:                98116 events,     4600 KiB data
> > > >   CPU  4:               290902 events,    13637 KiB data
> > > >   CPU  5:                10926 events,      513 KiB data
> > > >   CPU  6:                76861 events,     3603 KiB data
> > > >   CPU  7:                17855 events,      837 KiB data
> > > >   Total:                696733 events (dropped 0),    32660 KiB data
> > > >
> > >
> > > In this result, there is few IO in ordered mode.
> > >
> > > As I understand (please correct this if I am wrong), with writeback +
> > > discard, ext4_issue_discard is called immediately at each rm command.
> > > However, with ordered mode, ext4_issue_discard is called when end of
> > > committing a transaction to pace with the corresponding transaction.
> > > It means, they are not discarded yet.
> > >
> > > Even with ordered mode, if sync is called after rm command,
> > > ext4_issue_discard can be called due to transaction commit.
> > > So, I think you will get similar results form writeback mode with sync
> > > command.
> > >
> >
> > Hi,
> >
> > that's what I get with data=ordered if I issue a sync after the removal:
> >
> > # time rm -rf /media/linux-5.10/ ; sync ; kill $!
> >
> > real    0m1.569s
> > user    0m0.044s
> > sys     0m1.508s
> > #
> >  === nvme0n1 ===
> >  CPU  0:                10980 events,      515 KiB data
> >  CPU  1:                    0 events,        0 KiB data
> >  CPU  2:                    0 events,        0 KiB data
> >  CPU  3:                   26 events,        2 KiB data
> >  CPU  4:                 3601 events,      169 KiB data
> >  CPU  5:                    0 events,        0 KiB data
> >  CPU  6:                21786 events,     1022 KiB data
> >  CPU  7:                    0 events,        0 KiB data
> >  Total:                 36393 events (dropped 0),     1706 KiB data
> >
> > Still way less transactions than writeback.
> >
> The full trace you shared on this thread seems contains only on writeback
> mode. In the trace, discards are issued by each deletion file by rm.
>
> If you share the full trace on ordered mode, it will help we analyze the
> results. It is expected that number of discards will lower than writeback
> mode, because discards can be merged on ordered mode.
>

Hi,

I did the same blktrace with data=ordered,discard
Find it here:

https://drive.google.com/file/d/1gqffP9WPCME3_81xlXAQCiDlTK-Gqv4_/view?usp=sharing

Thanks,
-- 
per aspera ad upstream
