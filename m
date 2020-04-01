Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC7BC19B635
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Apr 2020 21:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732208AbgDATII (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Apr 2020 15:08:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45828 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgDATIH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Apr 2020 15:08:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 031J7bgJ073100;
        Wed, 1 Apr 2020 19:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=SiHoAK4L0hFFZifisc4oRg1bwR7m0yS+ePfM2B7UWtg=;
 b=Howkrcm43KHi6VFOJstj2/HM7PLchHqCKnOwVz4W6sy+ESQ+Q+Pi0crz1MFG6SBKC7Qv
 BATicL6zpKU0PdWBV1B6cV8V591Lsgk9m+PErzEoUxnZXfO/MEGp3p1UetSy/OTM+lVA
 e8O8nJbOc1brgk4mFOpVc1rRCcj6z3ntrLxRjhP0alnTNi9SswzWGuBYmpYKvNbNfRCo
 ovqKhyujvxN0OrPBZ1qdEf47pPCKWSRUtayAsIBTrfTmkzS56+wXpZi2VTnWotDVbqmo
 mA0QvjC68+jVBEGSmVJHv9d9TeU/MNNke/6zA0eLWMUzJySsp0x+Ggh3uNsV8kjHFDSX wQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 303yun9x6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 19:07:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 031J24Oi124294;
        Wed, 1 Apr 2020 19:05:57 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 302ga1118a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 19:05:57 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 031J5sXR012257;
        Wed, 1 Apr 2020 19:05:54 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Apr 2020 12:05:54 -0700
Date:   Wed, 1 Apr 2020 12:05:53 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     David Howells <dhowells@redhat.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: Exporting ext4-specific information through fsinfo attributes
Message-ID: <20200401190553.GC56931@magnolia>
References: <2461554.1585726747@warthog.procyon.org.uk>
 <20200401162744.GB201933@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401162744.GB201933@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=966 bulkscore=0 mlxscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010156
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 01, 2020 at 09:27:44AM -0700, Eric Biggers wrote:
> On Wed, Apr 01, 2020 at 08:39:07AM +0100, David Howells wrote:
> > Hi Ted,
> > 
> > Whilst we were at Vault, I asked you if there was any live ext4 information
> > that it could be useful to export through fsinfo().  I've implemented a patch
> > that exports six superblock timestamps:
> > 
> > 	FSINFO_ATTR_EXT4_TIMESTAMPS: 
> > 		mkfs    : 2016-02-26 00:37:03
> > 		mount   : 2020-03-31 21:57:30
> > 		write   : 2020-03-31 21:57:28
> > 		fsck    : 2018-12-17 23:32:45
> > 		1st-err : -
> > 		last-err: -
> > 
> > but is there anything else that could be of interest?
> > 
> > Thanks,
> > David
> > 
> 
> FWIW, the filesystem UUID would be useful for testing ext4 and f2fs encryption
> (since it's now sometimes used in the derivation of encryption keys).  But I see
> you already included it as FSINFO_ATTR_VOLUME_UUID.

It is??  What happens if you tune2fs -U if csum_seed isn't enabled?

--D

> 
> - Eric
