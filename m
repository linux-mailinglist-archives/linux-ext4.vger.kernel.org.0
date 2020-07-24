Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C7A22BC3D
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Jul 2020 04:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgGXC6a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Jul 2020 22:58:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbgGXC63 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 23 Jul 2020 22:58:29 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06O2Wcfu079630;
        Thu, 23 Jul 2020 22:58:21 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32faj3vrcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 22:58:21 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06O2vwBs029161;
        Fri, 24 Jul 2020 02:58:18 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 32brbgune3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 02:58:18 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06O2wGsg59900232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 02:58:16 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E1EB5204E;
        Fri, 24 Jul 2020 02:58:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.220.127])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 789D952050;
        Fri, 24 Jul 2020 02:58:15 +0000 (GMT)
Subject: Re: [PATCH] ext4:remove some redundant function declarations
To:     Shijie Luo <luoshijie1@huawei.com>, linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz
References: <20200724014747.15924-1-luoshijie1@huawei.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 24 Jul 2020 08:28:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200724014747.15924-1-luoshijie1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200724025815.789D952050@d06av21.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_20:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=750 lowpriorityscore=0 mlxscore=0 clxscore=1011
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240012
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 7/24/20 7:17 AM, Shijie Luo wrote:
> ext4 update feature functions do not exist now, remove these useless
> function declarations.
> 
> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>

LGTM, feel free to add:
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

> ---
>   fs/ext4/ext4.h | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 42f5060f3cdf..196b52c75422 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2924,12 +2924,6 @@ do {									\
> 
>   #endif
> 
> -extern int ext4_update_compat_feature(handle_t *handle, struct super_block *sb,
> -					__u32 compat);
> -extern int ext4_update_rocompat_feature(handle_t *handle,
> -					struct super_block *sb,	__u32 rocompat);
> -extern int ext4_update_incompat_feature(handle_t *handle,
> -					struct super_block *sb,	__u32 incompat);
>   extern ext4_fsblk_t ext4_block_bitmap(struct super_block *sb,
>   				      struct ext4_group_desc *bg);
>   extern ext4_fsblk_t ext4_inode_bitmap(struct super_block *sb,
> 
