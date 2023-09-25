Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753187AD7B5
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Sep 2023 14:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjIYMI6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Sep 2023 08:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjIYMIl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Sep 2023 08:08:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83001BD
        for <linux-ext4@vger.kernel.org>; Mon, 25 Sep 2023 05:08:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 54B6C1F459;
        Mon, 25 Sep 2023 12:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695643703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KDSqbtpNDfDZpc7I5Hc8DnpJO20gVcuFOR0lD7GNVLM=;
        b=XLnEMn0Ji3kfla36igvpshT135a5ztSAs5lrGI5dKW4ahI8rult1QLTu5Pi4lgIj5JQkr2
        LavfRKOM6s/jxPnh9ExUr9AVxuOi4bTlXxdGJS1VXAEYymxyhe/hauTbB0lrzy+HJruonb
        cDigjX8QWsbkSGmNcAxserCo2RU1Alo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695643703;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KDSqbtpNDfDZpc7I5Hc8DnpJO20gVcuFOR0lD7GNVLM=;
        b=0/MTeDUTpufJZJI/6RZWjKBrP0sd2Y1pdH9KxFmu+1aNwvZx8LOJA8zgBcmugZXaMJ3PiB
        lMgzJY4QRmjJInAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48E921358F;
        Mon, 25 Sep 2023 12:08:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wlXBETd4EWWOYAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 25 Sep 2023 12:08:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E1A44A07C6; Mon, 25 Sep 2023 14:08:22 +0200 (CEST)
Date:   Mon, 25 Sep 2023 14:08:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Christoph Hellwig <hch@lst.de>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [bug report] ext4 misses final i_size meta sync under O_DIRECT |
 O_SYNC semantics after iomap DIO conversion
Message-ID: <20230925120822.g2mvg2wsd42dpsh4@quack3>
References: <20230920152005.7iowrlukd5zbvp43@quack3>
 <87y1gy5s9c.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1gy5s9c.fsf@doe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 22-09-23 17:33:59, Ritesh Harjani wrote:
> Jan Kara <jack@suse.cz> writes:
> 
> > On Wed 20-09-23 17:08:19, Ritesh Harjani wrote:
> >> Jan Kara <jack@suse.cz> writes:
> >> 
> >> > Hello!
> >> >
> >> > On Tue 19-09-23 14:00:04, Gao Xiang wrote:
> >> >> Our consumer reports a behavior change between pre-iomap and iomap
> >> >> direct io conversion:
> >> >> 
> >> >> If the system crashes after an appending write to a file open with
> >> >> O_DIRECT | O_SYNC flag set, file i_size won't be updated even if
> >> >> O_SYNC was marked before.
> >> >> 
> >> >> It can be reproduced by a test program in the attachment with
> >> >> gcc -o repro repro.c && ./repro testfile && echo c > /proc/sysrq-trigger
> >> >> 
> >> >> After some analysis, we found that before iomap direct I/O conversion,
> >> >> the timing was roughly (taking Linux 3.10 codebase as an example):
> >> >> 
> >> >> 	..
> >> >> 	- ext4_file_dio_write
> >> >> 	  - __generic_file_aio_write
> >> >> 	      ..
> >> >> 	    - ext4_direct_IO  # generic_file_direct_write
> >> >> 	      - ext4_ext_direct_IO
> >> >> 	        - ext4_ind_direct_IO  # final_size > inode->i_size
> >> >> 	          - ..
> >> >> 	          - ret = blockdev_direct_IO()
> >> >> 	          - i_size_write(inode, end) # orphan && ret > 0 &&
> >> >> 	                                   # end > inode->i_size
> >> >> 	          - ext4_mark_inode_dirty()
> >> >> 	          - ...
> >> >> 	  - generic_write_sync  # handling O_SYNC
> >> >> 
> >> >> So the dirty inode meta will be committed into journal immediately
> >> >> if O_SYNC is set.  However, After commit 569342dc2485 ("ext4: move
> >> >> inode extension/truncate code out from ->iomap_end() callback"),
> >> >> the new behavior seems as below:
> >> >> 
> >> >> 	..
> >> >> 	- ext4_dio_write_iter
> >> >> 	  - ext4_dio_write_checks  # extend = 1
> >> >> 	  - iomap_dio_rw
> >> >> 	      - __iomap_dio_rw
> >> >> 	      - iomap_dio_complete
> >> >> 	        - generic_write_sync
> >> >> 	  - ext4_handle_inode_extension  # extend = 1
> >> 
> >> Yes, since ext4_handle_inode_extension() will handle inode i_disksize
> >> update and mark the inode dirty, generic_write_sync() call should happen
> >> after that.
> >> 
> >> That also means then we don't have any generic FS testcase which can
> >> validate this behaviour. 
> >
> > Yeah.
> >
> 
> Ok. Let me then first send a fstest in response to this integrity
> problem with directio and o_sync.

Thanks for working on the testcase! I have written a fix in the meantime
but so far it causes weird inconsistencies in fsstress ENOSPC hitters tests
so I'm still debugging that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
