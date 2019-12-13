Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9162111EE98
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Dec 2019 00:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLMXiN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Dec 2019 18:38:13 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:48430 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfLMXiM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Dec 2019 18:38:12 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDN9PI3006183;
        Fri, 13 Dec 2019 23:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=w/tf+gg+lfu5p0/9cNSvdS5eGRE0SBFzZmRmYN93VCw=;
 b=I1NOAyepTda6ZuT0CG9l/cERj7GChzdZ9GnlksV0/mwgC/Juh0/3WaItZq76oUhniK/a
 0fcnMxH5hEe9ncGjD1zLDQJ2cw3z+h4tW7ed5Y4WZslpnGT647Tly85wl1lh/Ha922eY
 vLjStqZiI78d6fJQBrw/AsbpdBqYeKOBx3OqoZ1gO4FC3MkQo5XGQ9Y9lbGA746HthP1
 0d9NKrqiYjTSgRmSFM6F6Bwwdhgw6f09nljmcYo+a5IOicaG43sblt9nbTu8zzTKq+5Y
 G3CMeduhWkp8ZlmdWIQFMNojAdzEz4arzu0I5RtTnAbE9TXetUpzGIcLyeR8yO8eUxA6 pg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2wrw4nrnnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 23:38:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBDN9Oj8157069;
        Fri, 13 Dec 2019 23:37:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2wvdwrkxgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 23:37:59 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBDNbuJe012333;
        Fri, 13 Dec 2019 23:37:56 GMT
Received: from localhost (/10.145.178.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 13 Dec 2019 15:37:56 -0800
Date:   Fri, 13 Dec 2019 15:37:55 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>, jack@suse.com,
        linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca
Subject: Re: ext4 warnings: extent tree (at level 2) could be narrower.
Message-ID: <20191213233754.GA99863@magnolia>
References: <20191213230226.GA11066@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213230226.GA11066@duo.ucw.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=752
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912130165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9470 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=811 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912130165
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Dec 14, 2019 at 12:02:26AM +0100, Pavel Machek wrote:
> Hi!
> 
> Periodic fsck kicked in on x86-32 machine. I did partial update in the
> meantime, and was running various kernels including -next... Now I'm
> getting:
> 
> data: Inode 1840310 extent tree (at level 2) could be narrower. IGNORED.
> 
> on 5 inodes.  Is it harmless, or does it mean I was running buggy
> kernel in the past, or...?

That message means that e2fsck has found that the extent tree could be
smaller than it actually is; the lack of any other complaints about the
extent tree mean that it's ok.

The kernel cannot shrink the extent tree on its own (but e2fsck can), so
this message is where e2fsck would have applied that optimization.

IOWs: mostly harmless, but the kernel was (and still is) a bit deficient.

--D

> Best regards,
> 									Pavel
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


