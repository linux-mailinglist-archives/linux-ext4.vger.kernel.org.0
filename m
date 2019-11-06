Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4C4F0DDE
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 05:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbfKFEiA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Nov 2019 23:38:00 -0500
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25359 "EHLO
        sender3-pp-o92.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729774AbfKFEiA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Nov 2019 23:38:00 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573015059; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=ZvoLyfgJ75zT6WtbEFmmG9QmwRuojVjdLJez0i4kZXPMYvjeeqRhZ62e1alUU5sdZSZavOFfCg/RrRDeYFvT3jU0sKHPgUzhvAYT/T4vYCJg9D+B22cFQjGNLG7RKV3JyeGQcscxdJP2xX1G49ZXX5P9ZnhY52B4LDNzZgivgQU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1573015059; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To; 
        bh=9SmfZSPSU/d+WPI28gb5yeMdxiYp2jtXKO5e0IclLYM=; 
        b=Q3Ncm5ZvFUzVpYNBa2nuHX35MIJpZV9bPsN7fn/2hLiQHKAgpXkzyyRWZDcq5ho4zkKRGdXyapnfhvsH7YVoudOezBd1GKLNDXTXZZ3G347r31iBb0pTducfAXvUN3BmVIDIkz48cjqO8fxCnN9wpbURQFCO0h5Q1lnhMZ5SeiE=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1573015059;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Date:From:Reply-To:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=2053; bh=9SmfZSPSU/d+WPI28gb5yeMdxiYp2jtXKO5e0IclLYM=;
        b=JrS6+vewlOxZYvjBfaonRb6lviKX5XrHbKieXXeAdT97mapGVOedWL2b9zR3VkBM
        Wl8owWOGX4LKFD/roo1HiahDJUXrveSeBIF03IDTPhPE3Joe/8VMHR24LE/ugaP0HlX
        tQg68NDsrfdS4hA0cqestm1elFFCta0D1eNcznAE=
Received: from mail.baihui.com by mx.zoho.com.cn
        with SMTP id 1573015055681539.5346250763338; Wed, 6 Nov 2019 12:37:35 +0800 (CST)
Date:   Wed, 06 Nov 2019 12:37:35 +0800
From:   Chengguang Xu <cgxu519@mykernel.net>
Reply-To: cgxu519@mykernel.net
To:     "Jan Kara" <jack@suse.cz>
Cc:     "adilger.kernel" <adilger.kernel@dilger.ca>,
        "tytso" <tytso@mit.edu>, "Jan Kara" <jack@suse.com>,
        "linux-ext4" <linux-ext4@vger.kernel.org>
Message-ID: <16e3f00ed3d.da5d5acd1285.2289879597060795256@mykernel.net>
In-Reply-To: <20191015112523.GB29554@quack2.suse.cz>
References: <20191015102327.5333-1-cgxu519@mykernel.net> <20191015112523.GB29554@quack2.suse.cz>
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

 ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=8C, 2019-10-15 19:25:23 Jan Kara <=
jack@suse.cz> =E6=92=B0=E5=86=99 ----
 > On Tue 15-10-19 18:23:27, Chengguang Xu wrote:
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
 > > ---
 > > - Fix a bug in the limit setting logic.
 >=20
 > Thanks for the patch! It looks good to me. You can add:
 >=20
 > Reviewed-by: Jan Kara <jack@suse.cz>
 >=20

Hi Jan,

I have a proposal for another direction.
Could we add a check for soft limit  in quota layer when setting the value?
So that we could not bother with  specific file systems on statfs().=20

Thanks,
Chengguang


