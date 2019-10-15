Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 400E6D725F
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Oct 2019 11:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbfJOJez (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Oct 2019 05:34:55 -0400
Received: from sender3-pp-o92.zoho.com.cn ([124.251.121.251]:25923 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbfJOJey (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 15 Oct 2019 05:34:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571132072; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=G+fFFGDqKpPr61InFRRJjGKKFqLVt9W/E7Hm0G38WbI5BpsePYxjc0zhgKwQtQ2vbbU6CL3kTmqii9/fUJz+xhn3d1v5ITtPDRG++yOA+feBt2ECF6V2iVp69hordJEx+tBfzN7sdc7amKCmn7nRCBgbUrkHEZeuXcgTPS14j08=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1571132072; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To:ARC-Authentication-Results; 
        bh=SH1JWxwZ2qADO489iGJgJob448+Ronoz97wdjG2YxiY=; 
        b=kTEPzOmj4jUZ/8Yr9mqsGp+09Jd+LPiQHig57DAQ8Fk/QKj0p+tNSPkBf94So0e1sxARvLylJysORbOOJp7Q+TCu7VxgasHw95nUCcHPmt1/nqfdJ0/ah5P+YdjG41BDOwxOjF2mi5Okw+fvOZBNlwgZ9zXmxD6KTVKPWdeHIlY=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1571132072;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=4012; bh=SH1JWxwZ2qADO489iGJgJob448+Ronoz97wdjG2YxiY=;
        b=Z+COc0Y0Ov/aWaxKG0+JY9wOPhVL+fj9GDhJl4qqOEnqRDYO2Cx41uSND+xxTV25
        cF0YRiZNVeJKjt2vJjrQHLT1i9AfmTu+5BzOYCERlslJ64u2IDYAvZ39SSl3Ofg4oAn
        iZDH/cwMrHEwdVuVQKJUPPkJt4cVfwbMtqbiGNF8=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1571132071771555.9761419747704; Tue, 15 Oct 2019 17:34:31 +0800 (CST)
Date:   Tue, 15 Oct 2019 17:34:31 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>
Cc:     "tytso" <tytso@mit.edu>,
        "adilger.kernel" <adilger.kernel@dilger.ca>,
        "linux-ext4" <linux-ext4@vger.kernel.org>
Message-ID: <16dcec4df57.d8e9fcdc10107.7620254946323645087@mykernel.net>
In-Reply-To: <20191015082001.GD21550@quack2.suse.cz>
References: <20191010051426.1087-1-cgxu519@mykernel.net> <20191015082001.GD21550@quack2.suse.cz>
Subject: Re: [PATCH] ext4: choose hardlimit when softlimit is larger than
 hardlimit in ext4_statfs_project()
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Priority: Medium
User-Agent: ZohoCN Mail
X-Mailer: ZohoCN Mail
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2019-10-15 16:20:01 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Thu 10-10-19 13:14:26, Chengguang Xu wrote:
 > > Setting softlimit larger than hardlimit seems meaningless
 > > for disk quota but currently it is allowed. In this case,
 > > there may be a bit of comfusion for users when they run
 > > df comamnd to directory which has project quota.
 > >=20
 > > For example, we set 20M softlimit and 10M hardlimit of
 > > block usage limit for project quota of test_dir(project id 123).
 > >=20
 > > [root@hades mnt_ext4]# repquota -P -a
 > > *** Report for project quotas on device /dev/loop0
 > > Block grace time: 7days; Inode grace time: 7days
 > >                         Block limits                File limits
 > > Project         used    soft    hard  grace    used  soft  hard  grace
 > > ----------------------------------------------------------------------
 > >  0        --      13       0       0              2     0     0
 > >  123      --   10237   20480   10240              5   200   100
 > >=20
 > > The result of df command as below:
 > >=20
 > > [root@hades mnt_ext4]# df -h test_dir
 > > Filesystem      Size  Used Avail Use% Mounted on
 > > /dev/loop0       20M   10M   10M  50% /home/cgxu/test/mnt_ext4
 > >=20
 > > Even though it looks like there is another 10M free space to use,
 > > if we write new data to diretory test_dir(inherit project id),
 > > the write will fail with errno(-EDQUOT).
 > >=20
 > > After this patch, the df result looks like below.
 > >=20
 > > [root@hades mnt_ext4]# df -h test_dir
 > > Filesystem      Size  Used Avail Use% Mounted on
 > > /dev/loop0       10M   10M  3.0K 100% /home/cgxu/test/mnt_ext4
 > >=20
 > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 >=20
 > Good spotting! But the patch has a bug:
 >=20
 > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
 > > index dd654e53ba3d..08d4f993b365 100644
 > > --- a/fs/ext4/super.c
 > > +++ b/fs/ext4/super.c
 > > @@ -5546,9 +5546,11 @@ static int ext4_statfs_project(struct super_blo=
ck *sb,
 > >          return PTR_ERR(dquot);
 > >      spin_lock(&dquot->dq_dqb_lock);
 > > =20
 > > -    limit =3D (dquot->dq_dqb.dqb_bsoftlimit ?
 > > -         dquot->dq_dqb.dqb_bsoftlimit :
 > > -         dquot->dq_dqb.dqb_bhardlimit) >> sb->s_blocksize_bits;
 > > +    limit =3D ((dquot->dq_dqb.dqb_bhardlimit &&
 > > +        (dquot->dq_dqb.dqb_bhardlimit < dquot->dq_dqb.dqb_bsoftlimit)=
) ?
 > > +        dquot->dq_dqb.dqb_bhardlimit :
 > > +        dquot->dq_dqb.dqb_bsoftlimit) >> sb->s_blocksize_bits;
 > > +
 >=20
 > This is wrong in case softlimit isn't set and hardlimit is. In that case
 > you'd have 'limit' equal to 0, which is wrong. Also the formula is rathe=
r
 > hard to parse already. So I'd rather go with something like:

Ah, you are right, I overlooked it.=20
I'll fix in next version. Thanks for your review.

Thanks,
Chengguang

 >=20
 >     limit =3D 0;
 >     if (dquot->dq_dqb.dqb_bsoftlimit &&
 >         (!limit || dquot->dq_dqb.dqb_bsoftlimit < limit))
 >         limit =3D dquot->dq_dqb.dqb_bsoftlimit;
 >     if (dquot->dq_dqb.dqb_bhardlimit &&
 >         (!limit || dquot->dq_dqb.dqb_bhardlimit < limit))
 >         limit =3D dquot->dq_dqb.dqb_bhardlimit;
 >     limit >>=3D sb->s_blocksize_bits;
 >=20
 > and similarly for inode limit...
 >=20
 >                                 Honza
 >=20
 > >      if (limit && buf->f_blocks > limit) {
 > >          curblock =3D (dquot->dq_dqb.dqb_curspace +
 > >                  dquot->dq_dqb.dqb_rsvspace) >> sb->s_blocksize_bits;
 > > @@ -5558,9 +5560,11 @@ static int ext4_statfs_project(struct super_blo=
ck *sb,
 > >               (buf->f_blocks - curblock) : 0;
 > >      }
 > > =20
 > > -    limit =3D dquot->dq_dqb.dqb_isoftlimit ?
 > > -        dquot->dq_dqb.dqb_isoftlimit :
 > > -        dquot->dq_dqb.dqb_ihardlimit;
 > > +    limit =3D (dquot->dq_dqb.dqb_ihardlimit &&
 > > +        (dquot->dq_dqb.dqb_ihardlimit < dquot->dq_dqb.dqb_isoftlimit)=
) ?
 > > +        dquot->dq_dqb.dqb_ihardlimit :
 > > +        dquot->dq_dqb.dqb_isoftlimit;
 > > +
 > >      if (limit && buf->f_files > limit) {
 > >          buf->f_files =3D limit;
 > >          buf->f_ffree =3D
 > > --=20
 > > 2.20.1
 > >=20
 > >=20
 > >=20
 > --=20
 > Jan Kara <jack@suse.com>
 > SUSE Labs, CR
 >

