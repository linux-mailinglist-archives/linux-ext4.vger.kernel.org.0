Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E536377F0
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jun 2019 17:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfFFPan (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Jun 2019 11:30:43 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47508 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbfFFPam (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Jun 2019 11:30:42 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56FSllQ173914;
        Thu, 6 Jun 2019 15:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=F9Pe8iiITRC+INv7Pb3oZ7h6kOB6KWbAP6291TG+Zps=;
 b=woOcfrQufGMFhDFP1y2RTDa8qUN6eNckHuSAFHtdE26srtOt4qwqJPE//u5Pe/aQ7fXU
 bkobW/2YdeqgCFqkeX2bu74Ebm9h14iWXDCWVA9No3CqnPeaYRHM1RFpdUGfnLBo0Zkk
 Pnp7OgOVY4gpO9KBEyWkfSlGz7Ym8DNL5+WKIGG1hbVuA9N110w9x8hY8m/KKPM+6MZu
 QQMR+zsS64u8AQB+Xf6oogPTnDXzIS0p6F3+IBDC0pz47ReV33SX4HW83RiGjrjb9sJm
 9oK/sL9/Qj1elqbpYh8a6fzRHeWKph10G7AgtIEgthb7919AMfjJ9gpHOVe2ay9sZ6Wf AQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2suevdsfxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 15:30:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x56FT4ex139851;
        Thu, 6 Jun 2019 15:30:25 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2swngmjmnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jun 2019 15:30:25 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x56FUOAI023747;
        Thu, 6 Jun 2019 15:30:24 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 06 Jun 2019 08:30:24 -0700
Date:   Thu, 6 Jun 2019 08:30:21 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH 1/2] ext4: only set project inherit bit for directory
Message-ID: <20190606153021.GA1700170@magnolia>
References: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906060105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906060106
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 06, 2019 at 01:32:24PM +0900, Wang Shilong wrote:
> From: Wang Shilong <wshilong@ddn.com>
> 
> It doesn't make any sense to have project inherit bits
> for regular files, even though this won't cause any
> problem, but it is better fix this.
> 
> Cc: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>

It's good to be maintaining consistent behavior with XFS.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

(applies to both ext4 & f2fs patches)

--D

> ---
>  fs/ext4/ext4.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 1cb67859e051..ceb74093e138 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -421,7 +421,8 @@ struct flex_groups {
>  			   EXT4_PROJINHERIT_FL | EXT4_CASEFOLD_FL)
>  
>  /* Flags that are appropriate for regular files (all but dir-specific ones). */
> -#define EXT4_REG_FLMASK (~(EXT4_DIRSYNC_FL | EXT4_TOPDIR_FL | EXT4_CASEFOLD_FL))
> +#define EXT4_REG_FLMASK (~(EXT4_DIRSYNC_FL | EXT4_TOPDIR_FL | EXT4_CASEFOLD_FL |\
> +			   EXT4_PROJINHERIT_FL))
>  
>  /* Flags that are appropriate for non-directories/regular files. */
>  #define EXT4_OTHER_FLMASK (EXT4_NODUMP_FL | EXT4_NOATIME_FL)
> -- 
> 2.21.0
> 
