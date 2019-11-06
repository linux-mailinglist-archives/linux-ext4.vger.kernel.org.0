Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80BCBF1428
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 11:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfKFKk6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 05:40:58 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25342 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726656AbfKFKk6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 05:40:58 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573036838; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=FhHWEYQ6zGUTNZr2Ifc/U5dLrJgTNBKTEBFTsK/UGWC4kf5H3fkRaQkBfVvvt3itcPee1bG6FX9r/1/qUY3cUpkelo81uWP/cbsilt+Gbp45Oc1K1kVJ18BfRKkudW1TxO1o0RdETTqRRh1uW2EdeyAQSDssa2uSJCs4cKXmA5k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1573036838; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=qKcoxG0Mx09fjX3RK8sRBS/HXfNVwIIEH4GxkGM68AM=; 
        b=eYUNN16TaBzFeQ7LsdYC/YbrCyD3r/LER66Dfl1tmvhYi34Cr88XsrNhsBTbka35KPHiWdpBMWPOoIRB6mmdCcWWE7yoUDa2LTA4BLUNOdsX/MdLOQwfosPjTWBjW6H6CFiBT3sqEVF5G9YEbPwRFTTWHj6V286CUUzGEvGrcNM=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1573036838;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=3079; bh=qKcoxG0Mx09fjX3RK8sRBS/HXfNVwIIEH4GxkGM68AM=;
        b=YYblifOEMd2nqy7+iXxSXxdOzTsvpS7uElR6nwObgm/Zj/Ff8i6V3tJisCEOZAcJ
        b8SoFY/d+Db+19b33uTuLayiyzQJ40wT5A0mHvPUOQEUQKZJmKn6mJw5t9X6ji1GlwB
        YrJ4qa8DGNbvDxEW7VaA+Ap1paqGVZoNV6H12/ug=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1573036836449372.56275490652695; Wed, 6 Nov 2019 18:40:36 +0800 (CST)
Date:   Wed, 06 Nov 2019 18:40:36 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>
Cc:     "adilger.kernel" <adilger.kernel@dilger.ca>,
        "tytso" <tytso@mit.edu>, "Jan Kara" <jack@suse.com>,
        "linux-ext4" <linux-ext4@vger.kernel.org>
Message-ID: <16e404d465e.ddfd6f53546.5756417115406096069@mykernel.net>
In-Reply-To: <20191106094924.GA16085@quack2.suse.cz>
References: <20191015102327.5333-1-cgxu519@mykernel.net>
 <20191015112523.GB29554@quack2.suse.cz>
 <16e3f00ed3d.da5d5acd1285.2289879597060795256@mykernel.net> <20191106094924.GA16085@quack2.suse.cz>
Subject: Re: [PATCH v2] ext4: choose hardlimit when softlimit is larger than
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2019-11-06 17:49:24 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Wed 06-11-19 12:37:35, Chengguang Xu wrote:
 > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2019-10-15 19:25:23 Jan K=
ara <jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > >  > On Tue 15-10-19 18:23:27, Chengguang Xu wrote:
 > >  > > Setting softlimit larger than hardlimit seems meaningless
 > >  > > for disk quota but currently it is allowed. In this case,
 > >  > > there may be a bit of comfusion for users when they run
 > >  > > df comamnd to directory which has project quota.
 > >  > >=20
 > >  > > For example, we set 20M softlimit and 10M hardlimit of
 > >  > > block usage limit for project quota of test_dir(project id 123).
 > >  > >=20
 > >  > > [root@hades mnt_ext4]# repquota -P -a
 > >  > > *** Report for project quotas on device /dev/loop0
 > >  > > Block grace time: 7days; Inode grace time: 7days
 > >  > >                         Block limits                File limits
 > >  > > Project         used    soft    hard  grace    used  soft  hard  =
grace
 > >  > > -----------------------------------------------------------------=
-----
 > >  > >  0        --      13       0       0              2     0     0
 > >  > >  123      --   10237   20480   10240              5   200   100
 > >  > >=20
 > >  > > The result of df command as below:
 > >  > >=20
 > >  > > [root@hades mnt_ext4]# df -h test_dir
 > >  > > Filesystem      Size  Used Avail Use% Mounted on
 > >  > > /dev/loop0       20M   10M   10M  50% /home/cgxu/test/mnt_ext4
 > >  > >=20
 > >  > > Even though it looks like there is another 10M free space to use,
 > >  > > if we write new data to diretory test_dir(inherit project id),
 > >  > > the write will fail with errno(-EDQUOT).
 > >  > >=20
 > >  > > After this patch, the df result looks like below.
 > >  > >=20
 > >  > > [root@hades mnt_ext4]# df -h test_dir
 > >  > > Filesystem      Size  Used Avail Use% Mounted on
 > >  > > /dev/loop0       10M   10M  3.0K 100% /home/cgxu/test/mnt_ext4
 > >  > >=20
 > >  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 > >  > > ---
 > >  > > - Fix a bug in the limit setting logic.
 > >  >=20
 > >  > Thanks for the patch! It looks good to me. You can add:
 > >  >=20
 > >  > Reviewed-by: Jan Kara <jack@suse.cz>
 > >  >=20
 > >=20
 > > Hi Jan,
 > >=20
 > > I have a proposal for another direction.
 > > Could we add a check for soft limit  in quota layer when setting the v=
alue?
 > > So that we could not bother with  specific file systems on statfs().=
=20
 >=20
 > What do you mean exactly? To not allow softlimit to be larger than
 > hardlimit? That would make some sense but I don't think the risk of
 > breaking some user that accidentally depends on current behavior is wort=
h
 > the few checks we can save...
 >=20
=20
Actually, I thought exactly same as you when I wrote my patch for statfs() =
of ext4.
However, even though softlimit > hardlimit, we cannot allow user to use blo=
cks or inode
more than hardlimit. IOW, the limit is always there and  fixed in this situ=
ation.
So  how about set softlimit to hardlimit when softlimit > hardlimit and ret=
urn with success?


Thanks,
Chengguang



