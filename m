Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE7EA12DE68
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Jan 2020 10:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbgAAJxG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Jan 2020 04:53:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725783AbgAAJxG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Jan 2020 04:53:06 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0019qGFR053289
        for <linux-ext4@vger.kernel.org>; Wed, 1 Jan 2020 04:53:05 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2x88jj1c01-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Wed, 01 Jan 2020 04:53:04 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 1 Jan 2020 09:53:03 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Jan 2020 09:53:01 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0019r09o38666308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Jan 2020 09:53:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 352B9AE053;
        Wed,  1 Jan 2020 09:53:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 929B1AE04D;
        Wed,  1 Jan 2020 09:52:59 +0000 (GMT)
Received: from [9.199.159.72] (unknown [9.199.159.72])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Jan 2020 09:52:59 +0000 (GMT)
Subject: Re: [PATCH 0/8] ext4: extents.c cleanups
To:     Eric Biggers <ebiggers@kernel.org>, linux-ext4@vger.kernel.org
References: <20191231180444.46586-1-ebiggers@kernel.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 1 Jan 2020 15:22:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191231180444.46586-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20010109-4275-0000-0000-00000393D3FD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010109-4276-0000-0000-000038A7B45E
Message-Id: <20200101095259.929B1AE04D@d06av26.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-01_02:2019-12-30,2020-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001010092
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 12/31/19 11:34 PM, Eric Biggers wrote:
> This series makes a few cleanups to things I noticed while reading some
> of the code in extents.c.
> 
> No actual changes in behavior.
> 
> Eric Biggers (8):
>    ext4: remove ext4_{ind,ext}_calc_metadata_amount()
>    ext4: clean up len and offset checks in ext4_fallocate()
>    ext4: remove redundant S_ISREG() checks from ext4_fallocate()
>    ext4: make some functions static in extents.c
>    ext4: fix documentation for ext4_ext_try_to_merge()
>    ext4: remove obsolete comment from ext4_can_extents_be_merged()
>    ext4: fix some nonstandard indentation in extents.c
>    ext4: add missing braces in ext4_ext_drop_refs()
>  >   fs/ext4/ext4.h         |  11 ----
>   fs/ext4/ext4_extents.h |   5 --
>   fs/ext4/extents.c      | 143 +++++++++++++----------------------------
>   fs/ext4/indirect.c     |  26 --------
>   fs/ext4/inode.c        |   3 -
>   fs/ext4/super.c        |   2 -
>   6 files changed, 45 insertions(+), 145 deletions(-)


Nice cleanup.

While reviewing your patch series also found an unused macro
"MPAGE_DA_EXTENT_TAIL" in inode.c file. Submitted a patch on top of
this series itself. Maybe it can be included as part of your extent
cleanup series itself.

Patch:- "ext4: remove unused macro MPAGE_DA_EXTENT_TAIL"

In your series I think that last 4 commits could be squashed into 1
commit itself, since those 4 patches are related to comments or
minor indentations in extents.c file. But no major objection on that.

Either ways, you may add.

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


-ritesh

