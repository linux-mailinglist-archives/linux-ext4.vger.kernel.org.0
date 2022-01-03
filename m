Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB0648310B
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jan 2022 13:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiACMcN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Jan 2022 07:32:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229586AbiACMcN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 3 Jan 2022 07:32:13 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 203BCg3j021585;
        Mon, 3 Jan 2022 12:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=DPp7w2vEjDkLxraZPaKaqA60M7D6xgLCt1pzTGvqTlI=;
 b=GAE1XgqoluT80Sdwz0AyEcVLxmci9KXs0Xrr6KgC0Li+m0w+CoWIKLSv7XqVq5keVoD+
 ZeGtjneUOcIsATrByMshiyVPz2+FzklESUZc5L9qHhoGANAOzt+NHqChCoL0lJISrxjA
 vkwcWPagawGj5ai+HRjXiPGXBBdGdxoF7fNySHmkf0hihQwH48P1aaXfnTwor4A8hon5
 hjjII07XrGaMbKkKPKQxZ6i/xVHzuJx1eyUMBZXvAiAs9x+9TbRE4o2TphijqLG6cGO9
 /GDgdsHhXF76RbkuiunJ1/R2Go1QB7JVdbZf8+YJ3eSHP55+S2B38wzNyPGJ2eHdjs4K 6w== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dc02ss5dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jan 2022 12:32:02 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 203CUIDG029904;
        Mon, 3 Jan 2022 12:31:59 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3dae7jjnap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jan 2022 12:31:58 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 203CVuw643778410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Jan 2022 12:31:56 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9325211C04A;
        Mon,  3 Jan 2022 12:31:56 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3166F11C070;
        Mon,  3 Jan 2022 12:31:56 +0000 (GMT)
Received: from localhost (unknown [9.43.89.189])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  3 Jan 2022 12:31:55 +0000 (GMT)
Date:   Mon, 3 Jan 2022 18:01:55 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     zhanchengbin <zhanchengbin1@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        liuzhiqiang26@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH] setup_tdb : fix memory leak
Message-ID: <20220103122202.tz6wv5tyf4xmeb2t@riteshh-domain>
References: <3a0cbb4e-6ea3-356a-433d-3a7a6466b018@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a0cbb4e-6ea3-356a-433d-3a7a6466b018@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kWagNIBFg7BkJP-VfQQ5-vrs5_sM5Bzj
X-Proofpoint-ORIG-GUID: kWagNIBFg7BkJP-VfQQ5-vrs5_sM5Bzj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-03_04,2022-01-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=808 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201030085
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 21/11/30 02:40PM, zhanchengbin wrote:
> In setup_tdb(), need free tdb_dir before return,
> otherwise it will cause memory leak.
>
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
> ---
>  e2fsck/dirinfo.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/e2fsck/dirinfo.c b/e2fsck/dirinfo.c
> index 49d624c5..a2b36d8e 100644
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
> +		goto error;
>
>  	retval = ext2fs_get_mem(strlen(tdb_dir) + 64, &db->tdb_fn);

I think freeing of db->tdb_fn should also be handled in case of an error.

>  	if (retval)
> -		return;
> +		goto error;
>
>  	uuid_unparse(ctx->fs->super->s_uuid, uuid);
>  	sprintf(db->tdb_fn, "%s/%s-dirinfo-XXXXXX", tdb_dir, uuid);
> @@ -74,7 +74,7 @@ static void setup_tdb(e2fsck_t ctx, ext2_ino_t num_dirs)
>  	umask(save_umask);
>  	if (fd < 0) {
>  		db->tdb = NULL;
> -		return;
> +		goto error;

So in case of an error we should call ext2fs_free_mem(&db->tdb_fn), right?

Rest looks good to me.

-ritesh


>  	}
>
>  	if (num_dirs < 99991)
> @@ -83,6 +83,11 @@ static void setup_tdb(e2fsck_t ctx, ext2_ino_t num_dirs)
>  	db->tdb = tdb_open(db->tdb_fn, num_dirs, TDB_NOLOCK | TDB_NOSYNC,
>  			   O_RDWR | O_CREAT | O_TRUNC, 0600);
>  	close(fd);
> +
> +error:
> +	if(tdb_dir) {
> +		free(tdb_dir);
> +	}
>  }
>  #endif
>
> --
> 2.23.0
>
>
