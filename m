Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7A8F0E10
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 06:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbfKFFEm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 00:04:42 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41316 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbfKFFEm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 00:04:42 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA654PZj118018;
        Wed, 6 Nov 2019 05:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=2HK6pjnUuS5rTt/+cPLmjPtErNSB/q0uYNS8dH3A+u4=;
 b=FUVkBoBshiVOroeu56JMzfNwEyfKWp5ivoOFU+azb5lZyANg4oW4ymlQwg0v9kQy53P8
 l5obj10dTFQj+25U9OsTQTnOw2cu3yHpxH9YDhnwFzgisvRINQonS8uVkLoWQtXWSwqq
 5jW9XhqM3XdVJajiFQSOSeRNA1Z4aoGUBTMdUO+C2KVdo4ZK0mB9Z3KttLNuZbMRpu55
 GL3YociZOfnnl9h52r/ZDA28fkaAD90/v39ArZOyE/CrBsrzUm8tvzYKIOqRwWJd9/xU
 Jea5rSBMwZWeVZC6343M385sdXIAWhURNPBcnpBD2XMAKS6nOtg3KDktPJYo1n9aJ0l2 TA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2w117u379g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 05:04:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xA654FDh073134;
        Wed, 6 Nov 2019 05:04:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2w35pq82sh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Nov 2019 05:04:21 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id xA653ao2011473;
        Wed, 6 Nov 2019 05:03:36 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Nov 2019 21:03:36 -0800
Date:   Tue, 5 Nov 2019 21:03:36 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>,
        "adilger.kernel" <adilger.kernel@dilger.ca>, tytso <tytso@mit.edu>,
        Jan Kara <jack@suse.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH v2] ext4: choose hardlimit when softlimit is larger than
 hardlimit in ext4_statfs_project()
Message-ID: <20191106050336.GD15203@magnolia>
References: <20191015102327.5333-1-cgxu519@mykernel.net>
 <20191015112523.GB29554@quack2.suse.cz>
 <16e3f00ed3d.da5d5acd1285.2289879597060795256@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16e3f00ed3d.da5d5acd1285.2289879597060795256@mykernel.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1911060053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9432 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1911060053
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 06, 2019 at 12:37:35PM +0800, Chengguang Xu wrote:
>  ---- 在 星期二, 2019-10-15 19:25:23 Jan Kara <jack@suse.cz> 撰写 ----
>  > On Tue 15-10-19 18:23:27, Chengguang Xu wrote:
>  > > Setting softlimit larger than hardlimit seems meaningless
>  > > for disk quota but currently it is allowed. In this case,
>  > > there may be a bit of comfusion for users when they run
>  > > df comamnd to directory which has project quota.
>  > > 
>  > > For example, we set 20M softlimit and 10M hardlimit of
>  > > block usage limit for project quota of test_dir(project id 123).
>  > > 
>  > > [root@hades mnt_ext4]# repquota -P -a
>  > > *** Report for project quotas on device /dev/loop0
>  > > Block grace time: 7days; Inode grace time: 7days
>  > >                         Block limits                File limits
>  > > Project         used    soft    hard  grace    used  soft  hard  grace
>  > > ----------------------------------------------------------------------
>  > >  0        --      13       0       0              2     0     0
>  > >  123      --   10237   20480   10240              5   200   100
>  > > 
>  > > The result of df command as below:
>  > > 
>  > > [root@hades mnt_ext4]# df -h test_dir
>  > > Filesystem      Size  Used Avail Use% Mounted on
>  > > /dev/loop0       20M   10M   10M  50% /home/cgxu/test/mnt_ext4
>  > > 
>  > > Even though it looks like there is another 10M free space to use,
>  > > if we write new data to diretory test_dir(inherit project id),
>  > > the write will fail with errno(-EDQUOT).
>  > > 
>  > > After this patch, the df result looks like below.
>  > > 
>  > > [root@hades mnt_ext4]# df -h test_dir
>  > > Filesystem      Size  Used Avail Use% Mounted on
>  > > /dev/loop0       10M   10M  3.0K 100% /home/cgxu/test/mnt_ext4
>  > > 
>  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>  > > ---
>  > > - Fix a bug in the limit setting logic.
>  > 
>  > Thanks for the patch! It looks good to me. You can add:
>  > 
>  > Reviewed-by: Jan Kara <jack@suse.cz>
>  > 
> 
> Hi Jan,
> 
> I have a proposal for another direction.
> Could we add a check for soft limit  in quota layer when setting the value?
> So that we could not bother with  specific file systems on statfs(). 

How do the other filesystems (e.g. xfs) behave if someone tries to set a
soft limit higher than the hard limit?

--D

> Thanks,
> Chengguang
> 
> 
