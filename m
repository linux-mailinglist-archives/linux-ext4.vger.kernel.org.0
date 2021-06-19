Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FACF3AD684
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Jun 2021 03:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234846AbhFSBoD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Jun 2021 21:44:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38900 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232384AbhFSBoC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 18 Jun 2021 21:44:02 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15J1XEB0039648;
        Fri, 18 Jun 2021 21:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=vDwbDF1gxL2wZRifoyg61ZjuE7oE7hQFGjo1VRZVgbU=;
 b=S2mRq/lrYZ5Pvo6u/DNCgrl6fLS+FnWyD8I7avZEnuIIFLcChhbc3SCU9s9hIu64GU3S
 mn3NlKR9+Ooeq57xAXJq1jE+5MHuLXXk+u8PpKl6150HngAQGCSS6K8rKjD3TJ7h1tcd
 Q2LSbHKsQbHoCqi4BR2FeCfFiXK8D/4J2LbX9UbjmNg0LRrYaI7YTDWC4M92pONhKVax
 EmxcP8O5jRj+Vf8S/TBQRmyZUsvHvMwEMAAQwJAPGuPfcskiWdNDSEBMwOc+HQY7jhRa
 HiiQEcCKa7dvj5J7IGmT92FkdrnCr06A2r8AMgCPmaPFV+Dhj/89F8owp2ZrXoQxnx6e 9g== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39969w8vtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 21:41:49 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15J1ZdQp028816;
        Sat, 19 Jun 2021 01:41:47 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 394mj8sy56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Jun 2021 01:41:47 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15J1eZBa32833976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Jun 2021 01:40:35 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A6975204E;
        Sat, 19 Jun 2021 01:41:45 +0000 (GMT)
Received: from localhost (unknown [9.199.33.55])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id CB84C52050;
        Sat, 19 Jun 2021 01:41:44 +0000 (GMT)
Date:   Sat, 19 Jun 2021 07:11:44 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH] ext4: Fix loff_t overflow in ext4_max_bitmap_size()
Message-ID: <20210619014144.regpoiyqlost22ua@riteshh-domain>
References: <594f409e2c543e90fd836b78188dfa5c575065ba.1622867594.git.riteshh@linux.ibm.com>
 <20210607100028.GE30275@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607100028.GE30275@quack2.suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IdRLCB35R2vAAMWly0SNf5AiWzYRB8G3
X-Proofpoint-ORIG-GUID: IdRLCB35R2vAAMWly0SNf5AiWzYRB8G3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_13:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106190005
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21/06/07 12:00PM, Jan Kara wrote:
> On Sat 05-06-21 10:39:32, Ritesh Harjani wrote:
> > We should use unsigned long long rather than loff_t to avoid
> > overflow in ext4_max_bitmap_size() for comparison before returning.
> > w/o this patch sbi->s_bitmap_maxbytes was becoming a negative
> > value due to overflow of upper_limit (with has_huge_files as true)
> >
> > Below is a quick test to trigger it on a 64KB pagesize system.
> >
> > sudo mkfs.ext4 -b 65536 -O ^has_extents,^64bit /dev/loop2
> > sudo mount /dev/loop2 /mnt
> > sudo echo "hello" > /mnt/hello 	-> This will error out with
> > 				"echo: write error: File too large"
> >
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
>
> OK, this works (although it's really tight ;). Won't it be somewhat safer
> if we compared upper_limit and res before shifting both by blocksize_bits
> to the left? Basically we need to shift only for comparison with
> MAX_LFS_FILESIZE which is in bytes... But either way feel free to add:

Yes, at 1st I did think that, but since for comparing "res" against
MAX_LFS_FILESIZE we will be anyway doing the bit shifting and since this logic
too was (just) fitting into the limits so I thought of keeping it the same.
But, if absolutely required, I can make those changes.

>
> Reviewed-by: Jan Kara <jack@suse.cz>


Thanks for the review :)

-ritesh

>
> 								Honza
>
> > ---
> >  fs/ext4/super.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 7dc94f3e18e6..bedb66386966 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -3189,17 +3189,17 @@ static loff_t ext4_max_size(int blkbits, int has_huge_files)
> >   */
> >  static loff_t ext4_max_bitmap_size(int bits, int has_huge_files)
> >  {
> > -	loff_t res = EXT4_NDIR_BLOCKS;
> > +	unsigned long long upper_limit, res = EXT4_NDIR_BLOCKS;
> >  	int meta_blocks;
> > -	loff_t upper_limit;
> > -	/* This is calculated to be the largest file size for a dense, block
> > +
> > +	/*
> > +	 * This is calculated to be the largest file size for a dense, block
> >  	 * mapped file such that the file's total number of 512-byte sectors,
> >  	 * including data and all indirect blocks, does not exceed (2^48 - 1).
> >  	 *
> >  	 * __u32 i_blocks_lo and _u16 i_blocks_high represent the total
> >  	 * number of 512-byte sectors of the file.
> >  	 */
> > -
> >  	if (!has_huge_files) {
> >  		/*
> >  		 * !has_huge_files or implies that the inode i_block field
> > @@ -3242,7 +3242,7 @@ static loff_t ext4_max_bitmap_size(int bits, int has_huge_files)
> >  	if (res > MAX_LFS_FILESIZE)
> >  		res = MAX_LFS_FILESIZE;
> >
> > -	return res;
> > +	return (loff_t)res;
> >  }
> >
> >  static ext4_fsblk_t descriptor_loc(struct super_block *sb,
> > --
> > 2.31.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
