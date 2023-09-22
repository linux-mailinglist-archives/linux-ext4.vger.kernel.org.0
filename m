Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905D37AB1B7
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Sep 2023 14:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjIVMEW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Sep 2023 08:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbjIVMEM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Sep 2023 08:04:12 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D66100
        for <linux-ext4@vger.kernel.org>; Fri, 22 Sep 2023 05:04:05 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-690bd8f89baso1816663b3a.2
        for <linux-ext4@vger.kernel.org>; Fri, 22 Sep 2023 05:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695384244; x=1695989044; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+rZBTXldh6fGcLXPDs1Aq0nPjZAfErnl8acbOhRd+nE=;
        b=MCzt/YX2auqZI6X/TrI+CusTOn/1BDR13ifYt50NWFsQb8dXG+gWbTfQ+VnkDHesLQ
         NnINl3Q1QNn6GETQGUHIxB1/5f1EbvUp7/S6kGm/Eey2Fxc2MTZcyULX9r/kD8kbD5Y7
         YNEAyNQicsraw87g4cnrRbz2ZsZagb2SkYAAOxnd5NbwjNodLsKH5z07NV4uhGuWHgLO
         MdpvX7ThbcFMgY/fO96kSik4Z0gU6zR/vHgl9+Z9D4BVtPRrlhaVajVEiUR36B9Bferh
         4NshNb7ecuimWMzd0JXZldYV/mkUkUsky1RVUxnL9fzsY6kQlPM/SHqkFYoGabAVN4Ad
         bnog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695384244; x=1695989044;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+rZBTXldh6fGcLXPDs1Aq0nPjZAfErnl8acbOhRd+nE=;
        b=ovp6q5Em/DT0ZEwBtrIBYHotWgRNe11C4EEkVjLSvMKalesL3zAZZVcxQL9wgHQ5vG
         5wEeehxiBhAmdrG+jJ6m/JEa4EJrJiKZ4KVvil2lf+s433HNd5k5kUxmnG78btNRg7kn
         ErTuIHONh8xjKAfBxG17AAbO5cvXm0SEUpLNIfx15PPlPXz2zB5B0ViHkcZnFj3VphPm
         WrnT/JlEOmRnMqyzneHPX+6yHxtqZoVNvSJxB0jqL/Q82/ds2c2wS19nQ2xOoeQWxKiQ
         PHbHs+DCCC5nwx3XYcEcQmCm0B5clXuGFuPFcKXq0+vgejICdo4mm1rJJg74J2mq6c+r
         W6/A==
X-Gm-Message-State: AOJu0Yy+xgZM0nJNRngB17dWwUc6nGFh8GcgFum7LcOEzbXsYdDm4/hb
        5o6ikeTm3NyiKeTi35NJj1Y=
X-Google-Smtp-Source: AGHT+IHujq9+4VDSYKnYCyDKJh9N0IhkFU2KFBY2omzYFVqqO8pAYIkcbUZ8ahKMFnFIhqns9xI7YA==
X-Received: by 2002:a05:6a00:1350:b0:68f:efc2:ba46 with SMTP id k16-20020a056a00135000b0068fefc2ba46mr9673588pfu.25.1695384244155;
        Fri, 22 Sep 2023 05:04:04 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id b13-20020aa7810d000000b0068fb9965036sm3023874pfi.109.2023.09.22.05.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 05:04:03 -0700 (PDT)
Date:   Fri, 22 Sep 2023 17:33:59 +0530
Message-Id: <87y1gy5s9c.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.cz>, Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Christoph Hellwig <hch@lst.de>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [bug report] ext4 misses final i_size meta sync under O_DIRECT | O_SYNC semantics after iomap DIO conversion
In-Reply-To: <20230920152005.7iowrlukd5zbvp43@quack3>
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

> On Wed 20-09-23 17:08:19, Ritesh Harjani wrote:
>> Jan Kara <jack@suse.cz> writes:
>> 
>> > Hello!
>> >
>> > On Tue 19-09-23 14:00:04, Gao Xiang wrote:
>> >> Our consumer reports a behavior change between pre-iomap and iomap
>> >> direct io conversion:
>> >> 
>> >> If the system crashes after an appending write to a file open with
>> >> O_DIRECT | O_SYNC flag set, file i_size won't be updated even if
>> >> O_SYNC was marked before.
>> >> 
>> >> It can be reproduced by a test program in the attachment with
>> >> gcc -o repro repro.c && ./repro testfile && echo c > /proc/sysrq-trigger
>> >> 
>> >> After some analysis, we found that before iomap direct I/O conversion,
>> >> the timing was roughly (taking Linux 3.10 codebase as an example):
>> >> 
>> >> 	..
>> >> 	- ext4_file_dio_write
>> >> 	  - __generic_file_aio_write
>> >> 	      ..
>> >> 	    - ext4_direct_IO  # generic_file_direct_write
>> >> 	      - ext4_ext_direct_IO
>> >> 	        - ext4_ind_direct_IO  # final_size > inode->i_size
>> >> 	          - ..
>> >> 	          - ret = blockdev_direct_IO()
>> >> 	          - i_size_write(inode, end) # orphan && ret > 0 &&
>> >> 	                                   # end > inode->i_size
>> >> 	          - ext4_mark_inode_dirty()
>> >> 	          - ...
>> >> 	  - generic_write_sync  # handling O_SYNC
>> >> 
>> >> So the dirty inode meta will be committed into journal immediately
>> >> if O_SYNC is set.  However, After commit 569342dc2485 ("ext4: move
>> >> inode extension/truncate code out from ->iomap_end() callback"),
>> >> the new behavior seems as below:
>> >> 
>> >> 	..
>> >> 	- ext4_dio_write_iter
>> >> 	  - ext4_dio_write_checks  # extend = 1
>> >> 	  - iomap_dio_rw
>> >> 	      - __iomap_dio_rw
>> >> 	      - iomap_dio_complete
>> >> 	        - generic_write_sync
>> >> 	  - ext4_handle_inode_extension  # extend = 1
>> 
>> Yes, since ext4_handle_inode_extension() will handle inode i_disksize
>> update and mark the inode dirty, generic_write_sync() call should happen
>> after that.
>> 
>> That also means then we don't have any generic FS testcase which can
>> validate this behaviour. 
>
> Yeah.
>

Ok. Let me then first send a fstest in response to this integrity
problem with directio and o_sync.

-ritesh
