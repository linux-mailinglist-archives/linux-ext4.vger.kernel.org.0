Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474242185D5
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jul 2020 13:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728790AbgGHLPU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jul 2020 07:15:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3776 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbgGHLPU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Jul 2020 07:15:20 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 068B22S2029825;
        Wed, 8 Jul 2020 07:15:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3255kdmdh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 07:15:18 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 068B3svd039693;
        Wed, 8 Jul 2020 07:15:17 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3255kdmdgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 07:15:17 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 068BFGN6009783;
        Wed, 8 Jul 2020 11:15:16 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 3251dw0af6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 11:15:15 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 068BFDUc63439114
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jul 2020 11:15:13 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD67DA4054;
        Wed,  8 Jul 2020 11:15:13 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97DF5A405C;
        Wed,  8 Jul 2020 11:15:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.222.188])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Jul 2020 11:15:12 +0000 (GMT)
Subject: Re: [PATCH] ext4: Delete unnecessary checks before brelse()
To:     Markus Elfring <Markus.Elfring@web.de>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Theodore Ts'o" <tytso@mit.edu>
Cc:     kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <0d713702-072f-a89c-20ec-ca70aa83a432@web.de>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 8 Jul 2020 16:45:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <0d713702-072f-a89c-20ec-ca70aa83a432@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200708111512.97DF5A405C@b06wcsmtp001.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_07:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 cotscore=-2147483648 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007080075
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 6/13/20 11:37 PM, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 13 Jun 2020 19:12:24 +0200
> 
> The brelse() function tests whether its argument is NULL
> and then returns immediately.
> Thus remove the tests which are not needed around the shown calls.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Sure, LGTM. Feel free to add
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   fs/ext4/extents.c | 6 ++----
>   fs/ext4/xattr.c   | 3 +--
>   2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 221f240eae60..315276d50aa8 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -693,10 +693,8 @@ void ext4_ext_drop_refs(struct ext4_ext_path *path)
>   		return;
>   	depth = path->p_depth;
>   	for (i = 0; i <= depth; i++, path++) {
> -		if (path->p_bh) {
> -			brelse(path->p_bh);
> -			path->p_bh = NULL;
> -		}
> +		brelse(path->p_bh);
> +		path->p_bh = NULL;
>   	}
>   }
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 9b29a40738ac..eb997ce21be3 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1354,8 +1354,7 @@ static int ext4_xattr_inode_write(handle_t *handle, struct inode *ea_inode,
> 
>   	block = 0;
>   	while (wsize < bufsize) {
> -		if (bh != NULL)
> -			brelse(bh);
> +		brelse(bh);
>   		csize = (bufsize - wsize) > blocksize ? blocksize :
>   								bufsize - wsize;
>   		bh = ext4_getblk(handle, ea_inode, block, 0);
> --
> 2.27.0
> 
