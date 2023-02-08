Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD3768F04E
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Feb 2023 15:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjBHOD1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Feb 2023 09:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjBHODW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Feb 2023 09:03:22 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCE1DBE0;
        Wed,  8 Feb 2023 06:02:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A5D82220C9;
        Wed,  8 Feb 2023 14:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675864968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GJY4tobiL5T+hGLI3mpeXEghVbKcnK1CLc9b6AsnAIE=;
        b=rXSyxZZLPX10gFtRNtdMZ5VB11Ux+a3Aad5TXaFduBSkC1Soad9UfFaLUerV/pCsQYbq1W
        3VHDNEd88upLMDKd9Jqm4ad6bpXyROgidCPT1CH1O78kImbTOfQIVJpOcQkMY0zP+hXJNT
        +Jgzlj4MilZYzZShzCCiCL7MQTBhDwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675864968;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GJY4tobiL5T+hGLI3mpeXEghVbKcnK1CLc9b6AsnAIE=;
        b=0XSGdXY0tBUgbrNM50it1AaRp/DSZG/oTXp/+76sad6bmd/qbAUUvHhHxFfTCrOCUCs5mG
        55wlk7pu1Pr0tUCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 921AA1358A;
        Wed,  8 Feb 2023 14:02:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eLmhI4ir42OEGAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 08 Feb 2023 14:02:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 07AA3A06D5; Wed,  8 Feb 2023 15:02:48 +0100 (CET)
Date:   Wed, 8 Feb 2023 15:02:47 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Bhatnagar, Rishabh" <risbhat@amazon.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, abuehaze@amazon.com
Subject: Re: EXT4 IOPS degradation between 4.14 and 5.10
Message-ID: <20230208140247.rt62xdtriopfdb4o@quack3>
References: <053b60a6-133e-5d59-0732-464d5160772a@amazon.com>
 <20230126093231.ujn6yaxhexwzizp5@quack3>
 <b948ed49-1bdf-b17e-d03a-7ec8dfdb1afc@amazon.com>
 <20230127121721.lerrb36nhj7gdiwm@quack3>
 <6a0fcca5-b869-ffb7-426b-b49a6782c1c0@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a0fcca5-b869-ffb7-426b-b49a6782c1c0@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 30-01-23 09:45:32, Bhatnagar, Rishabh wrote:
> 
> On 1/27/23 4:17 AM, Jan Kara wrote:
> > CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you can confirm the sender and know the content is safe.
> > 
> > 
> > 
> > On Thu 26-01-23 10:23:07, Bhatnagar, Rishabh wrote:
> > > On 1/26/23 1:32 AM, Jan Kara wrote:
> > > > On Wed 25-01-23 16:33:54, Bhatnagar, Rishabh wrote:
> > > > > Fio with buffered io/fsync=1/randwrite
> > > > So I'm curious. Do you have any workload that actually does these
> > > > synchronous random buffered IOs? Or is it just a benchmarking exercise?
> > > > 
> > > So database team was a running benchmark called hammerdb with 16 connections
> > > where they started noticing dropped
> > > performance for 5.10. We traced it back to filesystem with this benchmark.
> > > Although the database workload would be something similar
> > >   I guess.
> > HammerDB is a TPC-C and TPC-H benchmark but details of the IO depend more
> > on the database it is hammering. Do you know which one? Anyway the most
> > important fact for me is that it is visible in a real world workload (well,
> > as much as DB benchmarking is real-world ;)).
> I believe its the MySQL database though not so sure.

Well, in that case I think your MySQL DB is somewhat misconfigured. At
least as far as we have been consulting MySQL / MariaDB developers
regarding benchmarking, they suggested we should configure the database to
use direct IO and increase DB internal buffers instead of relying on
buffered IO and pagecache behavior. And if your fio job is representative
of the IO load the DB really creates, I'd agree that that would be a saner
and likely more performant configuration ;)

> > > > > + /*
> > > > > + * We come here when we got at @end. We take care to not overflow the
> > > > > + * index @index as it confuses some of the callers. This breaks the
> > > > > + * iteration when there is page at index -1 but that is already broken
> > > > > + * anyway.
> > > > > + */
> > > > > + if (end == (pgoff_t)-1)
> > > > > + *index = (pgoff_t)-1;
> > > > > + else
> > > > > + *index = end + 1;
> > > > > +out:
> > > > > rcu_read_unlock();
> > > > > 
> > > > > - if (ret)
> > > > > - *index = pages[ret - 1]->index + 1;
> > > > > -
> > > > > 
> > > > >   From the description of the patch i didn't see any mention of this
> > > > > functional change.
> > > > > Was this change intentional and did help some usecase or general performance
> > > > > improvement?
> > > > So the change was intentional. When I was working on the series, I was
> > > > somewhat concerned that the old code could end up in a pathological
> > > > situation like:
> > > >     We scan range 0-1000000, find the only dirty page at index 0, return it.
> > > >     We scan range 1-1000000, find the only dirty page at index 1, return it.
> > > >     ...
> > > > 
> > > > This way we end up with rather inefficient scanning and in theory malicious
> > > > user could livelock writeback like this. That being said this was/is mostly
> > > > a theoretical concern.
> > > Ok so its more of a security concern. But do you think this has a latency
> > > impact? I didn't see
> > > much latency impact between the two sets and throughput is higher.
> > Yes, I expect there will be latency impact but for this workload probably
> > relatively small. I expect the expensive part on your workload is the
> > fsync(2) call, in particular the committing of the transaction and the
> > flushing of the disk caches as a result of that. Data writes themselves are
> > relatively cheap. If you had say 1MB blocks instead of 16k ones, I'd expect
> > the numbers to start looking differently as the cost of IO and of cache
> > flushing becomes for comparable - obviously it all depends on the details
> > of the backing storage as well. Perhaps could you measure how much time we
> > spend in file_write_and_wait_range() calls vs in the whole ext4_sync_file()
> > call to confirm that?
> > 
> > Overall your tests show we could gain some throughput without sacrificing
> > too much latency if we somehow batch tiny fsync requests more. The trick is
> > how to do this without regressing other workloads and also across various
> > storage types which are going to have very different properties.
> 
> Yeah i agree fsync is much more expensive operation than just dirtying
> buffers in page cache.  I did use the ext4dist tool from bcc to get the
> distribution of write vs fsync.  Overall fsync is much more expensive
> operation so yeah if we can get higher throughput here with batching it
> shouldn't impact fsync latency that much.

Well, I was more interested in file_write_and_wait_range() vs
ext4_sync_file() latency comparison. write(2) calls are indeed very fast
because they just copy into the page cache so that is not very interesting.
But file_write_and_wait_range() is more interesting because that measures
the cost of writing file data to the disk while whole ext4_sync_file()
measures the cost of writing file data to the disk + the cost of flushing
the journal and I'm interested in how much is the flushing of the journal
costly compared to the data writeback.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
