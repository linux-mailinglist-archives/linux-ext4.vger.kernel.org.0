Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0DA90444
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2019 16:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfHPO5V (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Aug 2019 10:57:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:46670 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727311AbfHPO5V (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 16 Aug 2019 10:57:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9FB6AF40;
        Fri, 16 Aug 2019 14:57:19 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 35E511E4009; Fri, 16 Aug 2019 16:57:19 +0200 (CEST)
Date:   Fri, 16 Aug 2019 16:57:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Jan Kara <jack@suse.cz>, Joseph Qi <jiangqi903@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
Subject: Re: [RFC] performance regression with "ext4: Allow parallel DIO
 reads"
Message-ID: <20190816145719.GA3041@quack2.suse.cz>
References: <ab7cf51b-6b52-d151-e22c-6f4400a14589@linux.alibaba.com>
 <29d50d24-f8e7-5ef4-d4d8-3ea6fb1c6ed3@gmail.com>
 <6DADA28C-542F-45F6-ADB0-870A81ABED23@dilger.ca>
 <15112e38-94fe-39d6-a8e2-064ff47187d5@linux.alibaba.com>
 <20190728225122.GG7777@dread.disaster.area>
 <960bb915-20cc-26a0-7abc-bfca01aa39c0@gmail.com>
 <20190815151336.GO14313@quack2.suse.cz>
 <075fd06f-b0b4-4122-81c6-e49200d5bd17@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <075fd06f-b0b4-4122-81c6-e49200d5bd17@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 16-08-19 21:23:24, Joseph Qi wrote:
> On 19/8/15 23:13, Jan Kara wrote:
> > On Tue 30-07-19 09:34:39, Joseph Qi wrote:
> >> On 19/7/29 06:51, Dave Chinner wrote:
> >>> On Fri, Jul 26, 2019 at 09:12:07AM +0800, Joseph Qi wrote:
> >>>>
> >>>>
> >>>> On 19/7/26 05:20, Andreas Dilger wrote:
> >>>>>
> >>>>>> On Jul 23, 2019, at 5:17 AM, Joseph Qi <jiangqi903@gmail.com> wrote:
> >>>>>>
> >>>>>> Hi Ted & Jan,
> >>>>>> Could you please give your valuable comments?
> >>>>>
> >>>>> It seems like the original patches should be reverted?  There is no data
> >>>>
> >>>> From my test result, yes.
> >>>> I've also tested libaio with iodepth 16, it behaves the same. Here is the test
> >>>> data for libaio 4k randrw:
> >>>>
> >>>> -------------------------------------------------------------------------------------------
> >>>> w/ parallel dio reads | READ 78313KB/s, 19578, 1698.70us  | WRITE 78313KB/s, 19578, 4837.60us
> >>>> -------------------------------------------------------------------------------------------
> >>>> w/o parallel dio reads| READ 387774KB/s, 96943, 1009.73us | WRITE 387656KB/s，96914, 308.87us
> >>>> -------------------------------------------------------------------------------------------
> >>>>
> >>>> Since this commit went into upstream long time ago，to be precise, Linux
> >>>> 4.9, I wonder if someone else has also observed this regression, or
> >>>> anything I missed?
> >>>
> >>> I suspect that the second part of this set of mods that Jan had
> >>> planned to do (on the write side to use shared locking as well)
> >>> did not happen and so the DIO writes are serialising the workload.
> >>>
> >>
> >> Thanks for the inputs, Dave.
> >> Hi Jan, Could you please confirm this?
> >> If so, should we revert this commit at present?
> > 
> > Sorry for getting to you only now. I was on vacation and then catching up
> > with various stuff. I suppose you are not using dioread_nolock mount
> > option, are you? Can you check what are your results with that mount
> > option?
> > 
> Yes, I've just used default mount options when testing. And it is indeed
> that there is performance improvement with dioread_nolock after reverting
> the 3 related commits.
> I'll do a supplementary test with parallel dio reads as well as
> dioread_nolock and send out the test result.
> 
> > I have hard time remembering what I was thinking those couple years back
> > but I think the plan was to switch to dioread_nolock always but somehow I
> > didn't finish that and now I forgot where I got stuck because I don't see
> > any problem with that currently.
> Do you mean mark dioread_nolock as default?

Yes, in fact I'd like to just remove the other path so that we can remove
this confusing mount option.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
