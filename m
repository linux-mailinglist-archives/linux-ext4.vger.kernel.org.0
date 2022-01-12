Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1F348C816
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jan 2022 17:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355040AbiALQTE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Jan 2022 11:19:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17362 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241078AbiALQTD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 12 Jan 2022 11:19:03 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20CG7whU015849;
        Wed, 12 Jan 2022 16:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Uk9m0lZZKUeUMSCI2sqaQaxPknoFIIxE6cFSIDILurA=;
 b=gxFrs6vhU7RynkzViVurPlHL4MGpNrmKW96Jq2KJdljNHajAkOPOSbK3wJISyx1IQKQ9
 vWFnG9ya7fXrG/IrdTb4UbjWkQJj8DXPGVgh2dXX9VusVQTR9dTiJEBYQTkCW0ziISml
 FrOjoAuyPz2GKoAPadd/l0JtHph57Es8UPlBl+KdXBlv7DweSA/sWQ4nZ1aknLJDJLch
 QUnHlUpPMQJZzDOeGgXEtPuuAnXUsL70tLueUq/DNiEQQLuPf4T+/yxWFCn+a4mmHI2q
 SYxXZdvaYMzPN6SLfdtdUnvsLLlbCiFQzEb2kMW1aRBazCcGvWjb3RJjv3S8YbI0f0aG 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dhycgvgdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 16:18:59 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20CGGkDD009006;
        Wed, 12 Jan 2022 16:18:58 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dhycgvgcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 16:18:58 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20CGB9LG007338;
        Wed, 12 Jan 2022 16:18:56 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3df289dgvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jan 2022 16:18:56 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20CGIsM528967172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jan 2022 16:18:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E995EAE057;
        Wed, 12 Jan 2022 16:18:53 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E146AE045;
        Wed, 12 Jan 2022 16:18:53 +0000 (GMT)
Received: from localhost (unknown [9.43.59.72])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 12 Jan 2022 16:18:53 +0000 (GMT)
Date:   Wed, 12 Jan 2022 21:48:52 +0530
From:   riteshh <riteshh@linux.ibm.com>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        luo penghao <luo.penghao@zte.com.cn>
Cc:     Lukas Czerner <lczerner@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>, cgel.zte@gmail.com,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux] ext4: Delete useless ret assignment
Message-ID: <20220112161852.uctmtrfvxbf6bmij@riteshh-domain>
References: <20211230062905.586150-1-luo.penghao@zte.com.cn>
 <YdZzt0LF/ajTGNXo@mit.edu>
 <20220106105843.comh4jk3krxppgbp@work>
 <CAD+ocbyF=9pskuSRono-hAg2mEzEmCOD30oFGYW8piQ=BjwhYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbyF=9pskuSRono-hAg2mEzEmCOD30oFGYW8piQ=BjwhYw@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -ykcULlyQWhnxv2JPtYzEKaF0HLqplp8
X-Proofpoint-ORIG-GUID: dDFN8OKLXFrd75sAorbo8EnuQLbv6Pox
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-12_04,2022-01-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201120103
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/01/06 04:59PM, harshad shirwadkar wrote:
> First of all thanks for catching this. Yeah, I think the right thing
> to do here is to return the return value up to the caller. Also, I
> agree with Lukas, we should only set fc_modified_inodes_size if the
> allocation succeeds. Luo, would you be okay updating the patch to
> include these changes?
>
> Thanks,
> Harshad
>
> On Thu, Jan 6, 2022 at 2:58 AM Lukas Czerner <lczerner@redhat.com> wrote:
> >
> > On Wed, Jan 05, 2022 at 11:44:39PM -0500, Theodore Ts'o wrote:
> > > On Thu, Dec 30, 2021 at 06:29:05AM +0000, cgel.zte@gmail.com wrote:
> > > > From: luo penghao <luo.penghao@zte.com.cn>
> > > >
> > > > The assignments in these two places will be overwritten by new
> > > > assignments later, so they should be deleted.
> > > >
> > > > The clang_analyzer complains as follows:
> > > >
> > > > fs/ext4/fast_commit.c
> > > >
> > > > Value stored to 'ret' is never read
> > >

Since I was also suspecting a similar issue in ext4_fc_record_modified_inode()
(w.r.t. krealloc()) while doing some code reviews a while ago.
And I also happened to stumble upon this discussion which added some more
context to it.

@Luo,
I am preparing some other fixes and might submit this fix also as part of those.
I am completely ok, if you would like to push a patch from your end
based on this discussion. In that case, I will request to drop my patch
or won't even publish it, if you submit it before my fixes gets out.

-ritesh

> > > I suspect the right answer here is that we *should* be checking the
> > > return value, and reflecting the error up to caller, if appropriate.
> > >
> > > Harshad, what do you think?
> >
> > Indeed we absolutely *must* be checking the return value and bail out
> > otherwise we risk overwriting kernel memory among other possible
> > problems.
> >
> > See ext4_fc_record_modified_inode() where we increment
> > fc_modified_inodes_size before the actual reallocation which in case of
> > allocation failure will leave us with elevated fc_modified_inodes_size
> > and the next call to ext4_fc_record_modified_inode() can modify
> > fc_modified_inodes[] out of bounds.
> >
> > In addition to checking the return value we should probably also move
> > incrementing the fc_modified_inodes_size until after the successful
> > reallocation in order to avoid such pitfalls.
> >
> > Thanks!
> > -Lukas
> >
> > >
> > >                                       - Ted
> > >
> > > >
> > > > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > > > Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
> > > > ---
> > > >  fs/ext4/fast_commit.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > > > index 8ea5a81..8d5d044 100644
> > > > --- a/fs/ext4/fast_commit.c
> > > > +++ b/fs/ext4/fast_commit.c
> > > > @@ -1660,7 +1660,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
> > > >             return 0;
> > > >     }
> > > >
> > > > -   ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
> > > > +   ext4_fc_record_modified_inode(sb, inode->i_ino);
> > > >
> > > >     start = le32_to_cpu(ex->ee_block);
> > > >     start_pblk = ext4_ext_pblock(ex);
> > > > @@ -1785,7 +1785,7 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl,
> > > >             return 0;
> > > >     }
> > > >
> > > > -   ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
> > > > +   ext4_fc_record_modified_inode(sb, inode->i_ino);
> > > >
> > > >     jbd_debug(1, "DEL_RANGE, inode %ld, lblk %d, len %d\n",
> > > >                     inode->i_ino, le32_to_cpu(lrange.fc_lblk),
> > > > --
> > > > 2.15.2
> > > >
> > > >
> > >
> >
