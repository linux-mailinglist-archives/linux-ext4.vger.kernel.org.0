Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809EE243CCE
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Aug 2020 17:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgHMPuy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Aug 2020 11:50:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37218 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726131AbgHMPuy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 Aug 2020 11:50:54 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07DFV9DR022124;
        Thu, 13 Aug 2020 11:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=vT+8aCNgc8mLLjPu41+lZxb1zUEliqpaQbKygAdlOXo=;
 b=BsnPTLPcQlOoyxmCSsbBSk4RxZDwR1Tj+AIo+p9wCZwYDCa/USAtx6j5MlNy+SMTJkgf
 WbZdrIjaqxc6MIyLcQ7IxxAD4eGFH+Q462UGgiAoVwxkArUbwyrzUuWM/ft+EqVDri51
 PfpQcwroNGkeJnYTPvSAK5BBENbUrErVPl2WUrMr7VS/8qtITsp+8zsJEBEdJ4mPGO9e
 jo3otQ4s5n4oGnZJl4vGhoQ1QP8+eHb1Kw2OG7W/4Lnv/xfCv2/l5Wq/ijhwpq3e86tO
 CLRRiVJBFkTyEANOlDPjkWVY4RvsLEcNPKv5ygHIrCRhGHO3r3rVTwrkj4ChAEvIOCCi oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32w4b9h7v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 11:50:48 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07DFVtMx026473;
        Thu, 13 Aug 2020 11:50:48 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32w4b9h7u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 11:50:48 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07DFivdB008911;
        Thu, 13 Aug 2020 15:50:46 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 32skp8dq0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 15:50:46 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07DFohaq29098474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Aug 2020 15:50:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D3F7A405B;
        Thu, 13 Aug 2020 15:50:43 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2682A4051;
        Thu, 13 Aug 2020 15:50:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.217])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Aug 2020 15:50:42 +0000 (GMT)
Subject: Re: [PATCH v2 1/2] ext4: rename journal_dev to s_journal_dev inside
 ext4_sb_info
To:     brookxu <brookxu.cn@gmail.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
References: <561ad829-542a-2ed2-349f-62ff0ac7fa19@gmail.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 13 Aug 2020 21:20:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <561ad829-542a-2ed2-349f-62ff0ac7fa19@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200813155042.C2682A4051@d06av23.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_14:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130114
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 8/7/20 11:50 AM, brookxu wrote:
> Rename journal_dev to s_journal_dev inside ext4_sb_info, keep
> the naming rules consistent with other variables, which is
> convenient for code reading and writing.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

It seems the author email and Signed-off-by emails are different
and checkpatch complains. Highlighting for your FYI -

./scripts/checkpatch.pl 1.patch
WARNING: Missing Signed-off-by: line by nominal patch author 'brookxu 
<brookxu.cn@gmail.com>'

Other than that, threading ("--thread") on your patch series will help
add proper headers in the email so that it could be seen as threaded
emails.


Patch looks good to me. Please feel free to add,
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>


> ---
>   fs/ext4/ext4.h  |  2 +-
>   fs/ext4/fsmap.c |  8 ++++----
>   fs/ext4/super.c | 14 +++++++-------
>   3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 68e0ebe..8ca9adf 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1463,7 +1463,7 @@ struct ext4_sb_info {
>   	unsigned long s_commit_interval;
>   	u32 s_max_batch_time;
>   	u32 s_min_batch_time;
> -	struct block_device *journal_bdev;
> +	struct block_device *s_journal_bdev;
>   #ifdef CONFIG_QUOTA
>   	/* Names of quota files with journalled quota */
>   	char __rcu *s_qf_names[EXT4_MAXQUOTAS];
> diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
> index dbccf46..005c0ae 100644
> --- a/fs/ext4/fsmap.c
> +++ b/fs/ext4/fsmap.c
> @@ -571,8 +571,8 @@ static bool ext4_getfsmap_is_valid_device(struct super_block *sb,
>   	if (fm->fmr_device == 0 || fm->fmr_device == UINT_MAX ||
>   	    fm->fmr_device == new_encode_dev(sb->s_bdev->bd_dev))
>   		return true;
> -	if (EXT4_SB(sb)->journal_bdev &&
> -	    fm->fmr_device == new_encode_dev(EXT4_SB(sb)->journal_bdev->bd_dev))
> +	if (EXT4_SB(sb)->s_journal_bdev &&
> +	    fm->fmr_device == new_encode_dev(EXT4_SB(sb)->s_journal_bdev->bd_dev))
>   		return true;
>   	return false;
>   }
> @@ -642,9 +642,9 @@ int ext4_getfsmap(struct super_block *sb, struct ext4_fsmap_head *head,
>   	memset(handlers, 0, sizeof(handlers));
>   	handlers[0].gfd_dev = new_encode_dev(sb->s_bdev->bd_dev);
>   	handlers[0].gfd_fn = ext4_getfsmap_datadev;
> -	if (EXT4_SB(sb)->journal_bdev) {
> +	if (EXT4_SB(sb)->s_journal_bdev) {
>   		handlers[1].gfd_dev = new_encode_dev(
> -				EXT4_SB(sb)->journal_bdev->bd_dev);
> +				EXT4_SB(sb)->s_journal_bdev->bd_dev);
>   		handlers[1].gfd_fn = ext4_getfsmap_logdev;
>   	}
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 8ce61f3..f785aee7 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -935,10 +935,10 @@ static void ext4_blkdev_put(struct block_device *bdev)
>   static void ext4_blkdev_remove(struct ext4_sb_info *sbi)
>   {
>   	struct block_device *bdev;
> -	bdev = sbi->journal_bdev;
> +	bdev = sbi->s_journal_bdev;
>   	if (bdev) {
>   		ext4_blkdev_put(bdev);
> -		sbi->journal_bdev = NULL;
> +		sbi->s_journal_bdev = NULL;
>   	}
>   }
> 
> @@ -1069,14 +1069,14 @@ static void ext4_put_super(struct super_block *sb)
> 
>   	sync_blockdev(sb->s_bdev);
>   	invalidate_bdev(sb->s_bdev);
> -	if (sbi->journal_bdev && sbi->journal_bdev != sb->s_bdev) {
> +	if (sbi->s_journal_bdev && sbi->s_journal_bdev != sb->s_bdev) {
>   		/*
>   		 * Invalidate the journal device's buffers.  We don't want them
>   		 * floating about in memory - the physical journal device may
>   		 * hotswapped, and it breaks the `ro-after' testing code.
>   		 */
> -		sync_blockdev(sbi->journal_bdev);
> -		invalidate_bdev(sbi->journal_bdev);
> +		sync_blockdev(sbi->s_journal_bdev);
> +		invalidate_bdev(sbi->s_journal_bdev);
>   		ext4_blkdev_remove(sbi);
>   	}
> 
> @@ -3712,7 +3712,7 @@ int ext4_calculate_overhead(struct super_block *sb)
>   	 * Add the internal journal blocks whether the journal has been
>   	 * loaded or not
>   	 */
> -	if (sbi->s_journal && !sbi->journal_bdev)
> +	if (sbi->s_journal && !sbi->s_journal_bdev)
>   		overhead += EXT4_NUM_B2C(sbi, sbi->s_journal->j_maxlen);
>   	else if (ext4_has_feature_journal(sb) && !sbi->s_journal && j_inum) {
>   		/* j_inum for internal journal is non-zero */
> @@ -5057,7 +5057,7 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
>   			be32_to_cpu(journal->j_superblock->s_nr_users));
>   		goto out_journal;
>   	}
> -	EXT4_SB(sb)->journal_bdev = bdev;
> +	EXT4_SB(sb)->s_journal_bdev = bdev;
>   	ext4_init_journal_params(sb, journal);
>   	return journal;
> 
