Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD684D571
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2019 19:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfFTRuq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jun 2019 13:50:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35670 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfFTRup (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jun 2019 13:50:45 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KHnFbv124013;
        Thu, 20 Jun 2019 17:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=uCDJoD2AjjfnOAuhEhsslfYWPgCKlKhrihxUVjJ+YD0=;
 b=wgb8jXPDsSsNlHy1ysordgyUjhB3Nr5Mr/LzG4yXglYe9kzADMJ1aEVa0lr9VDOF1+PC
 PQShtMDQLfsA7XHWaSsffmIIhmATOSA4wW+7dJo6ldxlRf6j/divebl/WA7LvJZpJr87
 Gd+9jV2LEYQUBkFNNb8y/s/0o29yZFuT5Y7h1o+RbKjicpVSHyiAR1LO731ruu1xD+OT
 UK0+RwXz7X+8CBT83mwe99r2rSk1WiqQ8RMIz73o8Li+QzAz0ODsiavHRWhHCtlcxLmH
 YjDie5NhuSiyOL+tDqtEHATBi9t5f4pvbRWVNvXKDrTv+0co87WTcLQbPoISpjw6A6at XQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2t7809jgje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 17:50:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5KHoWv6003725;
        Thu, 20 Jun 2019 17:50:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2t77ypgku6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 17:50:38 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5KHobuO021546;
        Thu, 20 Jun 2019 17:50:37 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 20 Jun 2019 10:50:37 -0700
Date:   Thu, 20 Jun 2019 10:50:35 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Eryu Guan <guaneryu@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
Subject: Re: Removing the shared class of tests
Message-ID: <20190620175035.GA5380@magnolia>
References: <20190612184033.21845-1-krisman@collabora.com>
 <20190612184033.21845-2-krisman@collabora.com>
 <20190616144440.GD15846@desktop>
 <20190616200154.GA7251@mit.edu>
 <20190620112903.GF15846@desktop>
 <20190620162116.GA4650@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620162116.GA4650@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906200127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9294 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906200127
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 20, 2019 at 12:21:16PM -0400, Theodore Ts'o wrote:
> On Thu, Jun 20, 2019 at 07:29:03PM +0800, Eryu Guan wrote:
> > 
> > IMO, shared tests are generic tests that don't have proper _require
> > rules, so they're hard-coded with explicit "_supported_fs xxx yyy". With
> > proper _require rules, there should be no shared tests at all, and we'd
> > try avoid adding new shared tests if possible.
> 
> Thanks for the clarification, that makes sense!
> 
> I can see some shared tests that we can probably move out, actually.
> shared/00[134] and shared/272 make no sense at all for ext2.  The ext3
> file system was removed in 2015, in the 4.3 kernel, and since 2009
> (ten years ago) in 2.6.33, the ext4 implementation could be used to
> support ext3 (and I believe many if not all enterprise distros been
> taking advantage of this long before 2015, so they only had to update
> patches for ext4).
> 
> (If anything, we might be better served by a two line patch to check
> so that simply included the ext4 group when FSTYP == ext3.  That way
> we will run more tests on those systems which still support the ext3
> emulated-by-ext4 mode.)
> 
> The shared/002 test could be moved to generic if we had a way for file
> systems to declare how many xattrs per file they support.
> 
> The shared/006 test needs some way of descriminating which inodes have
> a fixed number of inodes, since it fills a small file system until it
> runs out of space and then runs fsck on it.  Actually, if we make the
> test file system smaller, so it runs in finite time, we could probably
> just run it on all file systems, since checking to see what file
> systems which don't have a fixed inode table (e.g., btrfs) do under
> ENOSPC when creating tons of inodes probably makes sense there for
> those file systems as well.

xfs doesn't have a fixed inode table either, so ... that sounds like a
good idea.

> I'm not sure why shared/011 is only run on ext4 and btrfs.  Does
> cgroup-aware writeback not work on other file systems?

IIRC it doesn't work on xfs because the author never quite answered
Dave's question about whether or not it would cause ... io priority
inversions or something?  There was some unanswered question (iirc) so
nobody RVB'd the patch and it never went upstream.

> The shared/{008,009,010} tests could be moved to generic if we added
> _require_dedup.  The shared/298 tests just needs a _require_fstrim.

FWIW shared/010 is blacklisted on my systems because of its poor "kill
everything and wait for the processes to exit" code.  The test starts
fsstress and then "while [ -e $dupe_run ]; do duperemove; done" loops.

When end_test runs, it'll remove the $dupe_run flag file and wait for
all the duperemoves to finish.  Unfortunately by this time the
duperemoves and the fsstress threads are duking it out for file locks
and it takes forever for duperemove to finish scanning and exit.
Consequently this test sometimes runs for a very long time.

I /think/ the answer is for end_test to send SIGTERM or something to the
duperemoves and wait for them to exit sooner than later.

> The bottom line is I think if this is something we care about, we can
> probably move out nearly all of the tests from shared.  Should I start
> sending patches?  :-)

Sounds good to me....

--D

> 
> 						- Ted
