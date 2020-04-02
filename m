Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F52F19C5A2
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Apr 2020 17:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388902AbgDBPRb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Apr 2020 11:17:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47956 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388234AbgDBPRb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Apr 2020 11:17:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032F9jkN119222;
        Thu, 2 Apr 2020 15:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=b7LvnNRQelJJFiZAKAezXKPCgTvSHxhEiLDieWmH8+E=;
 b=AidubZHlYX/2Afhy8InsZ8KTKnf5BHlXBj7v+QxvyAuw+0tNRpcB/9nKONB0xTdu+wrS
 yK3VeDG366ia0jLv0rAqwmOKZzalWV/VsN/K7ROnMorGTCI9twEViBnX0umAvza17Xvp
 n2apCbTondHgZUanREpkeaDVd6HLij4FqjWF6WezfkrN1PcgdymMio0AtP69P1GkNOkU
 0QjqBsBCZE8qAbOWLfC318s78k79jTRgvF2P8DmLJ6O1BaW89EU07qKuNfB3K7OVaNuQ
 hFIJW4Vah1SPv0tFw1yce+oPWQchbRWgnrw3QGq4DjI1YxOiXKY8uy8ibGs0+vC+9wOK zA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 303yuneq2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 15:17:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 032F75Rc077878;
        Thu, 2 Apr 2020 15:17:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 302g2js5r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 15:17:24 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 032FHNrq027112;
        Thu, 2 Apr 2020 15:17:23 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 08:17:23 -0700
Date:   Thu, 2 Apr 2020 08:17:20 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>
Subject: Re: [PATCH] e2scrub: Remove PATH setting from the scripts
Message-ID: <20200402151720.GD56931@magnolia>
References: <20200402134716.3725-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402134716.3725-1-lczerner@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=928 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=29 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020131
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9579 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=993 bulkscore=0
 suspectscore=29 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020131
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 02, 2020 at 03:47:16PM +0200, Lukas Czerner wrote:
> We don't want to override system setting by changing the PATH. This
> should remain under administrator/user control.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Looks ok to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  scrub/e2scrub.in     | 2 --
>  scrub/e2scrub_all.in | 2 --
>  2 files changed, 4 deletions(-)
> 
> diff --git a/scrub/e2scrub.in b/scrub/e2scrub.in
> index 30ab7cbd..7c3f46e9 100644
> --- a/scrub/e2scrub.in
> +++ b/scrub/e2scrub.in
> @@ -23,8 +23,6 @@
>  # check filesystems in VGs that have at least 256MB (or so) of
>  # free space.
>  
> -PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
> -
>  if (( $EUID != 0 )); then
>      echo "e2scrub must be run as root"
>      exit 1
> diff --git a/scrub/e2scrub_all.in b/scrub/e2scrub_all.in
> index 4288b969..b6a7d0ad 100644
> --- a/scrub/e2scrub_all.in
> +++ b/scrub/e2scrub_all.in
> @@ -18,8 +18,6 @@
>  #  along with this program; if not, write the Free Software Foundation,
>  #  Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301, USA.
>  
> -PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
> -
>  if (( $EUID != 0 )); then
>      echo "e2scrub_all must be run as root"
>      exit 1
> -- 
> 2.21.1
> 
