Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F7F7A7414
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Sep 2023 09:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbjITH3M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Sep 2023 03:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjITH3L (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Sep 2023 03:29:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6326894
        for <linux-ext4@vger.kernel.org>; Wed, 20 Sep 2023 00:29:05 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-578a6bb11ecso1695573a12.0
        for <linux-ext4@vger.kernel.org>; Wed, 20 Sep 2023 00:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1695194945; x=1695799745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aGn2kW9kqySs3xB1gO3u3lD0x8Smn8qk9PYDX40fE2Q=;
        b=d6vFp61xpf2ZkNlYwJMU86mgn2Ccw0erYPyQekHPGUy+1AtnaVRsIIzEngnLhaSV8z
         fOAmhne/ZdcdrjVZrZWBtasZLSvjJnO/2D4Oo81GWjQRdle7ZGOZ+AzOG6VzlxsBx9eu
         PsIyU8oiNW0ZL+3L/2vqv8Mk8uD8j+KoNSLxeEK8Y9yggEkrFQ3P6zKin88J5BiRGSgy
         BRF31vbBT5Sc96KmZKYXXNCkSOjiV+qC0en9icRCg7lRMeB0gGcXsFDtZUiDSCiozCSl
         Y3voaLFtFdR1WEXEEaLbMOnlO/ABmbqNP/s3oO6dyd9htX3BlACuQoPHmb3qxem2Rhc0
         5SLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695194945; x=1695799745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aGn2kW9kqySs3xB1gO3u3lD0x8Smn8qk9PYDX40fE2Q=;
        b=sb737vLwmaX7ax+egDAla7XBdjcV8pVHewz53cxJkAPDqg8gXV7mx6iOKpkknmKH4N
         +P2/ZVwR5XEActuREIeIcxwwxA+0b5+DVE6tFGmndirg1gw0aFzVL/XRHUEmRoPR2TF6
         J/ewtY9OvMUEfwT1u+Y3qMMcEadeH4832v7TCgazQU/cnBSPaQO2HOsJ0JHpPDHIEWjU
         8s2PHzDVozZ9keypcdrvTOx2+SrwfQKz5aO1okYrWNEr+WLo4Gw03mOMlbyucplpQq6B
         3wU42yx5Kk108L716OPP1l8lUIHNCPiMHZjYQ8NxQwhQkkQcQCies0/dl4G1cRSwnXs6
         igzA==
X-Gm-Message-State: AOJu0YzOV/YK03ReuIawoqzd3p8dLN6YZuj5pj6J5QXW8XfAXBLHn7eS
        Gr4wHwuOw1J2LRzcF3hGR7NpmA==
X-Google-Smtp-Source: AGHT+IGUtNWWyWmf848fI59Oh9vzwzV+h8xoT5tsOUJTpca8S2UbitMHLT8sOumyEoNeDIyW97OmpQ==
X-Received: by 2002:a17:90a:64c2:b0:263:829:2de with SMTP id i2-20020a17090a64c200b00263082902demr1813447pjm.2.1695194944762;
        Wed, 20 Sep 2023 00:29:04 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id 15-20020a17090a1a0f00b00263dfe9b972sm618582pjk.0.2023.09.20.00.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:29:04 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qirdt-0038Jd-2e;
        Wed, 20 Sep 2023 17:29:01 +1000
Date:   Wed, 20 Sep 2023 17:29:01 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Christoph Hellwig <hch@lst.de>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [bug report] ext4 misses final i_size meta sync under O_DIRECT |
 O_SYNC semantics after iomap DIO conversion
Message-ID: <ZQqfPVcQ12ijUTpS@dread.disaster.area>
References: <02d18236-26ef-09b0-90ad-030c4fe3ee20@linux.alibaba.com>
 <20230919120532.5dg7mgdnwd5lezgz@quack3>
 <9fccc0e4-8f51-d3e7-21de-f85f8837be7f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fccc0e4-8f51-d3e7-21de-f85f8837be7f@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 19, 2023 at 09:47:34PM +0800, Gao Xiang wrote:
> 
> (sorry... add Darrick here...)
> 
> Hi Jan,
> 
> On 2023/9/19 20:05, Jan Kara wrote:
> > Hello!
> > 
> > On Tue 19-09-23 14:00:04, Gao Xiang wrote:
> > > Our consumer reports a behavior change between pre-iomap and iomap
> > > direct io conversion:
> > > 
> > > If the system crashes after an appending write to a file open with
> > > O_DIRECT | O_SYNC flag set, file i_size won't be updated even if
> > > O_SYNC was marked before.
> > > 
> > > It can be reproduced by a test program in the attachment with
> > > gcc -o repro repro.c && ./repro testfile && echo c > /proc/sysrq-trigger
> > > 
> > > After some analysis, we found that before iomap direct I/O conversion,
> > > the timing was roughly (taking Linux 3.10 codebase as an example):
> > > 
> > > 	..
> > > 	- ext4_file_dio_write
> > > 	  - __generic_file_aio_write
> > > 	      ..
> > > 	    - ext4_direct_IO  # generic_file_direct_write
> > > 	      - ext4_ext_direct_IO
> > > 	        - ext4_ind_direct_IO  # final_size > inode->i_size
> > > 	          - ..
> > > 	          - ret = blockdev_direct_IO()
> > > 	          - i_size_write(inode, end) # orphan && ret > 0 &&
> > > 	                                   # end > inode->i_size
> > > 	          - ext4_mark_inode_dirty()
> > > 	          - ...
> > > 	  - generic_write_sync  # handling O_SYNC
> > > 
> > > So the dirty inode meta will be committed into journal immediately
> > > if O_SYNC is set.  However, After commit 569342dc2485 ("ext4: move
> > > inode extension/truncate code out from ->iomap_end() callback"),
> > > the new behavior seems as below:
> > > 
> > > 	..
> > > 	- ext4_dio_write_iter
> > > 	  - ext4_dio_write_checks  # extend = 1
> > > 	  - iomap_dio_rw
> > > 	      - __iomap_dio_rw
> > > 	      - iomap_dio_complete
> > > 	        - generic_write_sync
> > > 	  - ext4_handle_inode_extension  # extend = 1
> > > 
> > > So that i_size will be recorded only after generic_write_sync() is
> > > called.  So O_SYNC won't flush the update i_size to the disk.
> > 
> > Indeed, that looks like a bug. Thanks for report!
> 
> Thanks for the confirmation!
> 
> > 
> > > On the other side, after a quick look of XFS side, it will record
> > > i_size changes in xfs_dio_write_end_io() so it seems that it doesn't
> > > have this problem.
> > 
> > Yes, I'm a bit hazy on the details but I think we've decided to call
> > ext4_handle_inode_extension() directly from ext4_dio_write_iter() because
> > from ext4_dio_write_end_io() it was difficult to test in a race-free way
> > whether extending i_size (and i_disksize) is needed or not (we don't
> > necessarily hold i_rwsem there). I'll think how we could fix the problem
> > you've reported.

Given that ext4 can run extent conversion in IO completion, it can
run file extension in IO completion. Yes, that might require
additional synchronisation of file size updates to co-ordinate
submission and completion size checks. XFS just uses a spinlock for
this....

> Yes, another concern is O_DSYNC, I'm quite not sure if the behavior
> is changed too.

For O_DSYNC, the file size change needs to be covered by the
call to generic_write_sync() as well. O_DSYNC should be thought of
as being essentially the same as O_SYNC except for minor details.

> I had a rough feeling that currently iomap DIO behaviors on these are
> too strict and might not fit in each specific fs detailed
> implementation, tho.


In what way?  iomap implements exactly the data integrity semantics
that are required for O_DSYNC and O_SYNC writes, and it requires
filesystem end_io method to finalize all metadata modifications
needed for data integrity purposes.

Keep in mind that iomap is designed around the requirements async IO
(AIO and io_uring) place on individual IOs: there is no waiting
context to "finish" the IO before userspace is signalled that it is
complete. Hence everything related to data integrity needs to be
done by the filesystem in ->end_io before the iomap completion runs
generic_write_sync() and signals IO completion....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
