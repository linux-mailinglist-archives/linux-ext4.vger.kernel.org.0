Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA453A0A63
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Jun 2021 05:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbhFIDCy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Jun 2021 23:02:54 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:38158 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232894AbhFIDCy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Jun 2021 23:02:54 -0400
Received: from dread.disaster.area (pa49-179-138-183.pa.nsw.optusnet.com.au [49.179.138.183])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id 5DEDD80B3AA;
        Wed,  9 Jun 2021 13:00:41 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lqoSN-00AcSM-UP; Wed, 09 Jun 2021 13:00:39 +1000
Date:   Wed, 9 Jun 2021 13:00:39 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [RFC PATCH v3 5/8] jbd2,ext4: add a shrinker to release
 checkpointed buffers
Message-ID: <20210609030039.GB2419729@dread.disaster.area>
References: <20210527135641.420514-1-yi.zhang@huawei.com>
 <20210527135641.420514-6-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527135641.420514-6-yi.zhang@huawei.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=MnllW2CieawZLw/OcHE/Ng==:117 a=MnllW2CieawZLw/OcHE/Ng==:17
        a=kj9zAlcOel0A:10 a=r6YtysWOX24A:10 a=7-415B0cAAAA:8
        a=W6Ry0vDpiFjloNHkwdsA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 27, 2021 at 09:56:38PM +0800, Zhang Yi wrote:
> +/**
> + * jbd2_journal_shrink_scan()
> + *
> + * Scan the checkpointed buffer on the checkpoint list and release the
> + * journal_head.
> + */
> +unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
> +				       struct shrink_control *sc)
> +{
> +	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
> +	unsigned long nr_to_scan = sc->nr_to_scan;
> +	unsigned long nr_shrunk;
> +	unsigned long count;
> +
> +	count = percpu_counter_sum_positive(&journal->j_jh_shrink_count);
> +	trace_jbd2_shrink_scan_enter(journal, sc->nr_to_scan, count);
> +
> +	nr_shrunk = jbd2_journal_shrink_checkpoint_list(journal, &nr_to_scan);
> +
> +	count = percpu_counter_sum_positive(&journal->j_jh_shrink_count);
> +	trace_jbd2_shrink_scan_exit(journal, nr_to_scan, nr_shrunk, count);
> +
> +	return nr_shrunk;
> +}
> +
> +/**
> + * jbd2_journal_shrink_scan()
> + *
> + * Count the number of checkpoint buffers on the checkpoint list.
> + */
> +unsigned long jbd2_journal_shrink_count(struct shrinker *shrink,
> +					struct shrink_control *sc)
> +{
> +	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
> +	unsigned long count;
> +
> +	count = percpu_counter_sum_positive(&journal->j_jh_shrink_count);
> +	trace_jbd2_shrink_count(journal, sc->nr_to_scan, count);
> +
> +	return count;
> +}

NACK.

You should not be putting an expensive percpu counter sum in a
shrinker object count routine. These gets called a *lot* under
memory pressure, and summing over hundreds/thousands of CPUs on
every direct reclaim instance over every mounted filesystem
instance that uses jbd2 is really, really going to hurt system
performance under memory pressure.

And, quite frankly, summing twice in the scan routine just to trace
the result with no other purpose is unnecessary and excessive CPU
overhead for a shrinker.

Just use percpu_counter_read() in all cases here - it is more than
accurate enough for the purposes of both tracing and memory reclaim.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
