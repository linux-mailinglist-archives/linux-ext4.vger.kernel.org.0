Return-Path: <linux-ext4+bounces-5810-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CB29F92A2
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 13:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D6E1894D48
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 12:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343852153EB;
	Fri, 20 Dec 2024 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="He4zcA3b"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61482211A3D;
	Fri, 20 Dec 2024 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734699358; cv=none; b=MjdvPai3rMJM7uJqc4/ufa6UqiVVS3lgz09NOtrLkmMBWl9QlR/Gkc00EQAKG+f5c89/V298Fbb6qYMXhqhV+pndzxrELrUJ596S7h/2c7IKveqZU/Pa3sLDhn5LNaSPEOOXXQzfvFfXLzWdv4vntJawO8OplL+pJC+Zm6LCtEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734699358; c=relaxed/simple;
	bh=f4ESyd2iAEPNSxCH5hE0DLwkQIST2D56WkjlcJA73AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrcTCNL1Rh6LTAOKIhqyh9uKooNQhijpwecsJRNyh0gJ2UHl5DwpNmTqijZanzEvsUh7e0ykDdmK7khRe/HjnU/nfr1e9iyo8eIgTlqAybb4Sw/n6YJgVUgKvTBIVaLOmf+2xeFDO1m/NfY6yaXrogtfcd9Z8Y/77UvgRGObIsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=He4zcA3b; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJNbV4L010782;
	Fri, 20 Dec 2024 12:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=cW45KTZZyEcKFqjC7FVWPJgVQKkOaU
	v7LIzMb6QRRYQ=; b=He4zcA3bWXlswNutPvEZoKKuBiSDBxCbHWUvgOIgbsiKsY
	5P99rBpBC8SGBVT+BxCKd08ENI6sX2ppqt6j0QzKnPoqMykTiJXYtpLFi8689RWj
	nLh/w/59B+/yJQkJiN7jw7//FqwfPPHCiVGJkECtQdiyz1Cx5eMj1Va0qnzLa5yM
	0GUCSUvXumW+ci3OgLYRNmu2xyv0zW6JyA0GsB5gT+ZwB/fINSFIOMR3rsulXDij
	TGBgTbWxSM/sCBNg4UVzYv4w2rgsH417Haae7p3GrMW+Dtd1cWlLlgTHFQyV16zo
	KTLOl9W/euDm8W6eFPNdbu2b4HJPTgOQ/ebM/sIA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43mwaajub1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 12:55:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK9CMVw014350;
	Fri, 20 Dec 2024 12:55:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43hmqyjauq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 12:55:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BKCtkq818809194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Dec 2024 12:55:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00E9820043;
	Fri, 20 Dec 2024 12:55:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E86D020040;
	Fri, 20 Dec 2024 12:55:44 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.39.23.188])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Dec 2024 12:55:44 +0000 (GMT)
Date: Fri, 20 Dec 2024 18:25:42 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] ext4: remove unneeded forward declaration in namei.c
Message-ID: <Z2VpLu6ay0wW8uNK@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20241219110027.1440876-1-shikemeng@huaweicloud.com>
 <20241219110027.1440876-4-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219110027.1440876-4-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yxNLyaJoyewBeQL2CIm4tegq5YdNkUQB
X-Proofpoint-GUID: yxNLyaJoyewBeQL2CIm4tegq5YdNkUQB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200103

On Thu, Dec 19, 2024 at 07:00:24PM +0800, Kemeng Shi wrote:
> Remove unneeded forward declaration in namei.c
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/ext4/namei.c | 30 ------------------------------
>  1 file changed, 30 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 8ff840ef4730..33670cebdedc 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -291,36 +291,6 @@ struct dx_tail {
>  	__le32 dt_checksum;	/* crc32c(uuid+inum+dirblock) */
>  };
>  
> -static inline ext4_lblk_t dx_get_block(struct dx_entry *entry);
> -static void dx_set_block(struct dx_entry *entry, ext4_lblk_t value);
> -static inline unsigned dx_get_hash(struct dx_entry *entry);
> -static void dx_set_hash(struct dx_entry *entry, unsigned value);
> -static unsigned dx_get_count(struct dx_entry *entries);
> -static unsigned dx_get_limit(struct dx_entry *entries);
> -static void dx_set_count(struct dx_entry *entries, unsigned value);
> -static void dx_set_limit(struct dx_entry *entries, unsigned value);
> -static unsigned dx_root_limit(struct inode *dir, unsigned infosize);
> -static unsigned dx_node_limit(struct inode *dir);
> -static struct dx_frame *dx_probe(struct ext4_filename *fname,
> -				 struct inode *dir,
> -				 struct dx_hash_info *hinfo,
> -				 struct dx_frame *frame);
> -static void dx_release(struct dx_frame *frames);
> -static int dx_make_map(struct inode *dir, struct buffer_head *bh,
> -		       struct dx_hash_info *hinfo,
> -		       struct dx_map_entry *map_tail);
> -static void dx_sort_map(struct dx_map_entry *map, unsigned count);
> -static struct ext4_dir_entry_2 *dx_move_dirents(struct inode *dir, char *from,
> -					char *to, struct dx_map_entry *offsets,
> -					int count, unsigned int blocksize);
> -static struct ext4_dir_entry_2 *dx_pack_dirents(struct inode *dir, char *base,
> -						unsigned int blocksize);
> -static void dx_insert_block(struct dx_frame *frame,
> -					u32 hash, ext4_lblk_t block);
> -static int ext4_htree_next_block(struct inode *dir, __u32 hash,
> -				 struct dx_frame *frame,
> -				 struct dx_frame *frames,
> -				 __u32 *start_hash);
>  static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
>  		struct ext4_filename *fname,
>  		struct ext4_dir_entry_2 **res_dir);
> -- 
> 2.30.0
> 

