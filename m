Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D43DD67E503
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Jan 2023 13:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbjA0MVe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Jan 2023 07:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjA0MUp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Jan 2023 07:20:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7147F8661A;
        Fri, 27 Jan 2023 04:17:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4490721EB7;
        Fri, 27 Jan 2023 12:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674821842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/4KpuuqdrAykh+DBTA8CxdH9dCzIxdOHKTS53nbzPEc=;
        b=l4MILwDzhgtG6BvXoJQomLlRvEQKucaRuH8JQbUqZJBQoASoxcCB0nxUeUGNYBZzO4P4Y/
        Rf9Z45ukYja4xmv98mGJrYUaYPiVYg/QPBA8IGT7DKGhSCDz6sd2eDrclpFNknbnDwVy6+
        F7tGj+GzHXwUVOqmcNm6aoZ65e9ztdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674821842;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/4KpuuqdrAykh+DBTA8CxdH9dCzIxdOHKTS53nbzPEc=;
        b=dD8ABIgHhnqcw3aTmcv6VuS+cKk6EPeD18V+IyTQVCgrECeFGXblfU4otWWcO8/5yxQsaY
        HeStgSCudTC4IoAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28D78138E3;
        Fri, 27 Jan 2023 12:17:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kEnsCdLA02OfegAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 27 Jan 2023 12:17:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9F0D9A06B4; Fri, 27 Jan 2023 13:17:21 +0100 (CET)
Date:   Fri, 27 Jan 2023 13:17:21 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Bhatnagar, Rishabh" <risbhat@amazon.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, abuehaze@amazon.com
Subject: Re: EXT4 IOPS degradation between 4.14 and 5.10
Message-ID: <20230127121721.lerrb36nhj7gdiwm@quack3>
References: <053b60a6-133e-5d59-0732-464d5160772a@amazon.com>
 <20230126093231.ujn6yaxhexwzizp5@quack3>
 <b948ed49-1bdf-b17e-d03a-7ec8dfdb1afc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b948ed49-1bdf-b17e-d03a-7ec8dfdb1afc@amazon.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 26-01-23 10:23:07, Bhatnagar, Rishabh wrote:
> On 1/26/23 1:32 AM, Jan Kara wrote:
> > On Wed 25-01-23 16:33:54, Bhatnagar, Rishabh wrote:
> > > Fio with buffered io/fsync=1/randwrite
> > So I'm curious. Do you have any workload that actually does these
> > synchronous random buffered IOs? Or is it just a benchmarking exercise?
> > 
> So database team was a running benchmark called hammerdb with 16 connections
> where they started noticing dropped
> performance for 5.10. We traced it back to filesystem with this benchmark.
> Although the database workload would be something similar
>  I guess.

HammerDB is a TPC-C and TPC-H benchmark but details of the IO depend more
on the database it is hammering. Do you know which one? Anyway the most
important fact for me is that it is visible in a real world workload (well,
as much as DB benchmarking is real-world ;)).

> > > With HEAD as 9c19a9cb1642c074aa8bc7693cd4c038643960ae (with the above
> > > series)
> > > 
> > > write: io=445360KB, bw=7418.6KB/s, *iops=463*, runt= 60033msec
> > > clat (usec): min=4, max=32132, avg=311.90, stdev=1812.74
> > > lat (usec): min=5, max=32132, avg=312.28, stdev=1812.74
> > > clat percentiles (usec):
> > > | 1.00th=[ 8], 5.00th=[ 10], 10.00th=[ 16], 20.00th=[ 25],
> > > | 30.00th=[ 36], 40.00th=[ 47], 50.00th=[ 60], 60.00th=[ 71],
> > > | 70.00th=[ 84], 80.00th=[ 97], 90.00th=[ 111], 95.00th=[ 118],
> > > | 99.00th=[11840], 99.50th=[15936], 99.90th=[21888], 99.95th=[23936],
> > > 
> > > With HEAD as 6b4c54e3787bc03e810062bd257a3b05fd9c72d6(without the above
> > > series)
> > > 
> > > write: io=455184KB, bw=7583.4KB/s, *iops=473*, runt= 60024msec
> > > clat (usec): min=6, max=24325, avg=319.72, stdev=1694.52
> > > lat (usec): min=6, max=24326, avg=319.99, stdev=1694.53
> > > clat percentiles (usec):
> > > | 1.00th=[ 9], 5.00th=[ 11], 10.00th=[ 17], 20.00th=[ 26],
> > > | 30.00th=[ 38], 40.00th=[ 50], 50.00th=[ 60], 60.00th=[ 73],
> > > | 70.00th=[ 85], 80.00th=[ 98], 90.00th=[ 111], 95.00th=[ 118],
> > > | 99.00th=[ 9792], 99.50th=[14016], 99.90th=[21888], 99.95th=[22400],
> > > | 99.99th=[24192]
> > OK, about 2% regression. How stable is that across multiple runs?
> This is quite consistent. The thing to note here is this test is on 4.14+
> tip with and without
> these patch series.
> I tried reverting to the same behavior in 5.10 with the following patch but
> i only see a very low improvement. (~1%)

I see. Thanks for experiments.

> This is because on 5.10 we also have this patch
> ext4: avoid unnecessary transaction starts during writeback. (This limits
> the invocation of this function within the while loop)
> If i revert the above patch as well along with applying below patch i get
> back around 4% IOPS.
> 
> -       if (end == (pgoff_t)-1)
> -               *index = (pgoff_t)-1;
> -       else
> -               *index = end + 1;
> +       if (xas.xa_index > end) {
> +               if (end == (pgoff_t)-1)
> +                       *index = (pgoff_t)-1;
> +               else
> +                       *index = end + 1;
> +       }
> +       else if (ret)
> +               *index = xas.xa_index + 1;

Yes, so these patches have kind of magnifying effect together as each
multiplies the number of scanning by 2. So with both of them we get like 4
scans of the inode for dirty pages in one writeback round instead of 1.

> > > I also see that number of handles per transaction were much higher before
> > > this patch series
> > > 
> > > 0ms waiting for transaction
> > > 0ms request delay
> > > 20ms running transaction
> > > 0ms transaction was being locked
> > > 0ms flushing data (in ordered mode)
> > > 10ms logging transaction
> > > *13524us average transaction commit time*
> > > *73 handles per transaction*
> > > 0 blocks per transaction
> > > 1 logged blocks per transaction
> > > 
> > > vs after the patch series.
> > > 
> > > 0ms waiting for transaction
> > > 0ms request delay
> > > 20ms running transaction
> > > 0ms transaction was being locked
> > > 0ms flushing data (in ordered mode)
> > > 20ms logging transaction
> > > *21468us average transaction commit time*
> > > *66 handles per transaction*
> > > 1 blocks per transaction
> > > 1 logged blocks per transaction
> > > 
> > > This is probably again helping in bunching the writeback transactions and
> > > increasing throughput.
> > Yeah, probably.
> > 
> > > I looked at the code to understand what might be going on.
> > > It seems like commit 72b045aecdd856b083521f2a963705b4c2e59680 changes the
> > > behavior of find_get_pages_range_tag.
> > > Before this commit if find_get_pages_tag cannot find nr_pages (PAGEVEC_SIZE)
> > > it returns the number of pages found as ret and
> > > sets the *index to the last page it found + 1. After the commit the behavior
> > > changes such that if we don’t find nr_pages pages
> > > we set the index to end and not to the last found page. (added diff from
> > > above commit)
> > > Since pagevec_lookup_range_tag is always called in a while loop (index <=
> > > end) the code before the commit helps in coalescing
> > > writeback of pages if there are multiple threads doing write as it might
> > > keep finding new dirty (tagged) pages since it doesn’t set index to end.
> > > 
> > > + /*
> > > + * We come here when we got at @end. We take care to not overflow the
> > > + * index @index as it confuses some of the callers. This breaks the
> > > + * iteration when there is page at index -1 but that is already broken
> > > + * anyway.
> > > + */
> > > + if (end == (pgoff_t)-1)
> > > + *index = (pgoff_t)-1;
> > > + else
> > > + *index = end + 1;
> > > +out:
> > > rcu_read_unlock();
> > > 
> > > - if (ret)
> > > - *index = pages[ret - 1]->index + 1;
> > > -
> > > 
> > >  From the description of the patch i didn't see any mention of this
> > > functional change.
> > > Was this change intentional and did help some usecase or general performance
> > > improvement?
> > So the change was intentional. When I was working on the series, I was
> > somewhat concerned that the old code could end up in a pathological
> > situation like:
> >    We scan range 0-1000000, find the only dirty page at index 0, return it.
> >    We scan range 1-1000000, find the only dirty page at index 1, return it.
> >    ...
> > 
> > This way we end up with rather inefficient scanning and in theory malicious
> > user could livelock writeback like this. That being said this was/is mostly
> > a theoretical concern.
> 
> Ok so its more of a security concern. But do you think this has a latency
> impact? I didn't see
> much latency impact between the two sets and throughput is higher.

Yes, I expect there will be latency impact but for this workload probably
relatively small. I expect the expensive part on your workload is the
fsync(2) call, in particular the committing of the transaction and the
flushing of the disk caches as a result of that. Data writes themselves are
relatively cheap. If you had say 1MB blocks instead of 16k ones, I'd expect
the numbers to start looking differently as the cost of IO and of cache
flushing becomes for comparable - obviously it all depends on the details
of the backing storage as well. Perhaps could you measure how much time we
spend in file_write_and_wait_range() calls vs in the whole ext4_sync_file()
call to confirm that?

Overall your tests show we could gain some throughput without sacrificing
too much latency if we somehow batch tiny fsync requests more. The trick is
how to do this without regressing other workloads and also across various
storage types which are going to have very different properties.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
