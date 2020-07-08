Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67B5218F53
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jul 2020 19:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgGHRz4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jul 2020 13:55:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725978AbgGHRzz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Jul 2020 13:55:55 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 068H3FBw055439;
        Wed, 8 Jul 2020 13:55:51 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 325bewfrcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 13:55:50 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 068HoTrY028929;
        Wed, 8 Jul 2020 17:55:48 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 322hd84y43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 17:55:48 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 068HtjrY12058974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jul 2020 17:55:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C94D452059;
        Wed,  8 Jul 2020 17:55:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.77.205.134])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2E47E52051;
        Wed,  8 Jul 2020 17:55:45 +0000 (GMT)
Subject: Re: [PATCH] ext4: Do not block RWF_NOWAIT dio write on unallocated
 space
To:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <20200708153516.9507-1-jack@suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 8 Jul 2020 23:25:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708153516.9507-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200708175545.2E47E52051@d06av21.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_15:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 cotscore=-2147483648 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 spamscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007080109
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 7/8/20 9:05 PM, Jan Kara wrote:
> Since commit 378f32bab371 ("ext4: introduce direct I/O write using iomap
> infrastructure") we don't properly bail out of RWF_NOWAIT direct IO
> write if underlying blocks are not allocated. Also
> ext4_dio_write_checks() does not honor RWF_NOWAIT when re-acquiring
> i_rwsem. Fix both issues.
> 
> Fixes: 378f32bab371 ("ext4: introduce direct I/O write using iomap infrastructure")
> Reported-by: Filipe Manana <fdmanana@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

LGTM, feel free to add
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

> ---
>   fs/ext4/file.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 2a01e31a032c..8f742b53f1d4 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -428,6 +428,10 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>   	 */
>   	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
>   	     !ext4_overwrite_io(inode, offset, count))) {
> +		if (iocb->ki_flags & IOCB_NOWAIT) {
> +			ret = -EAGAIN;
> +			goto out;
> +		}
>   		inode_unlock_shared(inode);
>   		*ilock_shared = false;
>   		inode_lock(inode);
> 
