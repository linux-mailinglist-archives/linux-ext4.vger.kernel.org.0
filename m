Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2033A52535B
	for <lists+linux-ext4@lfdr.de>; Thu, 12 May 2022 19:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351986AbiELROd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 May 2022 13:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346772AbiELROc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 May 2022 13:14:32 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2716726A707
        for <linux-ext4@vger.kernel.org>; Thu, 12 May 2022 10:14:30 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24CHE8mL007381
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 13:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652375650; bh=67iChVcO9/wm/TRaCuDf/PEeqOS9FwkJk0+0RfT68ws=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=bBvxgc4VLzAiTQYcE1+NaHkltJcE5wW0bdYDeAF1zLgxS8c7tLuG38WF0BlR1/fe4
         a29DWHkV7Fyjss07bl3y0NSdJGY9fLWjgBJd9N/+Az2pcnPwgoTKwZHpWLmoFSv5i8
         o/1qX6Dmlkim6ytng5/h57St8+C9SNzjXpgsfCSccZ6r8GOGFngqdrLWHFz8zBeLcm
         b0uTt4/ZzQ8MWmVw50b5N5ssEOKdsEHNr7EUiMylNx7MbjqzLumXMWysZkHFucIs5v
         T646x3vCXc8VnVVO1YpYi8yD0ppDBCgM+ErJ9YSM8Cr9ScaWFVBHax96MMgqdlcKaf
         f42H0a+KnxclQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A14F215C3F2A; Thu, 12 May 2022 13:14:08 -0400 (EDT)
Date:   Thu, 12 May 2022 13:14:08 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com, wubo40@huawei.com
Subject: Re: [PATCH v2 0/6] solve memory leak and check whether NULL pointer
Message-ID: <Yn1AYM7rLvRHXNgQ@mit.edu>
References: <52a2a39d-617f-2f27-a8a4-34da6103e44c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52a2a39d-617f-2f27-a8a4-34da6103e44c@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 31, 2021 at 03:40:41PM +0800, zhanchengbin wrote:
> Solve the memory leak of the abnormal branch and the new null pointer check

Applied, but the patches were all white-space damaged so I had to
apply them by hand.  I also reworded the commit description to be
clearer.

The one exception is the patch to lib/ss, which had already been fixed
commit a282671a0 ("libss: fix possible NULL pointer dereference on
allocation failure") in my tree.

Cheers,

                                        - Ted

> Changes from V1:
> ---------------
> - In the V1 of the patch series, have a bug in patch 1/6, when s->s get
>   memory successd, s-len is not assigned a value.
> 
> zhanchengbin (6):
>   e2fsck: set s->len=0 if malloc() fails in alloc_string()
>   lib/ss: check whether argp is null before accessing it in
>     ss_execute_command()
>   lib/support: check whether inump is null before accessing it in
>     quota_set_sb_inum()
>   e2fsprogs: call ext2fs_badblocks_list_free() to free list in exception
>     branch
>   e2fsck: check whether ldesc is null before accessing it in
>     end_problem_latch()
>   lib/ext2fs: call ext2fs_free_mem() to free &io->name in exception
>     branch
> 
>  e2fsck/logfile.c      | 2 +-
>  e2fsck/problem.c      | 2 ++
>  lib/ext2fs/test_io.c  | 2 ++
>  lib/ext2fs/undo_io.c  | 2 ++
>  lib/ss/execute_cmd.c  | 2 ++
>  lib/support/mkquota.c | 3 ++-
>  misc/dumpe2fs.c       | 1 +
>  resize/resize2fs.c    | 4 ++--
>  8 files changed, 14 insertions(+), 4 deletions(-)
> 
> -- 
> 2.27.0
