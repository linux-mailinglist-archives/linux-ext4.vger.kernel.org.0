Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B524BC649
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Feb 2022 08:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239646AbiBSHMy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 19 Feb 2022 02:12:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbiBSHMx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 19 Feb 2022 02:12:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A66427D6;
        Fri, 18 Feb 2022 23:12:35 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21J6Aswh022573;
        Sat, 19 Feb 2022 07:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=InDdrb2T70Jylv7UEtN08N+EnU+K0Gftexg0r6m2N/4=;
 b=srs8WLIlbbzffaWBHGuNJJzNpOF+gqU9mXb4PvuGHqufhZ96LYC8GWVA7PsVl7p/EXjA
 nb6jDlFSvMEfGnoYVHexmqueXoH1kf5K20LxGsCB/4488JhnF5b3k7XdWHIxwZvodITo
 qLlx47AQSG4GvkjtIr7Ng9DFcSTcOTuSBXpv/93j3LRbgHfjY8YVLgMyjLQBgr2wfeYJ
 gsbkJ4rG6vhzN5r4eMnu/9HQUla6DA5H7izgXH4sv4gs/m6bvmG5jyzZ3R0cDIeiYRVg
 /21GAe8mod4KTzXMqpiEVJcFFl5AapaLDu+erdV+V99cQ96nFoT9Bush4b/ZRfatQmCS NA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ear4f2vum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Feb 2022 07:12:34 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21J7COoA004900;
        Sat, 19 Feb 2022 07:12:32 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3ear68gq1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Feb 2022 07:12:32 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21J7CTCD46793024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Feb 2022 07:12:29 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 28F545204F;
        Sat, 19 Feb 2022 07:12:29 +0000 (GMT)
Received: from localhost (unknown [9.43.86.157])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EA4AF5204E;
        Sat, 19 Feb 2022 07:12:27 +0000 (GMT)
Date:   Sat, 19 Feb 2022 12:42:25 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] src/ext4_resize.c: Refactor code and ensure accurate
 errno is returned
Message-ID: <20220219071225.mi5hutyxds7xn3io@riteshh-domain>
References: <cover.1644217569.git.ojaswin@linux.ibm.com>
 <a64b4c4d199b822fe72bf4c3752b61e0dc0f3e19.1644217569.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a64b4c4d199b822fe72bf4c3752b61e0dc0f3e19.1644217569.git.ojaswin@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GuzLcICkbC_aK_Rw1Pon5NAGyc5vqNek
X-Proofpoint-GUID: GuzLcICkbC_aK_Rw1Pon5NAGyc5vqNek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-19_02,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 mlxscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202190044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/02/07 01:55PM, Ojaswin Mujoo wrote:
> The current implementation of ext4_resize returned 1 whenever
> there was an error. Modify this to return the correct error code.
> This is important for tests that rely on correct error reporting, by
> the kernel, for ext4 resize functionality.
>
> Additionaly, perform some code cleanup.

Thanks for fixing the error return codes. This looks good to me.

Feel free to add -
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

Stats on running this stats on my dev machine

<on old kernels>
===================
qemu@qemu:~/src/tools/xfstests-dev$ sudo ./check -s ext4_4k ext4/056
SECTION       -- ext4_4k
FSTYP         -- ext4
PLATFORM      -- Linux/ppc64le qemu 5.4.0-100-generic #113-Ubuntu SMP Thu Feb 3 18:43:11 UTC 2022
MKFS_OPTIONS  -- -I 256 -O 64bit -F -b 4096 /dev/loop10
MOUNT_OPTIONS -- -o data=ordered /dev/loop10 /mnt1/scratch

ext4/056        [failed, exit status 1]- output mismatch (see /home/qemu/src/tools/xfstests-dev/results//ext4_4k/ext4/056.out.bad)
    --- tests/ext4/056.out      2022-02-19 06:55:22.233659113 +0000
    +++ /home/qemu/src/tools/xfstests-dev/results//ext4_4k/ext4/056.out.bad     2022-02-19 06:57:48.931542566 +0000
    @@ -1,2 +1,3 @@
     QA output created by 056
    -Test Succeeded!
    +_check_generic_filesystem: filesystem on /dev/loop10 is inconsistent
    +(see /home/qemu/src/tools/xfstests-dev/results//ext4_4k/ext4/056.full for details)
    ...
    (Run 'diff -u /home/qemu/src/tools/xfstests-dev/tests/ext4/056.out /home/qemu/src/tools/xfstests-dev/results//ext4_4k/ext4/056.out.bad'  to see the entire diff)
Ran: ext4/056
Failures: ext4/056
Failed 1 of 1 tests

SECTION       -- ext4_4k
=========================
Ran: ext4/056
Failures: ext4/056
Failed 1 of 1 tests

<on 5.16.0-rc4>
===================
qemu@qemu:~/src/tools/xfstests-dev$ sudo ./check -s ext4_4k -i 10 ext4/056
SECTION       -- ext4_4k
FSTYP         -- ext4
PLATFORM      -- Linux/ppc64le qemu 5.16.0-rc4+ #6 SMP Sat Jan 29 22:07:24 UTC 2022
MKFS_OPTIONS  -- -I 256 -O 64bit -F -b 4096 /dev/loop10
MOUNT_OPTIONS -- -o data=ordered /dev/loop10 /mnt1/scratch

ext4/056 9s ...  11s
Ran: ext4/056
Passed all 1 tests

-ritesh
