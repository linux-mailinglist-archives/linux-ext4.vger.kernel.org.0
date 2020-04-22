Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16F11B49F0
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Apr 2020 18:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgDVQM5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Apr 2020 12:12:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56592 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgDVQMz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Apr 2020 12:12:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03MGCTIT145533;
        Wed, 22 Apr 2020 16:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=8C3MGk0l1QMotLfF3nDA+NwuR6y/7otfahW/v8eSNzU=;
 b=uHnHP+P2bGlk+tuv09I0lMDmOp8lTD5GZCwZIr/bHPDfvrQBoZrPW2i/E6a6Jk8L1QTO
 ZAyr26nRo8tLIkeUaAkGz4RQTyC/2VkYd+sQmX1qTD9+v8/CCq3OGoMecKrRTbqYqYQE
 8AZm3dNo14j85QNLaxcT5pi7eQMpKiXHGHSmNv6Lam2M3ppmFMYOWMNgqrf1Z9lIOZsk
 DLqqOYfnM017DoxaMmyMjUUen7o87AT2Lm9KMwf6vIN/KscKBKgvDfhG1hGOiXxomon/
 hPu14G8vG01QIW7i52sKMjQQPY+08wAD/BVc1gl0ynZnPolvaHrmwzOCKNSwY1yq6PeC rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 30grpgr9tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 16:12:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03MGCIbJ187873;
        Wed, 22 Apr 2020 16:12:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 30gb1jvq8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 16:12:46 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03MGChTT031953;
        Wed, 22 Apr 2020 16:12:43 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Apr 2020 09:12:43 -0700
Date:   Wed, 22 Apr 2020 09:12:42 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: Exporting ext4-specific information through fsinfo attributes
Message-ID: <20200422161242.GD6733@magnolia>
References: <20200401151837.GB56931@magnolia>
 <2461554.1585726747@warthog.procyon.org.uk>
 <2504712.1587485842@warthog.procyon.org.uk>
 <BFC9114B-7D3D-4B8F-A8BB-75C2770EE36D@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BFC9114B-7D3D-4B8F-A8BB-75C2770EE36D@dilger.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004220123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004220123
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 21, 2020 at 04:07:43PM -0600, Andreas Dilger wrote:
> On Apr 21, 2020, at 10:17 AM, David Howells <dhowells@redhat.com> wrote:
> > 
> > Darrick J. Wong <darrick.wong@oracle.com> wrote:
> > 
> >> The entire superblock as a binary blob? :)
> > 
> > How about the attached?  Please forgive the duplication of struct
> > ext4_super_block into the test program, but it's not in the UAPI.
> 
> I think (hope?) Darrick was joking?

<cough> 80% joking.  It /was/ April 1st, after all. :)

Ted has said on a few occasions that one of the big stumbling blocks to
making tune2fs safe wrt mounted ext4 is that there's no way to get or
set superblock fields in a way that's kernel-mediated, and maybe the
easiest way is to export the superblock instead of playing this game
with synchronous sb writes from the kernel and the strange
mask-and-write behavior that tune2fs does.

I'm not convinced that's the best way to do that, though at least for
/reading/ the superblock I guess it beats defining a whole new structure
and ioctl.

> At least IMHO, exporting the whole superblock as a binary blob is not
> a great user interface.  I guess it has the benefit of allowing access
> to various non-standard fields without accessing the device directly.
> Kind of like SCSI mode pages, but that can get ugly quickly...
> 
> I can definitely get behind adding generic properties like the ones
> you list below.

The other properties look fine (in principle) to me though. :)

--D

> > 
> > David
> > ---
> > fsinfo: Add support to ext4
> > 
> > Add support to ext4, including the following:
> > 
> > (1) FSINFO_ATTR_SUPPORTS: Information about supported STATX attributes and
> >     support for ioctls like FS_IOC_[GS]ETFLAGS and FS_IOC_FS[GS]ETXATTR.
> > 
> > (2) FSINFO_ATTR_FEATURES: Information about features supported by an ext4
> >     filesystem, such as whether version counting, birth time and name case
> >     folding are in operation.
> > 
> > (3) FSINFO_ATTR_VOLUME_NAME: The volume name from the superblock.
> > 
> > (4) FSINFO_ATTR_EXT4_SUPERBLOCK: The entirety of the on disk-format
> >     superblock record as an opaque blob.
> > 
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: "Theodore Ts'o" <tytso@mit.edu>
> > cc: Andreas Dilger <adilger.kernel@dilger.ca>
> > cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> > cc: Eric Biggers <ebiggers@kernel.org>
> > cc: linux-ext4@vger.kernel.org
> 
> Cheers, Andreas
> 
> 
> 
> 
> 


