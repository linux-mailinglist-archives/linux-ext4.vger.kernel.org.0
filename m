Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C996486F5C
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 03:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405167AbfHIBb2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Aug 2019 21:31:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57892 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732796AbfHIBb2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Aug 2019 21:31:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x791Sw3s013874;
        Fri, 9 Aug 2019 01:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=hPVSpA8g72KdoIKpyeBaTutMNPniNhafljipnDqtxtk=;
 b=SsTSodQl5wnAmJ7e4J63a239yWLmN7bR7+ez3z0tuQogRqiYRercWHCUNkE8X3zLuuv5
 o6KeSMj5sS+Bk4pwQG3nSBQ2JNM3qNox5bds7hSavK1iOqk5dbKcBvEdHsyfHM1rRbRM
 1fj2Xoi7xVN6fmgSV9BIKtmbvyZG7t3bVFLwLmR43SAWUxDkTa+fyigGkjFDOfzDQ8np
 PQxIOnskqv0m7HbSURWK4xzuqDAL2wOJT7whPd6LuffzFbR4U/9uwcNihHu+U3m41KbS
 t8DGpnM/n0cDeWdgxGwC2XyJAXWwqJc83ziJbpDdZBOgZutL2/iyY9LaN0C/a8hPF282 Hw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=hPVSpA8g72KdoIKpyeBaTutMNPniNhafljipnDqtxtk=;
 b=gVh1xkQiJ3hI0YqMR9gxeaKi6qpbIrTNOca/3MGdUUpXTCuu4IaQNAQQy7QdaVXng0ld
 e4M3Nfj5/GeAy6TySNWp8iDLu1APwLS2uA9IlJlx9Ry9K8jEIjQ/fdM9vzPLy0ppcCAv
 /SJ8U7narMir0hWOtHmXoR7TsIHbrTCeelzFgaSYfZrzrpyru8sYCTZK5QKgfA5aFcfj
 MNlZKXgCyjLR/YOg6NrFowK02Qz1EnFuwYAboZAZiCgU9Mttqb8m4hsE777t/mX6qvnj
 r5fdhj9/2V7Jly4wBAZ/uEV4TIKn6eA2PrJM5pbk7UE1Kxazo55tRaI0o6mLmzy3bQ3w EQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2u8hps4cgc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Aug 2019 01:31:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x791SMh3140961;
        Fri, 9 Aug 2019 01:31:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2u8x9f129e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Aug 2019 01:31:23 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x791VL9a001422;
        Fri, 9 Aug 2019 01:31:22 GMT
Received: from localhost (/10.145.178.70)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Aug 2019 18:00:59 -0700
Date:   Thu, 8 Aug 2019 18:00:58 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-ext4@vger.kernel.org,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: mke2fs accepts block size not mentioned in its man page
Message-ID: <20190809010058.GA7125@magnolia>
References: <ce9edecb-6f04-77d3-32f1-2b9de6cd3d7e@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce9edecb-6f04-77d3-32f1-2b9de6cd3d7e@gmx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9343 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908090014
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9343 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908090014
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 05, 2019 at 01:35:02PM +0800, Qu Wenruo wrote:
> Hi,
> 
> Just doing some tests on aarch64 with 64K page size.
> 
> Man page of mke2fs only mentions 3 valid block size: 1k, 2k, 4k.
> But in real world, we can pass 64K as block size for it without any problem:
> 
>   $mke2fs -F -t ext3 -b 65536 /dev/loop1
>   Warning: blocksize 65536 not usable on most systems.
>   mke2fs 1.45.2 (27-May-2019)
>   /dev/loop1 contains a btrfs file system
>   Discarding device blocks: done
>   Creating filesystem with 81920 64k blocks and 81920 inodes
>   Filesystem UUID: 311bb224-6d2d-44a7-9790-92c4878d6549
>   [...]
> 
> It's great to see mke2fs accepts 64K as nodesize, which allows
> btrfs-convert to work.
> (If blocksize is default to 4K or doesn't accept 64K page size,
> btrfs-convert can work but can't be mounted on system with 64K page size)
> 
> Shouldn't the man page mention all valid values?

You'd think so, but 64k blocks only works on machines with 64k pages,
so that's why it doesn't mention anything beyond the lowest common
denominator. :/

--D

> Thanks,
> Qu
> 



