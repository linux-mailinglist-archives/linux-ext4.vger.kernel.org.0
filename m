Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DFF243B34
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Aug 2020 16:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgHMOFF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Aug 2020 10:05:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726131AbgHMOFE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 Aug 2020 10:05:04 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07DE2ZsU014264;
        Thu, 13 Aug 2020 10:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=vXpI1sudIb98u52icnP2RIXOR36X2eL6/IgG6DZb2VM=;
 b=tCyl4AEwglwDUzFY7zzltdPQf/C4ZPvJ5T+QUynHxDqMt4iVwEO0IWC7hHiWkA/V8904
 ukTOPPS3jc/ivQOsIp1wBZJm2stmE7YBcv+nwlBssGKHS53tpoxpQU2TGvX/jyvzLgrQ
 DPVteLssXMsGFSH2UoZNwBGpDvpq16kvTfgAIfmnVqHe3KqpjRgkYzhOJtVuzvsKZpLU
 Ha3aIR+zDgLzUE06AfwjOxsJSSmYMVnEClqmVksIJZrRyIH4rgGCKT811gtWyKlv7bLP
 KJqtUVDGZJu9Kjd4Tp3zGvuMIe/XHdmns7kDf3GZ5AcB0VR2Iwo+rYYvjVnbPnHsi82v vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32w0nhk6e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 10:05:00 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07DE2i8E015261;
        Thu, 13 Aug 2020 10:04:59 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32w0nhk6bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 10:04:59 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07DE1TUm010569;
        Thu, 13 Aug 2020 14:04:57 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 32skahdmhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 14:04:56 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07DE4swf24641952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Aug 2020 14:04:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61D15A4059;
        Thu, 13 Aug 2020 14:04:54 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B3F4A404D;
        Thu, 13 Aug 2020 14:04:53 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.217])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Aug 2020 14:04:53 +0000 (GMT)
Subject: Re: [PATCH] ext4: fix log printing of ext4_mb_regular_allocator()
To:     brookxu <brookxu.cn@gmail.com>, adilger.kernel@dilger.ca,
        tytso@mit.edu, linux-ext4@vger.kernel.org
References: <131a608b-0c8a-1a2d-57ee-4263cfcdd5a2@gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 13 Aug 2020 19:34:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <131a608b-0c8a-1a2d-57ee-4263cfcdd5a2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <20200813140453.8B3F4A404D@d06av23.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_11:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130102
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 8/7/20 7:31 PM, brookxu wrote:
> Fix log printing of ext4_mb_regular_allocator()，it may be an
> unintentional behavior.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> ---
>   fs/ext4/mballoc.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 5d4a1be..b0da525 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2324,15 +2324,14 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
>   		 * We've been searching too long. Let's try to allocate
>   		 * the best chunk we've found so far
>   		 */
> -
>   		ext4_mb_try_best_found(ac, &e4b);
>   		if (ac->ac_status != AC_STATUS_FOUND) {
>   			/*
>   			 * Someone more lucky has already allocated it.
>   			 * The only thing we can do is just take first
>   			 * found block(s)
> -			printk(KERN_DEBUG "EXT4-fs: someone won our chunk\n");
>   			 */
> +			mb_debug(sb, "EXT4-fs: someone won our chunk\n");

mb_debug() already adds "EXT4-fs" string. So we need not add that here.
but maybe we can add "sbi->s_mb_lost_chunks" in this msg, which may be
helpful debug msg if too many lost chunks.


>   			ac->ac_b_ex.fe_group = 0;
>   			ac->ac_b_ex.fe_start = 0;
>   			ac->ac_b_ex.fe_len = 0;
> 
