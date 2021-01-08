Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B6E2EEB5E
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jan 2021 03:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbhAHChy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jan 2021 21:37:54 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:42117 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbhAHChy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jan 2021 21:37:54 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210108023710epoutp047f356ad9f99189d0d86a996fc38dd37c~YIUFE6U5q1952119521epoutp040
        for <linux-ext4@vger.kernel.org>; Fri,  8 Jan 2021 02:37:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210108023710epoutp047f356ad9f99189d0d86a996fc38dd37c~YIUFE6U5q1952119521epoutp040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1610073431;
        bh=l/KUfAhsFOgyUhrY21rqugRrtZWnNJOwIdHlX0ISaxg=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=hmDc5pLScQNB9PGbuNSRfHVF2AaYtmKk2bY3GS9V1e1kJHfKmmAaqNnjTvp+jUpE0
         jbW1RpFZ+rfxeU3qy0UmYJ0dMPen+2lJh2ggU55TPLH18CNz2X4NRniAh8ufulVE+e
         eiLRKD3ePDK0jMOP9UCL0A8PRfXja1kfFtMkccEE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20210108023710epcas2p4772412909ded44ae0b9d337e7e2896ed~YIUEq_vbe3132031320epcas2p4C;
        Fri,  8 Jan 2021 02:37:10 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.182]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DBnLY1SBjz4x9Pt; Fri,  8 Jan
        2021 02:37:09 +0000 (GMT)
X-AuditID: b6c32a46-1efff7000000dbf8-1d-5ff7c553d592
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        95.06.56312.355C7FF5; Fri,  8 Jan 2021 11:37:07 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH] ext4: Remove expensive flush on fast commit
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     Andreas Dilger <adilger@dilger.ca>,
        Daejun Park <daejun7.park@samsung.com>,
        harshad shirwadkar <harshadshirwadkar@gmail.com>
CC:     "tytso@mit.edu" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <8A3C241B-9536-447B-B22D-F922D64731C7@dilger.ca>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210108023707epcms2p32beb982610c9460e5fb08f927c52ad1d@epcms2p3>
Date:   Fri, 08 Jan 2021 11:37:07 +0900
X-CMS-MailID: 20210108023707epcms2p32beb982610c9460e5fb08f927c52ad1d
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdljTQjf46Pd4g2M3bCyWnXzEZLHqQbjF
        ysYWJouZ8+6wWVzeNYfNorXnJ7sDm0fL5nKPnbPusns0nTnK7NG3ZRWjx+dNcgGsUTk2GamJ
        KalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUD7lRTKEnNKgUIB
        icXFSvp2NkX5pSWpChn5xSW2SqkFKTkFhoYFesWJucWleel6yfm5VoYGBkamQJUJORmvdqxk
        LNjCVrFv6lX2BsbJrF2MnBwSAiYSlyZfAbK5OIQEdjBKzLh3ia2LkYODV0BQ4u8OYZAaYQEX
        ifULGlhAbCEBJYn1F2exQ8T1JG49XMMIYrMJ6EhMP3EfLC4i0MQo8XNLJshMZoGFjBJdlyaw
        QyzjlZjR/pQFwpaW2L58K1gzp4CtxPcNnUwQcQ2JH8t6mSFsUYmbq9+yw9jvj81nhLBFJFrv
        nYWqEZR48HM3VFxS4tjuD1Bz6iW23vnFCHKEhEAPo8ThnbegPtaXuNaxEewIXgFfiSu35oDF
        WQRUJfb+vQo11EVi+pQ1YHFmAXmJ7W/nMIMChVlAU2L9Ln0QU0JAWeLILRaICj6JjsN/4V7c
        Me8J1AlqEut+rmeCKJeRuDUP6koPib7N+9knMCrOQgT0LCSrZiGsWsDIvIpRLLWgODc9tdio
        wAg5bjcxgpOiltsOxilvP+gdYmTiYDzEKMHBrCTCa3HsS7wQb0piZVVqUX58UWlOavEhRlOg
        JycyS4km5wPTcl5JvKGpkZmZgaWphamZkYWSOG+xwYN4IYH0xJLU7NTUgtQimD4mDk6pBqa6
        qQFbVT9GMq9qZeGby7z79/dJesITtBJqOQR//zzVYZC12/6N1mL3gqJpH659+959TntjZbDV
        Hmued9Z2SwsZzv0sj5soZxT2ckHMUe8lRhbbWb2ebruQPH33jfjIK9ur/ZIuHjOzZudxdz90
        /PeEafcs9DYpMny7sUBVqM6ivr31k8HPqBamrgMBr6aEX5mxOlX6rFDUlldMc96+vdzS0fn1
        6hslt28TZ3FV8dqcuLetee3jcxdnTmvTSxEXeZvml/lzFqvc8W4tgYSmXuEH7zm+805mKp+3
        vDGpUJZHSeL3r/kHfwbWb99fkOYb8nvVigjZtn0W6QXHn2zpL/npHR9j/2raBIP9iQJCuRxK
        LMUZiYZazEXFiQAkF7jnEwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210106013242epcms2p5b6b4ed8ca86f29456fdf56aa580e74b4
References: <8A3C241B-9536-447B-B22D-F922D64731C7@dilger.ca>
        <20210106013242epcms2p5b6b4ed8ca86f29456fdf56aa580e74b4@epcms2p5>
        <CAD+ocbyp+SOzpDDYsJVpd+t+UcjanZRtR85dHLgykLdURhV5wA@mail.gmail.com>
        <CGME20210106013242epcms2p5b6b4ed8ca86f29456fdf56aa580e74b4@epcms2p3>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> > In the fast commit, it adds REQ_FUA and REQ_PREFLUSH on each fast commit
> > block when barrier is enabled. However, in recovery phase, ext4 compares
> > CRC value in the tail. So it is sufficient adds REQ_FUA and REQ_PREFLUSH
> > on the block that has tail.
> 
> Does the tail block *always* contain a CRC, or is that dependent on
> EXT4_FEATURE_RO_COMPAT_METADATA_CSUM, JBD2_FEATURE_INCOMPAT_CSUM_V2,
> or JBD2_FEATURE_INCOMPAT_CSUM_V3 being enabled?

In the fast commit, the tail block always contain a CRC.
 
> If one of those features is *required* before the FAST_COMMIT feature
> can be used, then this patch looks OK.  Otherwise, the CSUM feature
> should be checked before the FUA is skipped for non-tail blocks.

So, I think it is OK without checking other CSUM feature.

Thanks,
Daejun
