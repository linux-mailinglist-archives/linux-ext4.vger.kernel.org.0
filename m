Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFE771B00D8
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Apr 2020 06:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDTEyU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Apr 2020 00:54:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45912 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725872AbgDTEyT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 20 Apr 2020 00:54:19 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03K4gdFN117756
        for <linux-ext4@vger.kernel.org>; Mon, 20 Apr 2020 00:54:18 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ghmam604-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Mon, 20 Apr 2020 00:54:18 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 20 Apr 2020 05:53:55 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 20 Apr 2020 05:53:53 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03K4sE9j44630454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Apr 2020 04:54:14 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77D9D4C04E;
        Mon, 20 Apr 2020 04:54:14 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 236974C04A;
        Mon, 20 Apr 2020 04:54:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.92.243])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 20 Apr 2020 04:54:11 +0000 (GMT)
Subject: Re: [PATCH] ext4: remove unnecessary comparisons to bool
To:     Jason Yan <yanaijie@huawei.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, enwlinux@gmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200420042918.19459-1-yanaijie@huawei.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 20 Apr 2020 10:24:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200420042918.19459-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20042004-0012-0000-0000-000003A7AD9F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042004-0013-0000-0000-000021E4F609
Message-Id: <20200420045412.236974C04A@d06av22.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-19_06:2020-04-17,2020-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004200039
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 4/20/20 9:59 AM, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> fs/ext4/extents_status.c:1057:5-28: WARNING: Comparison to bool
> fs/ext4/inode.c:2314:18-24: WARNING: Comparison to bool
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Thanks for the patch. Looks good to me.

Feel free to add:
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

> ---
>   fs/ext4/extents_status.c | 2 +-
>   fs/ext4/inode.c          | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index d996b44d2265..e75171535375 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -1054,7 +1054,7 @@ static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
>   	end = (end > ext4_es_end(es)) ? ext4_es_end(es) : end;
> 
>   	/* record the first block of the first delonly extent seen */
> -	if (rc->first_do_lblk_found == false) {
> +	if (!rc->first_do_lblk_found) {
>   		rc->first_do_lblk = i;
>   		rc->first_do_lblk_found = true;
>   	}
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 2a4aae6acdcb..acb8fedcba76 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2311,7 +2311,7 @@ static int mpage_map_and_submit_buffers(struct mpage_da_data *mpd)
>   			 * mapping, or maybe the page was submitted for IO.
>   			 * So we return to call further extent mapping.
>   			 */
> -			if (err < 0 || map_bh == true)
> +			if (err < 0 || map_bh)
>   				goto out;
>   			/* Page fully mapped - let IO run! */
>   			err = mpage_submit_page(mpd, page);
> 

