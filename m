Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592494C8159
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Mar 2022 03:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiCAC6X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Feb 2022 21:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiCAC6W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Feb 2022 21:58:22 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A7BFD16
        for <linux-ext4@vger.kernel.org>; Mon, 28 Feb 2022 18:57:40 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2212g3Tl007288;
        Tue, 1 Mar 2022 02:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=GgmNCmKn/ZE14AXSLtAZ93F9dh6toLr0yN44gJLPheU=;
 b=HgwDkkdL+gSPeg3msNlRjp79yD4xaNtB26AYkz87VjMr1V9Q8htU8YOcQU9jgrNqsoXl
 XSbKxousZqsxVRLp5HrmVzuweEWZn1dxK1c57F+fPNb/4BKSAuoJmnS2Q3lDCAarEHah
 n+O5t4UAoLhj5pkvrwRet5bM6TEjXDDyPyAp6g6poQALLNFQ9Hj5I2eW4oUCw6QtiW1K
 q+mmhBatLHgr/3fjd59m61mc8RYor0tg1G5iovq1YSA0OdOrF6qo0XJqqBl5c0dZbdVt
 dKqMLWAnIGo0d0BkwPybEmvU4opIAC6OGOXU2Dv8U1peV4hDtCiSPHGmNMhhKx7oe0Ov aQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ehax6r70k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 02:57:34 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2212tud5030563;
        Tue, 1 Mar 2022 02:57:34 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ehax6r707-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 02:57:34 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2212rNj1027682;
        Tue, 1 Mar 2022 02:57:32 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3efbu91c52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 02:57:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2212vUtA52953510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Mar 2022 02:57:30 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC74EA405C;
        Tue,  1 Mar 2022 02:57:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A4AAA4054;
        Tue,  1 Mar 2022 02:57:29 +0000 (GMT)
Received: from localhost (unknown [9.43.50.230])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Mar 2022 02:57:29 +0000 (GMT)
Date:   Tue, 1 Mar 2022 08:27:28 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Wang Shilong <wshilong@ddn.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Parallel fsck performance degradation case discussion
Message-ID: <20220301025706.e5vxlanadb2ppwvv@riteshh-domain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Tp_OcWdapuT_YhvC-3EaY99KauervBNE
X-Proofpoint-GUID: LDOP3vjy3H6sksaJD8tEQUBSZ8hxCYUr
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-28_10,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1011 priorityscore=1501 impostorscore=0 malwarescore=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010007
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

I am working to help merge ext4's parallel fsck in upstream e2fsprogs.
Ted has provided some details here[1] on some of the work needed, to get it
accepted/merged into upstream.

However, in this email, I mostly wanted to discuss some performance(perf) observations
and to check if we have done our multi-thread fsck testing on such test cases or not.

So, I was doing some testing with different FS layouts and with different disk types
to see its performance benefits. Here are some of the observations. I wanted to know
if it is in line with your observations too.
Also to mainly discuss Case-4, to see if it is already a known limitation.

Case-1: Huge no. of 0 byte sized inodes (22M inodes)
We do see performance benefits with pfsck in this use case (I saw around 3x improvement with ramfs).
This is also true for all disk/device setups i.e. ramfs based ext4 FS using loop device,
on HDD and on NVMes (perf improvements can vary based on disk types too).

Case-2: Huge no. of 4KB-32KB sized inodes/directories (22M inodes)
We do see performance benefits with pfsck in this use case as well (again around 3x improvement with ramfs).
This is also true for all disk/device setups i.e. ramfs based ext4 FS using loop device,
on HDD and on NVMes (perf improvements can vary based on disk types).

Case-3: Large directories (with many 0 byte files within these directories)
In this case, mostly pass-2 takes significant time, but again we do see performance
improvements with pass-1 for all different disk/device setups.

Case-4: Files with heavy fragmentation i.e. lots of extents.
(creating this FS layout roughly by running script1.sh followed by script2.sh mentioned at the end of this email)
In this case we start seeing performance degradation if the I/O device is fast enough.
1. On a single HDD, we see significant perf reduction > ~30% (with pfsck compare to non pfsck).
2. With single nvme, similar perf reduction or more.
3. ramfs based single loop device setup - ~100% perf reduction.
4. ramfs based 4 loop devices with dm_delay on top and with SW raid0 config (md0) (i.e. with 4 dm-delay devices of 50G each in raid0).
    a. With delay of 0ms we see a performance degradation of around ~100%. (10s v/s 20s)
       Below is the perf profile where the performance degradation is seen (with pfsck -m 4)
		   26.37%  e2fsck  e2fsck              [.] rb_insert_extent
		   13.54%  e2fsck  e2fsck              [.] ext2fs_rb_next
			9.72%  e2fsck  libc-2.31.so        [.] _int_free
			7.83%  e2fsck  libc-2.31.so        [.] malloc
			7.45%  e2fsck  e2fsck              [.] rb_test_clear_bmap_extent
			6.46%  e2fsck  e2fsck              [.] rb_test_bmap
			4.60%  e2fsck  libpthread-2.31.so  [.] __pthread_rwlock_rdlock
			4.39%  e2fsck  libpthread-2.31.so  [.] __pthread_rwlock_unlock

    b. But with above disk setup (4 dm-delay with raid0), ~36% to 3x performance improvement is observed when the
	   delay is within the range of [1ms - 500ms] (for every read/write).

Now, I understand we might say that parallel fsck benefits can mostly be seen in case of parallel I/O.
Because otherwise, pfsck might add some extra overhead due to thread spawning, allocating per thread
structures and merge logic. But should that account to significant perf degradation in such fragmented files use case?

From my observations so far, I see in case-4.a), most of the time is being spent in merging of block_found_map bitmap.
On measuring some stats and when testing with -m 1 (i.e. thread-0), I see e2fsck_pass1_merge_context() alone
taking 18sec out of 32sec (which is total time for pass-1).

<stats log>
============
[Thread 0] Scanned group range [0, 1599), inodes 169076
e2fsck_pass1_merge_context [0]: bg range [0, 1599] elapsed time: 18.580 count=25573571
elapsed time: 32.863

"count" in above stat measures total no. of extent entries found in thread_ctx->block_found_map
(by adding rb_count_bmap() function). Since there is only one thread here, that also means it is the total no.
of extent entries. Above data is shown with "-m 1", to just show the exact count entries.
Otherwise too with "-m 4", the performance is degraded.

I have also tested this on raid0 using 2 HDDs, and on that too perf degradation was observed.
(Although I don't have the exact data handy for this, but I can get those again, if needed).
But AFAIK, it was definitely a significant reduction in perf numbers.

So I was wondering if this is a known limitation around pfsck and if it has popped up in any of your tests too.
Also please do let me know if I have missed anything obvious here?

In some of my earlier testing, I had tested with lusture e2fsprogs (master-pfsck branch) and had similar observations
as mentioned above. But recently all my tests were based out of the following tree[2] (with patch[3] included).
I have these setups available with me, so if anything is needed to be tested from my end, I can do that.

References
============
[1]: https://lore.kernel.org/all/YMN10sXgoTR%2FIPxr@mit.edu/
[2]: https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/log/?h=pfsck
[3] https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/commit/?id=699di448eee4b991acafaae4e4f8222be332d6837


Thanks for your help!!
-ritesh

--

<script1.sh>
============
fragmented_filesize=$((10 * 1024 * 1024 * 1024))
dir_cnt=0
while [ $dir_cnt -lt 8192 ]; do
   mkdir $MNT/n$dir_cnt || break
   inode_cnt=0
   while [ $inode_cnt -lt 8192 ]; do
       if [ $inode_cnt -eq 0 ]; then
           xfs_io -fc "falloc 0 $fragmented_filesize" $MNT/n$dir_cnt/n$inode_cnt
       else
           touch $MNT/n$dir_cnt/n$inode_cnt || break
       fi
       inode_cnt=$((inode_cnt+1))
   done
   dir_cnt=$((dir_cnt+1))
done
exit

<script2.sh>
==============
dir_cnt=0
while [ $dir_cnt -lt 8192 ]; do
    inode_cnt=0
    $XFSTESTS_PATH/src/punch-alternating $MNT/n$dir_cnt/n$inode_cnt
    dir_cnt=$((dir_cnt+1))
done
