Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E03243CA0
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Aug 2020 17:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgHMPf3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Aug 2020 11:35:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30316 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726249AbgHMPf0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 Aug 2020 11:35:26 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07DFV7bV021957;
        Thu, 13 Aug 2020 11:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=wzZp+GpumCQLz7//UAkrY+3WtVLFxW4hL1TIQKinAbU=;
 b=CKbX1WC3ms185cGjUvKav5EWW19IIYxjA4C/7n1VCeaC8xTXwgl8bVq5eSDuEQ9KTeWj
 k5iMvw/hMmEnZnIdHdSKGBQaBCKyTLK0NK15pQdmr1rWG0mLtjhlY19pBM5VFGxg7GN1
 fR4i0As3cXG3TMgqxXwLWCVOlGMItE2rBB4s7yYDFibGrM0yqWkryXibBpFjmlpzZtAA
 OdxkkR23S9iq5A2UuTDE24wLmt5XRo8i1Zy/IIQvMMZTOo9t4IJcJRYHcCfHWeH08Ez1
 xwcoeNedkiDCdch+D8PJhrs2nQ4mHgdztrNBrUzisAVmxxm1miaRvH3qtYzjZG9V2sCq nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32w4b9gqqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 11:35:22 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07DFVjiA025732;
        Thu, 13 Aug 2020 11:35:22 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32w4b9gqpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 11:35:22 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07DFR6Zc000319;
        Thu, 13 Aug 2020 15:35:20 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 32skp83gms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 15:35:20 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07DFZHjD31916414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Aug 2020 15:35:17 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF958A405D;
        Thu, 13 Aug 2020 15:35:17 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 097F2A405B;
        Thu, 13 Aug 2020 15:35:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.217])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Aug 2020 15:35:16 +0000 (GMT)
Subject: Re: [PATCH] ext4: delete invalid comments near ext4_mb_check_limits()
To:     brookxu <brookxu.cn@gmail.com>, adilger.kernel@dilger.ca,
        tytso@mit.edu, linux-ext4@vger.kernel.org
References: <c49faf0c-d5d5-9c51-6911-9e0ff57c6bfa@gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 13 Aug 2020 21:05:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c49faf0c-d5d5-9c51-6911-9e0ff57c6bfa@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200813153517.097F2A405B@d06av23.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_14:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 mlxlogscore=923
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130114
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 8/7/20 7:31 PM, brookxu wrote:
> These comments do not seem to be related to ext4_mb_check_limits(),
> it may be invalid.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Either ways these comments are of no help and the
function has enough comments within.
So we should be good without it.

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

> ---
>   fs/ext4/mballoc.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 577ce98..aaefeb4 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1743,10 +1743,6 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
> 
>   }
> 
> -/*
> - * regular allocator, for general purposes allocation
> - */
> -
>   static void ext4_mb_check_limits(struct ext4_allocation_context *ac,
>   					struct ext4_buddy *e4b,
>   					int finish_group)
> 
