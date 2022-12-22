Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6C36545AE
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Dec 2022 18:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiLVRmK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Dec 2022 12:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiLVRmJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Dec 2022 12:42:09 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78E322BF8
        for <linux-ext4@vger.kernel.org>; Thu, 22 Dec 2022 09:42:07 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2BMHfwJt006188
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Dec 2022 12:41:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1671730920; bh=f6z01DdAyMnBb6PZpXX+fUEyuTG6sMoKykdJjw3cE0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=E2syviAxiNqtZfjPab0GQqH9xCVaTTz7tdpld3ahAsuUWooyvQIpIlxLa8RTi1x9j
         ie9kXj4kkhu4B1a28LebWx6lKIkvvXKqxolT4FeXp8JgG/UqfMbe1wwQhV6Ot7Q5OA
         yDuiX17iNNmI4lh2AseR67Zp2+m3sf1i3T2DLHRc2GSElSZ1/1knHcUHha9C6UYeYl
         YsN3O6/tcL6GOX81mFnR+cVIdSLSE8DdFbnQaadp8KZvy9rMbwW/Ge6kbkjh/rAr/h
         Gczs/WZ1oL/Qi6jUP9UJjYOgnYe+QDqHG/+on0DjkY3H3bIXpmMgsFgZXnQCSfDT3F
         BI6oAWssizC/A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 421A315C39F2; Thu, 22 Dec 2022 12:41:58 -0500 (EST)
Date:   Thu, 22 Dec 2022 12:41:58 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jun Nie <jun.nie@linaro.org>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] ext4: fix underflow in group bitmap calculation
Message-ID: <Y6SW5s/jFY1oWFe2@mit.edu>
References: <20221222020244.1821308-1-jun.nie@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222020244.1821308-1-jun.nie@linaro.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 22, 2022 at 10:02:44AM +0800, Jun Nie wrote:
> There is case that s_first_data_block is not 0 and block nr is smaller than
> s_first_data_block when calculating group bitmap during allocation. This
> underflow make index exceed es->s_groups_count in ext4_get_group_info()
> and trigger the BUG_ON.
> 
> Fix it with protection of underflow.

When was this happening, and why?  If blocknr is less than
s_first_data_block, this is either a insufficient input validation,
insufficient validation to detection file system corruption. or some
other kernel bug.

Looking quickly at the code and the repro, it appears that issue is
that FS_IOC_GETFSMAP is getting passed a stating physical block of 0
in fmh_keys[0] when on a file system with a blocksize of 1k (in which
case s_first_data_block is 1).  It's unclear to me what
FS_IOC_GETFSMAP should *do* when passed a value which requests that it
provide a mapping for a block which is out of bounds (either too big,
or too small)?.  Should it return an error?  Should it simply not
return a mapping?  The map page for ioctl_getfsmap() doesn't shed any
light on this question.

Darrick, you designed the interface and wrote most of fs/ext4/fsmap.c.
Can you let us know what is supposed to happen in this case?  Many
thanks!!

> Fixes: 72b64b594081ef ("ext4 uninline ext4_get_group_no_and_offset()")

This makes ***no*** sense; the commit in question is from 2006, which
means that in some jourisdictions it's old enough to drive a car.  :-)
Futhermore, all it does is move the function from an inline function
to a C file (in this case, balloc.c).  It also long predates
introduction of FS_IOC_GETFSMAP support, which was in 2017.  

I'm guessing you just did a "git blame" and blindly assumed that
whatever commit last touched the C code in question was what
introduced the problem?

Anyway, please try to understand what is going on instead of doing the
moral equivalent of taking a sledgehammer to the code until the
reproducer stops triggering a BUG.  It's not enough to shut up the
reproducer; you should understand what is happening, and why, and then
strive to find the best fix to the problem.  Papering over problems in
the end will result in more fragile code, and the goal of syzkaller is
to improve kernel quality.  But syzkaller is just a tool and used
wrongly, it can have the opposite effect.

Regards,

					- Ted
