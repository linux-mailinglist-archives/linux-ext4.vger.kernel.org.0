Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6711F5F76
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jun 2020 03:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgFKBV2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Jun 2020 21:21:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbgFKBV1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 10 Jun 2020 21:21:27 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05B17CjE093234;
        Wed, 10 Jun 2020 21:21:20 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31k5hxqv59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 21:21:20 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05B1L7Tt030186;
        Thu, 11 Jun 2020 01:21:18 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 31g2s80s47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jun 2020 01:21:18 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05B1LF9a64029050
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jun 2020 01:21:15 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4C31A4051;
        Thu, 11 Jun 2020 01:21:15 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE7ECA4040;
        Thu, 11 Jun 2020 01:21:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.93.125])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Jun 2020 01:21:14 +0000 (GMT)
Subject: Re: [PATCH] ext4: mballoc: Disable preemption before getting per-CPU
 pointer
To:     YueHaibing <yuehaibing@huawei.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca
References: <20200610134919.73688-1-yuehaibing@huawei.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 11 Jun 2020 06:51:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610134919.73688-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200611012114.CE7ECA4040@d06av23.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_13:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 mlxscore=0 mlxlogscore=944 suspectscore=0 bulkscore=0 impostorscore=0
 cotscore=-2147483648 phishscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110005
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Fix for this is already submitted @

https://patchwork.ozlabs.org/project/linux-ext4/patch/534f275016296996f54ecf65168bb3392b6f653d.1591699601.git.riteshh@linux.ibm.com/

-ritesh

On 6/10/20 7:19 PM, YueHaibing wrote:
> BUG: using smp_processor_id() in preemptible [00000000] code: kworker/u16:3/2181
> caller is ext4_mb_new_blocks+0x388/0xed0
> CPU: 2 PID: 2181 Comm: kworker/u16:3 Not tainted 5.7.0+ #182
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> Workqueue: writeback wb_workfn (flush-8:0)
> Call Trace:
>   dump_stack+0xb9/0xfc
>   debug_smp_processor_id+0xc8/0xd0
>   ext4_mb_new_blocks+0x388/0xed0
>   ext4_ext_map_blocks+0xa92/0xff0
>   ext4_map_blocks+0x34e/0x580
>   ext4_writepages+0xa28/0x11b0
>   do_writepages+0x46/0xe0
>   __writeback_single_inode+0x5f/0x6b0
>   writeback_sb_inodes+0x290/0x620
>   __writeback_inodes_wb+0x62/0xb0
>   wb_writeback+0x36c/0x520
>   wb_workfn+0x319/0x680
>   process_one_work+0x271/0x640
>   worker_thread+0x3a/0x3a0
>   kthread+0x14e/0x170
>   ret_from_fork+0x27/0x40
> 
> Disable preemption before accessing discard_pa_seq.
> 
> Fixes: 07b5b8e1ac40 ("ext4: mballoc: introduce pcpu seqcnt for freeing PA to improve ENOSPC handling")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   fs/ext4/mballoc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index a9083113a8c0..30b3bfb1e06a 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4708,7 +4708,8 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
>   	}
>   
>   	ac->ac_op = EXT4_MB_HISTORY_PREALLOC;
> -	seq = *this_cpu_ptr(&discard_pa_seq);
> +	seq = *get_cpu_ptr(&discard_pa_seq);
> +	put_cpu_ptr(&discard_pa_seq);
>   	if (!ext4_mb_use_preallocated(ac)) {
>   		ac->ac_op = EXT4_MB_HISTORY_ALLOC;
>   		ext4_mb_normalize_request(ac, ar);
> 
