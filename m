Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A9B243CD4
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Aug 2020 17:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgHMPxb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Aug 2020 11:53:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726249AbgHMPx1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 Aug 2020 11:53:27 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07DFWRZV036978;
        Thu, 13 Aug 2020 11:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=CRfN5S+co8EixlzodjZJii8swglZ26POxlT4p+o5d88=;
 b=SL79bhlxCjGTyNwTj8fzY6Om5zV0MK0OdpUWgPiSbGH1PS20SvLfnYZ142xKTUwTSlne
 Ril8dAkx/FGVm+gIjhoEqRWh5ttfTW010a+PZljSyH/4dJ6nz1b0kW5IOT68HGLykmSm
 trhoi3+hHuQ2UxgNnbFWG0cv8wuTn2QCQIqfX9ez0K6BHeJ0U4EuFadzKYtDpwYXa0C8
 7j+udswt77+i51GYVhB5Ys+p1owBfqprcxe8nZLbg5moO+wODZYZtc9noJsLKe5YdXzq
 MEhM02Rnv8bA+67jejggc4O8+aBpHpf6AmV9Ne0Loyw7ZpMPbmCqOnmIk6ZysNzh5uyu VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32w6vcbbxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 11:53:21 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07DFWRIq036961;
        Thu, 13 Aug 2020 11:53:20 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32w6vcbbwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 11:53:20 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07DFiQ1I030527;
        Thu, 13 Aug 2020 15:53:18 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 32skp85qgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 15:53:18 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07DFrG5r11796754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Aug 2020 15:53:16 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8292DA4040;
        Thu, 13 Aug 2020 15:53:16 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 989BAA4053;
        Thu, 13 Aug 2020 15:53:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.217])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Aug 2020 15:53:15 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] ext4: rename system_blks to s_system_blks inside
 ext4_sb_info
To:     brookxu <brookxu.cn@gmail.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
References: <b37bb523-8d3f-a6d4-f2b2-a321602c26e3@gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 13 Aug 2020 21:23:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b37bb523-8d3f-a6d4-f2b2-a321602c26e3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200813155315.989BAA4053@d06av23.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_14:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130114
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 8/7/20 11:50 AM, brookxu wrote:
> Rename system_blks to s_system_blks inside ext4_sb_info, keep
> the naming rules consistent with other variables, which is
> convenient for code reading and writing.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Other than the points mentioned in the other email in [Patch 1/2],
(related to --thread and author signed-off-by)

this patch looks good to me. Please feel free to add,
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   fs/ext4/block_validity.c | 14 +++++++-------
>   fs/ext4/ext4.h           |  2 +-
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
> index 16e9b2f..69240b4 100644
> --- a/fs/ext4/block_validity.c
> +++ b/fs/ext4/block_validity.c
> @@ -138,7 +138,7 @@ static void debug_print_tree(struct ext4_sb_info *sbi)
> 
>   	printk(KERN_INFO "System zones: ");
>   	rcu_read_lock();
> -	system_blks = rcu_dereference(sbi->system_blks);
> +	system_blks = rcu_dereference(sbi->s_system_blks);
>   	node = rb_first(&system_blks->root);
>   	while (node) {
>   		entry = rb_entry(node, struct ext4_system_zone, node);
> @@ -263,11 +263,11 @@ int ext4_setup_system_zone(struct super_block *sb)
>   	int ret;
> 
>   	if (!test_opt(sb, BLOCK_VALIDITY)) {
> -		if (sbi->system_blks)
> +		if (sbi->s_system_blks)
>   			ext4_release_system_zone(sb);
>   		return 0;
>   	}
> -	if (sbi->system_blks)
> +	if (sbi->s_system_blks)
>   		return 0;
> 
>   	system_blks = kzalloc(sizeof(*system_blks), GFP_KERNEL);
> @@ -308,7 +308,7 @@ int ext4_setup_system_zone(struct super_block *sb)
>   	 * with ext4_data_block_valid() accessing the rbtree at the same
>   	 * time.
>   	 */
> -	rcu_assign_pointer(sbi->system_blks, system_blks);
> +	rcu_assign_pointer(sbi->s_system_blks, system_blks);
> 
>   	if (test_opt(sb, DEBUG))
>   		debug_print_tree(sbi);
> @@ -333,9 +333,9 @@ void ext4_release_system_zone(struct super_block *sb)
>   {
>   	struct ext4_system_blocks *system_blks;
> 
> -	system_blks = rcu_dereference_protected(EXT4_SB(sb)->system_blks,
> +	system_blks = rcu_dereference_protected(EXT4_SB(sb)->s_system_blks,
>   					lockdep_is_held(&sb->s_umount));
> -	rcu_assign_pointer(EXT4_SB(sb)->system_blks, NULL);
> +	rcu_assign_pointer(EXT4_SB(sb)->s_system_blks, NULL);
> 
>   	if (system_blks)
>   		call_rcu(&system_blks->rcu, ext4_destroy_system_zone);
> @@ -353,7 +353,7 @@ int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
>   	 * mount option.
>   	 */
>   	rcu_read_lock();
> -	system_blks = rcu_dereference(sbi->system_blks);
> +	system_blks = rcu_dereference(sbi->s_system_blks);
>   	ret = ext4_data_block_valid_rcu(sbi, system_blks, start_blk,
>   					count);
>   	rcu_read_unlock();
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 8ca9adf..d60a462 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1470,7 +1470,7 @@ struct ext4_sb_info {
>   	int s_jquota_fmt;			/* Format of quota to use */
>   #endif
>   	unsigned int s_want_extra_isize; /* New inodes should reserve # bytes */
> -	struct ext4_system_blocks __rcu *system_blks;
> +	struct ext4_system_blocks __rcu *s_system_blks;
> 
>   #ifdef EXTENTS_STATS
>   	/* ext4 extents stats */
> 
