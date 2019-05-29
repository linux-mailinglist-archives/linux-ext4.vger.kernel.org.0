Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55C7B2E457
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2019 20:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfE2SWL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 May 2019 14:22:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49098 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2SWL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 May 2019 14:22:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TIIfH8039102;
        Wed, 29 May 2019 18:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=oyzX8wcX3RU2yRhTpw2cECz2ywhxsINBgbyEYDolhXM=;
 b=eUTqjKnW9k1yBMd6C0j1ZWME3jV+/EaVmtsM/3/eB6RqKTrJY8NURREYmtJKj9tp3ZZY
 9f4TMRO/mZidJ9QM2tsDfodD5lfu05XNMPQ34wPXmruMQLqT/nDHQPq5tjUszPm08/kV
 rTxKmlkq6wic19cOuunfohEc1ARsSk/DTHDNIszZlCtcmfKyuEGRMPvEC0USfZSKmP2u
 A1PxyZHN693SZM+Jc6h88uVh11Q56O3WZjXgdce7upNBzK2MpXftb0zTGaLgk4aP1SDi
 PtAU3CJA4ydhLpwQug9Uhec03TQcHaDUTUCBGYL9uU+jw09d55oixqFbpjHKAAIHPvmn 0Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2spw4tkr2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 18:21:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4TIKQAt009962;
        Wed, 29 May 2019 18:21:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2sqh73vbj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 18:21:15 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4TILDFF009388;
        Wed, 29 May 2019 18:21:14 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 11:21:13 -0700
Date:   Wed, 29 May 2019 11:21:11 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>, xfs <linux-xfs@vger.kernel.org>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: How to package e2scrub
Message-ID: <20190529182111.GA5220@magnolia>
References: <20190529120603.xuet53xgs6ahfvpl@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529120603.xuet53xgs6ahfvpl@work>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905290118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905290118
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 29, 2019 at 02:06:03PM +0200, Lukas Czerner wrote:
> Hi guys,
> 
> I am about to release 1.45.2 for Fedora rawhide, but I was thinking
> about how to package the e2scrub cron job/systemd service.

Funny, xfs has the same conundrum.  Adding Eric & xfs list to cc...

> I really do not like the idea of installing cron job and/or the service as
> a part of regular e2fsprogs package. This can potentially really surprise
> people in a bad way.
>
> Note that I've already heard some complaints from debian users about the
> systemd service being installed on their system after the e2fsprogs
> update.

Yeah, e2scrub is bitrotting rather faster than I had thought it
would... but it's only available in Debian unstable.

> What I am going to do is to split the systemd service into a separate
> package and I'd like to come to some agreement about the name of the
> package so that we can have the same name across distributions (at least
> Fedora/Debian/Suse).

Indeed.  Eric picked "xfsprogs-xfs_scrub" for Rawhide, though I find
that name to be very clunky and would have preferred "xfs_scrub".

> I was thinking about e2scrub-service for systemd service or e2scrub-cron
> for the cron job. What do you think ?

In /theory/ the cronjob support in e2scrub (and xfs_scrub) were designed
to step out of the way if systemd is running, so at least in theory (on
Debian anyway) the two can be in the same package with the end result
being that e2scrub runs weekly in the background.  I've not tried in
rhel/suse environments, however.

I also don't see the point of supporting cron *while* systemd is active.
That increases the amount of corner-case testing we have to do, for
little gain.  It's enough work to maintain the systemd-with-timers and
sysvinit-with-cron scenarios.

If you're worried about the stability of systemd timer code, systemd's
timer support has been stable enough to run e2scrub_all/xfs_scrub_all on
my systems since late 2015, and I have no interest in supporting either
on a pre-2016 distro.  Practically speaking, I guess that RHEL8, SLES16,
and Ubuntu 20.04 will be the first LTS distros to support e2scrub at
all.

(As for xfs_scrub, it'll barely achieve alpha status in Linux 5.2...)

> Also I decided not to package the cron job for now. But if I decide to
> package it in the future I'd like to change the e2scrub cron
> configuration so that it can run on the systems with systemd but make
> the package conflict with the e2scrub-service so that users are free to
> decide how they want to use it.

If you do end up creating two packages I'd name the systemd one
e2scrub-systemd over e2scrub-service.

--D

> Thoughts ?
> 
> Thanks!
> -Lukas
