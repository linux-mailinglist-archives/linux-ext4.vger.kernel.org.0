Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87957A6202
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 14:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjISMFl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Sep 2023 08:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISMFk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Sep 2023 08:05:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C42A9
        for <linux-ext4@vger.kernel.org>; Tue, 19 Sep 2023 05:05:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D17342296B;
        Tue, 19 Sep 2023 12:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695125132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z7gz9m/wDLk7VauKP/nz592F9OD+w767xYdMeuCwADM=;
        b=3bOIskraCYMl3jpMPGpSpaTcGw6n9x1IjCVeITRT0aVTb47NdaLMh4U3gAm4ouSgO3or4h
        XUtydm8uex+ZAXPZeJ3nMzUDWVbvaFDJRXiIV2pCUfACzhPN9goQkk68Aw3Y3fyjuBRJn0
        vst72Z8spnbcI5OukY9Vj6bLrKHycfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695125132;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z7gz9m/wDLk7VauKP/nz592F9OD+w767xYdMeuCwADM=;
        b=nalwXWpo5OfqOIuXMGKtVONItQ0UnpzLenDbxtLplWiJWCZWfHgFABpLaLcT9ZIhN6A7Q6
        WGZej0ZmyXm0VBAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8EED134F3;
        Tue, 19 Sep 2023 12:05:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0jIjLYyOCWUEBQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 19 Sep 2023 12:05:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 53708A0759; Tue, 19 Sep 2023 14:05:32 +0200 (CEST)
Date:   Tue, 19 Sep 2023 14:05:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Christoph Hellwig <hch@lst.de>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [bug report] ext4 misses final i_size meta sync under O_DIRECT |
 O_SYNC semantics after iomap DIO conversion
Message-ID: <20230919120532.5dg7mgdnwd5lezgz@quack3>
References: <02d18236-26ef-09b0-90ad-030c4fe3ee20@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02d18236-26ef-09b0-90ad-030c4fe3ee20@linux.alibaba.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On Tue 19-09-23 14:00:04, Gao Xiang wrote:
> Our consumer reports a behavior change between pre-iomap and iomap
> direct io conversion:
> 
> If the system crashes after an appending write to a file open with
> O_DIRECT | O_SYNC flag set, file i_size won't be updated even if
> O_SYNC was marked before.
> 
> It can be reproduced by a test program in the attachment with
> gcc -o repro repro.c && ./repro testfile && echo c > /proc/sysrq-trigger
> 
> After some analysis, we found that before iomap direct I/O conversion,
> the timing was roughly (taking Linux 3.10 codebase as an example):
> 
> 	..
> 	- ext4_file_dio_write
> 	  - __generic_file_aio_write
> 	      ..
> 	    - ext4_direct_IO  # generic_file_direct_write
> 	      - ext4_ext_direct_IO
> 	        - ext4_ind_direct_IO  # final_size > inode->i_size
> 	          - ..
> 	          - ret = blockdev_direct_IO()
> 	          - i_size_write(inode, end) # orphan && ret > 0 &&
> 	                                   # end > inode->i_size
> 	          - ext4_mark_inode_dirty()
> 	          - ...
> 	  - generic_write_sync  # handling O_SYNC
> 
> So the dirty inode meta will be committed into journal immediately
> if O_SYNC is set.  However, After commit 569342dc2485 ("ext4: move
> inode extension/truncate code out from ->iomap_end() callback"),
> the new behavior seems as below:
> 
> 	..
> 	- ext4_dio_write_iter
> 	  - ext4_dio_write_checks  # extend = 1
> 	  - iomap_dio_rw
> 	      - __iomap_dio_rw
> 	      - iomap_dio_complete
> 	        - generic_write_sync
> 	  - ext4_handle_inode_extension  # extend = 1
> 
> So that i_size will be recorded only after generic_write_sync() is
> called.  So O_SYNC won't flush the update i_size to the disk.

Indeed, that looks like a bug. Thanks for report!

> On the other side, after a quick look of XFS side, it will record
> i_size changes in xfs_dio_write_end_io() so it seems that it doesn't
> have this problem.

Yes, I'm a bit hazy on the details but I think we've decided to call
ext4_handle_inode_extension() directly from ext4_dio_write_iter() because
from ext4_dio_write_end_io() it was difficult to test in a race-free way
whether extending i_size (and i_disksize) is needed or not (we don't
necessarily hold i_rwsem there). I'll think how we could fix the problem
you've reported.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
