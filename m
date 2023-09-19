Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EF17A65A7
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 15:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjISNru (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Sep 2023 09:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjISNrt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Sep 2023 09:47:49 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702F89E
        for <linux-ext4@vger.kernel.org>; Tue, 19 Sep 2023 06:47:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VsRnxVo_1695131257;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VsRnxVo_1695131257)
          by smtp.aliyun-inc.com;
          Tue, 19 Sep 2023 21:47:38 +0800
Message-ID: <9fccc0e4-8f51-d3e7-21de-f85f8837be7f@linux.alibaba.com>
Date:   Tue, 19 Sep 2023 21:47:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [bug report] ext4 misses final i_size meta sync under O_DIRECT |
 O_SYNC semantics after iomap DIO conversion
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Christoph Hellwig <hch@lst.de>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Darrick J. Wong" <djwong@kernel.org>
References: <02d18236-26ef-09b0-90ad-030c4fe3ee20@linux.alibaba.com>
 <20230919120532.5dg7mgdnwd5lezgz@quack3>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230919120532.5dg7mgdnwd5lezgz@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


(sorry... add Darrick here...)

Hi Jan,

On 2023/9/19 20:05, Jan Kara wrote:
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
>>
>> So that i_size will be recorded only after generic_write_sync() is
>> called.  So O_SYNC won't flush the update i_size to the disk.
> 
> Indeed, that looks like a bug. Thanks for report!

Thanks for the confirmation!

> 
>> On the other side, after a quick look of XFS side, it will record
>> i_size changes in xfs_dio_write_end_io() so it seems that it doesn't
>> have this problem.
> 
> Yes, I'm a bit hazy on the details but I think we've decided to call
> ext4_handle_inode_extension() directly from ext4_dio_write_iter() because
> from ext4_dio_write_end_io() it was difficult to test in a race-free way
> whether extending i_size (and i_disksize) is needed or not (we don't
> necessarily hold i_rwsem there). I'll think how we could fix the problem
> you've reported.

Yes, another concern is O_DSYNC, I'm quite not sure if the behavior
is changed too.

I had a rough feeling that currently iomap DIO behaviors on these are
too strict and might not fit in each specific fs detailed
implementation, tho.

Thanks,
Gao Xiang

> 
> 								Honza
