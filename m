Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20559122EEC
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Dec 2019 15:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfLQOiS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Dec 2019 09:38:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726402AbfLQOiS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 17 Dec 2019 09:38:18 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBHEWjsc127443
        for <linux-ext4@vger.kernel.org>; Tue, 17 Dec 2019 09:38:16 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wxx5hxfa8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Tue, 17 Dec 2019 09:38:16 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 17 Dec 2019 14:38:14 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Dec 2019 14:38:10 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBHEc9sM29229106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Dec 2019 14:38:09 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C41404C04E;
        Tue, 17 Dec 2019 14:38:09 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8F1D4C058;
        Tue, 17 Dec 2019 14:38:07 +0000 (GMT)
Received: from [9.199.158.112] (unknown [9.199.158.112])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 Dec 2019 14:38:07 +0000 (GMT)
Subject: Re: [PATCH] ext4: fix Wunused-but-set-variable warning in
 ext4_add_entry()
To:     Yunfeng Ye <yeyunfeng@huawei.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
References: <c351e548-f094-aa90-bf8e-b267284c493e@huawei.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 17 Dec 2019 20:08:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c351e548-f094-aa90-bf8e-b267284c493e@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121714-0008-0000-0000-00000341D58A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121714-0009-0000-0000-00004A61E6D5
Message-Id: <20191217143807.E8F1D4C058@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_02:2019-12-17,2019-12-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=985
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912170123
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 12/17/19 5:41 PM, Yunfeng Ye wrote:
> Warning is found when compile with "-Wunused-but-set-variable":
> 
> fs/ext4/namei.c: In function ‘ext4_add_entry’:
> fs/ext4/namei.c:2167:23: warning: variable ‘sbi’ set but not used
> [-Wunused-but-set-variable]
>    struct ext4_sb_info *sbi;
>                         ^~~
> Fix this by moving the variable @sbi under CONFIG_UNICODE.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>

Looks good to me. You may add:

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>



> ---
>   fs/ext4/namei.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index a856997d87b5..617349be460f 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2164,7 +2164,9 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
>   	struct buffer_head *bh = NULL;
>   	struct ext4_dir_entry_2 *de;
>   	struct super_block *sb;
> +#ifdef CONFIG_UNICODE
>   	struct ext4_sb_info *sbi;
> +#endif
>   	struct ext4_filename fname;
>   	int	retval;
>   	int	dx_fallback=0;
> @@ -2176,12 +2178,12 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
>   		csum_size = sizeof(struct ext4_dir_entry_tail);
> 
>   	sb = dir->i_sb;
> -	sbi = EXT4_SB(sb);
>   	blocksize = sb->s_blocksize;
>   	if (!dentry->d_name.len)
>   		return -EINVAL;
> 
>   #ifdef CONFIG_UNICODE
> +	sbi = EXT4_SB(sb);
>   	if (ext4_has_strict_mode(sbi) && IS_CASEFOLDED(dir) &&
>   	    sbi->s_encoding && utf8_validate(sbi->s_encoding, &dentry->d_name))
>   		return -EINVAL;
> 

