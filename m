Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC0C2E7D9C
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Dec 2020 02:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgLaBdW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Dec 2020 20:33:22 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:12002 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgLaBdV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Dec 2020 20:33:21 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201231013238epoutp02eeb897293f857c1c717237e04810dbdf~VqRcRGkbj2113821138epoutp02m
        for <linux-ext4@vger.kernel.org>; Thu, 31 Dec 2020 01:32:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201231013238epoutp02eeb897293f857c1c717237e04810dbdf~VqRcRGkbj2113821138epoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1609378358;
        bh=D4kKCmHLjbqSFNsgta6NLMlj1yYxqAWKe9guecte5ac=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=uvUYcKu52/G770J8LoP2muiyFF3NOMDL9GNmwxqXDeaM05EdKuYlZ9wM3/s+wInkK
         2UqYa4b6pS7EBNIT1Se6vZ+RMqWIOlN/PSid64rX1v+Oc4ngw9hQgQvS9A9RxnOac9
         3So2/KTF+aSr74DEZQSan91EvaETBYKFCcSVfkGQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20201231013237epcas2p1bef960e446694ca481f07c8b0b9cdbbf~VqRb5MZRW3091130911epcas2p1O;
        Thu, 31 Dec 2020 01:32:37 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.186]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4D5rHm6StgzMqYkd; Thu, 31 Dec
        2020 01:32:36 +0000 (GMT)
X-AuditID: b6c32a47-b81ff7000000148e-96-5fed2a34c349
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        23.51.05262.43A2DEF5; Thu, 31 Dec 2020 10:32:36 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: Re: discard and data=writeback
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     Matteo Croce <mcroce@linux.microsoft.com>,
        Daejun Park <daejun7.park@samsung.com>
CC:     "tytso@mit.edu" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CAFnufp0zZL04L5UF_TY7+n91FjktG6Bb0J2j0f3eomXdnHGQ4A@mail.gmail.com>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20201231013236epcms2p63f3c167693f76407103422d8cd347725@epcms2p6>
Date:   Thu, 31 Dec 2020 10:32:36 +0900
X-CMS-MailID: 20201231013236epcms2p63f3c167693f76407103422d8cd347725
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmqa6J1tt4g1f/DS1WPQi3mDnvDpvF
        xV/zGS1ae36yO7B4/Np+lMmj6cxRZo++LasYPT5vkgtgicqxyUhNTEktUkjNS85PycxLt1Xy
        Do53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHaqKRQlphTChQKSCwuVtK3synKLy1JVcjI
        Ly6xVUotSMkpMDQs0CtOzC0uzUvXS87PtTI0MDAyBapMyMmY+nA5U8EjtopPB6+wNTDuZ+1i
        5OSQEDCReP38BmMXIxeHkMAORolryzcBORwcvAKCEn93CIPUCAvoS6yYvJUFxBYSUJJYf3EW
        O0RcT+LWwzWMIDabgI7E9BP3weIiAuES6073MYPYzAIJEheXT2eH2MUrMaP9KQuELS2xfflW
        sF5OgUCJk2tWsEHENSR+LOtlhrBFJW6ufssOY78/Np8RwhaRaL13FqpGUOLBz91QcUmJY7s/
        MEHY9RJb7/wC+0tCoIdR4vDOW1AP60tc69gIdgSvgK/Eg7U3wBawCKhKLFr/nAXkdwkBF4nt
        88wg7peX2P52DjNImFlAU2L9Ln2ICmWJI7dYICr4JDoO/4X7cMe8J1AXqEms+7meCaJcRuLW
        PEYI00Pi5LvoCYyKsxChPAvJplkImxYwMq9iFEstKM5NTy02KjBGjthNjOCUp+W+g3HG2w96
        hxiZOBgPMUpwMCuJ8CYkvIoX4k1JrKxKLcqPLyrNSS0+xGgK9OJEZinR5Hxg0s0riTc0NTIz
        M7A0tTA1M7JQEuctNngQLySQnliSmp2aWpBaBNPHxMEp1cAU/2TFI8e5jpXvmd5X/g9oLNw9
        bXLGc/t2Ede9vg6W8tYewtMjTG48OWW/UG7bIfMO+2s6nRIB4uwL9i05J5T6IYWJ3+DIuzPX
        GK2/q95/FviR/dQkZr97PA3VnPw3OdTCbeNf6Qpxb7j5RSloTYrs57T0z0l1uWoNXx908AbP
        7/rwyVjyuJZIhm87q9z5jgstt81T9bf8ye9bn93sLjr/zln+hou1m7p9/fp+WlRM1fHxMVE+
        vu/CRJ6Ua43TvL9XdX3VcthboJ07eaf7RjWltP7TcoL5UYWeD/aL5Ar+/HnnxR+eotXOrJba
        WzbtDC7d8p2vMC3o66Sl1VzVT7S2hT3ekLjzoS0n75OJMkosxRmJhlrMRcWJAFWX7K4CBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201229054143epcms2p15ae3cce43bb3c503adf94528f354ba78
References: <CAFnufp0zZL04L5UF_TY7+n91FjktG6Bb0J2j0f3eomXdnHGQ4A@mail.gmail.com>
        <20201229054143epcms2p15ae3cce43bb3c503adf94528f354ba78@epcms2p1>
        <CAFnufp39qXBtOfETsYz5LSoPZWik70uB=czmfpwiA8Hdwpi+dA@mail.gmail.com>
        <20201230052139epcms2p5d4b8d41625ebd7ea677500d1c05153ef@epcms2p5>
        <CGME20201229054143epcms2p15ae3cce43bb3c503adf94528f354ba78@epcms2p6>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

In the trace files, the amount of discard is almost the same in both modes.
(ordered: 1096MB / writeback: 1078MB) However, there is a big difference in
the average discard size per request. (ordered: 15.6KB / writeback: 34.2MB)
In ext4, when data is deleted, discard is immediately issued in writeback
mode. Therefore, the average size of discard commands is small and the
number of discard commands is large.
However, if it is not in the writeback mode, discard commands are issued by
JBD after merging them. Therefore, the average size of discard is large and
the number of discard commands is small.

In conclusion, since discard commands are not merged in the writeback mode,
many fragmented discard commands occur, so it affects the elapsed time of
many file deletion. And it is not abnormal behavior of ext4 file system.

Thanks,
Daejun
