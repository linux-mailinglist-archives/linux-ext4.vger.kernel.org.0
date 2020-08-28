Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D612255746
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Aug 2020 11:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgH1JN6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Aug 2020 05:13:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:39960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728362AbgH1JNy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 28 Aug 2020 05:13:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 39E66AE19;
        Fri, 28 Aug 2020 09:14:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 325961E12C0; Fri, 28 Aug 2020 11:13:51 +0200 (CEST)
Date:   Fri, 28 Aug 2020 11:13:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     "James Scriven (jamscriv)" <jamscriv@cisco.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: Performance issue with recently_deleted() /no_journal with huge
 directories
Message-ID: <20200828091351.GD7072@quack2.suse.cz>
References: <MN2PR11MB45667C6E534F7944BFA77684DB550@MN2PR11MB4566.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR11MB45667C6E534F7944BFA77684DB550@MN2PR11MB4566.namprd11.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi!

On Thu 27-08-20 12:09:21, James Scriven (jamscriv) wrote:
> Hi, I'm working on migrating a workload from kernel 2.6 to 4.18 (REHL6 to
> RHEL8).
> 
> The use case is a build farm that has a basic workflow of:
> 
> 1) rm -rf a large directory tree (about 2M files ~ 200GB) to free some space
> 2) download and extract a large tarbar (about 2M files ~ 200GB)
> 3) perform a build in the extracted directory tree
> Repeat...
> 
> We've being using an ext4 filesystem with no journal for maximum
> performance with great success. We're not very concerned about losing
> data, but do want some persistence, which is why we don't just use tmpfs
> for this. We'll keep a number of these large workspaces around as long as
> space permits, and delete the oldest (step 1) just before starting a new
> one (step 2). 
> 
> When migrating to this newer kernel, we are seeing performance
> degradation when we expand the tar, which I suspect is caused by inode
> allocation trying to find an unused inode that has not been used too
> recently. Since we have 2M deleted inodes that *have* been recently
> deleted, every one of the new 2M inodes has to search through all 2M of
> the deleted ones (or something to that approximation - my full
> understanding of the ext4 code is limited).
> 
> The simple testcase below shows the issue. My question is, is this edge
> case already understood? Is there a good way to re-gain this lost
> performance? Adding a "sync + drop_caches", or a sufficiently long sleep,
> between steps 1 and 2 will work around the issue, but is not ideal.

So from the tests below it isn't obvious to me that the recently_deleted()
logic is the culprit of the problem. But it is quite possible. We have
somewhat changed the logic in commit d05466b27b19 "ext4: avoid ENOSPC when
avoiding to reuse recently deleted inodes" so now we just reuse recently
deleted inode if we cannot find any better in the current group. That should
significantly reduce the cost of searching for free inode in your usecase
so you might give that change a try...

								Honza

> # each iteration of the test case the number of recently deleted inodes increases and performance degrades.
> 
> $ uname -a
> Linux sjc-asr-bm-470 4.18.0-147.3.1.el8_1.x86_64 #1 SMP Wed Nov 27 01:11:44 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
> $ sync; echo 3 | sudo tee /proc/sys/vm/drop_caches; for x in {1..10}; do rm -rf dirtree; mkdir dirtree; time mkdir dirtree/{1..50000}; done
> 3
> 
> real    0m1.796s
> user    0m0.041s
> sys     0m1.528s
> 
> real    0m3.280s
> user    0m0.035s
> sys     0m3.235s
> 
> real    0m4.329s
> user    0m0.035s
> sys     0m4.279s
> 
> real    0m6.033s
> user    0m0.032s
> sys     0m5.988s
> 
> real    0m7.303s
> user    0m0.041s
> sys     0m7.246s
> 
> real    0m7.874s
> user    0m0.032s
> sys     0m7.826s
> 
> real    0m9.376s
> user    0m0.036s
> sys     0m9.323s
> 
> real    0m9.979s
> user    0m0.052s
> sys     0m9.910s
> 
> real    0m9.808s
> user    0m0.037s
> sys     0m9.749s
> 
> real    0m9.067s
> user    0m0.038s
> sys     0m9.011s
> 
> 
> 
> 
> $ uname -a
> Linux sjc-asr-bm-100 2.6.32-754.17.1.el6.x86_64 #1 SMP Thu Jun 20 11:47:12 EDT 2019 x86_64 x86_64 x86_64 GNU/Linux
> $ sync; echo 3 | sudo tee /proc/sys/vm/drop_caches; for x in {1..10}; do rm -rf dirtree; mkdir dirtree; time mkdir dirtree/{1..50000}; done
> 3
> 
> real    0m0.724s
> user    0m0.031s
> sys     0m0.693s
> 
> real    0m0.762s
> user    0m0.041s
> sys     0m0.721s
> 
> real    0m0.717s
> user    0m0.043s
> sys     0m0.674s
> 
> real    0m0.712s
> user    0m0.037s
> sys     0m0.675s
> 
> real    0m0.749s
> user    0m0.036s
> sys     0m0.712s
> 
> real    0m0.710s
> user    0m0.040s
> sys     0m0.670s
> 
> real    0m0.746s
> user    0m0.038s
> sys     0m0.707s
> 
> real    0m0.715s
> user    0m0.034s
> sys     0m0.680s
> 
> real    0m0.747s
> user    0m0.040s
> sys     0m0.707s
> 
> real    0m0.732s
> user    0m0.042s
> sys     0m0.690s
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
