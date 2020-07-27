Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31C622E45B
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jul 2020 05:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgG0DUU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 26 Jul 2020 23:20:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61542 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726044AbgG0DUT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 26 Jul 2020 23:20:19 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06R349AK153107;
        Sun, 26 Jul 2020 23:20:17 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32ggmf6pd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 23:20:17 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06R37Wlp163593;
        Sun, 26 Jul 2020 23:20:16 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32ggmf6pcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Jul 2020 23:20:16 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06R3F4Kl012129;
        Mon, 27 Jul 2020 03:20:15 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 32gcy4hqwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 03:20:14 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06R3KC1x31654082
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 03:20:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C054A42042;
        Mon, 27 Jul 2020 03:20:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDE084204B;
        Mon, 27 Jul 2020 03:20:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.112])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jul 2020 03:20:11 +0000 (GMT)
Subject: Re: ext4: delete the invalid BUGON in ext4_mb_load_buddy_gfp()
To:     brookxu <brookxu.cn@gmail.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ad68e8a2-5ec3-5beb-537f-f3e53f55367a@gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 27 Jul 2020 08:50:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ad68e8a2-5ec3-5beb-537f-f3e53f55367a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <20200727032011.CDE084204B@d06av24.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_02:2020-07-24,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0
 mlxlogscore=903 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270016
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 7/27/20 7:24 AM, brookxu wrote:
> Delete the invalid BUGON in ext4_mb_load_buddy_gfp(), the previous
> code has already judged whether page is NULL.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Thanks for the patch. LGTM. Feel free to add.
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

> ---
>   fs/ext4/mballoc.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 28a139f..9b1c3ad 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1279,9 +1279,6 @@ int ext4_mb_init_group(struct super_block *sb, ext4_group_t group, gfp_t gfp)
>       e4b->bd_buddy_page = page;
>       e4b->bd_buddy = page_address(page) + (poff * sb->s_blocksize);
>   
> -    BUG_ON(e4b->bd_bitmap_page == NULL);
> -    BUG_ON(e4b->bd_buddy_page == NULL);
> -
>       return 0;
>   
>   err:
> 
