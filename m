Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12854AFE37
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Sep 2019 16:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfIKOAF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Sep 2019 10:00:05 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36095 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726058AbfIKOAF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Sep 2019 10:00:05 -0400
Received: from callcc.thunk.org (38.85.69.148.rev.vodafone.pt [148.69.85.38] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x8BDvsps004681
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Sep 2019 09:57:58 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C6DC242049E; Wed, 11 Sep 2019 09:57:07 -0400 (EDT)
Date:   Wed, 11 Sep 2019 09:57:07 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] jbd2: add new tracepoint jbd2_sleep_on_shadow
Message-ID: <20190911135707.GC2740@mit.edu>
References: <20190902145442.1921-1-xiaoguang.wang@linux.alibaba.com>
 <20190907162145.GC23683@mit.edu>
 <5d96e18f-9610-208f-6db3-6a7b6a112400@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d96e18f-9610-208f-6db3-6a7b6a112400@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 11, 2019 at 02:52:51PM +0800, Xiaoguang Wang wrote:
> > I think maybe it might be better to use units of microseconds and then
> > change sleep to usleep so the units are clear?  This is a spinlock, so
> > it should be quick.
>
> Sorry, I may not quite understand you, do you mean that milliseconds is not precise, so
> should use microseconds? For these two patches, they do not use usleep or msleep to do
> real sleep work, they just record the duration which process takes to wait bh_shadow flag
> to be cleared or transaction to be unlocked.

Apologies, I should have been clear enough.  Yes, my concern that
milliseconds might not be fine-grained enough.  The sample results
which you showed had values of 2ms, 1ms, and 0ms.  And the single 0ms
result in particular raised the concern that we should use a
microseconds instead of milliseconds.

In fact, instead of "sleep", maybe "latency(us)" or "latency(ms)"
would be a better label?

Regards,

						- Ted
