Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD97E734333
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jun 2023 20:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjFQSvm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 17 Jun 2023 14:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjFQSvl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 17 Jun 2023 14:51:41 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4447C1BC9
        for <linux-ext4@vger.kernel.org>; Sat, 17 Jun 2023 11:51:40 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-117-59.bstnma.fios.verizon.net [173.48.117.59])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35HIovrn010959
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Jun 2023 14:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1687027860; bh=xpkis3Guu7rOeGAVR6foU7dheW7zrVYAyHllrOR6Y7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Z6PTR6lToyU+sxcJ6kE0EjZ3peonX/jZOzwtswSj6RS6+FkxyIoi/HdunLxCMxlr1
         hAplxmQncOsY9nV3do3PnNoDfqFhMvOF7V2pyBJvziUuXH1NaNYOVnyVjJEyr6qcuC
         9BZHWv2PySzVnd3IHU4TlphfT/dLHjLzydz/IouzJeKBYqJdmVM5cT1/42eGHgPrsb
         8nlEw+3ZcF3PnOQeUPTKLDEtE8d6zfs5GWDR/IVq47V4pvugUSum/+al+GcdBUbDc9
         oMYjjhnVsz+7KzyKpUsGO7J5bYvS5mhNKJgyA5+L+qAJdOgrwDC867pZR89R4mxO+p
         xihqH4d8X/4cg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 67C5A15C0266; Sat, 17 Jun 2023 14:50:57 -0400 (EDT)
Date:   Sat, 17 Jun 2023 14:50:57 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2] jbd2: skip reading super block if it has been verified
Message-ID: <20230617185057.GA343628@mit.edu>
References: <20230616015547.3155195-1-yi.zhang@huaweicloud.com>
 <20230616132745.d3enqs4uni55abrj@quack3>
 <bfd1b9f3-7f0e-4b3c-9399-4d697be37a9e@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfd1b9f3-7f0e-4b3c-9399-4d697be37a9e@huaweicloud.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jun 17, 2023 at 10:42:59AM +0800, Zhang Yi wrote:
> > This works as a workaround. It is a bit kludgy but for now I guess it is
> > good enough. Thanks for the fix and feel free to add:
> 
> Thanks for the review. Yes, I suppose it's better to find a way to adjust
> the sequence of journal load and feature checking in ocfs2_check_volume(),
> so that we could completely remove the journal_get_superblock() in
> jbd2_journal_check_used_features().

Indeed, thanks for the fix.

This is would be for after the merge window, but I think we can clean
this up in the jbd2 layer by simply moving the call to
load_superblock() from jbd2_journal_load() and jbd2_journal_wipe() to
journal_init_common().  This change would mean the journal superblock
gets read as part of the call to jbd2_journal_init_{dev,inode}.

That way, once the file system has a journal_t object, it's guaranteed
that the j_sb_buffer contains valid data, and so we can drop the call
to journal_get_superblock() from jbd2_journal_check_used_features().

And after we do that, we should be able to inline the code in
load_superblock() and journal_get_superblock() into
journal_init_common(), which would simplify things in
jfs/jbd2/journal.c

Finally, so we can provide better error handling, we could change
Jbd2_journal_init_{dev,inode} to return an ERR_PTR instead of a NULL
if there is a failure.  And since it's a good idea to change the
function name when changing the function signature, we could rename
those functions to something like jbd2_open_{dev,inode} at the same
time.

						- Ted

P.S.  The only reason why we don't load the superblock in
jbd2_journal_init_{dev,common} was that back in 2001, it was possible
to create the journal by creating a zero length file in the file
system, noting the inode number of the file system, unmounting the
file system from ext2, and then remounting it with "mount -t ext3 -o
journal=NNN ...".  In order to do this, the ext3 file system code
called journal_init_inode() with the inode, and then follow it up with
a call to journal_create(), which would actually write out the journal
superblock.  For that reason, journal_init_inode() had to avoid
reading the journal superblock, since it might not be initialized yet.

We removed jbd2_journal_create() from fs/jbd2 back in 2009, and it
hadn't been in use for quite a while before that --- in fact, I'm not
sure ext4 ever supported this ext3-style "let's create a journal
without e2fsprogs support because Stephen Tweedie was implementing the
ext3 journal kernel code without wanting to make changes to e2fsprogs
first" feature.  :-)
