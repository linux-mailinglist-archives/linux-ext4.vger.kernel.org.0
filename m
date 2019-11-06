Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9FCF1464
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 11:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfKFKwa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 05:52:30 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25316 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725856AbfKFKwa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Nov 2019 05:52:30 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573037530; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=ATjKAjqRvt5TpHFBkeGQaUIRlKTwRcAEW2DJ8tQRF2h0fOMSeWOpHw/cxeE6KGdsphGy5e8xsqACeWU11/L2ZXD+2TSXSJZYfR9tMejcX63gFLNubtHAU/JL54q/WpfsEqUe8M1SwuP3LYq/fCyUCSXZHLxuUTz6aLJ4tWTiMSk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1573037530; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=ueDl8yBj967ynhJNnPt4MHXlqFIQgqRroiDSAHarr5s=; 
        b=fklhpKnq3TgCmYAPfxGBD9UumRszZirLUEqiVmTGxnJpfvjiez5OJs185T7stiie41WWB47GX9DRN2MQAZZUcjpZ/CqYoRQgMytDdVKFHR+kux/9oo5sPvcAPn7Nf5a2T2qi+pqGAlM4ajU8E2YECif36ckxmgPuN+KhuMlqVSI=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1573037530;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=3165; bh=ueDl8yBj967ynhJNnPt4MHXlqFIQgqRroiDSAHarr5s=;
        b=XGgvfkoGhhIko/BkJN95cywr1/XGqkBLK4CsddPubDXzY2mxnGXHzxUKkpbOa8PX
        /8m9HHpvdsRqibw62JYQQ4veS7Q3xD5RuWfvXuJGclPCo3tmVRHiJ6s0/sgQcIiRtDB
        fnrYydEHB8TUFlO1IeAObk2cmVPvdIXlgB5lHOFw=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1573037527514554.0097097118752; Wed, 6 Nov 2019 18:52:07 +0800 (CST)
Date:   Wed, 06 Nov 2019 18:52:07 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Jan Kara" <jack@suse.cz>,
        "adilger.kernel" <adilger.kernel@dilger.ca>,
        "tytso" <tytso@mit.edu>, "Jan Kara" <jack@suse.com>,
        "linux-ext4" <linux-ext4@vger.kernel.org>
Message-ID: <16e4057d1d7.11b9fb039554.6579544170413347739@mykernel.net>
In-Reply-To: <16e3fd9bbd0.13ef078cc303.945603942066109125@mykernel.net>
References: <20191015102327.5333-1-cgxu519@mykernel.net>
 <20191015112523.GB29554@quack2.suse.cz>
 <16e3f00ed3d.da5d5acd1285.2289879597060795256@mykernel.net> <20191106050336.GD15203@magnolia> <16e3fd9bbd0.13ef078cc303.945603942066109125@mykernel.net>
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2019-11-06 16:34:24 Chengguang=
 Xu <cgxu519@mykernel.net> =E6=92=B0=E5=86=99 ----
 >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=B8=89, 2019-11-06 13:03:36 Darrick=
 J. Wong <darrick.wong@oracle.com> =E6=92=B0=E5=86=99 ----
 >  > On Wed, Nov 06, 2019 at 12:37:35PM +0800, Chengguang Xu wrote:
 >  > >  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2019-10-15 19:25:23 Ja=
n Kara <jack@suse.cz> =E6=92=B0=E5=86=99 ----
 >  > >  > On Tue 15-10-19 18:23:27, Chengguang Xu wrote:
 >  > >  > > Setting softlimit larger than hardlimit seems meaningless
 >  > >  > > for disk quota but currently it is allowed. In this case,
 >  > >  > > there may be a bit of comfusion for users when they run
 >  > >  > > df comamnd to directory which has project quota.
 >  > >  > >=20
 >  > >  > > For example, we set 20M softlimit and 10M hardlimit of
 >  > >  > > block usage limit for project quota of test_dir(project id 123=
).
 >  > >  > >=20
 >  > >  > > [root@hades mnt_ext4]# repquota -P -a
 >  > >  > > *** Report for project quotas on device /dev/loop0
 >  > >  > > Block grace time: 7days; Inode grace time: 7days
 >  > >  > >                         Block limits                File limit=
s
 >  > >  > > Project         used    soft    hard  grace    used  soft  har=
d  grace
 >  > >  > > --------------------------------------------------------------=
--------
 >  > >  > >  0        --      13       0       0              2     0     =
0
 >  > >  > >  123      --   10237   20480   10240              5   200   10=
0
 >  > >  > >=20
 >  > >  > > The result of df command as below:
 >  > >  > >=20
 >  > >  > > [root@hades mnt_ext4]# df -h test_dir
 >  > >  > > Filesystem      Size  Used Avail Use% Mounted on
 >  > >  > > /dev/loop0       20M   10M   10M  50% /home/cgxu/test/mnt_ext4
 >  > >  > >=20
 >  > >  > > Even though it looks like there is another 10M free space to u=
se,
 >  > >  > > if we write new data to diretory test_dir(inherit project id),
 >  > >  > > the write will fail with errno(-EDQUOT).
 >  > >  > >=20
 >  > >  > > After this patch, the df result looks like below.
 >  > >  > >=20
 >  > >  > > [root@hades mnt_ext4]# df -h test_dir
 >  > >  > > Filesystem      Size  Used Avail Use% Mounted on
 >  > >  > > /dev/loop0       10M   10M  3.0K 100% /home/cgxu/test/mnt_ext4
 >  > >  > >=20
 >  > >  > > Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
 >  > >  > > ---
 >  > >  > > - Fix a bug in the limit setting logic.
 >  > >  >=20
 >  > >  > Thanks for the patch! It looks good to me. You can add:
 >  > >  >=20
 >  > >  > Reviewed-by: Jan Kara <jack@suse.cz>
 >  > >  >=20
 >  > >=20
 >  > > Hi Jan,
 >  > >=20
 >  > > I have a proposal for another direction.
 >  > > Could we add a check for soft limit  in quota layer when setting th=
e value?
 >  > > So that we could not bother with  specific file systems on statfs()=
.=20
 >  >=20
 >  > How do the other filesystems (e.g. xfs) behave if someone tries to se=
t a
 >  > soft limit higher than the hard limit?
 >  >=20
 >=20
 > In xfs if (hard && hard < soft), the limit will not be set(or changed) b=
ut command xfs_quota does not return error.
 >=20

Hi Darrick,

IMO, set nothing and return success seems  not reasonable,=20
is it possible change to set softlimit to hardlimit when softlimit > hardli=
mit?

Thanks,
Chengguang

