Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC40297068
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Aug 2019 05:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfHUDfA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Aug 2019 23:35:00 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33590 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726693AbfHUDfA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 20 Aug 2019 23:35:00 -0400
Received: from callcc.thunk.org ([12.235.16.3])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7L3Yhb1026351
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 23:34:45 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 57CCD420843; Tue, 20 Aug 2019 23:34:43 -0400 (EDT)
Date:   Tue, 20 Aug 2019 23:34:43 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
Cc:     Jan Kara <jack@suse.cz>, Joseph Qi <jiangqi903@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
Subject: Re: [RFC] performance regression with "ext4: Allow parallel DIO
 reads"
Message-ID: <20190821033443.GI10232@mit.edu>
References: <6DADA28C-542F-45F6-ADB0-870A81ABED23@dilger.ca>
 <15112e38-94fe-39d6-a8e2-064ff47187d5@linux.alibaba.com>
 <20190728225122.GG7777@dread.disaster.area>
 <960bb915-20cc-26a0-7abc-bfca01aa39c0@gmail.com>
 <20190815151336.GO14313@quack2.suse.cz>
 <075fd06f-b0b4-4122-81c6-e49200d5bd17@linux.alibaba.com>
 <20190816145719.GA3041@quack2.suse.cz>
 <a8ddec64-d87c-ae7a-9b02-2f24da2396e9@linux.alibaba.com>
 <20190820160805.GB10232@mit.edu>
 <f89131c9-6f84-ac3c-b53c-d3d55887ea89@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f89131c9-6f84-ac3c-b53c-d3d55887ea89@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Aug 21, 2019 at 09:04:57AM +0800, Joseph Qi wrote:
> On 19/8/21 00:08, Theodore Y. Ts'o wrote:
> > On Tue, Aug 20, 2019 at 11:00:39AM +0800, Joseph Qi wrote:
> >>
> >> I've tested parallel dio reads with dioread_nolock, it doesn't have
> >> significant performance improvement and still poor compared with reverting
> >> parallel dio reads. IMO, this is because with parallel dio reads, it take
> >> inode shared lock at the very beginning in ext4_direct_IO_read().
> > 
> > Why is that a problem?  It's a shared lock, so parallel threads should
> > be able to issue reads without getting serialized?
> > 
> The above just tells the result that even mounting with dioread_nolock,
> parallel dio reads still has poor performance than before (w/o parallel
> dio reads).

Right, but you were asserting that performance hit was *because* of
the shared lock.  I'm asking what leading you to have that opinion.
The fact that parallel dioread reads doesn't necessarily say that it
was because of that particular shared lock.  It could be due to any
number of other things.  Have you looked at /proc/lock_stat (enabeld
via CONFIG_LOCK_STAT) to see where the locking bottlenecks might be?

						- Ted
							   
