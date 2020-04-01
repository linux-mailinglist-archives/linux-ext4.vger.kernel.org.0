Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 406C919AEA3
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Apr 2020 17:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbgDAPUs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Apr 2020 11:20:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54578 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732640AbgDAPUs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Apr 2020 11:20:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 031FJVI4011138;
        Wed, 1 Apr 2020 15:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=0wkSFGv6en52wWFSe07yb+PZwIeIvGqVaTSkYhMWwaE=;
 b=D1po6vE/SAPCIhj0HJXFNjCmnR3B0VjPZEPHaSb51H1W3fH31anBfwko9eQ6G4vdjp8c
 /vDsu+B7a01e2P6mdyqT2iXCjg3vB91NhFUfenzxMITfZlqZp73TLIH5B+KeqHVw2XiX
 AHPkpwP0Jqz2VxGr9Yw0JvmF2e1wVKcwOI1ojeQIdioP3SYTIkzPWJrjtsfTKGTRgC74
 ZuNVCBcV6ycvcEOQaqj6hGXUHU+9obnhEig8QYd8ZfMS2s3ZTKZq0abW5yj4oHV4P+LD
 J3Ewf7iN3dB+KEzcqlgHiIMLhFgaAJ1rfy2fLMeGgqREhNPjiAiLQ8LXqXKVzBFB1KXE Ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 303cev647b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 15:20:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 031FH64g042373;
        Wed, 1 Apr 2020 15:18:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 304sjkm4fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Apr 2020 15:18:36 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 031FIZXQ026762;
        Wed, 1 Apr 2020 15:18:36 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Apr 2020 08:18:35 -0700
Date:   Wed, 1 Apr 2020 08:18:37 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     David Howells <dhowells@redhat.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: Exporting ext4-specific information through fsinfo attributes
Message-ID: <20200401151837.GB56931@magnolia>
References: <2461554.1585726747@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2461554.1585726747@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxlogscore=782 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=844 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004010134
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 01, 2020 at 08:39:07AM +0100, David Howells wrote:
> Hi Ted,
> 
> Whilst we were at Vault, I asked you if there was any live ext4 information
> that it could be useful to export through fsinfo().  I've implemented a patch
> that exports six superblock timestamps:
> 
> 	FSINFO_ATTR_EXT4_TIMESTAMPS: 
> 		mkfs    : 2016-02-26 00:37:03
> 		mount   : 2020-03-31 21:57:30
> 		write   : 2020-03-31 21:57:28
> 		fsck    : 2018-12-17 23:32:45
> 		1st-err : -
> 		last-err: -
> 
> but is there anything else that could be of interest?

The entire superblock as a binary blob? :)

This way we can begin moving dumpe2fs/tune2fs away from reading the raw
disk on live filesystems.

(I'd make the same noises about xfs, but less urgently since we already
have ioctls for that purpose.)

--D

> 
> Thanks,
> David
> 
