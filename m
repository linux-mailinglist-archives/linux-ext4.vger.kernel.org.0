Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9DF6D86BA
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 21:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbjDETTr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 15:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbjDETTc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 15:19:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B5F76A5;
        Wed,  5 Apr 2023 12:19:28 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335JCoZr029433;
        Wed, 5 Apr 2023 19:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=GwOm8iSIThbL0FbKFm8PRDGRSzotLgTDRpmZYgTp4SM=;
 b=jPpYFcENpmjXkpb0YANEYZkz+q2pfKv03r8t/HKVMPycyhBzF6FVmmUQU9EzL91WBIDJ
 Ij+ikplWUBtS5zNizBX3J4ua8Cr01Ypxx5MrpdmgrfHdYh5EiyFdLxp2/OTJWDhlJoOP
 cg037EqsNHCDU/p2NbRmtJW3vn5Dy+lQ1uBAwTelY951LKK2PS+hLz1zEGiuvAfJRggC
 G1aVjok18+MMx+Xhr85BALh308MK1fw4OMFljNcWmLeTlBxkyVa5sAYZ076CJ70B2RQC
 vzlBkkTH8VXZlFwfzBNXPA7tdgjNt9gvPhNEI5iSb4Mj7ymJsUGXJbk/P/L6fqEow8Tx 8A== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps9umrfqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 19:19:19 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3352CteD023017;
        Wed, 5 Apr 2023 19:19:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3ppc873jrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 19:19:17 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 335JJFt612452472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2023 19:19:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E09E20040;
        Wed,  5 Apr 2023 19:19:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6517D20049;
        Wed,  5 Apr 2023 19:19:13 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.12.224])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Apr 2023 19:19:13 +0000 (GMT)
Date:   Thu, 6 Apr 2023 00:49:10 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] Some fixes and cleanup to mballoc
Message-ID: <ZC3Jm7lpXirelmI/@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230321161220.418652-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321161220.418652-1-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: b0BMsYnMySU3NDe_AmYHgaOtXIqMNsuM
X-Proofpoint-GUID: b0BMsYnMySU3NDe_AmYHgaOtXIqMNsuM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_13,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=896 mlxscore=0 adultscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050170
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 22, 2023 at 12:12:12AM +0800, Kemeng Shi wrote:
> We use cluster unit and block unit for different structure members. For
> example, in struct ext4_prealloc_space, pa_lstart and pa_pstart are in
> block unit while pa_len and pa_free are in cluster unit; in struct
> ext4_free_extent, fe_logical is in block unit while fe_start and fe_len
> are in cluster unit. The first five patches fix wrong unit use in
> mballoc.
> The rest is random bugfix and cleanup to mballoc, More details can be
> found in respective patches.
> Besides, "kvm-xfstest smoke" passes all test.
> Thanks!
> 
> Kemeng Shi (8):
>   ext4: fix wrong unit use in ext4_mb_normalize_request
>   ext4: fix unit mismatch in ext4_mb_new_blocks_simple
>   ext4: fix wrong unit use in ext4_mb_new_inode_pa
>   ext4: fix wrong unit use in ext4_mb_find_by_goal
>   ext4: treat stripe in block unit
>   ext4: add EXT4_MB_HINT_GOAL_ONLY test in ext4_mb_use_preallocated
>   ext4: remove ext4_block_group and ext4_block_group_offset declaration
>   ext4: try all groups in ext4_mb_new_blocks_simple
> 
>  fs/ext4/ext4.h    |  4 ---
>  fs/ext4/mballoc.c | 75 +++++++++++++++++++++++++++++++++++------------
>  fs/ext4/super.c   | 13 ++++++++
>  3 files changed, 70 insertions(+), 22 deletions(-)
Hi Kemeng,

Thanks for the patches, they mostly look good to me. I'm running some
tests at my end as well and would provide my RVBs after that. Just
adding a few comments to some of the patches in the meantime.

Regards,
Ojaswin
> 
> -- 
> 2.30.0
> 
