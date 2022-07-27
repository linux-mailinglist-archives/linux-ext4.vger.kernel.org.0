Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8E9583167
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jul 2022 20:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbiG0SDe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jul 2022 14:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241236AbiG0SDP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jul 2022 14:03:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071A870E69
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 10:07:10 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id w10so5037820plq.0
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 10:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7MzCTx8DxKRkym+aIIDowx6SySCOc60blX/ZtMV/GtY=;
        b=WOvusV5J3W4qcK/+7jVqons/AxaqJQBpMEHuY7760UQvoM1TQEVJzQLGWOqQI3JBy0
         ONtMDAxpPgN6DazOXQV0blkU2F9cJE/wztnjtYFITVp3bIRLryhm/m030/Pm/YM+hYO8
         WxnDZd4UIe47qv+NGW0i+ydTeqvbhPF3KshsBVu+t2Jx9tDaNMPQ5MNPBhY9spQqqQ12
         48Bq+xNdnIveDwtYq8wgcoHJZ5wMnDjBAlHfV8q92qWTtn4Qo5OzjpoLASGSOpuY6DLZ
         I0sdaRFlnY9CuudmKonnf5xX8tGq/SMwJ5s3ucdLhKGx7t3+bvPwwkiO2GnOM8AsVZUG
         x2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7MzCTx8DxKRkym+aIIDowx6SySCOc60blX/ZtMV/GtY=;
        b=krRuZT1U/5Uxj4Nu+gksY0HrTcNAa8q+VQmWWwsLb1X9wJmQMnfQsbNzYRjzgeNc1n
         2UV3+a7MsO7GaZrCLzJmOvNVQZatJaoppcbET9Vw3Ye3lnBv97rGwnewb9uR13AbqGFD
         EUaO40/ZgpdPvFWKDfJOAxSiAWWliCMMasqMmNMRr3VcFBv/f2IWueUQdLehCZXq0YzT
         FHhfyxkCfAColQxxPgvMienYvFYj2iZgRF9IMByyh2PfYqndpxSrZmd3qDXw45ZekFr9
         6rFSW48VSUto/n6GknFfaYaW6G3s71iGZ2Yaq8mKjjuL90AbvroLvATjphLmMU/KjJkv
         2yHA==
X-Gm-Message-State: AJIora+XZEu/Va1hJ9t35SA2sAyY0sW26dtdO+OvzQRNhBBF9DxEQSFu
        GbhXwRWqP8mg5I7jgfzfMXo=
X-Google-Smtp-Source: AGRyM1sXPgvLeW3czt/nWY31YJew9Z6R6MzwwxMq6ANvUeAAVFqzLCbYJQMwW1oVh35+WcTOOz0oTg==
X-Received: by 2002:a17:902:a502:b0:16b:fbd9:7fc5 with SMTP id s2-20020a170902a50200b0016bfbd97fc5mr23534222plq.112.1658941629911;
        Wed, 27 Jul 2022 10:07:09 -0700 (PDT)
Received: from localhost ([2406:7400:63:e8f8:eb6b:eefa:cf45:ea0c])
        by smtp.gmail.com with ESMTPSA id r5-20020a635145000000b0040dd052ab11sm12442662pgl.58.2022.07.27.10.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 10:07:09 -0700 (PDT)
Date:   Wed, 27 Jul 2022 22:37:04 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: Ext4 mballoc behavior with mb_optimize_scan=1
Message-ID: <20220727170704.h4zli4ujer6a5cp2@riteshh-domain>
References: <20220727105123.ckwrhbilzrxqpt24@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727105123.ckwrhbilzrxqpt24@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/07/27 12:51PM, Jan Kara wrote:
> Hello,
>
> before going on vacation I was tracking down why reaim benchmark regresses
> (10-20%) with larger number of processes with the new mb_optimize_scan
> strategy of mballoc. After a while I have reproduced the regression with a
> simple benchmark that just creates, fsyncs, and deletes lots of small files
> (22k) from 16 processes, each process has its own directory. The immediate
> reason for the slow down is that with mb_optimize_scan=1 the file blocks
> are spread among more block groups and thus we have more bitmaps to update
> in each transaction.

To add a little more info to why maybe this regression is getting noticed this late
is that initially the patch series had a bug where the optimization was never
getting enabled for files with extents until it got fixed by this patch.

https://lore.kernel.org/linux-ext4/fc9a48f7f8dcfc83891a8b21f6dd8cdf056ed810.1646732698.git.ojaswin@linux.ibm.com/#t

>
> So the question is why mballoc with mb_optimize_scan=1 spreads allocations
> more among block groups. The situation is somewhat obscured by group
> preallocation feature of mballoc where each *CPU* holds a preallocation and
> small (below 64k) allocations on that CPU are allocated from this
> preallocation. If I trace creating of these group preallocations I can see
> that the block groups they are taken from look like:
>
> mb_optimize_scan=0:
> 49 81 113 97 17 33 113 49 81 33 97 113 81 1 17 33 33 81 1 113 97 17 113 113
> 33 33 97 81 49 81 17 49
>
> mb_optimize_scan=1:
> 127 126 126 125 126 127 125 126 127 124 123 124 122 122 121 120 119 118 117
> 116 115 116 114 113 111 110 109 108 107 106 105 104 104
>
> So we can see that while with mb_optimize_scan=0 the preallocation is
> always take from one of a few groups (among which we jump mostly randomly)
> which mb_optimize_scan=1 we consistently drift from higher block groups to
> lower block groups.
>
> The mb_optimize_scan=0 behavior is given by the fact that search for free
> space always starts in the same block group where the inode is allocated
> and the inode is always allocated in the same block group as its parent
> directory. So the create-delete benchmark generally keeps all inodes for
> one process in the same block group and thus allocations are always
> starting in that block group. Because files are small, we always succeed in
> finding free space in the starting block group and thus allocations are
> generally restricted to the several block groups where parent directories
> were originally allocated.
>
> With mb_optimize_scan=1 the block group to allocate from is selected by
> ext4_mb_choose_next_group_cr0() so in this mode we completely ignore the
> "pack inode with data in the same group" rule. The reason why we keep
> drifting among block groups is that whenever free space in a block group is
> updated (blocks allocated / freed) we recalculate largest free order (see
> mb_mark_used() and mb_free_blocks()) and as a side effect that removes
> group from the bb_largest_free_order_node list and reinserts the group at
> the tail.

One thing which comes to mind is maybe to cache the last block group from
which the allocation was satisfied and only if that fails, we could then try
the largest_free_order() bg.

>
> I have two questions about the mb_optimize_scan=1 strategy:
>
> 1) Shouldn't we respect the initial goal group and try to allocate from it
> in ext4_mb_regular_allocator() before calling ext4_mb_choose_next_group()?

I remember discussing this problem and I think the argument that time was...

""" ...snip from the cover letter.
These changes may result in allocations to be spread across the block
device. While that would not matter some block devices (such as flash)
it may be a cause of concern for other block devices that benefit from
storing related content togetther such as disk. However, it can be
argued that in high fragmentation scenrio, especially for large disks,
it's still worth optimizing the scanning since in such cases, we get
cpu bound on group scanning instead of getting IO bound. Perhaps, in
future, we could dynamically turn this new optimization on based on
fragmentation levels for such devices.
"""

...but maybe more explainations can be added by others.


>
> 2) The rotation of groups in mb_set_largest_free_order() seems a bit
> undesirable to me. In particular it seems pointless if the largest free
> order does not change. Was there some rationale behind it?

Agree.

Also,
I am wondering on whether there is a bot which does reaim benchmark testing too
on any of the performance patches. For e.g. [1].

[1]: https://github.com/intel/lkp-tests/blob/3fece75132266f680047f4e1740b39c5b3faabbf/tests/reaim

Can submitter of a patch also trigger this performance benchmark testing?
I have generally seen some kernel test bot reports with performace score
results, but I am not sure if there is a easy way to trigger this like how we
have for syzbot. Any idea?

-ritesh
