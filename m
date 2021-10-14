Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FCD42E0C4
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Oct 2021 20:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhJNSJB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Oct 2021 14:09:01 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:48429 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233836AbhJNSJB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 14 Oct 2021 14:09:01 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Urv6T5V_1634234813;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Urv6T5V_1634234813)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Oct 2021 02:06:54 +0800
Date:   Fri, 15 Oct 2021 02:06:52 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
Cc:     "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "enwlinux@gmail.com" <enwlinux@gmail.com>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Inode 2885482 (000000008e814f64): i_reserved_data_blocks (2) not
 cleared!
Message-ID: <YWhxvOf5EoHMFxtl@B-P7TQMD6M-0146.local>
References: <767ea5bb27e31cc58bea15cd2aec492946679bde.camel@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <767ea5bb27e31cc58bea15cd2aec492946679bde.camel@nokia.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 14, 2021 at 12:54:14PM +0000, Rantala, Tommi T. (Nokia - FI/Espoo) wrote:
> Hi,
> 
> I'm seeing these i_reserved_data_blocks not cleared! messages when using ext4
> with nodelalloc, message added in:
> 
>   commit 6fed83957f21eff11c8496e9f24253b03d2bc1dc
>   Author: Jeffle Xu <jefflexu@linux.alibaba.com>
>   Date:   Mon Aug 23 14:13:58 2021 +0800
> 
>       ext4: fix reserved space counter leakage
> 
> I can quickly reproduce in 5.15.0-rc5-00041-g348949d9a444 by doing some
> filesystem I/O while toggling delalloc:
> 
> 
> while true; do mount -o remount,nodelalloc /; sleep 1; mount -o remount,delalloc /; sleep 1; done &
> git clone linux xxx; rm -rf xxx

If I understand correctly, switching such option implies
sync inodes to write back exist delayed allocation blocks.

At a glance I don't find it. Yet no test actually.

Thanks,
Gao Xiang

> 
> [  222.928341] EXT4-fs (vdb1): re-mounted. Opts: delalloc. Quota mode: disabled.
> [  223.932516] EXT4-fs (vdb1): re-mounted. Opts: nodelalloc. Quota mode: disabled.
> [  224.183741] EXT4-fs (vdb1): Inode 2885482 (000000008e814f64): i_reserved_data_blocks (2) not cleared!
> [  224.185064] EXT4-fs (vdb1): Inode 2885478 (00000000862b48ad): i_reserved_data_blocks (2) not cleared!
> [  224.186434] EXT4-fs (vdb1): Inode 2885474 (00000000a20bdd95): i_reserved_data_blocks (7) not cleared!
> [  224.187649] EXT4-fs (vdb1): Inode 2885476 (00000000028005e1): i_reserved_data_blocks (2) not cleared!
> [  224.189016] EXT4-fs (vdb1): Inode 2885475 (0000000025d9617d): i_reserved_data_blocks (2) not cleared!
> [  224.190370] EXT4-fs (vdb1): Inode 2885480 (00000000d0722d90): i_reserved_data_blocks (7) not cleared!
> [  224.191732] EXT4-fs (vdb1): Inode 2885481 (000000009b50d6cb): i_reserved_data_blocks (1) not cleared!
> [  224.193093] EXT4-fs (vdb1): Inode 2885472 (00000000fe907f54): i_reserved_data_blocks (1) not cleared!
> [  227.946984] EXT4-fs: 9213 callbacks suppressed
> [  227.946989] EXT4-fs (vdb1): re-mounted. Opts: nodelalloc. Quota mode: disabled.
> 
> 
> -Tommi
> 
