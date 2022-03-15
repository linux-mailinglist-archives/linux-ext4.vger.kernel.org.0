Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C457D4D9506
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Mar 2022 08:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236696AbiCOHMC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Mar 2022 03:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233703AbiCOHMC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Mar 2022 03:12:02 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CBB4707B
        for <linux-ext4@vger.kernel.org>; Tue, 15 Mar 2022 00:10:45 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220315071039epoutp04ea5f29cfac133c2dd45c97d56db15331~cfE452BeZ0802808028epoutp04e
        for <linux-ext4@vger.kernel.org>; Tue, 15 Mar 2022 07:10:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220315071039epoutp04ea5f29cfac133c2dd45c97d56db15331~cfE452BeZ0802808028epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647328239;
        bh=0z3SFI42ZRuAdP8yrBK1mP5vrxqSVmVDz+qhjz8zcME=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=YxrPNBr0IhAXwJOKvcRGzfGzRgQDb7OeL3twQI4dOY9H6Ws1ohpfZ5CZg8wHC2Diu
         1liW+bciYBKHHHTmVfymoX4a8HEaZGzzy6kXs01JeDuOxwCaFu6NOxiA6EiPhIKw8s
         al524eHWwGcrgmieQeBueC8ybTNWRNnR44ZaoFSE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20220315071038epcas2p3c5229ca99c314cf934a168a230d49397~cfE4fwAMs3274232742epcas2p3x;
        Tue, 15 Mar 2022 07:10:38 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.91]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4KHl166tM5z4x9QB; Tue, 15 Mar
        2022 07:10:34 +0000 (GMT)
X-AuditID: b6c32a46-bffff70000023ea8-ae-62303be51064
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.54.16040.5EB30326; Tue, 15 Mar 2022 16:10:29 +0900 (KST)
Mime-Version: 1.0
Subject: Re: [PATCH v2 1/5] ext4: convert i_fc_lock to spinlock
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     "harshadshirwadkar@gmail.com" <harshadshirwadkar@gmail.com>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "riteshh@linux.ibm.com" <riteshh@linux.ibm.com>,
        "jack@suse.cz" <jack@suse.cz>, "tytso@mit.edu" <tytso@mit.edu>,
        Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20220315071028epcms2p2c9d25549f30cbccdcc208f311651977b@epcms2p2>
Date:   Tue, 15 Mar 2022 16:10:28 +0900
X-CMS-MailID: 20220315071028epcms2p2c9d25549f30cbccdcc208f311651977b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTXPeptUGSwd0pbBYvD2larHoQbrGy
        sYXJYvb0ZiaLmfPusFm8enyL3aK15ye7A7vHzll32T0mLDrA6NF05iizR9+WVYweZxYcYff4
        vEkugC0q2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH
        6BIlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5qiZWhgYGR
        KVBhQnbG959bWQoesFR8annA0sD4i7mLkZNDQsBE4tPXnWxdjFwcQgI7GCXe7Oxn6mLk4OAV
        EJT4u0MYpEZYwF5ixu/HTCC2kICSxPqLs9gh4noStx6uYQSx2QR0JKafuA8WFwGqX3HyLhPI
        TGaBO4wSL+b8YINYxisxo/0pC4QtLbF9+VZGCFtD4seyXqiDRCVurn7LDmO/PzYfqkZEovXe
        WagaQYkHP3dDxSUlXr65wQRh50v8v7IcqrdGYtuBeVC2vsS1jo1ge3kFfCV2dT8Fu4dFQFVi
        csdBqNtcJI4sOw82k1lAXmL72znMoHBgFtCUWL9LH8SUEFCWOHKLBeaTho2/2dHZzAJ8Eh2H
        /8LFd8x7AnWZmsS6n+uZIMbISNyaxziBUWkWIpxnIVk7C2HtAkbmVYxiqQXFuempxUYFRvCo
        Tc7P3cQITpJabjsYp7z9oHeIkYmD8RCjBAezkgjvmRf6SUK8KYmVValF+fFFpTmpxYcYTYEe
        nsgsJZqcD0zTeSXxhiaWBiZmZobmRqYG5krivF4pGxKFBNITS1KzU1MLUotg+pg4OKUamBps
        r318vHq6w/8O9cDNLY+Xu6+UTzC5orjZPsCiSkjxTN/+msimxvyG+eyfTuonHJvV4zZde3Pl
        7m6b31WdRa4aP7UXqmXM1ux14BBfNveU+IVL+qKGVlxPDx5OOCXLKnhu9f3+2S2MS76k7U6R
        6rRL+6co2f75SV1gkqvJdr8Ox5Xtln+P+Tc8P7X24c1Gsd47uVszC7d/2+7zUrazob7q3nLR
        7avma4o5MyZ9jFNwu65zwNDuQNvcbecENSfMkVwxcWkcW94u5YvvPpVELv3w/OC0s+sqEqbp
        tMb1TFrSp/uodkfjv3PyRndniwRuvZkdWKOZOK3DZboKq1/K/eDVao57Anc/um+1veasgRJL
        cUaioRZzUXEiAPbMZ6EbBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220315071028epcms2p2c9d25549f30cbccdcc208f311651977b
References: <CGME20220315071028epcms2p2c9d25549f30cbccdcc208f311651977b@epcms2p2>
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Harshad Shirwadkar,

...
>@@ -427,11 +427,11 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
> 	struct dentry *dentry = dentry_update->dentry;
> 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> 
>-	mutex_unlock(&ei->i_fc_lock);
>+	spin_unlock(&ei->i_fc_lock);
> 	node = kmem_cache_alloc(ext4_fc_dentry_cachep, GFP_NOFS);
Is it sleep-safe with spinlock?

> 	if (!node) {
> 		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_NOMEM, NULL);
>-		mutex_lock(&ei->i_fc_lock);
>+		spin_lock(&ei->i_fc_lock);
> 		return -ENOMEM;
> 	}
> 

Thanks,
Daejun
