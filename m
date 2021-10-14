Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08CF42E3E2
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Oct 2021 23:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhJNV7w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Oct 2021 17:59:52 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38510 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229829AbhJNV7w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Oct 2021 17:59:52 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19ELvXSA011427
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 17:57:33 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E7FF515C00CA; Thu, 14 Oct 2021 17:57:32 -0400 (EDT)
Date:   Thu, 14 Oct 2021 17:57:32 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "enwlinux@gmail.com" <enwlinux@gmail.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Inode 2885482 (000000008e814f64): i_reserved_data_blocks (2) not
 cleared!
Message-ID: <YWinzKvlbx0XlJKJ@mit.edu>
References: <767ea5bb27e31cc58bea15cd2aec492946679bde.camel@nokia.com>
 <YWhxvOf5EoHMFxtl@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWhxvOf5EoHMFxtl@B-P7TQMD6M-0146.local>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 15, 2021 at 02:06:52AM +0800, Gao Xiang wrote:
> On Thu, Oct 14, 2021 at 12:54:14PM +0000, Rantala, Tommi T. (Nokia - FI/Espoo) wrote:
> > Hi,
> > 
> > I'm seeing these i_reserved_data_blocks not cleared! messages when using ext4
> > with nodelalloc, message added in:
> > 
> >   commit 6fed83957f21eff11c8496e9f24253b03d2bc1dc
> >   Author: Jeffle Xu <jefflexu@linux.alibaba.com>
> >   Date:   Mon Aug 23 14:13:58 2021 +0800
> > 
> >       ext4: fix reserved space counter leakage
> > 
> > I can quickly reproduce in 5.15.0-rc5-00041-g348949d9a444 by doing some
> > filesystem I/O while toggling delalloc:
> > 
> > 
> > while true; do mount -o remount,nodelalloc /; sleep 1; mount -o remount,delalloc /; sleep 1; done &
> > git clone linux xxx; rm -rf xxx
> 
> If I understand correctly, switching such option implies
> sync inodes to write back exist delayed allocation blocks.

Well, no.  What it implies is that all writes after the remount into
an unallocated portion of the file will be allocated at the time when
the page is dirtied, instead of when the page is written back.  It's
possible for some pages to be written using delayed allocation, and
some other pages in the legacy "allocate on page dirty" mechanism.
This can happen when the file system is remounted; it can also happen
when the file system starts getting close to 100% full.  See the
comment in ext4_nonda_switch:

	/*
	 * switch to non delalloc mode if we are running low
	 * on free block. The free block accounting via percpu
	 * counters can get slightly wrong with percpu_counter_batch getting
	 * accumulated on each CPU without updating global counters
	 * Delalloc need an accurate free block accounting. So switch
	 * to non delalloc when we are near to error range.
	 */

Cheers,

					- Ted
