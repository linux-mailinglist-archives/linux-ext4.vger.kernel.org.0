Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D37C218546
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jul 2020 12:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgGHKwV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jul 2020 06:52:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44118 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbgGHKwV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Jul 2020 06:52:21 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 068AXJvs051752;
        Wed, 8 Jul 2020 06:52:07 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 325c6qry9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 06:52:07 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 068Akaq4023603;
        Wed, 8 Jul 2020 10:52:05 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 322hd7vfft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 10:52:05 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 068Aq3WD63111416
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jul 2020 10:52:03 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26953A405C;
        Wed,  8 Jul 2020 10:52:03 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AE73A405F;
        Wed,  8 Jul 2020 10:52:02 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.222.188])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Jul 2020 10:52:02 +0000 (GMT)
Subject: Re: [PATCH] ext2: initialize quota info in ext2_xattr_set()
To:     Chengguang Xu <cgxu519@mykernel.net>, jack@suse.com
Cc:     linux-ext4@vger.kernel.org
References: <20200626054959.114177-1-cgxu519@mykernel.net>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 8 Jul 2020 16:22:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626054959.114177-1-cgxu519@mykernel.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200708105202.7AE73A405F@b06wcsmtp001.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_07:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 cotscore=-2147483648
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007080073
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 6/26/20 11:19 AM, Chengguang Xu wrote:
> In order to correctly account/limit space usage, should initialize
> quota info before calling quota related functions.

How did you encounter the problem?
Any test case got hit?

> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

LGTM, feel free to add
Reviewed-by: Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   fs/ext2/xattr.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index 943cc469f42f..913e5c4921ec 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -437,6 +437,9 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
>   	name_len = strlen(name);
>   	if (name_len > 255 || value_len > sb->s_blocksize)
>   		return -ERANGE;
> +	error = dquot_initialize(inode);
> +	if (error)
> +		return error;
>   	down_write(&EXT2_I(inode)->xattr_sem);
>   	if (EXT2_I(inode)->i_file_acl) {
>   		/* The inode already has an extended attribute block. */
> 
