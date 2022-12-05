Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC260642F78
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Dec 2022 18:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiLERvs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 12:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiLERv3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 12:51:29 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEAC20188;
        Mon,  5 Dec 2022 09:49:28 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2B5Hmp1V006666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Dec 2022 12:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1670262534; bh=EyxV8qZhIzGczmqYjJSp/unx1C6FSCFFVqHS1FGWrSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=DFmWZlMI8RgxOi8rLeDWHiz7WyxufuRbmz42fSAF2T9p89fGPNnkEL/ygeraPArkM
         2Ehn8OFIC1QkNzpmQ9SmzOy23xPFjOMOEIpUbibyaLWegYnyLt15O+Ddt/4dtOA0N8
         7ubNpN2u6JieouauF/rVYGukq1Yj3CHiD3oCh8Qb8EGPLo8ipBO4xYXdHwgyot3474
         1m05wQ0VCex2QxQ5IEwPy66picVF1bxivFFqZ7//pZCiqG8YZAwQtp2O1Z7+LCr7jT
         7RF7StYyEU9YkCDwvt839APAqit8o+g6FrSdVR2m9NaS+9oCa+5ioq5hkb7aCYw1Df
         4Mf2GFYC4IYYg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D789015C3489; Mon,  5 Dec 2022 12:48:50 -0500 (EST)
Date:   Mon, 5 Dec 2022 12:48:50 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     Ye Bin <yebin@huaweicloud.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH RFC] ext4:record error information when insert extent
 failed in 'ext4_split_extent_at'
Message-ID: <Y44vAjbPtntOHy+M@mit.edu>
References: <20221024122725.3083432-1-yebin@huaweicloud.com>
 <2ab8e268-4e1a-8e97-4798-48fcdb651cdf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ab8e268-4e1a-8e97-4798-48fcdb651cdf@huawei.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 28, 2022 at 09:41:55AM +0800, zhanchengbin wrote:
> There have been a lot of problems here before, but the problem has not been
> fundamentally solved.

Indeed, this only papers only the problem.  The commit description is
pretty good, in that it describes the the root cause of the problem:

> > If 'ext4_ext_insert_extent' return '-ENOMEM' which will not fix 'ex->ee_len' by
> > old length. 'ext4_ext_insert_extent' will trigger extent tree merge, fix like
> > 'ex->ee_len = orig_ex.ee_len' may lead to new issues.
> > To solve above issue, record error messages when 'ext4_ext_insert_extent' return
> > 'err' not equal '(-ENOSPC && -EDQUOT)'. If filesysten is mounted with 'errors=continue'
> > as filesystem is not clean 'fsck' will repair issue. If filesystem is mounted with
> > 'errors=remount-ro' filesystem will be remounted by read-only.

What should actually happen here is that we undo the change in orig_ex
if ext4_ext_insert_extent fails.  As you point out, in an earlier part
of the code path, this gets handled by a "goto fix_extent_len".    

The problem is that it's possible that the shape of the extent tree
may have changed before ext4_insert_extent() fails with the ENOMEM.
So the simplistic fix of just jumping to fix_extent_len isn't going to
work.  But fixing it by much marking the file system is corrupt is a
bit of a cop-out.  Consider that if you were running ext4 in a Huawei
Cloud, and you run into the memory allocation failure, what would you
prefer?  For the individual system call to fail, and propagating the
failure to userspace?  Or to leave the file system corrupted?  (And
then either forcing a reboot so the file system to be fixed, or allow
the system to stumble along, with further unknown unexpected behaviour
from userspace?)

The real correct fix is that ext4_ext_insert_extent() needs to
rollback any changes to the extent tree that was made, *or* it needs
to make sure that the operation will succeed before starting to make
any changes, *or* we need to look up the orig_extent via
orig_ex->ee_block, and then undo the change.

It might be that we can't always reliably rollback the change, or we
might think that the operation will succeed, but then it fail due to
an I/O error.  If it's due to an I/O error, then it's fine to bail and
mark the file system as corrupted.  But if the failure is caused by an
ENOMEM, we should be able to handle this case more gracefully.

Can you look into a better fix?

Thanks,

						- Ted
