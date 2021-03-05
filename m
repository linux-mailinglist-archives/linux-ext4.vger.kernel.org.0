Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045F432ED1A
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Mar 2021 15:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhCEO1r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Mar 2021 09:27:47 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45238 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230496AbhCEO1Y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Mar 2021 09:27:24 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 125ERKBK020870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 5 Mar 2021 09:27:21 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9AA4315C3A88; Fri,  5 Mar 2021 09:27:20 -0500 (EST)
Date:   Fri, 5 Mar 2021 09:27:20 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: shrink race window in ext4_should_retry_alloc()
Message-ID: <YEI/yFdT2BtIiUrJ@mit.edu>
References: <20210218151132.19678-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218151132.19678-1-enwlinux@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 18, 2021 at 10:11:32AM -0500, Eric Whitney wrote:
> When generic/371 is run on kvm-xfstests using 5.10 and 5.11 kernels, it
> fails at significant rates on the two test scenarios that disable
> delayed allocation (ext3conv and data_journal) and force actual block
> allocation for the fallocate and pwrite functions in the test.  The
> failure rate on 5.10 for both ext3conv and data_journal on one test
> system typically runs about 85%.  On 5.11, the failure rate on ext3conv
> sometimes drops to as low as 1% while the rate on data_journal
> increases to nearly 100%.
> 
> The observed failures are largely due to ext4_should_retry_alloc()
> cutting off block allocation retries when s_mb_free_pending (used to
> indicate that a transaction in progress will free blocks) is 0.
> However, free space is usually available when this occurs during runs
> of generic/371.  It appears that a thread attempting to allocate
> blocks is just missing transaction commits in other threads that
> increase the free cluster count and reset s_mb_free_pending while
> the allocating thread isn't running.  Explicitly testing for free space
> availability avoids this race.
> 
> The current code uses a post-increment operator in the conditional
> expression that determines whether the retry limit has been exceeded.
> This means that the conditional expression uses the value of the
> retry counter before it's increased, resulting in an extra retry cycle.
> The current code actually retries twice before hitting its retry limit
> rather than once.
> 
> Increasing the retry limit to 3 from the current actual maximum retry
> count of 2 in combination with the change described above reduces the
> observed failure rate to less that 0.1% on both ext3conv and
> data_journal with what should be limited impact on users sensitive to
> the overhead caused by retries.
> 
> A per filesystem percpu counter exported via sysfs is added to allow
> users or developers to track the number of times the retry limit is
> exceeded without resorting to debugging methods.  This should provide
> some insight into worst case retry behavior.
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>

Thanks, applied.

						- Ted
