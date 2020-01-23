Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACB9F14722D
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2020 20:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgAWT42 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Jan 2020 14:56:28 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58320 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAWT42 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Jan 2020 14:56:28 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NJoYPh193302;
        Thu, 23 Jan 2020 19:55:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=MnL551nh+up1IIBRHpE2UvztGl+8xKjewu7+Zj2xl4k=;
 b=pfzgJ4NzW9JJT83B49Nu7oiW4Db+V58pV58ixfRnDZ79Aq/M/717YthrPUbl5TMpE4ta
 VcsxQXskB9b9EPpyZmt63fRcWFfDg1+X99aaAFoWfs5Y5FfGEbAbLrxXPL41KEdMjUqg
 Q1+ORchiul7ue4le58BIsgMU1X+2KgBtK8KcJD0SdJ40qLFRnUp+thAI6v5L62QeJzwZ
 iQQY18q0wYLlvMb7l/NTgAHspeKR2nsqIXJkt/kf8s/rPpdw26Q5vFOb/DP+BOglnX8s
 braVORI60vgW6JKR57qfefCsdrv3sNosIJWz3EHOkBbLu9aPmpeTSSHXnhpNC1Cgw3sF tg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2xktnrmhaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 19:55:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00NJob9C170263;
        Thu, 23 Jan 2020 19:55:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2xpq7ngvbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jan 2020 19:55:38 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00NJtYxE032271;
        Thu, 23 Jan 2020 19:55:34 GMT
Received: from localhost (/10.145.179.16)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 23 Jan 2020 11:55:34 -0800
Date:   Thu, 23 Jan 2020 11:55:31 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Jan Kara <jack@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Paul Mackerras <paulus@samba.org>, linux-ppp@vger.kernel.org,
        reiserfs-devel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] Documentation: changes.rst: update several outdated
 project URLs
Message-ID: <20200123195531.GW8247@magnolia>
References: <efb1f518-9e66-c472-d124-4b7d91e56639@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efb1f518-9e66-c472-d124-4b7d91e56639@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001230146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9509 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001230146
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 23, 2020 at 11:00:12AM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Update projects URLs in the changes.rst file.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Jan Kara <jack@suse.com>
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Cc: linux-ext4@vger.kernel.org
> Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
> Cc: Florian Westphal <fw@strlen.de>
> Cc: netfilter-devel@vger.kernel.org
> Cc: coreteam@netfilter.org
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linux-ppp@vger.kernel.org
> Cc: Jan Kara <jack@suse.com>
> Cc: reiserfs-devel@vger.kernel.org
> Cc: Darrick J. Wong <darrick.wong@oracle.com>
> Cc: linux-xfs@vger.kernel.org
> ---
> 
>  Documentation/process/changes.rst                    |   12 ++++++----
>  Documentation/translations/it_IT/process/changes.rst |   12 ++++++----
>  2 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff -Naurp linux-next-20200123/Documentation/translations/it_IT/process/changes.rst%WWW linux-next-20200123/Documentation/translations/it_IT/process/changes.rst
> --- linux-next-20200123/Documentation/translations/it_IT/process/changes.rst%WWW	2019-11-24 16:32:01.000000000 -0800
> +++ linux-next-20200123/Documentation/translations/it_IT/process/changes.rst	2020-01-23 10:47:56.226457425 -0800
> @@ -391,6 +391,8 @@ E2fsprogs
>  ---------
>  
>  - <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.29.tar.gz>
> +- <https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/>
> +- <https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/>
>  
>  JFSutils
>  --------
> @@ -400,12 +402,12 @@ JFSutils
>  Reiserfsprogs
>  -------------
>  
> -- <http://www.kernel.org/pub/linux/utils/fs/reiserfs/>
> +- <https://git.kernel.org/pub/scm/linux/kernel/git/jeffm/reiserfsprogs.git/>
>  
>  Xfsprogs
>  --------
>  
> -- <ftp://oss.sgi.com/projects/xfs/>
> +- <https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git>

Can we add a link to the release tarballs too?

https://www.kernel.org/pub/linux/utils/fs/xfs/xfsprogs/

With that amended,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

>  
>  Pcmciautils
>  -----------
> @@ -444,7 +446,9 @@ Rete
>  PPP
>  ---
>  
> -- <ftp://ftp.samba.org/pub/ppp/>
> +- <https://download.samba.org/pub/ppp/>
> +- <https://git.ozlabs.org/?p=ppp.git>
> +- <https://github.com/paulusmack/ppp/>
>  
>  
>  NFS-utils
> @@ -455,7 +459,7 @@ NFS-utils
>  Iptables
>  --------
>  
> -- <http://www.iptables.org/downloads.html>
> +- <https://netfilter.org/projects/iptables/index.html>
>  
>  Ip-route2
>  ---------
> diff -Naurp linux-next-20200123/Documentation/process/changes.rst%WWW linux-next-20200123/Documentation/process/changes.rst
> --- linux-next-20200123/Documentation/process/changes.rst%WWW	2019-11-24 16:32:01.000000000 -0800
> +++ linux-next-20200123/Documentation/process/changes.rst	2020-01-23 10:47:56.226457425 -0800
> @@ -384,6 +384,8 @@ E2fsprogs
>  ---------
>  
>  - <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.29.tar.gz>
> +- <https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/>
> +- <https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/>
>  
>  JFSutils
>  --------
> @@ -393,12 +395,12 @@ JFSutils
>  Reiserfsprogs
>  -------------
>  
> -- <http://www.kernel.org/pub/linux/utils/fs/reiserfs/>
> +- <https://git.kernel.org/pub/scm/linux/kernel/git/jeffm/reiserfsprogs.git/>
>  
>  Xfsprogs
>  --------
>  
> -- <ftp://oss.sgi.com/projects/xfs/>
> +- <https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git>
>  
>  Pcmciautils
>  -----------
> @@ -437,7 +439,9 @@ Networking
>  PPP
>  ---
>  
> -- <ftp://ftp.samba.org/pub/ppp/>
> +- <https://download.samba.org/pub/ppp/>
> +- <https://git.ozlabs.org/?p=ppp.git>
> +- <https://github.com/paulusmack/ppp/>
>  
>  NFS-utils
>  ---------
> @@ -447,7 +451,7 @@ NFS-utils
>  Iptables
>  --------
>  
> -- <http://www.iptables.org/downloads.html>
> +- <https://netfilter.org/projects/iptables/index.html>
>  
>  Ip-route2
>  ---------
> 
> 
