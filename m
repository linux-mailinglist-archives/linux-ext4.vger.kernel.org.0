Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0234578228
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Jul 2019 00:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfG1Wwe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 28 Jul 2019 18:52:34 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:38139 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726097AbfG1Wwe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 28 Jul 2019 18:52:34 -0400
Received: from dread.disaster.area (pa49-195-139-63.pa.nsw.optusnet.com.au [49.195.139.63])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 231CE369F52;
        Mon, 29 Jul 2019 08:52:29 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92)
        (envelope-from <david@fromorbit.com>)
        id 1hrs0g-0008Bg-B7; Mon, 29 Jul 2019 08:51:22 +1000
Date:   Mon, 29 Jul 2019 08:51:22 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Joseph Qi <jiangqi903@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
Subject: Re: [RFC] performance regression with "ext4: Allow parallel DIO
 reads"
Message-ID: <20190728225122.GG7777@dread.disaster.area>
References: <ab7cf51b-6b52-d151-e22c-6f4400a14589@linux.alibaba.com>
 <29d50d24-f8e7-5ef4-d4d8-3ea6fb1c6ed3@gmail.com>
 <6DADA28C-542F-45F6-ADB0-870A81ABED23@dilger.ca>
 <15112e38-94fe-39d6-a8e2-064ff47187d5@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15112e38-94fe-39d6-a8e2-064ff47187d5@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0 cx=a_idp_d
        a=fNT+DnnR6FjB+3sUuX8HHA==:117 a=fNT+DnnR6FjB+3sUuX8HHA==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=0o9FgrsRnhwA:10
        a=pGLkceISAAAA:8 a=7-415B0cAAAA:8 a=N5NhmcLlKfNiVwXJOTYA:9
        a=QEXdDO2ut3YA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 26, 2019 at 09:12:07AM +0800, Joseph Qi wrote:
> 
> 
> On 19/7/26 05:20, Andreas Dilger wrote:
> > 
> >> On Jul 23, 2019, at 5:17 AM, Joseph Qi <jiangqi903@gmail.com> wrote:
> >>
> >> Hi Ted & Jan,
> >> Could you please give your valuable comments?
> > 
> > It seems like the original patches should be reverted?  There is no data
> 
> From my test result, yes.
> I've also tested libaio with iodepth 16, it behaves the same. Here is the test
> data for libaio 4k randrw:
> 
> -------------------------------------------------------------------------------------------
> w/ parallel dio reads | READ 78313KB/s, 19578, 1698.70us  | WRITE 78313KB/s, 19578, 4837.60us
> -------------------------------------------------------------------------------------------
> w/o parallel dio reads| READ 387774KB/s, 96943, 1009.73us | WRITE 387656KB/s，96914, 308.87us
> -------------------------------------------------------------------------------------------
> 
> Since this commit went into upstream long time ago，to be precise, Linux
> 4.9, I wonder if someone else has also observed this regression, or
> anything I missed?

I suspect that the second part of this set of mods that Jan had
planned to do (on the write side to use shared locking as well)
did not happen and so the DIO writes are serialising the workload.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
