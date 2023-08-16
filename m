Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD4977E0F4
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 13:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbjHPL5c (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Aug 2023 07:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbjHPL5A (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Aug 2023 07:57:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EAC1FC3
        for <linux-ext4@vger.kernel.org>; Wed, 16 Aug 2023 04:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.at;
 s=s31663417; t=1692187015; x=1692791815; i=g.ottinger@gmx.at;
 bh=ebJcH3rZX7R4lCkTyekeJ4Kyow4H+hkRzQcXq81DhSk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ti1h15MED6GGVL9bqqq4da5BJEoY3X8pA7Ak9wQMVDbWJZIG6R1EIgamNFBxW8yoJt7ldTZ
 jlEqez9AFD4hF/P8cr67FNMidyZcxccndT9YJkxXQk6Mg5ixmxSBnUOnWP7IBsY4EJUQFbAvP
 J3mGrotaqHoRdYLplS/TP4WmlFmf3w11LTrnUPnymVLPBPXAvPSR+/49ihV/Z2FmKVXPf69Xh
 p3cXPyK2I0gBmvwHIw7SUWWjLBk5LlvjoL6POX2Epfk52HODlaKrwYLh4JdwP3J4lXfH7RbT3
 pSd8040RSWnXkheLZro3ZGdIXne4sst+i7LZZKwun7rfArue9CBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.236.202.2] ([10.236.202.2]) by
 msvc-mesg-gmx103.server.lan (via HTTP); Wed, 16 Aug 2023 13:56:54 +0200
MIME-Version: 1.0
Message-ID: <trinity-bf36bcac-6e5f-4c5c-aed5-f8981803a1b8-1692187013964@msvc-mesg-gmx105>
From:   Georg Ottinger <g.ottinger@gmx.at>
To:     Jan Kara <jack@suse.cz>
Cc:     Andreas Dilger <adilger@dilger.ca>, jack@suse.com,
        linux-ext4@vger.kernel.org
Subject: Aw: Re: [PATCH v1] ext2: fix datatype of block number in
 ext2_xattr_set2()
Content-Type: text/plain; charset=UTF-8
Importance: normal
Sensitivity: Normal
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 16 Aug 2023 13:56:54 +0200
In-Reply-To: <20230816102049.oxunyinqjclxhsss@quack3>
References: <20230815100340.22121-1-g.ottinger@gmx.at>
 <259983C6-320F-4A21-86CA-B965D01494D7@dilger.ca>
 <20230816102049.oxunyinqjclxhsss@quack3>
X-Priority: 3
X-Provags-ID: V03:K1:bwVO1pNLgpHRzNRIwHnusQuVJ2Fai3tvPQdeUrTATc3HM3dqWSETECTIFtA4yShPg5phI
 FI1QWkdh3VT8s/eUSWgRNkVOW6fCRyXIeqaNcmH8nDrzlknqyB9tzxxaAJq0JZhOhLmQOLpXODi+
 e0/RYzLUqmkfithgg4QiNfxSXOpcBZWuykJnPD/LU6yGg7bVhCxbZ3Slg0/o3puDQ3L21R6EvWLV
 BEsgSeqB8cPE25WPqzKXOelqOcCVWFw/wKC0M8pqL8VUTPhoumxG2RD2j9APVvSFS15g4wIJhOnJ
 JM=
UI-OutboundReport: notjunk:1;M01:P0:/oKTh6C/sNg=;I46aDC3D8fsz7IRABm+v6gAzMMK
 ez8uQ3UTInZGk+2Vs4K3XeuMaz4/M0gqMsNTgHxaHYq8sctlMlEnpZg+sXrnpSVaMimNSBPYg
 SgvUSYnTHChco7YM7bKtuAR48HENnYCgf4IjkS6czomdQUldHH1J+ch1pXaNNGVN1+gmGjJbB
 KT5r7qEqX8bQdGyryut/NAtNA4j6vNZcdwAYcjQdonDYbSc1jUTz0hR1oFN0H5jXzi8HDp1ML
 /qMhR/8DqCn4vtIg1Yit+rEb7r/G0A5zwvPFJPd1Q2W+EarSekL7wfy+3SDqnFw+Iv20cK7Bv
 CUFGw5TZF3MJzR2wfkGLMXp5T6QlZamPKdrv5RpNeL4qimnQT1I0qN7THAzMoUdDHheT28gSS
 bKI7xdTUSE+uc6npSCtkbFMFFmNFNBzNGGx79XwUvM5UDGm3jJ3V/XW7NeM7oAQctQegMt5VP
 d8TneXi/iCRX+6xxb81mp7sFzgh2GP34ydRZQGjhs/EE9AwKEC6tgEP94byUbBQRKbo2xTGvH
 nnyIjx+g0YA+WvGaKePWc488LHvdPWSgwU+JFtFMU/nGoXcuWZBQR4ThmKMjJsX7DJrwbTyqn
 pzT6HE5GBRRfUD2nBY5Te5HRl6YN2QEfsX/QLdSHhf88HUjAbpzqyeZdy6pLM5xr4bAWWrIA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

Stephan noticed that the Format string of the debug message was not %lu - =
thats why i sent a PATCH v2=2E


> Gesendet: Mittwoch, den 16=2E08=2E2023 um 12:20 Uhr
> Von: "Jan Kara" <jack@suse=2Ecz>
> An: "Andreas Dilger" <adilger@dilger=2Eca>
> Cc: "Georg Ottinger" <g=2Eottinger@gmx=2Eat>, jack@suse=2Ecom, linux-ext=
4@vger=2Ekernel=2Eorg
> Betreff: Re: [PATCH v1] ext2: fix datatype of block number in ext2_xattr=
_set2()
>=20
> Hello!
>=20
> On Tue 15-08-23 06:18:43, Andreas Dilger wrote:
> > On Aug 15, 2023, at 04:04, Georg Ottinger <g=2Eottinger@gmx=2Eat> wrot=
e:
> > > =EF=BB=BFI run a small server that uses external hard drives for bac=
kups=2E The
> > > backup software I use uses ext2 filesystems with 4KiB block size and
> > > the server is running SELinux and therefore relies on xattr=2E I rec=
ently
> > > upgraded the hard drives from 4TB to 12TB models=2E I noticed that a=
fter
> > > transferring some TBs I got a filesystem error "Freeing blocks not i=
n
> > > datazone - block =3D 18446744071529317386, count =3D 1" and the back=
up
> > > process stopped=2E Trying to fix the fs with e2fsck resulted in a
> > > completely corrupted fs=2E The error probably came from ext2_free_bl=
ocks(),
> > > and because of the large number 18e19 this problem immediately looke=
d
> > > like some kind of integer overflow=2E Whereas the 4TB fs was about 1=
e9
> > > blocks, the new 12TB is about 3e9 blocks=2E So, searching the ext2 c=
ode,
> > > I came across the line in fs/ext2/xattr=2Ec:745 where ext2_new_block=
()
> > > is called and the resulting block number is stored in the variable b=
lock
> > > as an int datatype=2E If a block with a block number greater than
> > > INT32_MAX is returned, this variable overflows and the call to
> > > sb_getblk() at line fs/ext2/xattr=2Ec:750 fails, then the call to
> > > ext2_free_blocks() produces the error=2E
> >=20
> > It would be useful to also do a quick grep through the rest of the ext=
2
> > code to check for this bug in other places calling ext2_mew_block() an=
d
> > similar calls=2E
>=20
> I did actually check when merging the patch and all the other places are
> storing returned block in ext2_fsblk_t=2E
>=20
> 								Honza
>=20
> --=20
> Jan Kara <jack@suse=2Ecom>
> SUSE Labs, CR
