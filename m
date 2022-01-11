Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D109448B2B5
	for <lists+linux-ext4@lfdr.de>; Tue, 11 Jan 2022 17:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242533AbiAKQ5T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 11 Jan 2022 11:57:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15324 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242265AbiAKQ5T (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 11 Jan 2022 11:57:19 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BGVkgI025661;
        Tue, 11 Jan 2022 16:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Hkgo8db6UjClKJyAo3+x9suzSu1aIDRx2x8giAINUyk=;
 b=QsZOP64kPKeimsrOFaerX3tIA3Mumm2HDc+j3+lqGnz8Vr5CFiFa2ChT1WqNNuH7c3BX
 TGSDct+bsnWMpypoH242QThVWPfsJrKxDtTsl9GOQHyfkyHq3aRbK/lAetchwwqKf5cR
 J7Ibu3tvqZQBe8aJ9Nhnz1k/JadmQkzu54vioBsnGFLpmMGeo4p5DoAjEU/fIHBD7GZr
 wJ54OhRtohNmOMOtUQeHRGb8c6Dwu+Gv794U7g4aLuDLYQaV70+5d/ImALrUwozy0N6Z
 bhr4/+BZ+Xx4EH50RMS6xws3MYbs+DPYoInNAnPD+Q1lv4me7SbVwjHIQ/y0s9SHlIrg Og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dh37p02pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 16:57:16 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20BDKRl3002389;
        Tue, 11 Jan 2022 16:57:15 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dh37p02p3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 16:57:15 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20BGXrbM010463;
        Tue, 11 Jan 2022 16:57:14 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3df289hkh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jan 2022 16:57:14 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20BGvCjI40632798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 16:57:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F143311C06E;
        Tue, 11 Jan 2022 16:57:11 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 886B711C05E;
        Tue, 11 Jan 2022 16:57:11 +0000 (GMT)
Received: from localhost (unknown [9.43.59.72])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jan 2022 16:57:11 +0000 (GMT)
Date:   Tue, 11 Jan 2022 22:27:10 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshads@google.com>
Subject: Re: [PATCH v2 0/4] ext4 fast commit API cleanup
Message-ID: <20220111165710.swbv2dvr75sraylh@riteshh-domain>
References: <20211223202140.2061101-1-harshads@google.com>
 <20220111125257.ffdn4gmtvfdkunr2@riteshh-domain>
 <CAD+ocbxw8oYg6RVXViwwwh1zuu4mrOQdJ6p0rT_FuXF=sMGaJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbxw8oYg6RVXViwwwh1zuu4mrOQdJ6p0rT_FuXF=sMGaJA@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NNuToDZCSpMu5R9CqmYtXfEpI7gLlVX8
X-Proofpoint-ORIG-GUID: F8RNbLlBMdfPa1f9AulvSh6wlzBBI2hV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-11_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201110093
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/01/11 08:19AM, harshad shirwadkar wrote:
> Hey Ritesh,
>
> Yes, your understanding is correct, this patch series does have a side
> effect that the entire file system gets locked before starting a fast
> commit. However, this regression is meant to be temporary (mainly to
> prevent merging of unnecessary correctness patches). I am working on
> another series which fixes this by only locking the inode that is
> being committed. That patch should be out shortly.
>
> The reason I hurried this patch series in without the inode locking
> patches first was that we had some consistency and file system hanging
> issues which needed to be fixed in the right way before the code
> becomes more cluttered with temporary correctness fixes which would
> eventually get dropped out. The hope is that with these patches, such
> fixes wouldn't need to be merged in.
>
> But yeah, I am fully aware of the performance degradation that this
> series introduces and you will soon see another patch series that
> fixes that issue.

Thanks Harshad, for taking time and helping me understand the reasoning behind.

-ritesh

>
> Thanks,
> Harshad
>
> On Tue, Jan 11, 2022 at 4:53 AM riteshh <riteshh@linux.ibm.com> wrote:
> >
> > On 21/12/23 12:21PM, Harshad Shirwadkar wrote:
> > > This patch series fixes up fast commit APIs. There are NO on-disk
> > > format changes introduced in this series. The main contribution of the
> > > series is that it drops fast commit specific transaction APIs and
> > > makes fast commits work with journal transaction APIs of JBD2
> > > journalling system. With these changes, a fast commit eligible
> > > transaction is simply enclosed in calls to "jbd2_journal_start()" and
> > > "jbd2_journal_stop()". If the update that is being performed is fast
> > > commit ineligible, one must simply call ext4_fc_mark_ineligible()
> > > after starting a transaction using "jbd2_journal_start()". The last
> > > patch in the series simplifies fast commit stats recording by moving
> > > it to a different function.
> > >
> > > I verified that the patch series introduces no regressions in "quick"
> > > and "log" groups when "fast_commit" feature is enabled.
> > >
> > > Changes from V1:
> > > ---------------
> > >
> > > - In the V1 of the patch series, there's performance regression. With
> > >   this patch series, we lock the entire file system from starting any
> > >   new handles during (which ensures consistency at the cost of
> > >   performance). What we ideally want to do is to lock individual
> > >   inodes from starting new updates during a commit. To do so, the V2
> > >   of this patch series retains the infrastructure of inode level
> > >   transactions (ext4_fc_start/stop_update()). In future (not in this
> > >   series), we would build on this infrastructure to lock individual
> > >   inodes and drop the file system level locking during the commit path.
> >
> > Hello Harshad,
> >
> > Sorry about being so late in the game :(
> >
> > So from what I understood from your above commit msg is that even the current
> > v2 patch series suffers from the same performance regression which is:-
> > we lock the filesystem from any starting transaction updates
> > (by taking j_barrier or say by calling jbd2_journal_lock_updates()) while
> > fast_commit's commit operation is in progress (which happens during a file fsync()).
> > This means when fast_commit's commit operation is in progress, then we can't even
> > start a new transaction for recording any metadata updates to any inodes of my FS.
> >
> > Is above understanding correct w.r.t this v2 patch series?
> > If yes, then why do we need to lock the full filesystem from starting any
> > journal txns? Why can't we let any process starts a new transaction while
> > the previous fast_commit's commit operation is in progress?
> >
> > JBD2 does allow us to do that right? i.e. while a jbd2 commit is in progress,
> > a new running transaction can be allocated and all the new metadata updates will
> > now be tracked in the new running txn, right?
> >
> > -ritesh
> >
> >
> > >
> > > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > >
> > > Harshad Shirwadkar (4):
> > >   ext4: use ext4_journal_start/stop for fast commit transactions
> > >   ext4: drop ineligible txn start stop APIs
> > >   ext4: simplify updating of fast commit stats
> > >   ext4: update fast commit TODOs
> > >
> > >  fs/ext4/acl.c         |   2 -
> > >  fs/ext4/ext4.h        |   7 +-
> > >  fs/ext4/extents.c     |   9 +-
> > >  fs/ext4/fast_commit.c | 188 ++++++++++++++++--------------------------
> > >  fs/ext4/fast_commit.h |  27 +++---
> > >  fs/ext4/file.c        |   4 -
> > >  fs/ext4/inode.c       |   7 +-
> > >  fs/ext4/ioctl.c       |  13 +--
> > >  fs/ext4/super.c       |   1 -
> > >  fs/jbd2/journal.c     |   2 +
> > >  10 files changed, 96 insertions(+), 164 deletions(-)
> > >
> > > --
> > > 2.34.1.307.g9b7440fafd-goog
> > >
