Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EDD2EC5FC
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Jan 2021 23:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbhAFWGW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Jan 2021 17:06:22 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:60850 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbhAFWGW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Jan 2021 17:06:22 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 106Lndv7088304;
        Wed, 6 Jan 2021 22:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=LNAU9R7BpJbgIN7kU6nqkws5Viv7UweU0XHxDSB0NfY=;
 b=i/qo61QF6vrPoHly5I1TM8Gvtq3FvsNCFB5mWHsfmFemjyJqmWuWW0n6jluyWkQc/wb3
 IRE5EGzgCvmu6Gz6w/PBqHt7jNEjy6z/+LHB9+ZLpQAZhyjYzid9toNDFXn0vslu8DKR
 zhKAPmdQTX3nSec3Wz+2PnAqoGz6xYZeca1sfdp001EmhToyxjZ+EoiI5XMAF6LG8KQa
 4l5vtcnCQlrshRXbd089ZlZOuvQgxG8BQIrsfRRIQV0OEiVH5pgXsRN8Uk2EE8WllN5M
 xFC64k6vw3p8yP5zolicPDxNlgdhHLdD9oRHwhNP91k6TEg1nHigJ2z8UME2bWoglPSF 7g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 35wftx9nh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 06 Jan 2021 22:05:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 106LkSOw149123;
        Wed, 6 Jan 2021 22:05:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 35v4rd5ye3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jan 2021 22:05:29 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 106M5RE4008328;
        Wed, 6 Jan 2021 22:05:27 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Jan 2021 14:05:27 -0800
Date:   Wed, 6 Jan 2021 14:05:26 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Daejun Park <daejun7.park@samsung.com>
Cc:     "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "harshadshirwadkar@gmail.com" <harshadshirwadkar@gmail.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext4: Remove expensive flush on fast commit
Message-ID: <20210106220526.GH6908@magnolia>
References: <CGME20210106013242epcms2p5b6b4ed8ca86f29456fdf56aa580e74b4@epcms2p5>
 <20210106013242epcms2p5b6b4ed8ca86f29456fdf56aa580e74b4@epcms2p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106013242epcms2p5b6b4ed8ca86f29456fdf56aa580e74b4@epcms2p5>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9856 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9856 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060123
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 06, 2021 at 10:32:42AM +0900, Daejun Park wrote:
> In the fast commit, it adds REQ_FUA and REQ_PREFLUSH on each fast commit
> block when barrier is enabled. However, in recovery phase, ext4 compares
> CRC value in the tail. So it is sufficient adds REQ_FUA and REQ_PREFLUSH
> on the block that has tail.

Just out of curiosity, how does the new fastcommit code handle tests
like generic/475 that simulate sudden disk failure?

--D

> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> ---
>  fs/ext4/fast_commit.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 4fcc21c25e79..e66507be334c 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -604,13 +604,13 @@ void ext4_fc_track_range(handle_t *handle, struct inode *inode, ext4_lblk_t star
>  	trace_ext4_fc_track_range(inode, start, end, ret);
>  }
>  
> -static void ext4_fc_submit_bh(struct super_block *sb)
> +static void ext4_fc_submit_bh(struct super_block *sb, bool is_tail)
>  {
>  	int write_flags = REQ_SYNC;
>  	struct buffer_head *bh = EXT4_SB(sb)->s_fc_bh;
>  
> -	/* TODO: REQ_FUA | REQ_PREFLUSH is unnecessarily expensive. */
> -	if (test_opt(sb, BARRIER))
> +	/* Add REQ_FUA | REQ_PREFLUSH only its tail */
> +	if (test_opt(sb, BARRIER) && is_tail)
>  		write_flags |= REQ_FUA | REQ_PREFLUSH;
>  	lock_buffer(bh);
>  	set_buffer_dirty(bh);
> @@ -684,7 +684,7 @@ static u8 *ext4_fc_reserve_space(struct super_block *sb, int len, u32 *crc)
>  		*crc = ext4_chksum(sbi, *crc, tl, sizeof(*tl));
>  	if (pad_len > 0)
>  		ext4_fc_memzero(sb, tl + 1, pad_len, crc);
> -	ext4_fc_submit_bh(sb);
> +	ext4_fc_submit_bh(sb, false);
>  
>  	ret = jbd2_fc_get_buf(EXT4_SB(sb)->s_journal, &bh);
>  	if (ret)
> @@ -741,7 +741,7 @@ static int ext4_fc_write_tail(struct super_block *sb, u32 crc)
>  	tail.fc_crc = cpu_to_le32(crc);
>  	ext4_fc_memcpy(sb, dst, &tail.fc_crc, sizeof(tail.fc_crc), NULL);
>  
> -	ext4_fc_submit_bh(sb);
> +	ext4_fc_submit_bh(sb, true);
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 
