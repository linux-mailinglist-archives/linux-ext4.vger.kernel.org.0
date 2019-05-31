Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88EE33117D
	for <lists+linux-ext4@lfdr.de>; Fri, 31 May 2019 17:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfEaPoG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 31 May 2019 11:44:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38016 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfEaPoG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 31 May 2019 11:44:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4VFYFpv165229;
        Fri, 31 May 2019 15:43:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=icO+AdpyViaYYmcr8t35qWYiSITxensnQBW5adiYkm4=;
 b=YgbedsZqkrHsK4MerE7P5H5GnQ1wyjjcaHkqF6P2eHflPXSeEmOofKD6uBpH/BBuOLEc
 upt98oSUGlNoPdwrrd2g3Vx6BSY3vBRfRuyQqJI4KnMbGvrGamuINufD2rIOYvpKA/qi
 Cei6VAXPNmJTK7JChusODh8Y6JnZsXLsW3wV79HVwtboZXRZ+k/5oYQS0jMxdFTMM0ff
 bcdi6wEqqjzVjnq2FsEYYwhaS+3604vDiI5E+oVzRTCUxGORGPSdMv0t9Vu87YGtop6j
 FLsUuLjDanGktVryxUA78TZO0AWjWdZu6IFa6dN1BSYsN+B6pORLnIV7oVql6bFBhMz8 Sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2spw4ty6h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 15:43:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4VFhWQi073255;
        Fri, 31 May 2019 15:43:33 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ss1fpq7s4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 May 2019 15:43:33 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4VFhVmX014984;
        Fri, 31 May 2019 15:43:31 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 31 May 2019 08:43:31 -0700
Date:   Fri, 31 May 2019 08:43:30 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Lukas Czerner <lczerner@redhat.com>,
        linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>
Subject: Re: How to package e2scrub
Message-ID: <20190531154330.GA5378@magnolia>
References: <20190529120603.xuet53xgs6ahfvpl@work>
 <20190529235948.GB3671@mit.edu>
 <20190530095907.GA29237@quack2.suse.cz>
 <20190530135155.GD2751@mit.edu>
 <20190531100713.GA14773@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531100713.GA14773@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905310098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9273 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905310097
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, May 31, 2019 at 12:07:13PM +0200, Jan Kara wrote:
> On Thu 30-05-19 09:51:55, Theodore Ts'o wrote:
> > On Thu, May 30, 2019 at 11:59:07AM +0200, Jan Kara wrote:
> > > Yeah, my plan is to just not package cron bits at all since openSUSE / SLES
> > > support only systemd init anyway these days (and in fact our distro people
> > > want to deprecate cron in favor of systemd). I guess I'll split off the
> > > scrub bits into a separate sub-package (likely e2fsprogs will suggest
> > > installation of this sub-package) and the service will be disabled by
> > > default.
> > 
> > I'm not super-fond of extra sub-packages for their own sake, and the
> > extra e2scrub bits are small enough (about 32k?) that I don't believe
> > it justifies an extra sub-package; but that's a distribution-level
> > packaging decision, so it's certainly fine if we're not completely aligned.
> 
> Yes, size is not a big concern but the scrub bits require util-linux, lvm,
> and mailer to work correctly and I don't want to add these dependencies to
> stock e2fsprogs package because some minimal installations do not want e.g.
> lvm at all. Granted these are just scripts so I could get away with not
> requiring e.g. lvm at all but it seems user-unfriendly to leave it up to
> user to determine that his systemd-service fails due to missing packages.

All good reasons for a separate package, particularly considering that
on the RH side they've split out xfs_scrub because of its python 3
dependencies.

> > Out of curiosity, were any of the complaints that you've heard gone
> > beyond people who ran into the various e2scrub/e2scrub_all bugs?  I'm
> > curious what their concerns were.
> 
> I didn't hear any complaints so far. But I have my doubts anyone actually
> run that code so far - openSUSE Tumbleweed has limited userbase, we do
> installs to btrfs by default, we don't propose LVM by default, and I didn't
> enable the service files to run by default.

(I suspect it's only Debian Unstable users who are running it right
now...)

--D

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
