Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9BFF9582
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2019 17:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfKLQXz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Nov 2019 11:23:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726008AbfKLQXy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 12 Nov 2019 11:23:54 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xACGJbf7140510
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2019 11:23:53 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w7y24kd97-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2019 11:23:52 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 12 Nov 2019 16:23:51 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Nov 2019 16:23:49 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xACGNmEJ61276290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 16:23:48 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 325244203F;
        Tue, 12 Nov 2019 16:23:48 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3F334204C;
        Tue, 12 Nov 2019 16:23:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.34.195])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 12 Nov 2019 16:23:41 +0000 (GMT)
Subject: Re: [PATCH] fs: ext4: remove unused variable warning in
 parse_options()
To:     Olof Johansson <olof@lixom.net>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
References: <20191111022523.34256-1-olof@lixom.net>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 12 Nov 2019 21:53:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191111022523.34256-1-olof@lixom.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19111216-0020-0000-0000-0000038594D2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19111216-0021-0000-0000-000021DB9F79
Message-Id: <20191112162341.E3F334204C@d06av24.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120138
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 11/11/19 7:55 AM, Olof Johansson wrote:
> Commit c33fbe8f673c5 ("ext4: Enable blocksize < pagesize for
> dioread_nolock") removed the only user of 'sbi' outside of the ifdef,
> so it caused a new warning:
> 
> fs/ext4/super.c:2068:23: warning: unused variable 'sbi' [-Wunused-variable]
> 
> Fixes: c33fbe8f673c5 ("ext4: Enable blocksize < pagesize for dioread_nolock")
> Signed-off-by: Olof Johansson <olof@lixom.net>

hmm, I see that I had CONFIG_QUOTA enabled, so missed this.
Thanks for the patch.

You may add:
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

> ---
>   fs/ext4/super.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index f3279210f0ba9..ee8c42d8a04f0 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -2065,7 +2065,7 @@ static int parse_options(char *options, struct super_block *sb,
>   			 unsigned int *journal_ioprio,
>   			 int is_remount)
>   {
> -	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	struct ext4_sb_info __maybe_unused *sbi = EXT4_SB(sb);
>   	char *p, __maybe_unused *usr_qf_name, __maybe_unused *grp_qf_name;
>   	substring_t args[MAX_OPT_ARGS];
>   	int token;
> 

