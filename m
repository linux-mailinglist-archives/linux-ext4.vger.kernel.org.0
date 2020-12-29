Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764132E6E5A
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Dec 2020 06:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgL2Fmb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 29 Dec 2020 00:42:31 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:45631 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgL2Fma (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 29 Dec 2020 00:42:30 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201229054147epoutp02b2048434e4a3ca8421ece7a36fbe78e8~VGYagWBT22148621486epoutp02i
        for <linux-ext4@vger.kernel.org>; Tue, 29 Dec 2020 05:41:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201229054147epoutp02b2048434e4a3ca8421ece7a36fbe78e8~VGYagWBT22148621486epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1609220507;
        bh=F60Tan2Ti2JQl/RzJqZjufAhnZmqQ208tHddu5p0upE=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=iXr+M5C5LNwMUu3j2XjopMV/Ft/qaq5EkRLEfrWBg/pC3rTL9HCpSLZ+Q7R16A6nV
         PfmBwz4N6bI9SDs1czhsV/Wb6Yz34f4uUa2Hy1vVumsRhLGYoc9BkZSUk38ZEjIg8+
         E51S7jT31uan6UrxB+dKsjNLfBN8aMMcpwpdWPCY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20201229054147epcas2p39a2b8ec278db867530cbb229919831cd~VGYaVkqXm1979419794epcas2p3U;
        Tue, 29 Dec 2020 05:41:47 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.188]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4D4jw940zxz4x9Pp; Tue, 29 Dec
        2020 05:41:45 +0000 (GMT)
X-AuditID: b6c32a47-b97ff7000000148e-8a-5feac1979daa
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.EF.05262.791CAEF5; Tue, 29 Dec 2020 14:41:43 +0900 (KST)
Mime-Version: 1.0
Subject: Re: discard and data=writeback
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     "mcroce@linux.microsoft.com" <mcroce@linux.microsoft.com>,
        "tytso@mit.edu" <tytso@mit.edu>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20201229054143epcms2p15ae3cce43bb3c503adf94528f354ba78@epcms2p1>
Date:   Tue, 29 Dec 2020 14:41:43 +0900
X-CMS-MailID: 20201229054143epcms2p15ae3cce43bb3c503adf94528f354ba78
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7bCmue70g6/iDeZtMLeYOe8Om8XFX/MZ
        LVp7frI7MHv82n6UyaPpzFFmj8+b5AKYo3JsMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1
        DS0tzJUU8hJzU22VXHwCdN0yc4AWKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIK
        DA0L9IoTc4tL89L1kvNzrQwNDIxMgSoTcjJmLS0pOCZU8erwAbYGxnPcXYwcHBICJhIdlyK6
        GLk4hAR2MEr8OTaZHSTOKyAo8XeHcBcjJ4ewgLrEtfdv2UFsIQElifUXZ7FDxPUkbj1cwwhi
        swnoSEw/cR8sLiKQIHHn1lawOLOArcT1q5OYQGwJAV6JGe1PWSBsaYntyyFqJAQ0JH4s62WG
        sEUlbq6G2AVivz82H6pGRKL13lmoGkGJBz93Q8UlJY7t/gA1v15i651fjCC/SAj0MEoc3nmL
        FSKhL3GtYyPYYl4BX4kru5vBGlgEVCUuvmtig6hxkTja94MF4mh5ie1v5zCDwoFZQFNi/S59
        SFApSxy5BVXBJ9Fx+C87zFs75j2BOkFNYt3P9UwQ5TISt+YxQpgeEiffRUMCMFBi669TTBMY
        FWYhgnkWkq2zELYuYGRexSiWWlCcm55abFRgjByvmxjB6U3LfQfjjLcf9A4xMnEwHmKU4GBW
        EuFNSHgVL8SbklhZlVqUH19UmpNafIjRFOjficxSosn5wASbVxJvaGpkZmZgaWphamZkoSTO
        W2zwIF5IID2xJDU7NbUgtQimj4mDU6qBSXmRnV2k8DWlu5+iCr+W+/TOl3826/Mbv9V9xZ7y
        IpddVKcp6CTeVQ/O5lI6esO3XUu8WeDfl/rf9Z7717CpHb1833naY7MO/djC34Et1buUBH7Y
        hzle2b9ROLoqXHpP/KeivEqDOftuTfwpsvHF1CtCnexd/NoX2bN/MEk9nOf6LfYUzzbdmvex
        7VZLmPg/1EmlOTnP1wnW4Dja/erhOtMkzrqslJgVh/p/Z34UNbkbuJdv6+1deX4fjj9zvFq0
        J1XpaYVC9w9Rpuj5e+4/eNGW9dnB8KrZtBXfxFp+Lcwokb3jIZLXrVO+4MjsTR9sdxl4zl/v
        vDRA+rCJ3+/yLd82NF202pPAd3TphLQ1SizFGYmGWsxFxYkA332+WvgDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201229054143epcms2p15ae3cce43bb3c503adf94528f354ba78
References: <CGME20201229054143epcms2p15ae3cce43bb3c503adf94528f354ba78@epcms2p1>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

> # dmesg |grep EXT4-fs |tail -1
> [ 1594.829833] EXT4-fs (nvme0n1p1): mounted filesystem with ordered
> data mode. Opts: data=ordered,discard
> # blktrace /dev/nvme0n1 & sleep 1 ; time rm -rf /media/linux-5.10/ ; kill $!
> [1] 3032
> 
> real    0m1.328s
> user    0m0.063s
> sys     0m1.231s
> # === nvme0n1 ===
>   CPU  0:                    0 events,        0 KiB data
>   CPU  1:                    0 events,        0 KiB data
>   CPU  2:                    0 events,        0 KiB data
>   CPU  3:                 1461 events,       69 KiB data
>   CPU  4:                    1 events,        1 KiB data
>   CPU  5:                    0 events,        0 KiB data
>   CPU  6:                    0 events,        0 KiB data
>   CPU  7:                    0 events,        0 KiB data
>   Total:                  1462 events (dropped 0),       69 KiB data
> 
> 
> # dmesg |grep EXT4-fs |tail -1
> [ 1734.837651] EXT4-fs (nvme0n1p1): mounted filesystem with writeback
> data mode. Opts: data=writeback,discard
> # blktrace /dev/nvme0n1 & sleep 1 ; time rm -rf /media/linux-5.10/ ; kill $!
> [1] 3069
> 
> real    1m30.273s
> user    0m0.139s
> sys     0m3.084s
> # === nvme0n1 ===
>   CPU  0:               133830 events,     6274 KiB data
>   CPU  1:                21878 events,     1026 KiB data
>   CPU  2:                46365 events,     2174 KiB data
>   CPU  3:                98116 events,     4600 KiB data
>   CPU  4:               290902 events,    13637 KiB data
>   CPU  5:                10926 events,      513 KiB data
>   CPU  6:                76861 events,     3603 KiB data
>   CPU  7:                17855 events,      837 KiB data
>   Total:                696733 events (dropped 0),    32660 KiB data
> 

In this result, there is few IO in ordered mode.

As I understand (please correct this if I am wrong), with writeback +
discard, ext4_issue_discard is called immediately at each rm command.
However, with ordered mode, ext4_issue_discard is called when end of
committing a transaction to pace with the corresponding transaction.
It means, they are not discarded yet.

Even with ordered mode, if sync is called after rm command,
ext4_issue_discard can be called due to transaction commit.
So, I think you will get similar results form writeback mode with sync
command.

Thanks,
Daejun
