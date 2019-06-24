Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 891205194C
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2019 19:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbfFXRHk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Jun 2019 13:07:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48046 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbfFXRHj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Jun 2019 13:07:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OH3aQP155723;
        Mon, 24 Jun 2019 17:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=u5idGy8k+K1N6OEhzOM3TAlGIfRSvUlOZZJDdOyaKsY=;
 b=wxUQ50xJvPqCfXmrLJlbgudN0G4azOnKeNw6qGK9x0z1mq0L3btqviHUx0pENRV68a6V
 epScV2nrCUdDzn2iOuNQ8dK26mahG/gmMIdd3ZGf2nIbkj9jxV6TmAbJjAgzG6TAudqV
 OCqM21k72EDuPn9fdulYjSdwYKCXBxUta100BK7AcgwsL4WgtgUCawBLMiPH505aB0rq
 hbalmnf/5QjaTPDZy01jXlStLJSKQXBKFlx8Ycy4PvD9veN4FRdoShcEjECiYRLs/K2q
 7Floo840f/Cpn8W34ld7r1hzTKaGiNzvGpOQdht8woOmlaLLn34JCjRfCucLer2N1AmL Dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t9brsyn80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 17:07:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OH3UCh109272;
        Mon, 24 Jun 2019 17:05:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2t9acbm8vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 17:05:18 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5OH5GVq007904;
        Mon, 24 Jun 2019 17:05:16 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 10:05:16 -0700
Date:   Mon, 24 Jun 2019 10:05:15 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Eryu Guan <guaneryu@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
Subject: Re: Removing the shared class of tests
Message-ID: <20190624170515.GF5375@magnolia>
References: <20190612184033.21845-1-krisman@collabora.com>
 <20190612184033.21845-2-krisman@collabora.com>
 <20190616144440.GD15846@desktop>
 <20190616200154.GA7251@mit.edu>
 <20190620112903.GF15846@desktop>
 <20190620162116.GA4650@mit.edu>
 <20190620175035.GA5380@magnolia>
 <20190624071610.GA10195@infradead.org>
 <20190624130730.GD1805@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190624130730.GD1805@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9298 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240135
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 24, 2019 at 09:07:30AM -0400, Theodore Ts'o wrote:
> On Mon, Jun 24, 2019 at 12:16:10AM -0700, Christoph Hellwig wrote:
> > 
> > As for the higher level question?  The shared tests always confused the
> > heck out of me.  generic with the right feature checks seem like a much
> > better idea.
> 
> Agreed.  I've sent out a patch series to bring the number of patches
> in shared down to four.  Here's what's left:
> 
> shared/002 --- needs a feature test to somehow determine whether a
> 	file system supports thousads of xattrs in a file (currently
> 	on btrfs and xfs)

I don't know of a good way to do that other than trying it.

> shared/011 --- needs some way of determining that a file system
> 	supports cgroup-aware writeback (currently enabled only for
> 	ext4 and btrfs).  Do we consider lack of support of
> 	cgroup-aware writeback a bug?  If so, maybe it doesn't need a
> 	feature test at all?

...but for the ones that do, we need a test to make sure the reported
accounting values aren't totally off in the stratosphere.

I wonder, could we add a _require_scratch_cgroupwb that would assign a
new cgroup, try to write a fixed amount of data (~64k) and then _notrun
if the cgroup write back thing reported zero bytes written?

> shared/032 --- needs a feature test to determine whether or not a file
> 	system's mkfs supports detection of "foreign file systems".
> 	e.g., whether or not it warns if you try overwrite a file
> 	system w/o another file system.  (Currently enabled by xfs and
> 	btrfs; it doesn't work for ext[234] because e2fsprogs, because
> 	I didn't want to break existing shell scripts, only warns when
> 	it is used interactively.  We could a way to force it to be
> 	activated it points out this tests is fundamentally testing
> 	implementation choices of the userspace utilities of a file
> 	system.  Does it belong in xfstests?   : ¯\_(ツ)_/¯ )
> 
> shared/289 --- contains ext4, xfs, and btrfs mechanisms for
> 	determining blocks which are unallocated.  Has hard-coded
> 	invocations to dumpe2fs, xfs_db, and /bin/btrfs.

Huh?  shared/289 looks like a pure ext* test to me....

# Copyright (c) 2012 Red Hat, Inc.  All Rights Reserved.
#
# FS QA Test No. 289
#
# Test overhead & df output for extN filesystems

<confused>

> These don't have obvious solutions.  We could maybe add a _notrun if
> adding the thousands of xattrs fails with an ENOSPC or related error
> (f2fs uses something else).
> 
> Maybe we just move shared/011 and move it generic/ w/o a feature test.
> 
> Maybe we remove shared/032 altogether, since for e2fsprogs IMHO
> the right place to put it is the regression test in e2fsprogs --- but
> I know xfs has a different test philosophy for xfsprogs; and tha begs
> the question of what to do for mkfs.btrfs.

<shrug> I'm fine with leaving the test there for xfs since that's where
we put all the xfsprogs tests anyway. :)

--D

> And maybe we just split up shared/289 to three different tests in
> ext4/, xfs/, and btrfs/, since it would make the test script much
> simpler to understand?
> 
> What do people think?
> 
> 						- Ted
