Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E387942E6D3
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Oct 2021 04:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbhJOCvd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Oct 2021 22:51:33 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:33413 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232960AbhJOCvc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 14 Oct 2021 22:51:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Us1lm4Q_1634266163;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Us1lm4Q_1634266163)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Oct 2021 10:49:25 +0800
Date:   Fri, 15 Oct 2021 10:49:23 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "enwlinux@gmail.com" <enwlinux@gmail.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Inode 2885482 (000000008e814f64): i_reserved_data_blocks (2) not
 cleared!
Message-ID: <YWjsM1W9CipPRK/d@B-P7TQMD6M-0146.local>
References: <767ea5bb27e31cc58bea15cd2aec492946679bde.camel@nokia.com>
 <YWhxvOf5EoHMFxtl@B-P7TQMD6M-0146.local>
 <YWinzKvlbx0XlJKJ@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWinzKvlbx0XlJKJ@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 14, 2021 at 05:57:32PM -0400, Theodore Ts'o wrote:
> On Fri, Oct 15, 2021 at 02:06:52AM +0800, Gao Xiang wrote:
> > On Thu, Oct 14, 2021 at 12:54:14PM +0000, Rantala, Tommi T. (Nokia - FI/Espoo) wrote:
> > > Hi,
> > > 
> > > I'm seeing these i_reserved_data_blocks not cleared! messages when using ext4
> > > with nodelalloc, message added in:
> > > 
> > >   commit 6fed83957f21eff11c8496e9f24253b03d2bc1dc
> > >   Author: Jeffle Xu <jefflexu@linux.alibaba.com>
> > >   Date:   Mon Aug 23 14:13:58 2021 +0800
> > > 
> > >       ext4: fix reserved space counter leakage
> > > 
> > > I can quickly reproduce in 5.15.0-rc5-00041-g348949d9a444 by doing some
> > > filesystem I/O while toggling delalloc:
> > > 
> > > 
> > > while true; do mount -o remount,nodelalloc /; sleep 1; mount -o remount,delalloc /; sleep 1; done &
> > > git clone linux xxx; rm -rf xxx
> > 
> > If I understand correctly, switching such option implies
> > sync inodes to write back exist delayed allocation blocks.
> 
> Well, no.  What it implies is that all writes after the remount into
> an unallocated portion of the file will be allocated at the time when
> the page is dirtied, instead of when the page is written back.  It's
> possible for some pages to be written using delayed allocation, and
> some other pages in the legacy "allocate on page dirty" mechanism.
> This can happen when the file system is remounted; it can also happen
> when the file system starts getting close to 100% full.  See the
> comment in ext4_nonda_switch:
> 
> 	/*
> 	 * switch to non delalloc mode if we are running low
> 	 * on free block. The free block accounting via percpu
> 	 * counters can get slightly wrong with percpu_counter_batch getting
> 	 * accumulated on each CPU without updating global counters
> 	 * Delalloc need an accurate free block accounting. So switch
> 	 * to non delalloc when we are near to error range.
> 	 */

Hi Ted,

Ok, thanks for the detailed behavior explanation yet I guess several
checks of "test_opt(inode->i_sb, DELALLOC)" could be somewhat racy
then? For example a check in __es_remove_extent() of extents_status.c?

Thanks,
Gao Xiang

> 
> Cheers,
> 
> 					- Ted
