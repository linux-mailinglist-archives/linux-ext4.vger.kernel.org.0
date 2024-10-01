Return-Path: <linux-ext4+bounces-4408-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C088C98B80C
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2024 11:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660692847F0
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2024 09:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C10819D889;
	Tue,  1 Oct 2024 09:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bjhaWsqZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E6B19D884
	for <linux-ext4@vger.kernel.org>; Tue,  1 Oct 2024 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773930; cv=none; b=q25AC4C15oUrvhQspBEjBMo0rmkPlBxoJI4Lx9UIMCvOPPc8/+h2Zm8QE3mxW0/w/fGuzAQd4Sy35Oxug1DtdPcT6LfQ5G1MGxfMgN8eourhneLc8K1Dmnei8LPfhA3wSGsvPMLeBMYgmNoOxU7rg2b8vZMxADmBs/nN6h2RzbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773930; c=relaxed/simple;
	bh=ehV5/uH+FckbOosKeqmSBRRDPb3XuFh/4yhTh4AbzQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wxc362RMZK3zUZFeVoA+RxX42zE4W8znGcV9hzIu+/TaOkQH/j4zleeMUAmb7l936+Kg7j22H+zzkhkZS2e1/VMUZNNL8Di0ndWAaNzaZu1Oyzn1lxtjOqAlx6SQbv9GgpFEos5T9ehakMnKSDCU71F7khQlgCLnmOinw3IqJlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bjhaWsqZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4917KFdA021703;
	Tue, 1 Oct 2024 09:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=H8QWBZaPu2Tl/FFg+NICLPDHHbJ
	Luwtw7atJgoT+dW0=; b=bjhaWsqZI5CY+DJ0qU+kku07FsUNf4dlnYCiq/LcLSw
	slFnrZ5RK7rrf3O7i1imB6Yxr+cG+JSD06I+n5/2+LrfduXdMZmXKs0EWBCJygsw
	q4J+0F19EU0blXgXVyxjxko+6YFHWHQIg01z38lbhiOAQwuOIh/fdA9M0rFzhuV6
	wGVOVpv+LPD/gAurtAwliXAHCMEPbSjv/upYEt2kIU5dF7/05C6g1c2feiHCb2Pj
	yPy0jQTQ/eC6/dlpq3+emNxDNttkisY6oFxjg/um3DHaL09X89ddlguuaJrnUg2m
	YAu0P2mXhd/C5LbfubunEXRtd5kpRpoNA0WDpHtXy7g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420cknghmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 09:12:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4918wB4Y008026;
	Tue, 1 Oct 2024 09:12:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgxuh4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 09:12:02 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4919C0ll22544710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 09:12:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 373C82004B;
	Tue,  1 Oct 2024 09:12:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6416B20040;
	Tue,  1 Oct 2024 09:11:59 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Oct 2024 09:11:59 +0000 (GMT)
Date: Tue, 1 Oct 2024 14:41:56 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] resize2fs: Check number of group descriptors only if
 meta_bg is disabled
Message-ID: <Zvu83J94z6ZgwOw5@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240925171926.11354-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925171926.11354-1-jack@suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: V4T1pWx1oOcdH-gpaB7KCmQKKb989Jog
X-Proofpoint-ORIG-GUID: V4T1pWx1oOcdH-gpaB7KCmQKKb989Jog
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=671
 mlxscore=0 priorityscore=1501 clxscore=1015 spamscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010058

On Wed, Sep 25, 2024 at 07:19:26PM +0200, Jan Kara wrote:
> When meta_bg feature is enabled, the total number of group descriptors
> is not really limiting the filesystem size. So there's no reason to
> check it in that case. This allows resize2fs to resize filesystems past
> 256TB boundary similarly as the kernel can do it.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Hi Jan,

Right this makes sense, I tested this using a sparse device:

# create a 1PB sparse device
sudo dmsetup create $SPARSE_DEVICE --table "0 $SIZE_1PB zero"
sudo dmsetup create $SNAPSHOT_NAME --table "0 $SIZE_1PB snapshot /dev/mapper/$SPARSE_DEVICE $BASE_DEVICE P 8"

sudo mkfs.ext4 /dev/mapper/$SNAPSHOT_NAME 512T
sudo resize2fs /dev/mapper/$SNAPSHOT_NAME 513T

This fails originally and works correctly with this patch applied. Infact without
this patch we end up failing 512T -> 512T resize as well which should just be 
a no-op.

Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

> ---
>  resize/main.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/resize/main.c b/resize/main.c
> index f914c0507e97..08a4bbaf7c65 100644
> --- a/resize/main.c
> +++ b/resize/main.c
> @@ -270,8 +270,6 @@ int main (int argc, char ** argv)
>  	long		sysval;
>  	int		len, mount_flags;
>  	char		*mtpt, *undo_file = NULL;
> -	dgrp_t		new_group_desc_count;
> -	unsigned long	new_desc_blocks;
>  
>  #ifdef ENABLE_NLS
>  	setlocale(LC_MESSAGES, "");
> @@ -551,17 +549,22 @@ int main (int argc, char ** argv)
>  		new_size &= ~((blk64_t)(1ULL << fs->cluster_ratio_bits) - 1);
>  	}
>  
> -	new_group_desc_count = ext2fs_div64_ceil(new_size -
> -				fs->super->s_first_data_block,
> -						 EXT2_BLOCKS_PER_GROUP(fs->super));
> -	new_desc_blocks = ext2fs_div_ceil(new_group_desc_count,
> -					  EXT2_DESC_PER_BLOCK(fs->super));
> -	if ((new_desc_blocks + fs->super->s_first_data_block) >
> -	    EXT2_BLOCKS_PER_GROUP(fs->super)) {
> -		com_err(program_name, 0,
> -			_("New size results in too many block group "
> -			  "descriptors.\n"));
> -		goto errout;
> +	if (!ext2fs_has_feature_meta_bg(fs->super)) {
> +		dgrp_t		new_group_desc_count;
> +		unsigned long	new_desc_blocks;
> +
> +		new_group_desc_count = ext2fs_div64_ceil(new_size -
> +					fs->super->s_first_data_block,
> +					EXT2_BLOCKS_PER_GROUP(fs->super));
> +		new_desc_blocks = ext2fs_div_ceil(new_group_desc_count,
> +					EXT2_DESC_PER_BLOCK(fs->super));
> +		if ((new_desc_blocks + fs->super->s_first_data_block) >
> +		    EXT2_BLOCKS_PER_GROUP(fs->super)) {
> +			com_err(program_name, 0,
> +				_("New size results in too many block group "
> +				  "descriptors.\n"));
> +			goto errout;
> +		}
>  	}
>  
>  	if (!force && new_size < min_size) {
> -- 
> 2.35.3
> 

