Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE14D3B8307
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 15:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbhF3NdS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 09:33:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234768AbhF3NdK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 30 Jun 2021 09:33:10 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UD3oDg080522;
        Wed, 30 Jun 2021 09:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=XaVUdpleEbTVL60NonNBZc+MKpX2ZGVuagZc2BUq4xk=;
 b=rVnfyrmsjitWOPILAigdYpfdP9ftFnY3rdY1t0paBU2h2csXC1Ig1I72lawkq2hnFLzZ
 /8UkXcv2CTPThNKMY7gBOi+tG1l2w/vxpp8E0vbNUlsiCV2mbAfvr30unC9jXYivHx84
 FlRtMfSPUdJ0Pe/fGs6HyQ/tNSpR29u5hNVAIfROsyZxJa+L3KA5vO6UKi1Hyblx2Iyx
 h7NAemWjiHul++2IsFms34T/0TQkLZqiHvZk4SFNZrReGa38WtR2PPsQ9dnGrl/yqgSJ
 R4cwPO59UR1ciMbZj38LKZcZXSuGvnNzQ/Q3+mX2A4Gc2rU7xgsbcOeKnAYocqrnRWLe Ug== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39gqkhv2xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 09:30:41 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15UDNfIJ023886;
        Wed, 30 Jun 2021 13:30:39 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 39duv8gxna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 13:30:39 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15UDUbqo33095966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Jun 2021 13:30:37 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7DABA405F;
        Wed, 30 Jun 2021 13:30:36 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F693A4067;
        Wed, 30 Jun 2021 13:30:36 +0000 (GMT)
Received: from localhost (unknown [9.85.89.133])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 30 Jun 2021 13:30:36 +0000 (GMT)
Date:   Wed, 30 Jun 2021 19:00:35 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/9] 64K blocksize related fixes
Message-ID: <20210630133035.yzqslqcobgkvfvn3@riteshh-domain>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623651783.git.riteshh@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FH8covjouWMgnmdlVYhINZduElu0Q5-N
X-Proofpoint-GUID: FH8covjouWMgnmdlVYhINZduElu0Q5-N
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-30_05:2021-06-29,2021-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300079
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21/06/14 11:58AM, Ritesh Harjani wrote:
> Below are the list of fixes mostly centered around 64K blocksize (on PPC64)
> and with ext4 filesystem. Tested this with both 64K & 4K blocksize on Power
> with (ext4/ext3/ext2/xfs/btrfs).

Gentle reminder on this patch series.

-ritesh

>
> Ritesh Harjani (9):
>   ext4/003: Fix this test on 64K platform for dax config
>   ext4/027: Correct the right code of block and inode bitmap
>   ext4/306: Add -b blocksize parameter too to avoid failure with DAX config
>   ext4/022: exclude this test for dax config on 64KB pagesize platform
>   generic/031: Fix the test case for 64k blocksize config
>   gitignore: Add 031.out file to .gitignore
>   generic/620: Remove -b blocksize option for ext4
>   common/attr: Cleanup end of line whitespaces issues
>   common/attr: Reduce MAX_ATTRS to leave some overhead for 64K blocksize
>
>  .gitignore                                 |  1 +
>  common/attr                                | 20 ++++++------
>  tests/ext4/003                             |  3 +-
>  tests/ext4/022                             |  7 ++--
>  tests/ext4/027                             |  4 +--
>  tests/ext4/306                             |  5 ++-
>  tests/generic/031                          | 37 ++++++++++++++++++----
>  tests/generic/031.out.64k                  | 19 +++++++++++
>  tests/generic/{031.out => 031.out.default} |  0
>  tests/generic/620                          |  7 ++++
>  10 files changed, 80 insertions(+), 23 deletions(-)
>  create mode 100644 tests/generic/031.out.64k
>  rename tests/generic/{031.out => 031.out.default} (100%)
>
> --
> 2.31.1
>
