Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961384D86E0
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Mar 2022 15:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbiCNOWP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Mar 2022 10:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbiCNOWO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Mar 2022 10:22:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635951C136;
        Mon, 14 Mar 2022 07:21:05 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22ED7CTq006007;
        Mon, 14 Mar 2022 14:21:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=vBin87u2Lp+yi/bIq2Z97IiIZZj6IztrcwtfbmwWMDQ=;
 b=pQeNhBH+A5tbUjhK0zA3hBAvlfKKlLc2S6lRLDtzc6WUjUORnyNxlh7w5Pgr1KMQRwt1
 +l6490fBv6VWM7oH0kurGPCl5HuwRwP/FoNj8dU35uNNeG2+b1whEclJLpg/u4thoosf
 nmxxB2tMvxBrJNkLBE+EtFTvosFoIMBX6pGbWOxPAkDY0+lDF4+1ukX3tm9GADJ5xhKj
 qh4SYF0sL4DDlwbbqvsSgJVwXWaqJXz6zmWV6bsfmcWDLalNaShX4Z1UPEJgylcaNW77
 gpyxlg5wv/Tu1U9A5V0oNACFgfA3bffRFkejefVOA9GhxH7XVQWNpj8AjR4qpqdPbzla +A== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3et6a6tfck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 14:21:04 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22EE7Ewc005330;
        Mon, 14 Mar 2022 14:21:02 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3erk58kr36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 14:21:02 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22EEKx0L26804566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 14:20:59 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3380E520C6;
        Mon, 14 Mar 2022 14:20:59 +0000 (GMT)
Received: from localhost (unknown [9.43.35.46])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E867652199;
        Mon, 14 Mar 2022 14:20:47 +0000 (GMT)
Date:   Mon, 14 Mar 2022 19:50:46 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4/053: Add support for testing mb_optimize_scan
Message-ID: <20220314142030.aigttj2likaqtz2c@riteshh-domain>
References: <5b0d252484cbe973c2df0c677cb47b30012b0db1.1647253313.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b0d252484cbe973c2df0c677cb47b30012b0db1.1647253313.git.ojaswin@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vk8ee9gjL8yshLkJ1Lh5A5pMkGxm1-0p
X-Proofpoint-ORIG-GUID: vk8ee9gjL8yshLkJ1Lh5A5pMkGxm1-0p
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_08,2022-03-14_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0
 clxscore=1011 suspectscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140089
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/03/14 04:02PM, Ojaswin Mujoo wrote:
> Add support to test the mb_optimize_scan mount option.
> Since its value is not reflected in the "options" file in proc,
> use "mb_structs_summary" to verify its value.

Yes, I think we can do this. Thanks for identifying it.

>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Overall the patch looks good to me. Feel free to add
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

> ---
>  tests/ext4/053 | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

<Some stats>

I ran this test of yours with and w/o your kernel fix for this mount option,
which is now sitting in ext4 dev tree [1].

<with kernel fix>
ext4/053 173s ...  147s
Ran: ext4/053
Passed all 1 tests

<w/o kernel fix>
ext4/053 173s ... [failed, exit status 2]- output mismatch (see /home/qemu/work/tools/xfstests-dev/results//ext4_4k/ext4/053.out.bad)
    --- tests/ext4/053.out      2022-01-03 11:50:08.671463501 +0530
    +++ /home/qemu/work/tools/xfstests-dev/results//ext4_4k/ext4/053.out.bad    2022-03-14 18:26:12.290610687 +0530
    @@ -1,2 +1,4 @@
     QA output created by 053
     Silence is golden.
    +mounting ext3 "mb_optimize_scan=1" checking "mb_optimize_scan=1" (not found) FAILED
    +mounting ext4 "mb_optimize_scan=1" checking "mb_optimize_scan=1" (not found) FAILED
    ...
    (Run 'diff -u /home/qemu/work/tools/xfstests-dev/tests/ext4/053.out /home/qemu/work/tools/xfstests-dev/results//ext4_4k/ext4/053.out.bad'  to see the entire diff)
Ran: ext4/053
Failures: ext4/053
Failed 1 of 1 tests

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=dev&id=27b38686a3bb601db48901dbc4e2fc5d77ffa2c1
