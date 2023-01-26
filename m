Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404BB67C75E
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Jan 2023 10:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbjAZJcg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Jan 2023 04:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236790AbjAZJce (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Jan 2023 04:32:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E886DBE5;
        Thu, 26 Jan 2023 01:32:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B5BFE21E5E;
        Thu, 26 Jan 2023 09:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674725551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yDHNH2fSqAKUUR+K5oA7z8NizLgJceEfWp/fbYJzxM0=;
        b=GxW8M38KoSKbC1KGQ9rxri2RBDK6pP+mFQafYBDTijpbOj3kYwr0UEAnM5krWx9nPbyP7S
        zhwqKcSGAS4jlqmwJxkESUQ+w3LTAA48h9Ls8mLo3N/8cf+Jwb98ZPUCmK2g1TbcK3rX6p
        GJm0G2RAZMxtvUCYuhlzUEojPjD7x1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674725551;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yDHNH2fSqAKUUR+K5oA7z8NizLgJceEfWp/fbYJzxM0=;
        b=0enVDQ8HrHT2lGq2DqcUctb5I0Rl5x1X48CmvA/gaH4OxIevJ8ljfplWGo0I+VbXCmzg1O
        A3ktuVVGf/vfwGAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A68B2139B3;
        Thu, 26 Jan 2023 09:32:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 63SdKK9I0mO+WgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 26 Jan 2023 09:32:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3D17CA06B4; Thu, 26 Jan 2023 10:32:31 +0100 (CET)
Date:   Thu, 26 Jan 2023 10:32:31 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Bhatnagar, Rishabh" <risbhat@amazon.com>
Cc:     Jan Kara <jack@suse.cz>, tytso@mit.edu, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, abuehaze@amazon.com
Subject: Re: EXT4 IOPS degradation between 4.14 and 5.10
Message-ID: <20230126093231.ujn6yaxhexwzizp5@quack3>
References: <053b60a6-133e-5d59-0732-464d5160772a@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <053b60a6-133e-5d59-0732-464d5160772a@amazon.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On Wed 25-01-23 16:33:54, Bhatnagar, Rishabh wrote:
> As discussed in the previous thread I'm chasing IOPS regression between 4.14
> -> 5.10 kernels.
> https://lore.kernel.org/lkml/20230112113820.hjwvieq3ucbwreql@quack3/T/
> <https://lore.kernel.org/lkml/20230112113820.hjwvieq3ucbwreql@quack3/T/>
> 
> Last issue we discussed was difficult to resolve so keeping it on the back
> burner for now.
> 
> I did some more bisecting and saw another series of patches that potentially
> impacts iops score:
> 72b045aecdd856b083521f2a963705b4c2e59680 (mm: implement
> find_get_pages_range_tag())
> 
> Running fio tests on tip as 9c19a9cb1642c074aa8bc7693cd4c038643960ae
> (including the 16 patch series) vs tip as
> 6b4c54e3787bc03e810062bd257a3b05fd9c72d6 (without the above series) shows an
> IOPS jump.

Ok, thanks for pinpointing this. That series landed a long time ago ;).

> Fio with buffered io/fsync=1/randwrite

So I'm curious. Do you have any workload that actually does these
synchronous random buffered IOs? Or is it just a benchmarking exercise?

> With HEAD as 9c19a9cb1642c074aa8bc7693cd4c038643960ae (with the above
> series)
> 
> write: io=445360KB, bw=7418.6KB/s, *iops=463*, runt= 60033msec
> clat (usec): min=4, max=32132, avg=311.90, stdev=1812.74
> lat (usec): min=5, max=32132, avg=312.28, stdev=1812.74
> clat percentiles (usec):
> | 1.00th=[ 8], 5.00th=[ 10], 10.00th=[ 16], 20.00th=[ 25],
> | 30.00th=[ 36], 40.00th=[ 47], 50.00th=[ 60], 60.00th=[ 71],
> | 70.00th=[ 84], 80.00th=[ 97], 90.00th=[ 111], 95.00th=[ 118],
> | 99.00th=[11840], 99.50th=[15936], 99.90th=[21888], 99.95th=[23936],
> 
> With HEAD as 6b4c54e3787bc03e810062bd257a3b05fd9c72d6(without the above
> series)
> 
> write: io=455184KB, bw=7583.4KB/s, *iops=473*, runt= 60024msec
> clat (usec): min=6, max=24325, avg=319.72, stdev=1694.52
> lat (usec): min=6, max=24326, avg=319.99, stdev=1694.53
> clat percentiles (usec):
> | 1.00th=[ 9], 5.00th=[ 11], 10.00th=[ 17], 20.00th=[ 26],
> | 30.00th=[ 38], 40.00th=[ 50], 50.00th=[ 60], 60.00th=[ 73],
> | 70.00th=[ 85], 80.00th=[ 98], 90.00th=[ 111], 95.00th=[ 118],
> | 99.00th=[ 9792], 99.50th=[14016], 99.90th=[21888], 99.95th=[22400],
> | 99.99th=[24192]

OK, about 2% regression. How stable is that across multiple runs?

> I also see that number of handles per transaction were much higher before
> this patch series
> 
> 0ms waiting for transaction
> 0ms request delay
> 20ms running transaction
> 0ms transaction was being locked
> 0ms flushing data (in ordered mode)
> 10ms logging transaction
> *13524us average transaction commit time*
> *73 handles per transaction*
> 0 blocks per transaction
> 1 logged blocks per transaction
> 
> vs after the patch series.
> 
> 0ms waiting for transaction
> 0ms request delay
> 20ms running transaction
> 0ms transaction was being locked
> 0ms flushing data (in ordered mode)
> 20ms logging transaction
> *21468us average transaction commit time*
> *66 handles per transaction*
> 1 blocks per transaction
> 1 logged blocks per transaction
> 
> This is probably again helping in bunching the writeback transactions and
> increasing throughput.

Yeah, probably.

> I looked at the code to understand what might be going on.
> It seems like commit 72b045aecdd856b083521f2a963705b4c2e59680 changes the
> behavior of find_get_pages_range_tag.
> Before this commit if find_get_pages_tag cannot find nr_pages (PAGEVEC_SIZE)
> it returns the number of pages found as ret and
> sets the *index to the last page it found + 1. After the commit the behavior
> changes such that if we don’t find nr_pages pages
> we set the index to end and not to the last found page. (added diff from
> above commit)
> Since pagevec_lookup_range_tag is always called in a while loop (index <=
> end) the code before the commit helps in coalescing
> writeback of pages if there are multiple threads doing write as it might
> keep finding new dirty (tagged) pages since it doesn’t set index to end.
> 
> + /*
> + * We come here when we got at @end. We take care to not overflow the
> + * index @index as it confuses some of the callers. This breaks the
> + * iteration when there is page at index -1 but that is already broken
> + * anyway.
> + */
> + if (end == (pgoff_t)-1)
> + *index = (pgoff_t)-1;
> + else
> + *index = end + 1;
> +out:
> rcu_read_unlock();
> 
> - if (ret)
> - *index = pages[ret - 1]->index + 1;
> -
> 
> From the description of the patch i didn't see any mention of this
> functional change.
> Was this change intentional and did help some usecase or general performance
> improvement?

So the change was intentional. When I was working on the series, I was
somewhat concerned that the old code could end up in a pathological
situation like:
  We scan range 0-1000000, find the only dirty page at index 0, return it.
  We scan range 1-1000000, find the only dirty page at index 1, return it.
  ...

This way we end up with rather inefficient scanning and in theory malicious
user could livelock writeback like this. That being said this was/is mostly
a theoretical concern.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
