Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C77D2E70F6
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Dec 2020 14:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgL2Nnk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Dec 2020 08:43:40 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51450 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgL2Nnj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Dec 2020 08:43:39 -0500
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8022320B6C40
        for <linux-ext4@vger.kernel.org>; Tue, 29 Dec 2020 05:42:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8022320B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1609249378;
        bh=EGfTyWfS7KnpoDIQCJrU8wyEkxf0jBil6dNazvWf8RQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Jp/660+GYglFAbbCjtN1TMFROCB8J6RTi3DTeyIod6xp/wxLEGz53RMpIatmwmysM
         cUCDEcVxXSp7IHB6SjpHc0ifu/0vJ+b92bMVlGNPbRASpHY9lNqJcpayukNPC/jY/3
         +3sn6lcQ26DRI7Uw12FN/ULS/h4O9GjXCCJiJHfk=
Received: by mail-pj1-f50.google.com with SMTP id z12so1460831pjn.1
        for <linux-ext4@vger.kernel.org>; Tue, 29 Dec 2020 05:42:58 -0800 (PST)
X-Gm-Message-State: AOAM532vBttj+Ze3sYjBH6cUqLoDnyq0OmfDkjpfHSa6ZrBuyMvWORco
        R5MT6muSniK7Bum1eN2l0vIZYoQKbhARv+ftoq0=
X-Google-Smtp-Source: ABdhPJw4bmVuO+2eKLwHOQtvyZ5jBz+1PVg+zSeMvvAGA1Nxbx5CvB+9C75j5y6D73F3P5wjcNJPNgEibUart233gkA=
X-Received: by 2002:a17:902:7d84:b029:db:feae:425e with SMTP id
 a4-20020a1709027d84b02900dbfeae425emr49066589plm.43.1609249377950; Tue, 29
 Dec 2020 05:42:57 -0800 (PST)
MIME-Version: 1.0
References: <CGME20201229054143epcms2p15ae3cce43bb3c503adf94528f354ba78@epcms2p1>
 <20201229054143epcms2p15ae3cce43bb3c503adf94528f354ba78@epcms2p1>
In-Reply-To: <20201229054143epcms2p15ae3cce43bb3c503adf94528f354ba78@epcms2p1>
From:   Matteo Croce <mcroce@linux.microsoft.com>
Date:   Tue, 29 Dec 2020 14:42:22 +0100
X-Gmail-Original-Message-ID: <CAFnufp39qXBtOfETsYz5LSoPZWik70uB=czmfpwiA8Hdwpi+dA@mail.gmail.com>
Message-ID: <CAFnufp39qXBtOfETsYz5LSoPZWik70uB=czmfpwiA8Hdwpi+dA@mail.gmail.com>
Subject: Re: discard and data=writeback
To:     daejun7.park@samsung.com
Cc:     "tytso@mit.edu" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 29, 2020 at 6:41 AM Daejun Park <daejun7.park@samsung.com> wrote:
>
> Hi,
>
> > # dmesg |grep EXT4-fs |tail -1
> > [ 1594.829833] EXT4-fs (nvme0n1p1): mounted filesystem with ordered
> > data mode. Opts: data=ordered,discard
> > # blktrace /dev/nvme0n1 & sleep 1 ; time rm -rf /media/linux-5.10/ ; kill $!
> > [1] 3032
> >
> > real    0m1.328s
> > user    0m0.063s
> > sys     0m1.231s
> > # === nvme0n1 ===
> >   CPU  0:                    0 events,        0 KiB data
> >   CPU  1:                    0 events,        0 KiB data
> >   CPU  2:                    0 events,        0 KiB data
> >   CPU  3:                 1461 events,       69 KiB data
> >   CPU  4:                    1 events,        1 KiB data
> >   CPU  5:                    0 events,        0 KiB data
> >   CPU  6:                    0 events,        0 KiB data
> >   CPU  7:                    0 events,        0 KiB data
> >   Total:                  1462 events (dropped 0),       69 KiB data
> >
> >
> > # dmesg |grep EXT4-fs |tail -1
> > [ 1734.837651] EXT4-fs (nvme0n1p1): mounted filesystem with writeback
> > data mode. Opts: data=writeback,discard
> > # blktrace /dev/nvme0n1 & sleep 1 ; time rm -rf /media/linux-5.10/ ; kill $!
> > [1] 3069
> >
> > real    1m30.273s
> > user    0m0.139s
> > sys     0m3.084s
> > # === nvme0n1 ===
> >   CPU  0:               133830 events,     6274 KiB data
> >   CPU  1:                21878 events,     1026 KiB data
> >   CPU  2:                46365 events,     2174 KiB data
> >   CPU  3:                98116 events,     4600 KiB data
> >   CPU  4:               290902 events,    13637 KiB data
> >   CPU  5:                10926 events,      513 KiB data
> >   CPU  6:                76861 events,     3603 KiB data
> >   CPU  7:                17855 events,      837 KiB data
> >   Total:                696733 events (dropped 0),    32660 KiB data
> >
>
> In this result, there is few IO in ordered mode.
>
> As I understand (please correct this if I am wrong), with writeback +
> discard, ext4_issue_discard is called immediately at each rm command.
> However, with ordered mode, ext4_issue_discard is called when end of
> committing a transaction to pace with the corresponding transaction.
> It means, they are not discarded yet.
>
> Even with ordered mode, if sync is called after rm command,
> ext4_issue_discard can be called due to transaction commit.
> So, I think you will get similar results form writeback mode with sync
> command.
>

Hi,

that's what I get with data=ordered if I issue a sync after the removal:

# time rm -rf /media/linux-5.10/ ; sync ; kill $!

real    0m1.569s
user    0m0.044s
sys     0m1.508s
#
 === nvme0n1 ===
 CPU  0:                10980 events,      515 KiB data
 CPU  1:                    0 events,        0 KiB data
 CPU  2:                    0 events,        0 KiB data
 CPU  3:                   26 events,        2 KiB data
 CPU  4:                 3601 events,      169 KiB data
 CPU  5:                    0 events,        0 KiB data
 CPU  6:                21786 events,     1022 KiB data
 CPU  7:                    0 events,        0 KiB data
 Total:                 36393 events (dropped 0),     1706 KiB data

Still way less transactions than writeback.

Cheers,
-- 
per aspera ad upstream
