Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1714E7A7A86
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Sep 2023 13:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjITLib (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Sep 2023 07:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjITLia (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Sep 2023 07:38:30 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16FDA3
        for <linux-ext4@vger.kernel.org>; Wed, 20 Sep 2023 04:38:24 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1d676732587so2905357fac.3
        for <linux-ext4@vger.kernel.org>; Wed, 20 Sep 2023 04:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695209904; x=1695814704; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6vC24T7M9Dn7Ndzi8pfM8Y4bY9eO0pHE+eDBTIPG6+o=;
        b=Nlu24H8Qq14TGiUxGzHAsOqCPhjeH8USmm1CuzY9vx4cIa8t/VF532O0m7U69FYGnq
         n5lcqe3kVduRQB+ufHd71EwapdagTHngDoBC0414O12A6hI3+AEqR8BSIek4YH8npekq
         YxZy0c8jHn/zRI2pOUQ5GtzMCynKAM0m/tYVmNvVNA8YC+Cv5RjsEFiocKCycY4fTdkT
         oujoGa5LyRCMkTgq7WRJZlG65pjHGq69/QJsAtkPNBYb4uo42PdyDw/D1jJIbhDvPkoq
         sLRd32GCtv60DrURllfyJSQD8VQFzG5U3gDvMeuxrMqyYTL1zdDUxQi3ueNl22cdcK/r
         mUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695209904; x=1695814704;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6vC24T7M9Dn7Ndzi8pfM8Y4bY9eO0pHE+eDBTIPG6+o=;
        b=riGXh+ViXIWNxsAzVWPkccI3qPkI+vJ/H4chzZo7tEXBuixDeMSdG2puXetQFEpd39
         1pxmVlJHMaavudeUeNkc15qWVzIXPsVIVs+hVYGbSrUYmAj2Frez71GyKnuspr0Hi5yF
         jv/z4HeuotvlBowQGWHPxYBHB792Ywi82sExMoMGfWen0kKeXW6/Eo/kBU1oNwa2a0kR
         6L+FXQPSAG764SUgz68iUj1m/8jcRYYLoOTekYYFwPnjtik7faWhbpXkYURapdu7kAGB
         O9IgwDjTR1tU4NG+6DxKFfertUojCOWj3buGODO2jsd5D0IvSkbEimXtHrFV0s9l1KXf
         41hg==
X-Gm-Message-State: AOJu0YyY3fteWWBbsHOdm723ccb2hr3/cfh6fKMkfJDkXxzJ8ebeWwpH
        VFLH97CXRLcPEzZCvCaiQ+c=
X-Google-Smtp-Source: AGHT+IEinNdx/XiMdgS6I7kpUoy5nPFSmYsQEBFbaZgRWBdvg8pPcTZTF7/ZSIr+2ddUXgABY3QQNQ==
X-Received: by 2002:a05:6871:551:b0:1bb:8842:7b5c with SMTP id t17-20020a056871055100b001bb88427b5cmr2166875oal.43.1695209903951;
        Wed, 20 Sep 2023 04:38:23 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id y9-20020aa78049000000b006675c242548sm10045574pfm.182.2023.09.20.04.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 04:38:23 -0700 (PDT)
Date:   Wed, 20 Sep 2023 17:08:19 +0530
Message-Id: <871qet6pn8.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>, Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Christoph Hellwig <hch@lst.de>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [bug report] ext4 misses final i_size meta sync under O_DIRECT | O_SYNC semantics after iomap DIO conversion
In-Reply-To: <20230919120532.5dg7mgdnwd5lezgz@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> Hello!
>
> On Tue 19-09-23 14:00:04, Gao Xiang wrote:
>> Our consumer reports a behavior change between pre-iomap and iomap
>> direct io conversion:
>> 
>> If the system crashes after an appending write to a file open with
>> O_DIRECT | O_SYNC flag set, file i_size won't be updated even if
>> O_SYNC was marked before.
>> 
>> It can be reproduced by a test program in the attachment with
>> gcc -o repro repro.c && ./repro testfile && echo c > /proc/sysrq-trigger
>> 
>> After some analysis, we found that before iomap direct I/O conversion,
>> the timing was roughly (taking Linux 3.10 codebase as an example):
>> 
>> 	..
>> 	- ext4_file_dio_write
>> 	  - __generic_file_aio_write
>> 	      ..
>> 	    - ext4_direct_IO  # generic_file_direct_write
>> 	      - ext4_ext_direct_IO
>> 	        - ext4_ind_direct_IO  # final_size > inode->i_size
>> 	          - ..
>> 	          - ret = blockdev_direct_IO()
>> 	          - i_size_write(inode, end) # orphan && ret > 0 &&
>> 	                                   # end > inode->i_size
>> 	          - ext4_mark_inode_dirty()
>> 	          - ...
>> 	  - generic_write_sync  # handling O_SYNC
>> 
>> So the dirty inode meta will be committed into journal immediately
>> if O_SYNC is set.  However, After commit 569342dc2485 ("ext4: move
>> inode extension/truncate code out from ->iomap_end() callback"),
>> the new behavior seems as below:
>> 
>> 	..
>> 	- ext4_dio_write_iter
>> 	  - ext4_dio_write_checks  # extend = 1
>> 	  - iomap_dio_rw
>> 	      - __iomap_dio_rw
>> 	      - iomap_dio_complete
>> 	        - generic_write_sync
>> 	  - ext4_handle_inode_extension  # extend = 1

Yes, since ext4_handle_inode_extension() will handle inode i_disksize
update and mark the inode dirty, generic_write_sync() call should happen
after that.

That also means then we don't have any generic FS testcase which can validate
this behaviour. 

>> 
>> So that i_size will be recorded only after generic_write_sync() is
>> called.  So O_SYNC won't flush the update i_size to the disk.
>
> Indeed, that looks like a bug. Thanks for report!
>
>> On the other side, after a quick look of XFS side, it will record
>> i_size changes in xfs_dio_write_end_io() so it seems that it doesn't
>> have this problem.
>
> Yes, I'm a bit hazy on the details but I think we've decided to call
> ext4_handle_inode_extension() directly from ext4_dio_write_iter() because
> from ext4_dio_write_end_io() it was difficult to test in a race-free way
> whether extending i_size (and i_disksize) is needed or not (we don't
> necessarily hold i_rwsem there).

We do hold i_rwsem in exclusive write mode for file extend case.
(ext4_dio_write_checks()).

IIUC, ext4_handle_inode_extension() takes "written" and "count" as it's
argument. This means that "count" bytes were mapped, but only "written"
bytes were written. This information is used in
ext4_handle_inode_extension() case for truncating blocks beyond EOF. 

I also found this discussion here [1].

[1]:
https://lore.kernel.org/linux-ext4/20191008151238.GK5078@quack2.suse.cz/

From this thread it looks like we decided to move
ext4_handle_inode_extension() case out of ->end_io callback after v4
series (in v5) to handle above case. Right?

Do let me know if you think it was due to something else.

> I'll think how we could fix the problem you've reported.
>

1. I was thinking why do we need to truncate those blocks which are beyond
EOF for DIO case? Wasn't there an argument, that for short DIO writes,
we can use the remaining blocks allocated to be written by buffered-io,
right? Do we risk exposing anything in doing so?
We do fallback to buffered-io for short writes in ext4_dio_write_iter().

2. Either ways let's say we still would like to call truncate. Then can we
move ext4_truncate() logic out of ext4_handle_inode_extension() and call
ext4_handle_inode_extension() from within ->end_io callback. 
ext4_truncate() can be then done in the main routine directly i.e. in
ext4_dio_write_iter() where we do have both "count" and "written" information.

Thoughts?

-ritesh

> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
