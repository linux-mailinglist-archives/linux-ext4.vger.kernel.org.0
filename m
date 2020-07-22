Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBF0229B53
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jul 2020 17:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgGVP0B (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Jul 2020 11:26:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53630 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgGVP0B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Jul 2020 11:26:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06MFCru3122242;
        Wed, 22 Jul 2020 15:25:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=BRu3Cg5xeogQTwOico5xp16clc/vob3lraKB4iAU7X4=;
 b=LtX7DJ3EKZ6eGrwJ/YgcngZh5VQrz8u7ftO5AF00hRuKO0KevDouvuEAzd87TiBQVJjQ
 3cw5ubq++6YIbZJEQ+nPp5VoOAejU+WGx76E/3PjbBvSIkRJh/O9tER+VKXYZvBaj3Lf
 O9YfiWDA6VUt+8FOt5y0JPaJ/JOxzCQlt7FSsCTaWurIh+6eNhhcn93NwywWhdaHtXPr
 /OrJqYXsf1//Uo0VHrP40idYmRptLkXpak3bPufP1HO5rQLDNi/UA3I8XzO2G6UzYzbW
 /flJmsGWGe4ifuH+w2CdLXFGmZdi4k+fCWwcM67AZRXO+7TJFUWjJE/OPqIvf5USiflk kA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32brgrm1n2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jul 2020 15:25:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06MFD53G035515;
        Wed, 22 Jul 2020 15:25:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 32epbj02yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jul 2020 15:25:52 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06MFPpQv024042;
        Wed, 22 Jul 2020 15:25:51 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 22 Jul 2020 15:25:50 +0000
Date:   Wed, 22 Jul 2020 08:25:50 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: Exporting ext4-specific information through fsinfo attributes
Message-ID: <20200722152550.GA7625@magnolia>
References: <20200721154202.GD848607@magnolia>
 <20200401151837.GB56931@magnolia>
 <2461554.1585726747@warthog.procyon.org.uk>
 <2504712.1587485842@warthog.procyon.org.uk>
 <701163.1595407986@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <701163.1595407986@warthog.procyon.org.uk>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9690 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007220106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9690 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007220106
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 22, 2020 at 09:53:06AM +0100, David Howells wrote:
> Darrick J. Wong <darrick.wong@oracle.com> wrote:
> 
> > Where are these FSINFO_FEAT* constants defined, and where are they
> > documented?
> > 
> > This generally looks ok to me, but I would like to see documentation
> > first.
> 
> Have a look at this branch:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fsinfo-core
> 
> Patch "fsinfo: Provide a bitmap of supported features"
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=fsinfo-core&id=9d7651e966331f18c7bfe053237b3627585c3e79
> 
> Documentation:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=fsinfo-core&id=6bb357c42c96c2a5d72ff02d109ce49bd0c455ab

Ah, thank you.  The ext4 bits look ok to me.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

(Looking forward to whenever you get to xfs... :))

--D


> David
> 
