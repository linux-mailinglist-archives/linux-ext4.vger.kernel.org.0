Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49ACD4E2E3E
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Mar 2022 17:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbiCUQly (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Mar 2022 12:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351326AbiCUQlx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Mar 2022 12:41:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960EE26543
        for <linux-ext4@vger.kernel.org>; Mon, 21 Mar 2022 09:40:27 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22LEBUiU009379;
        Mon, 21 Mar 2022 16:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=zNEm50i9iUTkThswxEGhWhV2GgsiYZwPgmNlF+CfZgw=;
 b=StenjJd6Vw/T/YsOpCMxgQyvpo0c+R7j/wzImwdAloZeoyn4/F0IBHwBHSCSaWewVaDe
 s/Hho4HXB7r4Z3e6Tm1LMWMHWwMFaQVa7du9xhsCNVkZNutKtGu3B/GmNjC9LFbrHLEY
 +tJ93xinN2mOok3nNpBfUg32HsAtJr/gAdwsZY2l7KNJIOkOb0YKBh/ncbWDmCin8FvI
 gV+DQsFO6lxT4Ukz743lgBZsuZoaOT+yvxQegt+YPISol1BBmadGxEG5Mm9cXq0N6NEn
 TqVhovKfJtwRzsmJmHZD9tTXvR89RIy9cEabeUZwm3vXCRjoFf9rydcBZwTFmn5d6Uz5 /g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3exb60v6cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 16:40:20 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22LGPoa1009452;
        Mon, 21 Mar 2022 16:40:19 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3exb60v6bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 16:40:19 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22LGWupm002253;
        Mon, 21 Mar 2022 16:40:17 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3ew6ehvdt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 16:40:17 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22LGeF0x38076768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Mar 2022 16:40:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E41642041;
        Mon, 21 Mar 2022 16:40:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 040AE42045;
        Mon, 21 Mar 2022 16:40:14 +0000 (GMT)
Received: from localhost (unknown [9.43.79.192])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Mar 2022 16:40:12 +0000 (GMT)
Date:   Mon, 21 Mar 2022 22:10:09 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Dongyang Li <dli@ddn.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Wang Shilong <wangshilong1991@gmail.com>
Subject: Re: Parallel fsck performance degradation case discussion
Message-ID: <20220321164009.dwqmdo7axyyixn2t@riteshh-domain>
References: <20220301025706.e5vxlanadb2ppwvv@riteshh-domain>
 <E7537AE6-AD26-4EF6-A9C2-9D90060B8DB1@dilger.ca>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E7537AE6-AD26-4EF6-A9C2-9D90060B8DB1@dilger.ca>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0jfenTPFzMSF8C3ywMaxM1DQ-6NGuHWm
X-Proofpoint-GUID: ENFYdzTZWXeO_n0cYFad6bQoxv8CLE65
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-21_07,2022-03-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203210105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Sorry about the delay in getting back to this. I was caught up in completing
some of the other open activities, but I will now be spending more time on
getting this work in shape for merging.

On 22/03/03 12:50PM, Andreas Dilger wrote:
> On Feb 28, 2022, at 7:57 PM, Ritesh Harjani <riteshh@linux.ibm.com> wrote:
> >
> > Hello,
> >
> > I am working to help merge ext4's parallel fsck in upstream e2fsprogs.
> > Ted has provided some details here[1] on some of the work needed, to
> > get it accepted/merged into upstream.
>
> Hi Ritesh,
> thanks for working on this and running the testing.
>
> > However, in this email, I mostly wanted to discuss some performance(perf) observations and to check if we have done our multi-thread fsck testing
> > on such test cases or not.
> >
> > So, I was doing some testing with different FS layouts and with different
> > disk types to see its performance benefits. Here are some of the observations.
> > I wanted to know if it is in line with your observations too.
>
> Most of our testing was done with large multi-disk declustered-parity RAID
> (i.e. in the range of 40-160 HDDs in a single volume).  I've attached an
> image showing our results.

Thanks for sharing the data.

Yes, the e2fsck timings with multi-disks (HDDs) raid0 setup and with large
inodes count is inline with my observations too.


>
> > Also to mainly discuss Case-4, to see if it is already a known limitation.
> >
> > Case-1: Huge no. of 0 byte sized inodes (22M inodes)
> > We do see performance benefits with pfsck in this use case (I saw around 3x improvement with ramfs).
> > This is also true for all disk/device setups i.e. ramfs based ext4 FS using loop device,
> > on HDD and on NVMes (perf improvements can vary based on disk types too).
> >
> > Case-2: Huge no. of 4KB-32KB sized inodes/directories (22M inodes)
> > We do see performance benefits with pfsck in this use case as well (again around 3x improvement with ramfs).
> > This is also true for all disk/device setups i.e. ramfs based ext4 FS using loop device,
> > on HDD and on NVMes (perf improvements can vary based on disk types).
> >
> > Case-3: Large directories (with many 0 byte files within these directories)
> > In this case, mostly pass-2 takes significant time, but again we do see
> > performance improvements with pass-1 for all different disk/device setups.
>
> Yes, the pass2/3 scanning can definitely be parallelized for workloads like
> this, but we haven't had time to do this work yet.  There was a preliminary
> patch to do some of the block fetching in parallel, but not the actual scan:
> https://review.whamcloud.com/44428

Sure, thanks for sharing the info.

>
> > Case-4: Files with heavy fragmentation i.e. lots of extents.
> > (creating this FS layout roughly by running script1.sh followed by script2.sh mentioned at the end of this email)
> > In this case we start seeing performance degradation if the I/O device is fast enough.
> > 1. On a single HDD, we see significant perf reduction > ~30% (with pfsck compare to non pfsck).
> > 2. With single nvme, similar perf reduction or more.
> > 3. ramfs based single loop device setup - ~100% perf reduction.
> > 4. ramfs based 4 loop devices with dm_delay on top and with SW raid0 config (md0) (i.e. with 4 dm-delay devices of 50G each in raid0).
> >    a. With delay of 0ms we see a performance degradation of around ~100%. (10s v/s 20s)
> >       Below is the perf profile where the performance degradation is seen (with pfsck -m 4)
> > 		   26.37%  e2fsck  e2fsck              [.] rb_insert_extent
> > 		   13.54%  e2fsck  e2fsck              [.] ext2fs_rb_next
> > 			9.72%  e2fsck  libc-2.31.so        [.] _int_free
> > 			7.83%  e2fsck  libc-2.31.so        [.] malloc
> > 			7.45%  e2fsck  e2fsck              [.] rb_test_clear_bmap_extent
> > 			6.46%  e2fsck  e2fsck              [.] rb_test_bmap
> > 			4.60%  e2fsck  libpthread-2.31.so  [.] __pthread_rwlock_rdlock
> > 			4.39%  e2fsck  libpthread-2.31.so  [.] __pthread_rwlock_unlock
>
> This is a pretty unrealistic scenario IMHO, with a huge number of fragmented
> chunks on a single HDD.  So it isn't clear if this is worthwhile to optimize
> the parallel mode, and instead run in a single thread?

Above perf profile is not on a single HDD.

So, in my testing, what I have observed so far is, when we have relatively faster devices
(including HDDs in a raid0 setup) and a FS layout with heavy fragmented files,
pfsck bottleneck is seen in rb tree insert/merge logic. In fact pfsck takes more
time then normal fsck.

I am guessing since this is not common use case for most of the scenarios,
so we might not have tested this before? Do you remember if that was the case?


Now given that in most of the common use cases with multi-disk raid setups, pfsck
performs quite well, so I think it makes more sense to get the current patches
rebased (after getting libext2fs abstraction changes done).
In parallel, I will also check the heavy fragmented file use case, to see
if there are any optimizations possible in rbtree insert/merge code paths which
can remove this observed bottleneck.

Thanks for your help!!
-ritesh


>
> Cheers, Andreas
>
> >
> >    b. But with above disk setup (4 dm-delay with raid0), ~36% to 3x performance improvement is observed when the
> > 	   delay is within the range of [1ms - 500ms] (for every read/write).
> >
> > Now, I understand we might say that parallel fsck benefits can mostly be seen in case of parallel I/O.
> > Because otherwise, pfsck might add some extra overhead due to thread spawning, allocating per thread
> > structures and merge logic. But should that account to significant perf degradation in such fragmented files use case?
> >
> > From my observations so far, I see in case-4.a), most of the time is being spent in merging of block_found_map bitmap.
> > On measuring some stats and when testing with -m 1 (i.e. thread-0), I see e2fsck_pass1_merge_context() alone
> > taking 18sec out of 32sec (which is total time for pass-1).
> >
> > <stats log>
> > ============
> > [Thread 0] Scanned group range [0, 1599), inodes 169076
> > e2fsck_pass1_merge_context [0]: bg range [0, 1599] elapsed time: 18.580 count=25573571
> > elapsed time: 32.863
> >
> > "count" in above stat measures total no. of extent entries found in thread_ctx->block_found_map
> > (by adding rb_count_bmap() function). Since there is only one thread here, that also means it is the total no.
> > of extent entries. Above data is shown with "-m 1", to just show the exact count entries.
> > Otherwise too with "-m 4", the performance is degraded.
> >
> > I have also tested this on raid0 using 2 HDDs, and on that too perf degradation was observed.
> > (Although I don't have the exact data handy for this, but I can get those again, if needed).
> > But AFAIK, it was definitely a significant reduction in perf numbers.
> >
> > So I was wondering if this is a known limitation around pfsck and if it has popped up in any of your tests too.
> > Also please do let me know if I have missed anything obvious here?
> >
> > In some of my earlier testing, I had tested with lusture e2fsprogs (master-pfsck branch) and had similar observations
> > as mentioned above. But recently all my tests were based out of the following tree[2] (with patch[3] included).
> > I have these setups available with me, so if anything is needed to be tested from my end, I can do that.
> >
> > References
> > ============
> > [1]: https://lore.kernel.org/all/YMN10sXgoTR%2FIPxr@mit.edu/
> > [2]: https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/log/?h=pfsck
> > [3] https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/commit/?id=699di448eee4b991acafaae4e4f8222be332d6837
> >
> >
> > Thanks for your help!!
> > -ritesh
> >
> > --
> >
> > <script1.sh>
> > ============
> > fragmented_filesize=$((10 * 1024 * 1024 * 1024))
> > dir_cnt=0
> > while [ $dir_cnt -lt 8192 ]; do
> >   mkdir $MNT/n$dir_cnt || break
> >   inode_cnt=0
> >   while [ $inode_cnt -lt 8192 ]; do
> >       if [ $inode_cnt -eq 0 ]; then
> >           xfs_io -fc "falloc 0 $fragmented_filesize" $MNT/n$dir_cnt/n$inode_cnt
> >       else
> >           touch $MNT/n$dir_cnt/n$inode_cnt || break
> >       fi
> >       inode_cnt=$((inode_cnt+1))
> >   done
> >   dir_cnt=$((dir_cnt+1))
> > done
> > exit
> >
> > <script2.sh>
> > ==============
> > dir_cnt=0
> > while [ $dir_cnt -lt 8192 ]; do
> >    inode_cnt=0
> >    $XFSTESTS_PATH/src/punch-alternating $MNT/n$dir_cnt/n$inode_cnt
> >    dir_cnt=$((dir_cnt+1))
> > done
>
>
> Cheers, Andreas
>
>
>
>


