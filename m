Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807FB2E7631
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Dec 2020 06:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgL3FW0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Dec 2020 00:22:26 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:23993 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgL3FW0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Dec 2020 00:22:26 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201230052143epoutp049910b890c880b70e1375434addbfde25~VZwKsP-uy3228032280epoutp04r
        for <linux-ext4@vger.kernel.org>; Wed, 30 Dec 2020 05:21:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201230052143epoutp049910b890c880b70e1375434addbfde25~VZwKsP-uy3228032280epoutp04r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1609305703;
        bh=YYKoE1CyjEvECEvYiDNC0LGxSICqz4dN0itzUw1bhS8=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=i8d2cOyNag5eVJeopvar4ehsN0GAVR0ZoGKszfggzIdRZWDhLgo8r5hRWpGqKAGaE
         S6vkQOx7ikVX/N5ZadIKfxKyOFu0B7TuUOsoAaeKO5czD+eHr6cU8HdoXx9StUtfWB
         a4R9F2NFlspHDVgVrrXPEf2a1tNqWHNMUashjKY8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20201230052142epcas2p434da9fbe7079777f9a091381a32e3258~VZwKDey-00736307363epcas2p4V;
        Wed, 30 Dec 2020 05:21:42 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.191]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4D5KQX1gC2z4x9Pp; Wed, 30 Dec
        2020 05:21:40 +0000 (GMT)
X-AuditID: b6c32a46-1d9ff7000000dbf8-57-5fec0e648096
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B4.93.56312.46E0CEF5; Wed, 30 Dec 2020 14:21:40 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: discard and data=writeback
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     Matteo Croce <mcroce@linux.microsoft.com>,
        Daejun Park <daejun7.park@samsung.com>
CC:     "tytso@mit.edu" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CAFnufp39qXBtOfETsYz5LSoPZWik70uB=czmfpwiA8Hdwpi+dA@mail.gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20201230052139epcms2p5d4b8d41625ebd7ea677500d1c05153ef@epcms2p5>
Date:   Wed, 30 Dec 2020 14:21:39 +0900
X-CMS-MailID: 20201230052139epcms2p5d4b8d41625ebd7ea677500d1c05153ef
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7bCmqW4K35t4g1lHOC1WPQi3mDnvDpvF
        xV/zGS1ae36yO7B4/Np+lMmj6cxRZo++LasYPT5vkgtgicqxyUhNTEktUkjNS85PycxLt1Xy
        Do53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHaqKRQlphTChQKSCwuVtK3synKLy1JVcjI
        Ly6xVUotSMkpMDQs0CtOzC0uzUvXS87PtTI0MDAyBapMyMnoOd7EUnBItmLto5eMDYwThLoY
        OTkkBEwkDq3ewtzFyMUhJLCDUWL77XtADgcHr4CgxN8dwiA1wgLaEjMfP2IBsYUElCTWX5zF
        DhHXk7j1cA0jiM0moCMx/cR9sLiIQLjEutN9zCA2s0CCxMXl09khdvFKzGh/ygJhS0tsX74V
        rJdTIFBi2eOdbBBxDYkfy3qZIWxRiZur37LD2O+PzWeEsEUkWu+dhaoRlHjwczdUXFLi2O4P
        TBB2vcTWO78YQf6SEOhhlDi88xYrREJf4lrHRrAjeAV8JeYsnwjWzCKgKnHj2DOoGheJz++v
        sEA8IC+x/e0ccJgwC2hKrN+lD2JKCChLHLkFVcEn0XH4L9yLO+Y9gTpBTWLdz/VMEOUyErfm
        MUKYHhIn30VPYFSchQjmWUg2zULYtICReRWjWGpBcW56arFRgRFyzG5iBCc9LbcdjFPeftA7
        xMjEwXiIUYKDWUmENyHhVbwQb0piZVVqUX58UWlOavEhRlOgHycyS4km5wPTbl5JvKGpkZmZ
        gaWphamZkYWSOG+xwYN4IYH0xJLU7NTUgtQimD4mDk6pBia+A0WxnD/SAxco9IcwLbS49yd+
        3zmzM/HPvMweWC25etd2j+vSi0tuHtM37i/vfTLhStKnMA4X2zWH3lzxPOwmIWyZ+EyuY1ae
        +3YXfuV3B+VFFDbHOn3xWhh8XpstYtbvt58dv794ZX23Uq50z7YL7xlT761YwplVHLj03EGr
        vV73m/82rlbu+vvObP6Pa2ce1X6pFpzMk5uz9uGOmd+ecwc8zDTpUFn4Qe+77GxLOZaPokUM
        LZ9P/Ysxun17ptd1pk7jbc8+lbv3T2tP+BGxcfa9Na/cHy91WSR6R8xQax5fc/iWl9b91/Vu
        zGSaJJiz49K07GOaG3Zb7Kv4cr74/bJLjL925ioFrGjebtUjqsRSnJFoqMVcVJwIADhSDdYD
        BAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201229054143epcms2p15ae3cce43bb3c503adf94528f354ba78
References: <CAFnufp39qXBtOfETsYz5LSoPZWik70uB=czmfpwiA8Hdwpi+dA@mail.gmail.com>
        <20201229054143epcms2p15ae3cce43bb3c503adf94528f354ba78@epcms2p1>
        <CGME20201229054143epcms2p15ae3cce43bb3c503adf94528f354ba78@epcms2p5>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> Hi,
> >
> > > # dmesg |grep EXT4-fs |tail -1
> > > [ 1594.829833] EXT4-fs (nvme0n1p1): mounted filesystem with ordered
> > > data mode. Opts: data=ordered,discard
> > > # blktrace /dev/nvme0n1 & sleep 1 ; time rm -rf /media/linux-5.10/ ; kill $!
> > > [1] 3032
> > >
> > > real    0m1.328s
> > > user    0m0.063s
> > > sys     0m1.231s
> > > # === nvme0n1 ===
> > >   CPU  0:                    0 events,        0 KiB data
> > >   CPU  1:                    0 events,        0 KiB data
> > >   CPU  2:                    0 events,        0 KiB data
> > >   CPU  3:                 1461 events,       69 KiB data
> > >   CPU  4:                    1 events,        1 KiB data
> > >   CPU  5:                    0 events,        0 KiB data
> > >   CPU  6:                    0 events,        0 KiB data
> > >   CPU  7:                    0 events,        0 KiB data
> > >   Total:                  1462 events (dropped 0),       69 KiB data
> > >
> > >
> > > # dmesg |grep EXT4-fs |tail -1
> > > [ 1734.837651] EXT4-fs (nvme0n1p1): mounted filesystem with writeback
> > > data mode. Opts: data=writeback,discard
> > > # blktrace /dev/nvme0n1 & sleep 1 ; time rm -rf /media/linux-5.10/ ; kill $!
> > > [1] 3069
> > >
> > > real    1m30.273s
> > > user    0m0.139s
> > > sys     0m3.084s
> > > # === nvme0n1 ===
> > >   CPU  0:               133830 events,     6274 KiB data
> > >   CPU  1:                21878 events,     1026 KiB data
> > >   CPU  2:                46365 events,     2174 KiB data
> > >   CPU  3:                98116 events,     4600 KiB data
> > >   CPU  4:               290902 events,    13637 KiB data
> > >   CPU  5:                10926 events,      513 KiB data
> > >   CPU  6:                76861 events,     3603 KiB data
> > >   CPU  7:                17855 events,      837 KiB data
> > >   Total:                696733 events (dropped 0),    32660 KiB data
> > >
> >
> > In this result, there is few IO in ordered mode.
> >
> > As I understand (please correct this if I am wrong), with writeback +
> > discard, ext4_issue_discard is called immediately at each rm command.
> > However, with ordered mode, ext4_issue_discard is called when end of
> > committing a transaction to pace with the corresponding transaction.
> > It means, they are not discarded yet.
> >
> > Even with ordered mode, if sync is called after rm command,
> > ext4_issue_discard can be called due to transaction commit.
> > So, I think you will get similar results form writeback mode with sync
> > command.
> >
> 
> Hi,
> 
> that's what I get with data=ordered if I issue a sync after the removal:
> 
> # time rm -rf /media/linux-5.10/ ; sync ; kill $!
> 
> real    0m1.569s
> user    0m0.044s
> sys     0m1.508s
> #
>  === nvme0n1 ===
>  CPU  0:                10980 events,      515 KiB data
>  CPU  1:                    0 events,        0 KiB data
>  CPU  2:                    0 events,        0 KiB data
>  CPU  3:                   26 events,        2 KiB data
>  CPU  4:                 3601 events,      169 KiB data
>  CPU  5:                    0 events,        0 KiB data
>  CPU  6:                21786 events,     1022 KiB data
>  CPU  7:                    0 events,        0 KiB data
>  Total:                 36393 events (dropped 0),     1706 KiB data
> 
> Still way less transactions than writeback.
> 
The full trace you shared on this thread seems contains only on writeback
mode. In the trace, discards are issued by each deletion file by rm.

If you share the full trace on ordered mode, it will help we analyze the
results. It is expected that number of discards will lower than writeback
mode, because discards can be merged on ordered mode.

Thanks,
Daejun
