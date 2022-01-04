Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF077484100
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jan 2022 12:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbiADLiH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jan 2022 06:38:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29518 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230166AbiADLiG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jan 2022 06:38:06 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2049nqeI017462;
        Tue, 4 Jan 2022 11:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=hjZPBrCl3EXhdnTQTLvZwuqsCssfyUSWS4KVjIPILrQ=;
 b=VcthBJryNBFWEAoxX5MUuTcrzJGxBkCulYoRz5SgoU1KVyg/CrfNq2RVdeNMtMBIpHtk
 QKXHNZS/msoTOl+J1ckUn0ecqENOQloHBRjdPug4Q+u6szbhhSv3wCWSRibsUM5e1b2S
 lBjA42j4BXqLfyiHbD4nopVrYuNYOr8BPDf7LK9HMyeJeds/06p7Yj3tmu926GGb4RtN
 pc1dT6WQ6gayclPXKh4bPUr1uxBH6u1NE3+xmEr+g05lJ1iGfj4jI+i+ZTvn8eXf5VWs
 I0odbyTh1gknh4yDcDwL8XM3kVr49d/uySMRbvIZlEufO4QCAU8dxegAP3/NS8HE3aCi Qg== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dckxs9s4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 11:37:56 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 204BTvEw023678;
        Tue, 4 Jan 2022 11:37:53 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3dae7jg6x7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 11:37:53 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 204Bbp0725231816
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jan 2022 11:37:51 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3139B11C052;
        Tue,  4 Jan 2022 11:37:51 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9E5511C050;
        Tue,  4 Jan 2022 11:37:50 +0000 (GMT)
Received: from localhost (unknown [9.43.73.10])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jan 2022 11:37:50 +0000 (GMT)
Date:   Tue, 4 Jan 2022 17:07:49 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        liuzhiqiang26@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH v2] setup_tdb : fix memory leak
Message-ID: <20220104113749.meyk7zkdtrqgwoc2@riteshh-domain>
References: <968b7f2c-6030-35c3-bc65-06a80b6e2403@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <968b7f2c-6030-35c3-bc65-06a80b6e2403@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZROZZR_JvjyW07R6euWTa9zIRp0BOL1A
X-Proofpoint-ORIG-GUID: ZROZZR_JvjyW07R6euWTa9zIRp0BOL1A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_05,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=718 priorityscore=1501 spamscore=0
 mlxscore=0 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201040077
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/01/04 07:21PM, zhanchengbin wrote:
> In setup_tdb(), need free tdb_dir and db->tdb_fn before return,
> otherwise it will cause memory leak.
>
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>  e2fsck/dirinfo.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/e2fsck/dirinfo.c b/e2fsck/dirinfo.c
> index 49d624c5..97a303e5 100644
> --- a/e2fsck/dirinfo.c
> +++ b/e2fsck/dirinfo.c
> @@ -49,7 +49,7 @@ static void setup_tdb(e2fsck_t ctx, ext2_ino_t num_dirs)
>  	ext2_ino_t		threshold;
>  	errcode_t		retval;
>  	mode_t			save_umask;
> -	char			*tdb_dir, uuid[40];
> +	char			*tdb_dir = NULL, uuid[40];
>  	int			fd, enable;
>
>  	profile_get_string(ctx->profile, "scratch_files", "directory", 0, 0,
> @@ -61,11 +61,11 @@ static void setup_tdb(e2fsck_t ctx, ext2_ino_t num_dirs)
>
>  	if (!enable || !tdb_dir || access(tdb_dir, W_OK) ||
>  	    (threshold && num_dirs <= threshold))
> -		return;
> +		goto tdb_dir_error;
>
>  	retval = ext2fs_get_mem(strlen(tdb_dir) + 64, &db->tdb_fn);
>  	if (retval)
> -		return;
> +		goto tdb_dir_error;
>
>  	uuid_unparse(ctx->fs->super->s_uuid, uuid);
>  	sprintf(db->tdb_fn, "%s/%s-dirinfo-XXXXXX", tdb_dir, uuid);
> @@ -74,7 +74,7 @@ static void setup_tdb(e2fsck_t ctx, ext2_ino_t num_dirs)
>  	umask(save_umask);
>  	if (fd < 0) {
>  		db->tdb = NULL;
> -		return;
> +		goto tdb_fn_error;
>  	}
>
>  	if (num_dirs < 99991)
> @@ -83,6 +83,16 @@ static void setup_tdb(e2fsck_t ctx, ext2_ino_t num_dirs)
>  	db->tdb = tdb_open(db->tdb_fn, num_dirs, TDB_NOLOCK | TDB_NOSYNC,
>  			   O_RDWR | O_CREAT | O_TRUNC, 0600);
>  	close(fd);
> +
> +	return;
> +
> +tdb_fn_error:
> +	ext2fs_free_mem(&db->tdb_fn);
> +	db->tdb_fn = NULL;

I think making tdb_fn = NULL is not needed, since ext2fs_free_mem() takes care of it.
With that removed, feel free to add:

Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

-riteshh



> +tdb_dir_error:
> +	if (tdb_dir) {
> +		free(tdb_dir);
> +	}
>  }
>  #endif
>
> --
> 2.27.0
>
