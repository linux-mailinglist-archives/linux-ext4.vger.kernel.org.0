Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECAF72D8A8
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jun 2023 06:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239633AbjFMEdp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jun 2023 00:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239654AbjFMEdT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jun 2023 00:33:19 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8A82D52
        for <linux-ext4@vger.kernel.org>; Mon, 12 Jun 2023 21:31:59 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-39.bstnma.fios.verizon.net [173.48.82.39])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35D4VKsm027047
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 00:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686630683; bh=cKB04XX96zaqTHLDk7A2yl9q/pYStDpBWJcQVn9eU9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dn2TNZKsJPGrwCA6rNo4JfBttGFBnN6c95t6wBPoHOn2kBxqvLN+daRaEpRQdMpzQ
         A8WIhHPUApwXJTlVHQcYCsfHYJwoNXWz7uI/4YQe6OCRFRJkx8ejmXSLfCzE9bWOhq
         5Q8VFlPVDuEom/QMUHigTNhZDus3a8Kf9v7UWTzxMB+bi4xyUR3H+h+j9BjbKklt68
         AsfRhLeZxRelkjUMXKsVIDeXDGJfffmizM6r7PaaR+ryhgo21BrfaQqLchhEwkUzWG
         2sZTzSA6Sfil9r/Hadg9zxK7d/mrPSzfL1WwpDJ+v+PtpwDQo0dM0j/ykdOqgUAxeS
         DC+Q/ocTUDysQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 96EF115C00B0; Tue, 13 Jun 2023 00:31:20 -0400 (EDT)
Date:   Tue, 13 Jun 2023 00:31:20 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yukuai3@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH v3 4/6] jbd2: Fix wrongly judgement for buffer head
 removing while doing checkpoint
Message-ID: <20230613043120.GB1584772@mit.edu>
References: <20230606135928.434610-1-yi.zhang@huaweicloud.com>
 <20230606135928.434610-5-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606135928.434610-5-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There is something about this patch which is causing test runs to hang
when running "gce-xfstests -c ext4/adv -C 10 generic/475" at least
60-70% of the time.

When I took a closer look, the problem seems to be e2fsck is hanging
after a SEGV when running e2fsck -nf on the block device.  This then
causes the check script to hang, until the test appliance's safety
timer triggers and forces a shutdown of the test VM and aborts the
test run.

The cause of the hang is clearly an e2fsprogs bug --- no matter how
corrupted the file system is, e2fsck should never crash or hang.  So
something is clearly going wrong with e2fsck:

    ...
    Symlink /p1/dc/d14/dee/l154 (inode #2898) is invalid.
    Clear? no

    Entry 'l154' in /p1/dc/d14/dee (2753) has an incorrect filetype (was 7, should be 0).
    Fix? no

    corrupted size vs. prev_size
    Signal (6) SIGABRT si_code=SI_TKILL 

    (Note: "corrutped size vs prev_size" is issued by glibc when
    malloc's internal data structures have been corrupted.  So
    there is definitely something going very wrong with e2fsck.)
    
That being said, if I run the same test on the parent commit (patch
3/6, jbd2: remove journal_clean_one_cp_list()), e2fsck does *not* hang
or crash, and the regression tests complete.  So this patch is
changing the behavior of the kernel in terms of the file system that
is left behind after a large number of injected I/O errors.

My plan therefore is to drop patches 4/6 through 6/6 of this patch
series.  This will allow at least the "long standing metadata
corruption issue that happens from to time" to be addressed, and it
will give us time study what's going on here in more detail.  I've
captured the compressed file system image which is causing e2fsck
(version 1.47.0) to corrupt malloc's data structure, and I'll try see
what using Address Sanitizer or valgrind show about what's going on.

Looking at the patch, it looks pretty innocuous, and I don't
understand how this could be making a significant enough difference
that it's causing e2fsck, which had previously been working fine, to
now start tossing its cookies.  If you could double check the patch
and see you see anything that I might have missed in my code review,
I'd really appreciate it.

Thanks,

					- Ted
