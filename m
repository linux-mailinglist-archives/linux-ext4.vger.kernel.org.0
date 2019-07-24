Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D142C7280B
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2019 08:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfGXGMj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Jul 2019 02:12:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55802 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfGXGMj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Jul 2019 02:12:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6O64GsI011347;
        Wed, 24 Jul 2019 06:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=dBYBitepri4eOLodpWx9MEgnOX2zh1pvRR4iSq683+E=;
 b=bqqApQvuH9OZkOdiacTvAzHnHfGXisd1wH75KgM9t8Pq5o5VRdqa83cvW4wf5o8IxYzi
 thETemx/k7WcNCADMgTrZ5+5KU5/4RFsmm+DUTgNIWGplnRUBMi1mjX7SHNXt1g+Me6X
 530BcE3Vk44+K+KGimGeQEu9cGH7+Or6eom0fXtNLkqLvScPXxAv7vrWyMiwtvPson7l
 Ox/4jPLmHt59CJIm6OztnoztXmrx0+t+IPJIgABtuCuTDJfffl5rDGFSrrXDT8M1guQd
 fuWJPMdb/KlLNGx4rabWz0qMlzbaUiePg6GmONNzV1z/nEb1aOUo1SOzzUYOIWnF93XF xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2tx61bu186-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 06:12:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6O63380156399;
        Wed, 24 Jul 2019 06:12:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2tx60xqf53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jul 2019 06:12:33 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6O6CWwE020358;
        Wed, 24 Jul 2019 06:12:32 GMT
Received: from localhost (/50.206.22.50)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Jul 2019 23:12:32 -0700
Date:   Tue, 23 Jul 2019 23:12:31 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 01/11] ext4: add handling for extended mount options
Message-ID: <20190724061231.GA7074@magnolia>
References: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
 <41522E01-D5E5-4DC6-8AD4-09E3FA19F112@dilger.ca>
 <20190722210235.GE16313@mit.edu>
 <7AD1A611-9BD2-4F32-9568-D0A517047EF0@dilger.ca>
 <CAD+ocbwCYZDrj9D=85AVaB_RLYjUFwNs1V02fRn4tHh04_k7_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbwCYZDrj9D=85AVaB_RLYjUFwNs1V02fRn4tHh04_k7_A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907240070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9327 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907240070
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 23, 2019 at 11:03:54PM -0700, harshad shirwadkar wrote:
> Before I respond to your questions, I would like to explain how fast
> commits differ from ijournal in a few key aspects (I will make sure to
> explain it in detail in patch 00/11 and documentation):

Please do; I hadn't realized there were also journal ondisk format
changes, and these must be recorded in the ext4 disk format
documentation.

> - Instead of storing extent blocks in a fast commit block, we only
> store extents that were modified in a particular fast commit
> transaction in tag-length-value format.
> 
> - Whenever the fast commit information (inode structure + changed
> extents in TLV format) exceeds one block, we fall back to full commit.
> Thus at this point, the number of blocks we write per fast commit
> transaction is either the total number of files changed (if fast
> commit was successfully performed) or the number of blocks that would
> be written by a full commit transaction.
> 
> - To reduce complexity, there is no support for per-core fast commit areas.
> 
> Current design of fast commits is such that we try to perform fast
> commits whenever possible but either if it's impossible to record file
> system changes by fast commits or if we haven't yet added support for
> dealing with a particular type of file system change, we fall back to
> full commits. Whenever we later add more features to fast commits, we
> probably would need more on-disk format changes for the fast commit
> blocks and that would mean we burn feature flags. So, my guess is that
> we would need to make a few judgement calls on whether we want to
> exclude a few fast commit features, keep the patch series simple and
> potentially burn feature flags later OR we save feature flags by
> implementing those fast commit features.

Every feature flag you add doubles the size of the testing matrix.
If I were you I'd only want to test the (fastcommit) and (!fastcommit)
scenarios.

--D

> On Tue, Jul 23, 2019 at 2:59 PM Andreas Dilger <adilger@dilger.ca> wrote:
> >
> > On Jul 22, 2019, at 3:02 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> > >
> > > On Mon, Jul 22, 2019 at 12:15:11PM -0600, Andreas Dilger wrote:
> > >> Unless I missed it, this patch series needs a 00/11 email that describes
> > >> *what* "fast commit" is, and why we want it.  This should include some
> > >> benchmark results, since (I'd assume) that the "fast" part of the feature
> > >> name implies a performance improvement?
> > >
> > > For background, it's a simplified version of the scheme proposed by
> > > Park and Shin, in their paper, "iJournaling: Fine-Grained Journaling
> > > for Improving the Latency of Fsync System Call"[1]
> > >
> > > [1] https://www.usenix.org/conference/atc17/technical-sessions/presentation/park
> > >
> > > I agree we should have a cover letter for this patch series.  Also, we
> > > should add documentation to Documentation/filesystems/journaling.rst
> > > about this feature; what it does, how it works, its basic on-disk
> > > format changes, etc.
> >
> > Thanks for the link, I hadn't read that paper previously.  From reading the
> > paper, it seems there are some things that should be addressed before the
> > patch is committed to the tree in order to maintain proper disk format
> > compatibility:
> > - the ijournal header shows a 256-byte inode.  In Lustre today (and also
> >   Samba and other xattr-intensive workloads) 512- or 1024-byte inodes are used
> >   in order to store more xattrs within the inode, so the size of the inode
> >   data in the ijournal header needs to match the actual inode size of the
> >   filesystem and not be a fixed size.  What if the inode size == blocksize?
> 
> Okay, I agree. This is one of such questions where we need to decide
> whether to exclude this fast commit feature request for now or not. I
> think whether or not we actually support 512 or 1024 byte inodes in
> this patch series, we definitely shouldn't assume in the fast commit
> header that inodes are of a fixed size. I will fix it. Supporting
> bigger inodes doesn't sound like it would result in big change in the
> patch series. But I would like to know whether you think it's okay to
> wait or not.
> 
> > - the ijournal header also shows a 4-byte inode number.  It would be prudent
> >   to reserve space for 64-bit inode numbers, or at least have some mechanism
> >   (flag) to indicate that a 64-bit inode is stored instead of a 32-bit inode.
> 
> Noted, will change that.
> 
> > - if there are many cores in a system, say 96, how much space will be used
> >   from the journal file by the per-core ijournal?
> > - what happens if multiple threads are writing to the same file with ijournal
> >   and per-core ijournal areas?  Will the same inode information be recorded
> >   in multiple ijournal areas?
> 
> As mentioned above, at least for now we keep it simple by not having
> per-core fast commit areas.
> 
> Thanks,
> Harshad
> 
> >
> > Cheers, Andreas
> >
> >
> >
> >
> >
