Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E6F66713E
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jan 2023 12:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbjALLt6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Jan 2023 06:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbjALLtM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Jan 2023 06:49:12 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE715DE71;
        Thu, 12 Jan 2023 03:38:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 92F6F3EFBA;
        Thu, 12 Jan 2023 11:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673523502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dvgAjwI4SSUvkYAQOz0CelVkUeepEWTA4YFwTQyagyM=;
        b=MGD/nsFzn6gzeqb2Jc65jG9R74RhXfw2CZ0sAwBgiFOu2xc+TFxRB71+mou2sMyJI66n27
        l5Rh69CC1P0LK5mhGJ+1AdHD3KppB4pfYIZcVAioyWbhJtCR9FVUW61GFl6zgCg5CVP7F+
        IhARw9ljgKyJx5P9FpHR3uXQ+CgEwO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673523502;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dvgAjwI4SSUvkYAQOz0CelVkUeepEWTA4YFwTQyagyM=;
        b=/eKigaMIKpQDemBxOYfRD5yikZ3MMKDvuMtjTS4bgHCur24wGmrm+uWqGsecE+mKAmRFWx
        jwA2m6+1rB+n2RCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B20713585;
        Thu, 12 Jan 2023 11:38:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +uEvFi7xv2O4NwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 12 Jan 2023 11:38:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 82347A0744; Thu, 12 Jan 2023 12:38:20 +0100 (CET)
Date:   Thu, 12 Jan 2023 12:38:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Bhatnagar, Rishabh" <risbhat@amazon.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        abuehaze@amazon.com
Subject: Re: EXT4 IOPS degradation in 5.10 compared to 5.4
Message-ID: <20230112113820.hjwvieq3ucbwreql@quack3>
References: <03d52010-06a8-9bff-0565-b698b48850a9@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03d52010-06a8-9bff-0565-b698b48850a9@amazon.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi!

On Wed 11-01-23 18:06:39, Bhatnagar, Rishabh wrote:
> We have been seeing a consistent 3% degradation in IOPS score between 5.4
> and 5.10 stable kernels while running fio tests.
> 
> I'm running test case on m6g.8xlarge AWS instances using arm64. The test
> involves:
> 
> 1. Creating 100GB volume with IO1 500 iops. Attaching it to the instance.
> 
> 2. Setup and mount fs:
> 
> mke2fs -m 1 -t ext4 -b 4096 -L /mnt /dev/nvme1n1
> mount -t ext4 -o noatime,nodiratime,data=ordered /dev/nvme1n1 /mnt
> 
> 3. Install fio package and run following test:
> (running 16 threads doing random buffered 16kb writes on a file.
> ioengine=psync, runtime=60secs)
> 
> jobs=16
> blocksize="16k"
> filesize=1000000
> 
> if [[ -n $1 ]]; then jobs=$1; fi
> if [[ -n $2 ]]; then blocksize=$2; fi
> 
> /usr/bin/fio --name=fio-test --directory=/mnt --rw=randwrite
> --ioengine=psync --buffered=1 --bs=${blocksize} \
>         --max-jobs=${jobs} --numjobs=${jobs} --runtime=30 --thread \
>         --filename=file0 --filesize=${filesize} \
>         --fsync=1 --group_reporting --create_only=1 > /dev/null
> 
> sudo echo 1 > /proc/sys/vm/drop_caches
> 
> set -x
> echo "Running with jobs=${jobs} filesize=${filesize} blocksize=${blocksize}"
> /usr/bin/fio --name=fio-test --directory=/mnt --rw=randwrite
> --ioengine=psync --buffered=1 --bs=${blocksize} \
>         --max-jobs=${jobs} --numjobs=${jobs} --runtime=60 --thread \
>         --filename=file0 --filesize=${filesize} \
>         --fsync=1 --group_reporting --time_based
> 
> After doing some kernel bisecting between we were able to pinpoint this
> commit that drops the iops score by 10~15 points (~3%).
> ext4: avoid unnecessary transaction starts during writeback
> (6b8ed62008a49751fc71fefd2a4f89202a7c2d4d)
> 
> We see higher iops/bw/total io after reverting the commit compared to base
> 5.10 kernel.
> Although the average clat is higher after reverting the commit the higher bw
> drives the iops score higher as seen in below fio output.

I expect the difference is somewhere in waiting for the journal. Can you
just check whether there's a difference if you use --fdatasync=1 instead of
--fsync=1? With this workload that should avoid waiting for the journal
because the only metadata updates are mtime timestamps in the inode.

> Fio output (5.10.162):
> write: io=431280KB, bw=7186.3KB/s, iops=449, runt= 60015msec
> clat (usec): min=6, max=25942, avg=267.76,stdev=1604.25
> lat (usec): min=6, max=25943, avg=267.93,stdev=1604.25
> clat percentiles (usec):
> | 1.00th=[ 9], 5.00th=[ 10], 10.00th=[ 16], 20.00th=[ 24]
> | 30.00th=[ 34], 40.00th=[ 45], 50.00th=[ 58], 60.00th=[ 70],
> | 70.00th=[ 81], 80.00th=[ 94], 90.00th=[ 107], 95.00th=[ 114],
> | 99.00th=[10048], 99.50th=[14016], 99.90th=[20096], 99.95th=[21888],
> | 99.99th=[24448]
> lat (usec) : 10=3.46%, 20=12.54%, 50=26.66%, 100=41.16%, 250=13.64%
> lat (usec) : 500=0.02%, 750=0.03%, 1000=0.01%
> lat (msec) : 2=0.23%, 4=0.50%, 10=0.73%, 20=0.91%, 50=0.12%
> cpu : usr=0.02%, sys=0.42%, ctx=299540, majf=0, minf=0
> IO depths : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
> submit : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
> complete : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
> issued : total=r=0/w=26955/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
> latency : target=0, window=0, percentile=100.00%, depth=1
> Run status group 0 (all jobs):
> WRITE: io=431280KB, aggrb=7186KB/s, minb=7186KB/s, maxb=7186KB/s,
> mint=60015msec, maxt=60015msec
> Disk stats (read/write):
> nvme1n1: ios=0/30627, merge=0/2125, ticks=0/410990, in_queue=410990,
> util=99.94%
> 
> Fio output (5.10.162 with revert):
> write: io=441920KB, bw=7363.7KB/s, iops=460, runt= 60014msec
> clat (usec): min=6, max=35768, avg=289.09, stdev=1736.62
> lat (usec): min=6, max=35768, avg=289.28,stdev=1736.62
> clat percentiles (usec):
> | 1.00th=[ 8], 5.00th=[ 10], 10.00th=[ 16], 20.00th=[ 24],
> | 30.00th=[ 36], 40.00th=[ 46], 50.00th=[ 59], 60.00th=[ 71],
> | 70.00th=[ 83], 80.00th=[ 97], 90.00th=[ 110], 95.00th=[ 117],
> | 99.00th=[10048], 99.50th=[14144], 99.90th=[21632], 99.95th=[25984],
> | 99.99th=[28288]
> lat (usec) : 10=4.13%, 20=11.67%, 50=26.59%, 100=39.57%, 250=15.28%
> lat (usec) : 500=0.03%, 750=0.03%, 1000=0.03%
> lat (msec) : 2=0.20%, 4=0.64%, 10=0.80%, 20=0.86%, 50=0.18%
> cpu : usr=0.01%, sys=0.43%, ctx=313909, majf=0, minf=0
> IO depths : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
> submit : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
> complete : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
> issued : total=r=0/w=27620/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
> latency : target=0, window=0, percentile=100.00%, depth=1
> Run status group 0 (all jobs):
> WRITE: io=441920KB, aggrb=7363KB/s, minb=7363KB/s, maxb=7363KB/s,
> mint=60014msec, maxt=60014msec
> Disk stats (read/write):
> nvme1n1: ios=0/31549, merge=0/2348, ticks=0/409221, in_queue=409221,
> util=99.88%
> 
> 
> Also i looked ext4_writepages latency which increases when the commit is
> reverted. (This makes sense since the commit avoids unnecessary
> transactions).
> 
> ./funclatency ext4_writepages -->(5.10.162)
> avg = 7734912 nsecs, total: 134131121171 nsecs, count: 17341
> 
> ./funclatency ext4_writepages -->(5.10.162 with revert)
> avg = 9036068 nsecs, total: 168956404886 nsecs, count: 18698
> 
> 
> Looking at the journal transaction data I can see that the average
> transaction commit time decreases after reverting the commit.
> This probably helps in the IOPS score.

So what the workload is doing is:
write()
  inode lock
  dirty 16k of page cache
  dirty inode i_mtime
  inode unlock
fsync()
  walk all inode pages, write dirty ones
  wait for all pages under writeback in the inode to complete IO
  force transaction commit and wait for it

Now this has the best throughput (and the worst latency) if all 16
processes work in lockstep - i.e., like:

  task1		task2		task3 ...
  write()
		write()
				write()
  fsync()
		fsync()
				fsync()

because in that case we writeout all dirty pages from 16 processes in one
sweep together and also we accumulate 16 mtime updates in single
transaction commit.

Now I suspect the commit you've identified leads to less synchronization
between the processes and thus in less batching happening. In particular
before the commit we've called mpage_prepare_extent_to_map() twice and the
second invocation starts at where the first invocation saw last dirty page.
So it potentially additionally writes newly dirtied pages beyond that place
and that effectively synchronizes processes more.

To confirm the theory, it might be interesting to gather a histogram of a
number of pages written back by ext4_writepages() call with / without the
commit.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
