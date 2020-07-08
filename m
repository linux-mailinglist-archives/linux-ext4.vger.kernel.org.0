Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED6D218575
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jul 2020 13:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgGHLEB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jul 2020 07:04:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40576 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728715AbgGHLEA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Jul 2020 07:04:00 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 068B26VK186254;
        Wed, 8 Jul 2020 07:03:50 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 325brda85a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 07:03:50 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 068B2IcX187365;
        Wed, 8 Jul 2020 07:03:49 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 325brda84b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 07:03:49 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 068B12Mp029726;
        Wed, 8 Jul 2020 11:03:48 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 325cjwg09r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 11:03:47 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 068B3jqN63045874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jul 2020 11:03:45 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DC71A405C;
        Wed,  8 Jul 2020 11:03:45 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C470A405B;
        Wed,  8 Jul 2020 11:03:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.222.188])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Jul 2020 11:03:44 +0000 (GMT)
Subject: Re: [PATCH] jbd2: add the missing unlock_buffer() in the error path
 of jbd2_write_superblock()
To:     "zhangyi (F)" <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz, jiufei.xue@linux.alibaba.com
References: <20200620061948.2049579-1-yi.zhang@huawei.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 8 Jul 2020 16:33:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200620061948.2049579-1-yi.zhang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200708110344.6C470A405B@b06wcsmtp001.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_07:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 phishscore=0 clxscore=1011 adultscore=0 cotscore=-2147483648
 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007080075
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 6/20/20 11:49 AM, zhangyi (F) wrote:
> jbd2_write_superblock() is under the buffer lock of journal superblock
> before ending that superblock write, so add a missing unlock_buffer() in
> in the error path before submitting buffer.
> 
> Fixes: 742b06b5628f ("jbd2: check superblock mapped prior to committing")
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> Cc: stable@kernel.org

LGTM, feel free to add
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   fs/jbd2/journal.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index a49d0e670ddf..55c4ec4edf96 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1366,8 +1366,10 @@ static int jbd2_write_superblock(journal_t *journal, int write_flags)
>   	int ret;
> 
>   	/* Buffer got discarded which means block device got invalidated */
> -	if (!buffer_mapped(bh))
> +	if (!buffer_mapped(bh)) {
> +		unlock_buffer(bh);
>   		return -EIO;
> +	}
> 
>   	trace_jbd2_write_superblock(journal, write_flags);
>   	if (!(journal->j_flags & JBD2_BARRIER))
> 
