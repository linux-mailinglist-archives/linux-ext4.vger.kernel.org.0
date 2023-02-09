Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAFD690238
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Feb 2023 09:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBIIe5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Feb 2023 03:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjBIIex (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Feb 2023 03:34:53 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F3C5268;
        Thu,  9 Feb 2023 00:34:51 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 71AAE5C418;
        Thu,  9 Feb 2023 08:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675931690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Hs1j4bTLbv5D9D4pDF8ynNWBCsg/djQgRo/zhSzDBg=;
        b=yXMTB+0Ex4MbCziSdoktH+gNgY5VhyqqQFu34VkpZoHZ5yN+x2haGp88V5sW/1JTI7fAj+
        x7n0V7f2+Ktlp97NNGcEARItltV7f06+Il/lU3J+4oIauRR2C9IO1Uq8By6AusvhTwmdqW
        gMyAqa4j3fJF+e7xd2I86RzMjn9RuJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675931690;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Hs1j4bTLbv5D9D4pDF8ynNWBCsg/djQgRo/zhSzDBg=;
        b=xTHlMFyMGBGuBbbfHn3vvhsmPEjWBMgYL+nA4esGLEQtU+D63JqXcGzCIg8wetK2zVpx1t
        EK35x9t/msb0qxBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6438613A1F;
        Thu,  9 Feb 2023 08:34:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vMptGCqw5GPhFAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Feb 2023 08:34:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E376FA06D8; Thu,  9 Feb 2023 09:34:49 +0100 (CET)
Date:   Thu, 9 Feb 2023 09:34:49 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Bhatnagar, Rishabh" <risbhat@amazon.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, abuehaze@amazon.com
Subject: Re: EXT4 IOPS degradation between 4.14 and 5.10
Message-ID: <20230209083449.ibmskbri5noojh4u@quack3>
References: <053b60a6-133e-5d59-0732-464d5160772a@amazon.com>
 <20230126093231.ujn6yaxhexwzizp5@quack3>
 <b948ed49-1bdf-b17e-d03a-7ec8dfdb1afc@amazon.com>
 <20230127121721.lerrb36nhj7gdiwm@quack3>
 <6a0fcca5-b869-ffb7-426b-b49a6782c1c0@amazon.com>
 <20230208140247.rt62xdtriopfdb4o@quack3>
 <1c134792-1763-8c92-6516-78a330d4756e@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c134792-1763-8c92-6516-78a330d4756e@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 08-02-23 11:17:21, Bhatnagar, Rishabh wrote:
> > > > > > > + /*
> > > > > > > + * We come here when we got at @end. We take care to not overflow the
> > > > > > > + * index @index as it confuses some of the callers. This breaks the
> > > > > > > + * iteration when there is page at index -1 but that is already broken
> > > > > > > + * anyway.
> > > > > > > + */
> > > > > > > + if (end == (pgoff_t)-1)
> > > > > > > + *index = (pgoff_t)-1;
> > > > > > > + else
> > > > > > > + *index = end + 1;
> > > > > > > +out:
> > > > > > > rcu_read_unlock();
> > > > > > > 
> > > > > > > - if (ret)
> > > > > > > - *index = pages[ret - 1]->index + 1;
> > > > > > > -
> > > > > > > 
> > > > > > >    From the description of the patch i didn't see any mention of this
> > > > > > > functional change.
> > > > > > > Was this change intentional and did help some usecase or general performance
> > > > > > > improvement?
> > > > > > So the change was intentional. When I was working on the series, I was
> > > > > > somewhat concerned that the old code could end up in a pathological
> > > > > > situation like:
> > > > > >      We scan range 0-1000000, find the only dirty page at index 0, return it.
> > > > > >      We scan range 1-1000000, find the only dirty page at index 1, return it.
> > > > > >      ...
> > > > > > 
> > > > > > This way we end up with rather inefficient scanning and in theory malicious
> > > > > > user could livelock writeback like this. That being said this was/is mostly
> > > > > > a theoretical concern.
> > > > > Ok so its more of a security concern. But do you think this has a latency
> > > > > impact? I didn't see
> > > > > much latency impact between the two sets and throughput is higher.
> > > > Yes, I expect there will be latency impact but for this workload probably
> > > > relatively small. I expect the expensive part on your workload is the
> > > > fsync(2) call, in particular the committing of the transaction and the
> > > > flushing of the disk caches as a result of that. Data writes themselves are
> > > > relatively cheap. If you had say 1MB blocks instead of 16k ones, I'd expect
> > > > the numbers to start looking differently as the cost of IO and of cache
> > > > flushing becomes for comparable - obviously it all depends on the details
> > > > of the backing storage as well. Perhaps could you measure how much time we
> > > > spend in file_write_and_wait_range() calls vs in the whole ext4_sync_file()
> > > > call to confirm that?
> > > > 
> > > > Overall your tests show we could gain some throughput without sacrificing
> > > > too much latency if we somehow batch tiny fsync requests more. The trick is
> > > > how to do this without regressing other workloads and also across various
> > > > storage types which are going to have very different properties.
> > > Yeah i agree fsync is much more expensive operation than just dirtying
> > > buffers in page cache.  I did use the ext4dist tool from bcc to get the
> > > distribution of write vs fsync.  Overall fsync is much more expensive
> > > operation so yeah if we can get higher throughput here with batching it
> > > shouldn't impact fsync latency that much.
> > Well, I was more interested in file_write_and_wait_range() vs
> > ext4_sync_file() latency comparison. write(2) calls are indeed very fast
> > because they just copy into the page cache so that is not very interesting.
> > But file_write_and_wait_range() is more interesting because that measures
> > the cost of writing file data to the disk while whole ext4_sync_file()
> > measures the cost of writing file data to the disk + the cost of flushing
> > the journal and I'm interested in how much is the flushing of the journal
> > costly compared to the data writeback.
> 
> Sorry i misunderstood your comment. Here is the revised data. Flushing
> journal very heavy compared to flushing data.
> 
> ext4_sync_file:       ~18.6 msecs
> fdatawrite_range:   ~ 4usecs
> fdatawait_range:     ~ 83.6usecs
> fc_commit:             ~18.6 msecs
> 
> Tracing 1 functions for "ext4_sync_file"
> 
> 
>      nsecs               : count     distribution
>    1048576 -> 2097151    : 75 |                                        |
>    2097152 -> 4194303    : 1496 |****                                    |
>    4194304 -> 8388607    : 3461 |**********                              |
>    8388608 -> 16777215   : 6693 |********************                    |
>   16777216 -> 33554431   : 13355 |****************************************|
>   33554432 -> 67108863   : 1631 |****                                    |
> 
> avg = 18624922 nsecs, total: 505778389231 nsecs, count: 27156
> 
> 
> Tracing 1 functions for "__filemap_fdatawrite_range"
> 
>      nsecs               : count     distribution
>        512 -> 1023       : 0 |                                        |
>       1024 -> 2047       : 1 |**                                      |
>       2048 -> 4095       : 14 |****************************************|
>       4096 -> 8191       : 5 |**************                          |
>       8192 -> 16383      : 1 |**                                      |
> 
> avg = 3943 nsecs, total: 82809 nsecs, count: 21
> 
> Tracing 1 functions for "__filemap_fdatawait_range
> 
>      nsecs               : count     distribution
>        128 -> 255        : 0 |                                        |
>        256 -> 511        : 1 |********************                    |
>        512 -> 1023       : 2 |****************************************|
>       1024 -> 2047       : 2 |****************************************|
>       2048 -> 4095       : 0 |                                        |
>       4096 -> 8191       : 0 |                                        |
>       8192 -> 16383      : 0 |                                        |
>      16384 -> 32767      : 0 |                                        |
>      32768 -> 65535      : 0 |                                        |
>      65536 -> 131071     : 0 |                                        |
>     131072 -> 262143     : 0 |                                        |
>     262144 -> 524287     : 1 |********************                    |
> 
> avg = 83644 nsecs, total: 501866 nsecs, count: 6
> 
> Tracing 1 functions for "ext4_fc_commit
> 
>      nsecs               : count     distribution
>    1048576 -> 2097151    : 70 |                                        |
>    2097152 -> 4194303    : 1512 |****                                    |
>    4194304 -> 8388607    : 3436 |**********                              |
>    8388608 -> 16777215   : 6699 |********************                    |
>   16777216 -> 33554431   : 13349 |****************************************|
>   33554432 -> 67108863   : 1641 |****                                    |
> 
> avg = 18622010 nsecs, total: 505699318966 nsecs, count: 27156

Thanks for the data! So indeed as I suspected for your storage the
transaction commit (likely due to the flushing of disk caches) costs the
vast majority of time. I guess I'll try to experiment with this a bit if we
can somehow achieve more batching in ext4_sync_file()...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
