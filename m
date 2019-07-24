Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B25C47344E
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2019 18:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbfGXQ4p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Jul 2019 12:56:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41000 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfGXQ4p (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Jul 2019 12:56:45 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6OGrWYO008438;
        Wed, 24 Jul 2019 16:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=xh7+O6ZYr0LuT6KoGKbs2G8yQLtNeQ3kwVKzRwDmS/I=;
 b=2p45Yfl+dJzs9kOihr7QgX2wcwy8hn2ktx/LcXdK6XoxSGJV0R54c008mL2IK0KeOLz9
 drUBUeBzEx8ab760/qw7+G7LRNKjPHD25L+ZIoDiN5Q81VWgg/la/3NXpU8uBiv2AoR4
 zm9I6QcPVKBmqydxs4pE4PLITWP/Qs9xW+EkO1C5k0u8JUjfijPBJx80Gz0rzTfDwf1R
 voTz1y21S7JjOcOs3yHZhAbJ3BYPHMnioh8tFOwbXL5OEYYYvPDsc9AT7SUOVBUfzTGv
 /EcY2Fetij47vdx/+PnpLLW9yr9bTW7XxfaB703i/lFClyQ7lXWQzbmG2g9tE74WPIFy 4g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2tx61bxqsv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 16:56:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6OGr06O016121;
        Wed, 24 Jul 2019 16:56:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2tx60xb9vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 16:56:39 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6OGucSp014219;
        Wed, 24 Jul 2019 16:56:38 GMT
Received: from localhost (/10.144.111.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Jul 2019 09:56:38 -0700
Date:   Wed, 24 Jul 2019 09:56:37 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 01/11] ext4: add handling for extended mount options
Message-ID: <20190724165637.GB7074@magnolia>
References: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
 <41522E01-D5E5-4DC6-8AD4-09E3FA19F112@dilger.ca>
 <20190722210235.GE16313@mit.edu>
 <7AD1A611-9BD2-4F32-9568-D0A517047EF0@dilger.ca>
 <CAD+ocbwCYZDrj9D=85AVaB_RLYjUFwNs1V02fRn4tHh04_k7_A@mail.gmail.com>
 <20190724061231.GA7074@magnolia>
 <20190724160749.GF4565@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724160749.GF4565@mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907240182
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9328 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907240182
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jul 24, 2019 at 12:07:49PM -0400, Theodore Y. Ts'o wrote:
> On Tue, Jul 23, 2019 at 11:12:31PM -0700, Darrick J. Wong wrote:
> > On Tue, Jul 23, 2019 at 11:03:54PM -0700, harshad shirwadkar wrote:
> > > Before I respond to your questions, I would like to explain how fast
> > > commits differ from ijournal in a few key aspects (I will make sure to
> > > explain it in detail in patch 00/11 and documentation):
> > 
> > Please do; I hadn't realized there were also journal ondisk format
> > changes, and these must be recorded in the ext4 disk format
> > documentation.
> 
> Actually, the changes are almost entirely in the on-disk journal
> layer.

I know.

Hmm, just as a reminder -- the ext4 disk format documentation
includes the jbd2 disk format documentation.

> The addition of the feature flag is really a UI issue, and
> worth some discussion.
> 
> One of the goals was to make it easy to allow kernels which didn't
> understand fast commit to be able to mount a file system which had
> been cleanly unmounted --- but of course, if the file system needs
> recovery, and fast commits are in the journal, we can't allow a fast
> commit oblivious kernel (or e2fsck) from trying to replay the journal.

BTW, are there patches to fix e2fsck to replay the factcommit journal?

> One way to do this would be with a mount option, but that's a bit ugly
> --- and a mount option in /etc/fstab will cause a failure if a kernel
> which doesn't understand that mount option is booted.
> 
> So the basic idea is to have a compat feature which means, "please use
> fast commits if present", and then when the file system is mounted on
> a fast-commit capable kernel, the incompat feature meaning "we're
> using the fast commit feature".  (This is same design pattern used
> with the HAS_JOURNAL compat feature and the NEEDS_RECOVERY incompat
> feature.)
> 
> The next question is whether to use the compat and incompat feature
> flags in the jbd2 superblock, or ext4-specific compat flags.  For the
> incompat flag, there's no reason not to use the journal incompat flag.
> But for the compat flag, we have better infrastructure for setting and
> clearing ext4-level compat feature flags.  Aside from that, though,
> there's no reason why we couldn't use the s_feature_compat field in
> the journal superblock --- in which case, *all* of the on-diks format
> changes would purely be on the jbd2 side of the ledger.

Probably better to use the journal compat flag so that the other jbd2
users can take advantage of it ... on the other hand, the only other
user (AFAIK) is ocfs2 and HAH.

> > Every feature flag you add doubles the size of the testing matrix.
> > If I were you I'd only want to test the (fastcommit) and (!fastcommit)
> > scenarios.
> 
> Sure, absolutely.  On the other hand, as the saying goes, "there comes
> a time in any project where it's time to shoot the engineers and put
> the d*mned thing into production".  One of the reasons why we're super
> interested in this feature is to claw back the performance hit of
> fde872682e17 ("ext4: force inode writes when nfsd calls
> commit_metadata").  I fully expect that this feature is going to make
> big difference to a number of customer workloads, so there is some
> urgency to getting this feature into production.
> 
> On the flip side, if we leave some performance wins on the table, it's
> absolutely true that it makes it harder to add those optimizations
> later, and it increases the testing load, not to mention the forwards
> and backwards compatibility issues.  It's an engineering trade-off.

<nod> I just remember hearing you complain about the size of the ext4
testing matrix in the past and figured you would't go for adding
fastcommit in small pieces each with new feature bits.

(I guess you could have a fastcommit_version field that increments every
time you add a new fastcommit journal item to constrain the combinatoric
explosion...)

--D

> 
>     	      		    	     	     - Ted
