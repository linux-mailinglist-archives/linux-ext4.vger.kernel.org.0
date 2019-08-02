Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDD57FC74
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Aug 2019 16:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbfHBOnG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Aug 2019 10:43:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:54788 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726818AbfHBOnG (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 2 Aug 2019 10:43:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35314B60A;
        Fri,  2 Aug 2019 14:43:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B38E31E433B; Fri,  2 Aug 2019 16:43:04 +0200 (CEST)
Date:   Fri, 2 Aug 2019 16:43:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        "Berrocal, Eduardo" <eduardo.berrocal@intel.com>
Subject: Re: dax writes on ext4 slower than direct-i/o?
Message-ID: <20190802144304.GP25064@quack2.suse.cz>
References: <CAPcyv4g1g2i-9p1ZDqy596O-cbw3Gas2wdiv49EvM+b0i-1uLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4g1g2i-9p1ZDqy596O-cbw3Gas2wdiv49EvM+b0i-1uLg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Dan!

On Tue 30-07-19 16:49:41, Dan Williams wrote:
> Eduardo raised a puzzling question about why dax yields lower iops
> than direct-i/o. The expectation is the reverse, i.e. that direct-i/o
> should be slightly slower than dax due to block layer overhead. This
> holds true for xfs, but on ext4 dax yields half the iops of direct-i/o
> for an fio 4K random write workload.
> 
> Here is a relative graph of ext4: dax + direct-i/o vs xfs: dax + direct-i/o
> 
> https://user-images.githubusercontent.com/56363/62172754-40c01e00-b2e8-11e9-8e4e-29e09940a171.jpg
> 
> A relative perf profile seems to show more time in
> ext4_journal_start() which I thought may be due to atime or mtime
> updates, but those do not seem to be the source of the extra journal
> I/O.
> 
> The urgency is a curiosity at this point, but I expect an end user
> might soon ask whether this is an expected implementation side-effect
> of dax.
> 
> Thanks in advance for any insight, and/or experiment ideas for us to go try.

Yeah, I think the reason is that ext4_iomap_begin() currently starts a
transaction unconditionally for each write whereas ext4_direct_IO_write()
is more clever and starts a transaction only when needing to allocate any
blocks. We could put similar smarts into ext4_iomap_begin() and it's
probably a good idea, just at this moment I'm working with one guy on
moving ext4 direct IO code to iomap infrastructure which overhauls
ext4_iomap_begin() anyway, so let's do this after that work.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
