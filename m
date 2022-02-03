Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A624A8FA1
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Feb 2022 22:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237543AbiBCVOd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Feb 2022 16:14:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235192AbiBCVOc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Feb 2022 16:14:32 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 213JcIR1009644;
        Thu, 3 Feb 2022 21:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=7z0ZCWtLzZrJPVSBXJGGwlsKXGRo1dpDl+uwF2QB/4Q=;
 b=K5pkxaXXjEsT/6dIX9T6aWwiCf8dH74Qy5kG9EGljEWXv4kXeLI2ZqlGsxaRI4KDOgvE
 ovRDV7k4K/pC022jc6HRcLVD+vIn+rn+kDP4mgsIGvV2EGjcA5ZAkF6u8RSUgtHx+F6L
 e2NBFdgUJqi9YhMILj0r15XNcr9mxBTPrZby8nWraStnCFf+l1Owq9OyV0D8l0udhZAG
 Cs/iMmG7T53dDJfljl2fcVUV7xYqHy+GMK/KWQAjFk5DNz1tV3IShLCZATpvjUElb+3B
 iPGB4RJ/ks0g+v89v+SLQDhwZ6msh0TN/cJXmj0oZLThYaSHVAq452huZJfpU0Sfnbt3 OQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e02k2h1nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 21:14:24 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 213LBZSl031230;
        Thu, 3 Feb 2022 21:14:23 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e02k2h1my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 21:14:23 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 213L2hmv018892;
        Thu, 3 Feb 2022 21:14:21 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3dvw7a83cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Feb 2022 21:14:21 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 213L4OV140894780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Feb 2022 21:04:24 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93C8511C054;
        Thu,  3 Feb 2022 21:14:18 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24B6E11C04C;
        Thu,  3 Feb 2022 21:14:18 +0000 (GMT)
Received: from localhost (unknown [9.43.61.133])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Feb 2022 21:14:17 +0000 (GMT)
Date:   Fri, 4 Feb 2022 02:44:16 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Xin Yin <yinxin.x@bytedance.com>
Cc:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [External] Re: [PATCH 1/2] ext4: use ext4_ext_remove_space() for
 fast commit replay delete range
Message-ID: <20220203211416.5jjdkk7pdaahignw@riteshh-domain>
References: <20211223032337.5198-1-yinxin.x@bytedance.com>
 <20211223032337.5198-2-yinxin.x@bytedance.com>
 <20220201203359.owrnrfqydjloy7oq@riteshh-domain>
 <CAK896s4=o9cFFnh0KzhbXSSjWiDFoTqNx0ATzGNH8rxj19+1aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK896s4=o9cFFnh0KzhbXSSjWiDFoTqNx0ATzGNH8rxj19+1aw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: an2wUMPWkhzA-KdfEn14KoNtdGCSkMEE
X-Proofpoint-ORIG-GUID: MPte-vS5sfRiUTHP3nN9weXGIGpDPAKl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-03_06,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202030126
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/02/02 09:40PM, Xin Yin wrote:
> On Wed, Feb 2, 2022 at 4:34 AM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
> >
> > Hello Xin,
> >
> > Sorry about revisiting this thread so late :(
> > Recently when I was working on one of the fast_commit issue, I got interested
> > in looking into some of those recent fast_commit fixes.
> >
> > Hence some of these queries.
> >
> > On 21/12/23 11:23AM, Xin Yin wrote:
> > > For now ,we use ext4_punch_hole() during fast commit replay delete range
> > > procedure. But it will be affected by inode->i_size, which may not
> > > correct during fast commit replay procedure. The following test will
> > > failed.
> > >
> > > -create & write foo (len 1000K)
> > > -falloc FALLOC_FL_ZERO_RANGE foo (range 400K - 600K)
> > > -create & fsync bar
> > ^^^^ do you mean "fsync foo" or is this actually a new file create and fsync
> > bar?
> bar is a new created file, it is the brother file of foo , it would be
> like this.
> ./foo ./bar
>
> >
> >
> > > -falloc FALLOC_FL_PUNCH_HOLE foo (range 300K-500K)
> > > -fsync foo
> > > -crash before a full commit
> > >
> > > After the fast_commit reply procedure, the range 400K-500K will not be
> > > removed. Because in this case, when calling ext4_punch_hole() the
> > > inode->i_size is 0, and it just retruns with doing nothing.
> >
> > I tried looking into this, but I am not able to put my head around that when
> > will the inode->i_size will be 0?
> >
> > So, what I think should happen is when you are doing falocate/fsync foo in your
> > above list of operations then, anyways the inode i_disksize will be updated
> > using ext4_mark_inode_dirty() and during replay phase inode->i_size will hold
> > the right value no?
> yes, the inode->i_size hold the right value and ext4_fc_replay_inode()
> will update inode to the final state, but during replay phase
> ext4_fc_replay_inode() usually is the last step,  so before this the
> inode->i_size may not correct.
>
> >
> > Could you please help understand when, where and how will inode->i_size will be
> > 0?
> I didn't check why inode->i_size is 0, in this case. I just think

Ok, so I now know why the inode->i_size is 0 during replay phase (for file foo).
This is because inode->i_disksize is not really updated until after the
ext4_writepages() kicks in, which in this case, won't happen (for file foo)
when we are doing fsync on file bar. And hence fsync on file bar won't also
not ensure the delalloc blocks for file foo get's written out.


In fact this above information was something that I was assuming it all wrong.
Earlier I was of the opinion that fast_commit still pushes _all_ the dirty
pagecache data of other files to disk too (which is incorrect) and the only
performance gains happens via less writes to disk (since we write less metadata
on disk).

But I think what really happens is -
In case of fast_commit when fsync is called on any file (say bar), apart from that
file's (bar) dirty data, it only writes the necessary required metadata information
of the blocks of others files (in this case file foo) which are already allocated.
(which in this case was due to fzero operation).
It does not actually allocate the delalloc blocks due to buffered writes of any
other file (other than for file on which fsync is called).

This happens in
ext4_fc_perform_commit() -> ext4_fc_submit_inode_data_all() ->
jbd2_submit_inode_data -> jbd2_journal_submit_inode_data_buffers() ->
generic_writepages() -> using writepage() which won't do block allocation for
delalloc blocks.

So that above is what should give the major performance boost with fast_commit
in case of multiple file writes doing fsync. :)

@Jan/Harshad - could you please confirm if above is correct?


> inode->i_size should not affect the behavior of the replay phase.
> Another case is inode->i_size may not include unwritten blocks , and
> if a file has unwritten blocks at bottom, we can not use
> ext4_punch_hole() to remove the unwritten blocks beyond i_size during
> the replay phase.

Right. So then yes, we should not depend on inode->i_size during replay phase,
since it might have an entry in fast_commit area which is still only partially
correct (or in some transient state w.r.t i_disksize).


>
> >
> > Also - it would be helpful if you have some easy reproducer of this issue you
> > mentioned.
> The attached test code can reproduce this issue, hope it helps.

Thanks, yes it did help.

-ritesh

>
>
> >
> > -ritesh
> >
> > >
> > > Change to use ext4_ext_remove_space() instead of ext4_punch_hole()
> > > to remove blocks of inode directly.
> > >
> > > Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> > > ---
> > >  fs/ext4/fast_commit.c | 13 ++++++++-----
> > >  1 file changed, 8 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > > index aa05b23f9c14..3deb97b22ca4 100644
> > > --- a/fs/ext4/fast_commit.c
> > > +++ b/fs/ext4/fast_commit.c
> > > @@ -1708,11 +1708,14 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
> > >               }
> > >       }
> > >
> > > -     ret = ext4_punch_hole(inode,
> > > -             le32_to_cpu(lrange.fc_lblk) << sb->s_blocksize_bits,
> > > -             le32_to_cpu(lrange.fc_len) <<  sb->s_blocksize_bits);
> > > -     if (ret)
> > > -             jbd_debug(1, "ext4_punch_hole returned %d", ret);
> > > +     down_write(&EXT4_I(inode)->i_data_sem);
> > > +     ret = ext4_ext_remove_space(inode, lrange.fc_lblk,
> > > +                             lrange.fc_lblk + lrange.fc_len - 1);
> > > +     up_write(&EXT4_I(inode)->i_data_sem);
> > > +     if (ret) {
> > > +             iput(inode);
> > > +             return 0;
> > > +     }
> > >       ext4_ext_replay_shrink_inode(inode,
> > >               i_size_read(inode) >> sb->s_blocksize_bits);
> > >       ext4_mark_inode_dirty(NULL, inode);
> > > --
> > > 2.20.1
> > >


