Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECFFC12B156
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Dec 2019 06:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfL0Fcj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Dec 2019 00:32:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37654 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbfL0Fcj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 27 Dec 2019 00:32:39 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBR5WB0I140687
        for <linux-ext4@vger.kernel.org>; Fri, 27 Dec 2019 00:32:37 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2x1f3f8p89-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Fri, 27 Dec 2019 00:32:37 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Fri, 27 Dec 2019 05:32:35 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 27 Dec 2019 05:32:33 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBR5WXVj58917116
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Dec 2019 05:32:33 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F9BF11C054;
        Fri, 27 Dec 2019 05:32:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A103111C058;
        Fri, 27 Dec 2019 05:32:31 +0000 (GMT)
Received: from [9.199.159.72] (unknown [9.199.159.72])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 27 Dec 2019 05:32:31 +0000 (GMT)
Subject: Re: [PATCH] ext4: Optimize ext4 DIO overwrites
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        "Berrocal, Eduardo" <eduardo.berrocal@intel.com>
References: <20191218174433.19380-1-jack@suse.cz>
 <20191219135329.529E3A404D@d06av23.portsmouth.uk.ibm.com>
 <20191219192823.GA5389@quack2.suse.cz> <20191226171731.GE3158@mit.edu>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 27 Dec 2019 11:02:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20191226171731.GE3158@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19122705-0012-0000-0000-00000378656B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19122705-0013-0000-0000-000021B46A0D
Message-Id: <20191227053231.A103111C058@d06av25.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-26_07:2019-12-24,2019-12-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 mlxlogscore=822 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912270043
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 12/26/19 10:47 PM, Theodore Y. Ts'o wrote:
> On Thu, Dec 19, 2019 at 08:28:23PM +0100, Jan Kara wrote:
>>> However depending on which patch lands first one may need a
>>> re-basing. Will conflict with this-
>>> https://marc.info/?l=linux-ext4&m=157613016931238&w=2
>>
>> Yes, but the conflict is minor and trivial to resolve.
>>
> 
> Is this the correct resolution?
> 
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -447,6 +447,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	struct inode *inode = file_inode(iocb->ki_filp);
>   	loff_t offset = iocb->ki_pos;
>   	size_t count = iov_iter_count(from);
> +	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
>   	bool extend = false, unaligned_io = false;
>   	bool ilock_shared = true;
>   
> @@ -526,7 +527,9 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   		ext4_journal_stop(handle);
>   	}
>   
> -	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, &ext4_dio_write_ops,
> +	if (ilock_shared)
> +		iomap_ops = &ext4_iomap_overwrite_ops;
> +	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>   			   is_sync_kiocb(iocb) || unaligned_io || extend);
>   
>   	if (extend)
> 
>  

Yes, this looks correct to me.

Thanks
-ritesh

