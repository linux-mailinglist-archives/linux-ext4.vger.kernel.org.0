Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7233B2CF53E
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Dec 2020 21:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgLDUDT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Dec 2020 15:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgLDUDT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Dec 2020 15:03:19 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6D7C0613D1
        for <linux-ext4@vger.kernel.org>; Fri,  4 Dec 2020 12:02:37 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id b12so3820574pjl.0
        for <linux-ext4@vger.kernel.org>; Fri, 04 Dec 2020 12:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=aYYIVcwNFKObxTgR8DcfdyrMfVprSMQWfJ1Qp0WnWEc=;
        b=YcFjhpzK0FlkxZOhps6KGs7Yqbphg7VLNPltN6xY4D7IksHY6KAHul7XuC8BCt0Baq
         AkXpGO/EX0oLHM76xBQDADZ9c/vDdze3K7yRTcb3SnG/JbLmvi4HKQRL2sAF2gP5nijG
         WVpmtvczqtnOV06kMAYk5iUdNyMozpifCOs3SDGL8StwM2AMkARbIDLVV3Z71LnujUc7
         QIvwB9U8gboBKca+Nsv2VwyeEY6/aWXlgkIngV4+TPj9NslyYbuS+mfQe8KGvJg9BcoG
         ii14L2ZsDI9BCquktW4VB6pZ58kwDhg6EdKm6pYJHVnLAXAzMUAf+5sbZdVZBsfdpg6D
         TQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=aYYIVcwNFKObxTgR8DcfdyrMfVprSMQWfJ1Qp0WnWEc=;
        b=YdYQfhxMhp11hfTwnjmEsl/3H2Zz1mbYdHsi5BmXtk2YUGB9sbtLZVUHb3FCIXjv3T
         kH/F0lacI0c7EhPhtcM12Z6F1UUQsi5IKsZDbWlbKjBRu0/Nf6i57E0a9EEmcCh7VYBk
         ZfgnUhnjxVy0Uuye6mxJWSRl3FYAokCI2Tc7t6lNE+f89BcLRTL4h1d6QEE9jFrYjFoP
         pJ9sUJfD25L8r+NIrRAlGownm3BfXqaqdWMLW49g76K4RKxJP7nSfjP8bHYSMugYtgbD
         S64b7TcqlR25W/Ef9eQXEu3wNvzv2Ce+SC17SFqjVwLQqfv+YE/9rjB+c9irSkOTPDze
         iBxw==
X-Gm-Message-State: AOAM531OgLzXp0mw+jqqxDDs6Lk1m/il6F6H9rcGsHcAAF/xJvVeO8sb
        C8WDuKR1zrQUix1x02t7D8SPIA==
X-Google-Smtp-Source: ABdhPJyKKGj/Ofp/4EJRNhCYft6OLQnmWBREUrfSr7SqawYRM0bJ04Nq5Sq410HeF+QJBBiqyYIxIg==
X-Received: by 2002:a17:902:d702:b029:da:2f28:cc85 with SMTP id w2-20020a170902d702b02900da2f28cc85mr5465587ply.64.1607112156553;
        Fri, 04 Dec 2020 12:02:36 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id q19sm5704968pff.101.2020.12.04.12.02.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2020 12:02:35 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <45B1E6EA-F7E4-4E32-8C63-CCFA662D0F75@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C2B0050A-F8D4-4C35-A727-2F2EB87F0D5C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: ext4: Funny characters appended to file names
Date:   Fri, 4 Dec 2020 13:02:32 -0700
In-Reply-To: <fea4dd48-fd8b-823c-0a4b-20ebcd804597@molgen.mpg.de>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
References: <fea4dd48-fd8b-823c-0a4b-20ebcd804597@molgen.mpg.de>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_C2B0050A-F8D4-4C35-A727-2F2EB87F0D5C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Dec 4, 2020, at 7:30 AM, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>=20
> Using Debian Sid/unstable with 5.9.11 (5.9.0-4-686-pae), it looks like =
the last `sudo grub-update` installed modules with corrupted file names. =
`/boot` is mounted.
>=20
>> $ findmnt /boot
>> TARGET SOURCE   FSTYPE OPTIONS
>> /boot  /dev/md0 ext4   rw,relatime
>> $ ls -l /boot/grub/i386-pc/
>> insgesamt 2085
>> -rw-r--r-- 1 root root   8004 13. Aug 23:00 =
'915resolution.mod-'$'\205\300''u'$'\023\211''=E9=8D=93]'$'\206\371\377\21=
1\360\350''f'$'\376\377\377\205\300''ur'$'\203\354\004''V'$'\377''t$'$'\03=
0''j'$'\002''=E8=83=92'
>> -rw-r--r-- 1 root root  10596 13. Aug 23:00 =
'acpi.mod-'$'\205\300''u'$'\023\211''=E9=8D=93]'$'\206\371\377\211\360\350=
''f'$'\376\377\377\205\300''ur'$'\203\354\004''V'$'\377''t$'$'\030''j'$'\0=
02''=E8=83=92'
>> [=E2=80=A6]
>> $ file =
/boot/grub/i386-pc/zstd.mod-=EF=BF=BD=EF=BF=BDu^S=EF=BF=BD=E9=8D=93\]=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDur=EF=BF=
=BD=EF=BF=BD^DVt\$^Xj^B=E8=83=92 =
/boot/grub/i386-pc/zstd.mod-=EF=BF=BD=EF=BF=BDu=EF=BF=BD=E9=8D=93]=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BDur=EF=BF=BD=EF=BF=BDV=EF=BF=BDt$j=E8=83=92: ELF 32-bit =
LSB relocatable, Intel 80386, version 1 (SYSV), not stripped
>=20
> Checking the file system returned no errors.
>=20
>    $ sudo umount /boot
>    $ sudo fsck.ext4 /dev/md0
>    e2fsck 1.45.6 (20-Mar-2020)
>    boot: sauber, 331/124928 Dateien, 145680/497856 Bl=C3=B6cke
>=20
> This causes GRUB fail to load the module, and it falls back into =
rescue mode.
>=20
> Any idea, what might have happened. It=E2=80=99s a degraded RAID, and =
I only use one drive since several years, but never deactivated it, and =
`/dev/md0` still shows up.
>=20
> ```
> $ more /proc/mdstat
> Personalities : [raid1] [linear] [multipath] [raid0] [raid6] [raid5] =
[raid4] [raid10]
> md0 : active raid1 sdb1[0]
>      497856 blocks [2/1] [U_]
>=20
> md1 : active raid1 sdb2[0]
>      1953013952 blocks [2/1] [U_]
>=20
> unused devices: <none>
> ```

Did you try downgrading to the previous kernel to see if that fixes the =
problem?
Then, it would be useful to bisect between the old working kernel and =
the new
broken kernel to see what introduced this bug.

Cheers, Andreas






--Apple-Mail=_C2B0050A-F8D4-4C35-A727-2F2EB87F0D5C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/KldkACgkQcqXauRfM
H+CzoA//dpnerHY8YQLqnomRv/i4unuJtQab8EfufMFnnm6l0jo0NCfjAJitYPRJ
zP5ta+sZGZPzBDOKglvlrp7kyk3TzyQqQ3STMZ5VWr4bGkkWjLGUNv+pwUBeohZK
6Ris7WrvB1VGh1youv8/Mhk1BfURv3HU988igmg+IRc/+zf7jhbU0fDm6IMO8+Ab
Xomo3FBYdLWn3H75pDdWjTA9O1KxUcdKGxGy20wZYKJMCLFrlKf0XxbrmdJmHKeG
ECl7TlAa9r6iAZfa91cRKgjEZSOSyZmvwcxi/1KBzr6lfCiGde9Ai6EJrsIvqIOg
m8t0fJ3ZYQZPOITdFVscgWmogTP/Qu4/CFmAToo9BZd9KHew/0mC0L+32QtHbzmQ
tBtZk+ltZ4Zg2lmI9aYyLW+zqeax6Gm0VWWZ6V5KjR+wCy5DdIoDOPC/9UIrwamX
o+AORZWhUBDdUIaQd1gmiP+FEIgel+H62NnMhb03xd8OMPFm0oLDouUToWCAyJBK
XC2zrNR+LuSXu7BwnjLkV0kwpL55UhkQH05fNBtHGhe3gv2nq1kwrhveep9I/9k4
AIhFfMFDH6j4flB6JB702/5l3H6q0vdWW3Vl8I040AbiVRWMs1NNrmhOz41HdFYN
hB6MCTKfXKmxwrk1YehWz22P7HSPaDw+rZWQfVPJAZeei0bMeu4=
=ZpRc
-----END PGP SIGNATURE-----

--Apple-Mail=_C2B0050A-F8D4-4C35-A727-2F2EB87F0D5C--
