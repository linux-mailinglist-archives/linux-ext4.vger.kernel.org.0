Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A759ACBAE
	for <lists+linux-ext4@lfdr.de>; Sun,  8 Sep 2019 10:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfIHIw3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 8 Sep 2019 04:52:29 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36720 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727538AbfIHIw1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 8 Sep 2019 04:52:27 -0400
Received: from callcc.thunk.org (110.8.30.213.rev.vodafone.pt [213.30.8.110])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x888qHDE025742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 8 Sep 2019 04:52:19 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F03B9420848; Sat,  7 Sep 2019 12:21:45 -0400 (EDT)
Date:   Sat, 7 Sep 2019 12:21:45 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] jbd2: add new tracepoint jbd2_sleep_on_shadow
Message-ID: <20190907162145.GC23683@mit.edu>
References: <20190902145442.1921-1-xiaoguang.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902145442.1921-1-xiaoguang.wang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Sep 02, 2019 at 10:54:41PM +0800, Xiaoguang Wang wrote:
> Sometimes process will be stalled in "wait_on_bit_io(&bh->b_state,
> BH_Shadow, TASK_UNINTERRUPTIBLE)" for a while, and in order to analyse
> app's latency thoroughly, add a new tracepoint to track this delay.
> 
> Trace info likes below:
> fsstress-5068  [008] .... 11007.757543: jbd2_sleep_on_shadow: dev 254,17 sleep 1
> fsstress-5070  [007] .... 11007.757544: jbd2_sleep_on_shadow: dev 254,17 sleep 2
> fsstress-5069  [009] .... 11007.757548: jbd2_sleep_on_shadow: dev 254,17 sleep 2
> fsstress-5067  [011] .... 11007.757569: jbd2_sleep_on_shadow: dev 254,17 sleep 1
> fsstress-5063  [007] .... 11007.757651: jbd2_sleep_on_shadow: dev 254,17 sleep 2
> fsstress-5070  [007] .... 11007.757792: jbd2_sleep_on_shadow: dev 254,17 sleep 0
> fsstress-5071  [011] .... 11007.763493: jbd2_sleep_on_shadow: dev 254,17 sleep 1
> 
> Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>

I think maybe it might be better to use units of microseconds and then
change sleep to usleep so the units are clear?  This is a spinlock, so
it should be quick.

For the other patch in this series, milliseconds seems fine, but if we
change the trace info to use "msleep" instead that would be clearer
--- or you could change it to use microseconds as well just for
consistency; I think either would be fine.

What do you think?

Cheers,

						- Ted
