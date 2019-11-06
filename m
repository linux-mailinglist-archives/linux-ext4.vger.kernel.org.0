Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A206AF1123
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 09:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbfKFIfC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 03:35:02 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25345 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727159AbfKFIfC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 03:35:02 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573029266; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=Mddu0dGuv6sdZHdyUaxH1UCAmQrxozWCuJdhGPrU9JC33+ETYjQfTQE/dw1pD8qeZ5HQNgEpAjvORYw8xyY6Pa1kcQJpFOX+cDf5a1sj/70nwSiliKuycy9WpFh4MjWbCz88/u+yNJm6kGWMOBg+sVUiz8LiQmSGeglKHcN+zdI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1573029266; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=88jTmaQ8V5u+M2/dGu6C624eDKCud4CbWGywqy7p/jg=; 
        b=nOaY4WN2nLYbsQH9JSrY4d8CiiTtPkSGQjHq18UMXpz+WsPm32Fnxv3ST6FQbzeEGS3cvmP2M9olUddXDLmASDgoGG/n8grXASun7ujwRSGzOjXWNlHjo8Pf6b7dOrq15N7GfjS1UdHONU/p2laJOr435j1pP8oquQGT6tRSU2Y=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1573029266;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=2731; bh=88jTmaQ8V5u+M2/dGu6C624eDKCud4CbWGywqy7p/jg=;
        b=Mcmjh8GCmxHR2eQR0ZStqzR74fLCKNC79lobtZidd67wc6WliQY0IVUc+VNFT9j8
        +MYag7misEVfgjQNjPYPJs+JcfLvYIIL904HBdXW43p0qM11vrztIt77ZAr8UyKqVMI
        KMLQvZDOzkSKVgp0infjtW0BXdC9yFe2LaD/bjf8=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 15730292643411008.9555114747113; Wed, 6 Nov 2019 16:34:24 +0800 (CST)
Date:   Wed, 06 Nov 2019 16:34:24 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Jan Kara" <jack@suse.cz>,
        "adilger.kernel" <adilger.kernel@dilger.ca>,
        "tytso" <tytso@mit.edu>, "Jan Kara" <jack@suse.com>,
        "linux-ext4" <linux-ext4@vger.kernel.org>
Message-ID: <16e3fd9bbd0.13ef078cc303.945603942066109125@mykernel.net>
In-Reply-To: <20191106050336.GD15203@magnolia>
References: <20191015102327.5333-1-cgxu519@mykernel.net>
 <20191015112523.GB29554@quack2.suse.cz>
 <16e3f00ed3d.da5d5acd1285.2289879597060795256@mykernel.net> <20191106050336.GD15203@magnolia>
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2019-11-06 13:03:36 Darrick J.=
 Wong <darrick.wong@oracle.com> =E6=92=B0=E5=86=99 ----
 > On Wed, Nov 06, 2019 at 12:37:35PM +0800, Chengguang Xu wrote:
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
 > How do the other filesystems (e.g. xfs) behave if someone tries to set a
 > soft limit higher than the hard limit?
 >=20

In xfs if (hard && hard < soft), the limit will not be set(or changed) but =
command xfs_quota does not return error.


Thanks,
Chengguang


