Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF954A65BD
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Feb 2022 21:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbiBAUeN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Feb 2022 15:34:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231571AbiBAUeM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Feb 2022 15:34:12 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211IP47A002332;
        Tue, 1 Feb 2022 20:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=CwFsW2ri/mvjy0B2QvLA7o77HnoLp7B5KW2hO7Z2Pws=;
 b=cvtmwBZEvEtmM+HLoVNVhdqmB5MQt8lRhw9FeQgB3tiB9prgm+54EWveFcyAW//vpXkF
 BGxN65JeDGr8GVHdl54mtUJaGn1XV3cn2ikaA3rDfW5u/SughYZDxKFIbLi/qiOf0PzW
 HHXyiYWlzd+PvxPXHssXk9MwA79VItjIFTc/BLdYm8b3m2OKZ3HhP7uMMWfRawjWalcW
 ZRZYF9M/bj3QVbWQqCAr7I0AWizDewl9QepLUBWKHmDznjY0O0kvsIS3pYTf82N8RqVV
 uuF/6c5tSB6uRF7SfnNes0nQAlMUfgPau0ByU06AgcJ2kg/0fN4TAlXXZBdxKW7iM25g PA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dya47a646-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:34:07 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211KJe78010622;
        Tue, 1 Feb 2022 20:34:06 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dya47a63q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:34:06 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211KWLcA016858;
        Tue, 1 Feb 2022 20:34:04 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3dvw79epy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:34:04 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211KY1gM24576310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 20:34:01 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9718352063;
        Tue,  1 Feb 2022 20:34:01 +0000 (GMT)
Received: from localhost (unknown [9.43.35.18])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EA64352050;
        Tue,  1 Feb 2022 20:34:00 +0000 (GMT)
Date:   Wed, 2 Feb 2022 02:03:59 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Xin Yin <yinxin.x@bytedance.com>
Cc:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ext4: use ext4_ext_remove_space() for fast commit
 replay delete range
Message-ID: <20220201203359.owrnrfqydjloy7oq@riteshh-domain>
References: <20211223032337.5198-1-yinxin.x@bytedance.com>
 <20211223032337.5198-2-yinxin.x@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223032337.5198-2-yinxin.x@bytedance.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: elR4ZXcgA9CjqbndA3W0kBSkvDdpIn_R
X-Proofpoint-ORIG-GUID: pSvyokNSDB2fgqESvRW446i1ztkiWVdJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010114
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Xin,

Sorry about revisiting this thread so late :(
Recently when I was working on one of the fast_commit issue, I got interested
in looking into some of those recent fast_commit fixes.

Hence some of these queries.

On 21/12/23 11:23AM, Xin Yin wrote:
> For now ,we use ext4_punch_hole() during fast commit replay delete range
> procedure. But it will be affected by inode->i_size, which may not
> correct during fast commit replay procedure. The following test will
> failed.
>
> -create & write foo (len 1000K)
> -falloc FALLOC_FL_ZERO_RANGE foo (range 400K - 600K)
> -create & fsync bar
^^^^ do you mean "fsync foo" or is this actually a new file create and fsync
bar?


> -falloc FALLOC_FL_PUNCH_HOLE foo (range 300K-500K)
> -fsync foo
> -crash before a full commit
>
> After the fast_commit reply procedure, the range 400K-500K will not be
> removed. Because in this case, when calling ext4_punch_hole() the
> inode->i_size is 0, and it just retruns with doing nothing.

I tried looking into this, but I am not able to put my head around that when
will the inode->i_size will be 0?

So, what I think should happen is when you are doing falocate/fsync foo in your
above list of operations then, anyways the inode i_disksize will be updated
using ext4_mark_inode_dirty() and during replay phase inode->i_size will hold
the right value no?

Could you please help understand when, where and how will inode->i_size will be
0?

Also - it would be helpful if you have some easy reproducer of this issue you
mentioned.

-ritesh

>
> Change to use ext4_ext_remove_space() instead of ext4_punch_hole()
> to remove blocks of inode directly.
>
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> ---
>  fs/ext4/fast_commit.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index aa05b23f9c14..3deb97b22ca4 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -1708,11 +1708,14 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
>  		}
>  	}
>
> -	ret = ext4_punch_hole(inode,
> -		le32_to_cpu(lrange.fc_lblk) << sb->s_blocksize_bits,
> -		le32_to_cpu(lrange.fc_len) <<  sb->s_blocksize_bits);
> -	if (ret)
> -		jbd_debug(1, "ext4_punch_hole returned %d", ret);
> +	down_write(&EXT4_I(inode)->i_data_sem);
> +	ret = ext4_ext_remove_space(inode, lrange.fc_lblk,
> +				lrange.fc_lblk + lrange.fc_len - 1);
> +	up_write(&EXT4_I(inode)->i_data_sem);
> +	if (ret) {
> +		iput(inode);
> +		return 0;
> +	}
>  	ext4_ext_replay_shrink_inode(inode,
>  		i_size_read(inode) >> sb->s_blocksize_bits);
>  	ext4_mark_inode_dirty(NULL, inode);
> --
> 2.20.1
>
