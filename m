Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D80651AAC25
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Apr 2020 17:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414854AbgDOPoJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Apr 2020 11:44:09 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41032 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1414848AbgDOPn6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Apr 2020 11:43:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03FFcMEl136260;
        Wed, 15 Apr 2020 15:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=T2qh9cOheluulo7hvfZ4YsBJ5GAxA8MUkn2Kv6ICqh0=;
 b=K6STKOh98tcKA/zfe9qGKIyx+GIXBZPYNyeod78ba0bL6IqYHG4MihBrfFr9Rhx3vobm
 ynIcebD3EW834stQFtgNZtRK2lsI4rJ6PNuVbsV5kQsFFF9ZUEhKP46A3vd3OPv2Xd2r
 nrNSgEWYWlN4DI5HkGuLqAaO0cqs9soc8/X5duA0zaumKPnOVIKy4i4vjbpmW7Tn7ndO
 sT6GSSww9Z7q/oc1jgVmdToxPZdR29R1E0Lm+THSyHI8F7whxaxaPuPcaF5YYgP6s24p
 hg0xrmrwwBQTPjSlhpmpJDHNZaua1M/l0uYr7248KJLvbX0Nji7qQ97rBhmsuuNVmZVq mw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30dn95m6ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 15:43:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03FFdBhU076039;
        Wed, 15 Apr 2020 15:41:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30dyvf1sp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 15:41:49 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03FFfjx8015209;
        Wed, 15 Apr 2020 15:41:46 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Apr 2020 08:41:45 -0700
Date:   Wed, 15 Apr 2020 08:41:44 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        ira.weiny@intel.com
Subject: Re: [PATCH 12/34] docs: filesystems: convert dax.txt to ReST
Message-ID: <20200415154144.GA6733@magnolia>
References: <cover.1586960617.git.mchehab+huawei@kernel.org>
 <71b1f910b2c3569a9fdaa8778378dd734f4f0091.1586960617.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71b1f910b2c3569a9fdaa8778378dd734f4f0091.1586960617.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004150115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150115
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

[add ira weiny to cc]

On Wed, Apr 15, 2020 at 04:32:25PM +0200, Mauro Carvalho Chehab wrote:
> - Add a SPDX header;
> - Adjust document title;
> - Some whitespace fixes and new line breaks;
> - Add it to filesystems/index.rst.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/admin-guide/ext4.rst             | 2 +-
>  Documentation/filesystems/{dax.txt => dax.rst} | 9 +++++++--
>  Documentation/filesystems/ext2.rst             | 2 +-
>  Documentation/filesystems/index.rst            | 1 +
>  4 files changed, 10 insertions(+), 4 deletions(-)
>  rename Documentation/filesystems/{dax.txt => dax.rst} (97%)
> 
> diff --git a/Documentation/admin-guide/ext4.rst b/Documentation/admin-guide/ext4.rst
> index 9443fcef1876..103bcc345bad 100644
> --- a/Documentation/admin-guide/ext4.rst
> +++ b/Documentation/admin-guide/ext4.rst
> @@ -392,7 +392,7 @@ When mounting an ext4 filesystem, the following option are accepted:
>  
>    dax
>          Use direct access (no page cache).  See
> -        Documentation/filesystems/dax.txt.  Note that this option is
> +        Documentation/filesystems/dax.rst.  Note that this option is
>          incompatible with data=journal.
>  
>  Data Mode
> diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.rst
> similarity index 97%
> rename from Documentation/filesystems/dax.txt
> rename to Documentation/filesystems/dax.rst
> index 735f3859b19f..5838144f80f0 100644
> --- a/Documentation/filesystems/dax.txt
> +++ b/Documentation/filesystems/dax.rst

Err, this will collide with the work that Ira's doing on DAX for 5.8[1].
Can the dax.txt conversion wait?

--D

[1] https://lore.kernel.org/linux-xfs/20200415152942.GS6742@magnolia/T/#m804562299416d865d8829caa82589a522b2080a5

> @@ -1,5 +1,8 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================
>  Direct Access for files
> ------------------------
> +=======================
>  
>  Motivation
>  ----------
> @@ -46,6 +49,7 @@ stall the CPU for an extended period, you should also not attempt to
>  implement direct_access.
>  
>  These block devices may be used for inspiration:
> +
>  - brd: RAM backed block device driver
>  - dcssblk: s390 dcss block device driver
>  - pmem: NVDIMM persistent memory driver
> @@ -55,6 +59,7 @@ Implementation Tips for Filesystem Writers
>  ------------------------------------------
>  
>  Filesystem support consists of
> +
>  - adding support to mark inodes as being DAX by setting the S_DAX flag in
>    i_flags
>  - implementing ->read_iter and ->write_iter operations which use dax_iomap_rw()
> @@ -127,6 +132,6 @@ by adding optional struct page support for pages under the control of
>  the driver (see CONFIG_NVDIMM_PFN in drivers/nvdimm for an example of
>  how to do this). In the non struct page cases O_DIRECT reads/writes to
>  those memory ranges from a non-DAX file will fail (note that O_DIRECT
> -reads/writes _of a DAX file_ do work, it is the memory that is being
> +reads/writes _of a DAX ``file_`` do work, it is the memory that is being
>  accessed that is key here).  Other things that will not work in the
>  non struct page case include RDMA, sendfile() and splice().
> diff --git a/Documentation/filesystems/ext2.rst b/Documentation/filesystems/ext2.rst
> index d83dbbb162e2..fa416b7a5802 100644
> --- a/Documentation/filesystems/ext2.rst
> +++ b/Documentation/filesystems/ext2.rst
> @@ -24,7 +24,7 @@ check=none, nocheck	(*)	Don't do extra checking of bitmaps on mount
>  				(check=normal and check=strict options removed)
>  
>  dax				Use direct access (no page cache).  See
> -				Documentation/filesystems/dax.txt.
> +				Documentation/filesystems/dax.rst.
>  
>  debug				Extra debugging information is sent to the
>  				kernel syslog.  Useful for developers.
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index c4f95f76ba6a..8e3ccb4ed483 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -24,6 +24,7 @@ algorithms work.
>     splice
>     locking
>     directory-locking
> +   dax
>  
>     automount-support
>  
> -- 
> 2.25.2
> 
