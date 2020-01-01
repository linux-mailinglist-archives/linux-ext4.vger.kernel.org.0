Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E30F12DE62
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Jan 2020 10:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgAAJq7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Jan 2020 04:46:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14698 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725783AbgAAJq7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Jan 2020 04:46:59 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0019hHDY115035
        for <linux-ext4@vger.kernel.org>; Wed, 1 Jan 2020 04:46:58 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2x86vakj6h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Wed, 01 Jan 2020 04:46:58 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 1 Jan 2020 09:46:56 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Jan 2020 09:46:55 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0019ksJn41615638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Jan 2020 09:46:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE2FEAE061;
        Wed,  1 Jan 2020 09:46:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01C3EAE045;
        Wed,  1 Jan 2020 09:46:53 +0000 (GMT)
Received: from [9.199.159.72] (unknown [9.199.159.72])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Jan 2020 09:46:52 +0000 (GMT)
Subject: Re: [PATCH 1/1] ext4: remove unsed macro MPAGE_DA_EXTENT_TAIL
To:     linux-ext4@vger.kernel.org
Cc:     ebiggers@kernel.org, jack@suse.cz, tytso@mit.edu
References: <20191231180444.46586-1-ebiggers@kernel.org>
 <20200101093631.24339-1-riteshh@linux.ibm.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 1 Jan 2020 15:16:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200101093631.24339-1-riteshh@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20010109-0012-0000-0000-00000379A666
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010109-0013-0000-0000-000021B5B406
Message-Id: <20200101094653.01C3EAE045@d06av26.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-01_02:2019-12-30,2020-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=978 spamscore=0 suspectscore=1 clxscore=1015
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001010090
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

NACK. Ignore this.
Will correct the spelling mistake in commit subject (unused)
and will resend it.

-riteshh

On 1/1/20 3:06 PM, Ritesh Harjani wrote:
> Remove unsed macro MPAGE_DA_EXTENT_TAIL which
> is no more used after below commit
> 4e7ea81d ("ext4: restructure writeback path")
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>   fs/ext4/inode.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 748a9e6baab1..b1249e82e57c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -48,8 +48,6 @@
>   
>   #include <trace/events/ext4.h>
>   
> -#define MPAGE_DA_EXTENT_TAIL 0x01
> -
>   static __u32 ext4_inode_csum(struct inode *inode, struct ext4_inode *raw,
>   			      struct ext4_inode_info *ei)
>   {
> 

