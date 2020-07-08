Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2E82184A2
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jul 2020 12:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgGHKEt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jul 2020 06:04:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11790 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbgGHKEs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Jul 2020 06:04:48 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 068A2shv043217;
        Wed, 8 Jul 2020 06:04:39 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3255kdjbq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 06:04:39 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 068A0J3j028949;
        Wed, 8 Jul 2020 10:04:37 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 322hd84gx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 10:04:37 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 068A1vkw51511586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jul 2020 10:01:57 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F061A405B;
        Wed,  8 Jul 2020 10:03:19 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59AD8A406B;
        Wed,  8 Jul 2020 10:03:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.222.188])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Jul 2020 10:03:18 +0000 (GMT)
Subject: Re: [PATCH v2] ext4: lost matching-pair of trace in ext4_truncate
To:     zhengliang <zhengliang6@huawei.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
References: <20200701083027.45996-1-zhengliang6@huawei.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 8 Jul 2020 15:33:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200701083027.45996-1-zhengliang6@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200708100318.59AD8A406B@b06wcsmtp001.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_07:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 cotscore=-2147483648 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007080069
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 7/1/20 2:00 PM, zhengliang wrote:
> It should call trace exit in all return path for ext4_truncate.
> 
> v2:
> It shoule call trace exit in all return path, and add "out_trace" label to avoid the
> multiple copies of the cleanup code in each error case.

v2 description should generally go below three dashed line so that
it need not become part of commit msg.


> 
> Signed-off-by: zhengliang <zhengliang6@huawei.com>

LGTM, feel free to add
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   fs/ext4/inode.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 10dd470876b3..6187c8880c02 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4163,7 +4163,7 @@ int ext4_truncate(struct inode *inode)
>   	trace_ext4_truncate_enter(inode);
> 
>   	if (!ext4_can_truncate(inode))
> -		return 0;
> +		goto out_trace;
> 
>   	if (inode->i_size == 0 && !test_opt(inode->i_sb, NO_AUTO_DA_ALLOC))
>   		ext4_set_inode_state(inode, EXT4_STATE_DA_ALLOC_CLOSE);
> @@ -4172,16 +4172,14 @@ int ext4_truncate(struct inode *inode)
>   		int has_inline = 1;
> 
>   		err = ext4_inline_data_truncate(inode, &has_inline);
> -		if (err)
> -			return err;
> -		if (has_inline)
> -			return 0;
> +		if (err || has_inline)
> +			goto out_trace;
>   	}
> 
>   	/* If we zero-out tail of the page, we have to create jinode for jbd2 */
>   	if (inode->i_size & (inode->i_sb->s_blocksize - 1)) {
>   		if (ext4_inode_attach_jinode(inode) < 0)
> -			return 0;
> +			goto out_trace;
>   	}
> 
>   	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
> @@ -4190,8 +4188,10 @@ int ext4_truncate(struct inode *inode)
>   		credits = ext4_blocks_for_truncate(inode);
> 
>   	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
> -	if (IS_ERR(handle))
> -		return PTR_ERR(handle);
> +	if (IS_ERR(handle)) {
> +		err = PTR_ERR(handle);
> +		goto out_trace;
> +	}
> 
>   	if (inode->i_size & (inode->i_sb->s_blocksize - 1))
>   		ext4_block_truncate_page(handle, mapping, inode->i_size);
> @@ -4242,6 +4242,7 @@ int ext4_truncate(struct inode *inode)
>   		err = err2;
>   	ext4_journal_stop(handle);
> 
> +out_trace:
>   	trace_ext4_truncate_exit(inode);
>   	return err;
>   }
> 
