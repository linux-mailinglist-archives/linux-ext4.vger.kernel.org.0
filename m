Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D312774A8
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Sep 2020 17:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgIXO77 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Sep 2020 10:59:59 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50066 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728184AbgIXO77 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Sep 2020 10:59:59 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 08OExX5F019000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 10:59:34 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AF2DC42003C; Thu, 24 Sep 2020 10:59:33 -0400 (EDT)
Date:   Thu, 24 Sep 2020 10:59:33 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin10@huawei.com>
Cc:     riteshh@linux.ibm.com, jack@suse.cz, adilger.kernel@dilger.ca,
        jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 2/2] ext4: Fix dead loop in ext4_mb_new_blocks
Message-ID: <20200924145933.GG482521@mit.edu>
References: <20200916113859.1556397-1-yebin10@huawei.com>
 <20200916113859.1556397-3-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916113859.1556397-3-yebin10@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Sep 16, 2020 at 07:38:59PM +0800, Ye Bin wrote:
> As we test disk offline/online with running fsstress, we find fsstress
> process is keeping running state.
> kworker/u32:3-262   [004] ...1   140.787471: ext4_mb_discard_preallocations: dev 8,32 needed 114
> ....
> kworker/u32:3-262   [004] ...1   140.787471: ext4_mb_discard_preallocations: dev 8,32 needed 114
> 
> ext4_mb_new_blocks
> repeat:
>         ext4_mb_discard_preallocations_should_retry(sb, ac, &seq)
>                 freed = ext4_mb_discard_preallocations
>                         ext4_mb_discard_group_preallocations
>                                 this_cpu_inc(discard_pa_seq);
>                 ---> freed == 0
>                 seq_retry = ext4_get_discard_pa_seq_sum
>                         for_each_possible_cpu(__cpu)
>                                 __seq += per_cpu(discard_pa_seq, __cpu);
>                 if (seq_retry != *seq) {
>                         *seq = seq_retry;
>                         ret = true;
>                 }
> 
> As we see seq_retry is sum of discard_pa_seq every cpu, if
> ext4_mb_discard_group_preallocations return zero discard_pa_seq in this
> cpu maybe increase one, so condition "seq_retry != *seq" have always
> been met.
> Ritesh Harjani suggest to in ext4_mb_discard_group_preallocations function we
> only increase discard_pa_seq when there is some PA to free.
> 
> Fixes: 07b5b8e1ac40 ("ext4: mballoc: introduce pcpu seqcnt for freeing PA to improve ENOSPC handling")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

Thanks, applied.

						- Ted
