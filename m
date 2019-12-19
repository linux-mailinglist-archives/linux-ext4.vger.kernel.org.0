Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3634126401
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Dec 2019 14:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfLSNxh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Dec 2019 08:53:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726757AbfLSNxg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 19 Dec 2019 08:53:36 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBJDgU45100464
        for <linux-ext4@vger.kernel.org>; Thu, 19 Dec 2019 08:53:35 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x00sfq03x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Thu, 19 Dec 2019 08:53:35 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 19 Dec 2019 13:53:33 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 19 Dec 2019 13:53:31 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBJDrUjs55115970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Dec 2019 13:53:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 528F4A4053;
        Thu, 19 Dec 2019 13:53:30 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 529E3A404D;
        Thu, 19 Dec 2019 13:53:29 +0000 (GMT)
Received: from [9.199.158.86] (unknown [9.199.158.86])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 19 Dec 2019 13:53:29 +0000 (GMT)
Subject: Re: [PATCH] ext4: Optimize ext4 DIO overwrites
To:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        "Berrocal, Eduardo" <eduardo.berrocal@intel.com>
References: <20191218174433.19380-1-jack@suse.cz>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 19 Dec 2019 19:23:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191218174433.19380-1-jack@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19121913-0008-0000-0000-0000034297A5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121913-0009-0000-0000-00004A62B133
Message-Id: <20191219135329.529E3A404D@d06av23.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-19_01:2019-12-17,2019-12-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912190118
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 12/18/19 11:14 PM, Jan Kara wrote:
> Currently we start transaction for mapping every extent for writing
> using direct IO. This is unnecessary when we know we are overwriting
> already allocated blocks and the overhead of starting a transaction can
> be significant especially for multithreaded workloads doing small writes.
> Use iomap operations that avoid starting a transaction for direct IO
> overwrites.
> 
> This improves throughput of 4k random writes - fio jobfile:
> [global]
> rw=randrw
> norandommap=1
> invalidate=0
> bs=4k
> numjobs=16
> time_based=1
> ramp_time=30
> runtime=120
> group_reporting=1
> ioengine=psync
> direct=1
> size=16G
> filename=file1.0.0:file1.0.1:file1.0.2:file1.0.3:file1.0.4:file1.0.5:file1.0.6:file1.0.7:file1.0.8:file1.0.9:file1.0.10:file1.0.11:file1.0.12:file1.0.13:file1.0.14:file1.0.15:file1.0.16:file1.0.17:file1.0.18:file1.0.19:file1.0.20:file1.0.21:file1.0.22:file1.0.23:file1.0.24:file1.0.25:file1.0.26:file1.0.27:file1.0.28:file1.0.29:file1.0.30:file1.0.31
> file_service_type=random
> nrfiles=32
> 
> from 3018MB/s to 4059MB/s in my test VM running test against simulated
> pmem device (note that before iomap conversion, this workload was able
> to achieve 3708MB/s because old direct IO path avoided transaction start
> for overwrites as well). For dax, the win is even larger improving
> throughput from 3042MB/s to 4311MB/s.

However for dax via ext4_dax_write_iter() path, we still need a way to
detect if it's overwrite and that path can be optimized too right?
I see, that this path could use both `shared inode locking` and
`no journal transaction` optimizations in case of overwrites. Correct?


> 
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

This was one of the next AI I too wanted to do. I guess since everyone
loves performance improvements. :)

No problem with current patch. Looks good. Gave it a run too on my
system.

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


However depending on which patch lands first one may need a
re-basing. Will conflict with this-
https://marc.info/?l=linux-ext4&m=157613016931238&w=2



> ---
>   fs/ext4/ext4.h  |  1 +
>   fs/ext4/file.c  |  4 +++-
>   fs/ext4/inode.c | 21 +++++++++++++++++++++
>   3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index f8578caba40d..e31fc5749a19 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3390,6 +3390,7 @@ static inline void ext4_clear_io_unwritten_flag(ext4_io_end_t *io_end)
>   }
> 
>   extern const struct iomap_ops ext4_iomap_ops;
> +extern const struct iomap_ops ext4_iomap_overwrite_ops;
>   extern const struct iomap_ops ext4_iomap_report_ops;
> 
>   static inline int ext4_buffer_uptodate(struct buffer_head *bh)
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 6a7293a5cda2..f8e4af72d64d 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -370,6 +370,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	loff_t offset;
>   	handle_t *handle;
>   	struct inode *inode = file_inode(iocb->ki_filp);
> +	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
>   	bool extend = false, overwrite = false, unaligned_aio = false;
> 
>   	if (iocb->ki_flags & IOCB_NOWAIT) {
> @@ -415,6 +416,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	if (!unaligned_aio && ext4_overwrite_io(inode, offset, count) &&
>   	    ext4_should_dioread_nolock(inode)) {
>   		overwrite = true;
> +		iomap_ops = &ext4_iomap_overwrite_ops;
>   		downgrade_write(&inode->i_rwsem);
>   	}
> 
> @@ -435,7 +437,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		ext4_journal_stop(handle);
>   	}
> 
> -	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, &ext4_dio_write_ops,
> +	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>   			   is_sync_kiocb(iocb) || unaligned_aio || extend);
> 
>   	if (extend)
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 28f28de0c1b6..e1eb4493aacc 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3448,6 +3448,22 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   	return 0;
>   }
> 
> +static int ext4_iomap_overwrite_begin(struct inode *inode, loff_t offset,
> +		loff_t length, unsigned flags, struct iomap *iomap,
> +		struct iomap *srcmap)
> +{
> +	int ret;
> +
> +	/*
> +	 * Even for writes we don't need to allocate blocks, so just pretend
> +	 * we are reading to save overhead of starting a transaction.
> +	 */
> +	flags &= ~IOMAP_WRITE;
> +	ret = ext4_iomap_begin(inode, offset, length, flags, iomap, srcmap);
> +	WARN_ON_ONCE(iomap->type != IOMAP_MAPPED);
> +	return ret;
> +}
> +
>   static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
>   			  ssize_t written, unsigned flags, struct iomap *iomap)
>   {
> @@ -3469,6 +3485,11 @@ const struct iomap_ops ext4_iomap_ops = {
>   	.iomap_end		= ext4_iomap_end,
>   };
> 
> +const struct iomap_ops ext4_iomap_overwrite_ops = {
> +	.iomap_begin		= ext4_iomap_overwrite_begin,
> +	.iomap_end		= ext4_iomap_end,
> +};
> +
>   static bool ext4_iomap_is_delalloc(struct inode *inode,
>   				   struct ext4_map_blocks *map)
>   {
> 

